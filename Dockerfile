FROM nvidia/cuda:11.7.1-devel-ubuntu22.04
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get upgrade -y && apt-get clean
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get install python3.10 -y
RUN apt-get install git -y
RUN apt-get update -y && apt-get install -y python3-pip python3-dev libsm6 libxext6 libxrender-dev
RUN apt-get install wget
RUN apt install -y libgl1-mesa-glx
RUN apt install unzip


RUN cd /root
RUN pwd
RUN mkdir MD && cd MD

WORKDIR /root/MD  

RUN wget https://mediafirewall.s3.ap-south-1.amazonaws.com/Mani/Trial_01.zip
RUN unzip Trial_01.zip 

COPY detect_3.py /root/MD

RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt

RUN cat detect_3.py

ENTRYPOINT [ "python" ]
CMD ["python", "detect_3.py", "--weights", "best.pt", "--conf", "0.5", "--source", "/Testcases/Distraction_Mobile_Truck.mp4"]
