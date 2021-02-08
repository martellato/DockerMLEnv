#Dockerfile to install and setup common tools
FROM ubuntu:20.04
#FROM nvidia/cuda:10.1-base
FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04
###########################
#Installs local python 3.6.5 from the Packages folder
COPY Packages /usr/Packages
RUN apt-get update
RUN apt-get install -y libssl-dev openssl build-essential zlib1g-dev libbz2-dev liblzma-dev
WORKDIR /usr/Packages
RUN tar xzvf Python-3.6.5.tgz
RUN Python-3.6.5/configure && make && make install
###########################
WORKDIR /.
#RUN apt-get install -y python3
RUN apt-get install -y python3-pip
RUN pip3 install --upgrade pip
RUN apt-get install -y git
RUN pip3 install numpy pandas matplotlib scikit-learn
RUN pip3 install tensorflow keras
RUN pip3 install torch
RUN pip3 install nltk opencv-python