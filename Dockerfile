#Dockerfile to install and setup common tools
FROM ubuntu:20.04
FROM nvidia/cuda:10.1-base
RUN apt-get update
RUN apt-get install -y git
RUN apt-get install -y python3
RUN apt-get install -y python3-pip
RUN pip3 install numpy
RUN pip3 install pandas
RUN pip3 install matplotlib
RUN pip3 install scikit-learn
RUN pip3 install tensorflow
RUN pip3 install keras
RUN pip3 install torch