#Dockerfile to install and setup common tools
FROM ubuntu:20.04
#FROM nvidia/cuda:10.1-base
FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu18.04
SHELL ["/bin/bash", "-c"] 
###########################
#Installs packages
RUN apt-get update
RUN apt-get install -y libssl-dev openssl build-essential zlib1g-dev libbz2-dev liblzma-dev wget qemu gcc-aarch64-linux-gnu
WORKDIR /usr/
###########################
#Installs pypy 3.6
RUN wget https://downloads.python.org/pypy/pypy3.6-v7.3.3-linux64.tar.bz2
RUN bzip2 -dk pypy3.6-v7.3.3-linux64.tar.bz2
RUN tar xvf pypy3.6-v7.3.3-linux64.tar
RUN echo 'export PATH=/usr/pypy3.6-v7.3.3-linux64/bin:$PATH' >> ~/.profile
###########################
#Installs Apache Spark
RUN wget https://downloads.apache.org/spark/spark-3.0.2/spark-3.0.2-bin-hadoop3.2.tgz
RUN tar xzvf spark-3.0.2-bin-hadoop3.2.tgz
RUN echo 'export PATH=/usr/spark-3.0.2-bin-hadoop3.2/bin:PATH=/usr/spark-3.0.2-bin-hadoop3.2/python:$PATH' >> ~/.profile
RUN echo "export PYSPARK_DRIVER_PYTHON=pypy" >> ~/.profile
###########################
#Installs JDK
#I know JDK can easily be installed using apt-get install default-jdk but I spent too much time making this work and I refuse to change it until v0.3! :D
RUN wget --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" https://download.oracle.com/otn-pub/java/jdk/15.0.2%2B7/0d1cfde4252546c6931946de8db48ee2/jdk-15.0.2_linux-x64_bin.tar.gz 
RUN tar xzvf jdk-15.0.2_linux-x64_bin.tar.gz
RUN echo 'export JAVA_HOME=/usr/jdk-15.0.2' >> ~/.profile
RUN echo 'export PATH=$JAVA_HOME/bin:$PATH' >> ~/.profile
###########################
#Installs local python 3.6.5 from the Packages folder
#COPY Packages /usr/Packages
#RUN apt-get update
#RUN apt-get install -y libssl-dev openssl build-essential zlib1g-dev libbz2-dev liblzma-dev
#WORKDIR /usr/Packages
#RUN tar xzvf Python-3.6.5.tgz
#RUN Python-3.6.5/configure && make && make install
###########################
#Installs Python Libraries
WORKDIR /.
#RUN apt-get install -y python3
RUN apt-get install -y python3-pip
RUN pip3 install --upgrade pip
RUN apt-get install -y git
RUN pip3 install numpy pandas matplotlib scikit-learn
RUN pip3 install tensorflow keras
RUN pip3 install torch
RUN pip3 install nltk opencv-python
ENTRYPOINT source ~/.profile && bin/bash