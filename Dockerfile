FROM nvidia/cuda:11.7.1-devel-ubuntu22.04
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get upgrade -y && apt-get clean
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get install python3.10 -y
RUN apt-get install git -y
RUN apt-get update -y && apt-get install -y python3-pip python3-dev libsm6 libxext6 libxrender-dev
RUN apt-get install -y libxcb-xinerama0 libxcb-shm0
RUN apt-get install wget
RUN apt install -y libgl1-mesa-glx
RUN apt install unzip
RUN apt-get update -y && apt-get install -y xvfb


RUN cd /root
RUN pwd
RUN mkdir MD && cd MD

WORKDIR /root/MD  

RUN wget https://mediafirewall.s3.ap-south-1.amazonaws.com/Mani/Trial_01.zip
RUN unzip Trial_01.zip 

RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt

ENV QT_QPA_PLATFORM_PLUGIN_PATH=/usr/local/lib/python3.10/dist-packages/cv2/qt/plugins/platforms

# Start Xvfb in the background
CMD Xvfb :99 -screen 0 1024x768x16 &

# Set the DISPLAY environment variable to use Xvfb
ENV DISPLAY=:99

COPY detect.py /root/MD

RUN cat detect.py

ENTRYPOINT [ "python3" ]
CMD ["detect.py", "--weights", "best.pt", "--conf", "0.5", "--source", "0"]
