#Dockerfile to install and setup common tools
FROM archlinux:latest
SHELL ["/bin/bash", "-c"]
RUN mkdir /usr/Packages
                           
RUN patched_glibc=glibc-linux4-2.33-4-x86_64.pkg.tar.zst && \
    curl -LO "https://repo.archlinuxcn.org/x86_64/$patched_glibc" && \
    bsdtar -C / -xvf "$patched_glibc"

#Installs packages
RUN yes | pacman -Syyu
RUN yes | pacman -S wget pypy3 jdk-openjdk git
WORKDIR /usr/Packages

#Installs Apache Spark
RUN wget https://downloads.apache.org/spark/spark-3.0.2/spark-3.0.2-bin-hadoop3.2.tgz
RUN tar xzvf spark-3.0.2-bin-hadoop3.2.tgz
RUN echo 'export PATH=/usr/Packages/spark-3.0.2-bin-hadoop3.2/bin:/usr/Packages/spark-3.0.2-bin-hadoop3.2/python:$PATH' >> ~/.profile
RUN echo 'export PYSPARK_DRIVER_PYTHON=pypy' >> ~/.profile


#Installs Python Libraries
WORKDIR /.
RUN yes | pacman -S python
RUN yes | pacman -S python-numpy python-pandas python-matplotlib python-scikit-learn
RUN yes | pacman -S python-tensorflow-opt-cuda tensorboard
RUN yes | pacman -S python-pytorch-opt-cuda
RUN yes | pacman -S python-nltk python-regex python-opencv
ENTRYPOINT source ~/.profile && bin/bash