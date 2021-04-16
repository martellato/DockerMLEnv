#Dockerfile to install and setup common tools
FROM archlinux:latest
#FROM nvidia/cuda:10.1-base
SHELL ["/bin/bash", "-c"]
RUN mkdir /usr/Packages
                           
RUN patched_glibc=glibc-linux4-2.33-4-x86_64.pkg.tar.zst && \
    curl -LO "https://repo.archlinuxcn.org/x86_64/$patched_glibc" && \
    bsdtar -C / -xvf "$patched_glibc"

#Installs packages
RUN yes | pacman -Syyu
#RUN yes | pacman -S libssl-dev openssl build-essential zlib1g-dev libbz2-dev liblzma-dev wget pypy openjdk git
RUN yes | pacman -S wget pypy jdk-openjdk git
WORKDIR /usr/Packages

#Installs Apache Spark
RUN wget https://downloads.apache.org/spark/spark-3.0.2/spark-3.0.2-bin-hadoop3.2.tgz
RUN tar xzvf spark-3.0.2-bin-hadoop3.2.tgz
RUN echo 'export PATH=/usr/Packages/spark-3.0.2-bin-hadoop3.2/bin:/usr/Packages/spark-3.0.2-bin-hadoop3.2/python:$PATH' >> ~/.profile
RUN echo 'export PYSPARK_DRIVER_PYTHON=pypy' >> ~/.profile


#Installs Python Libraries
WORKDIR /.
#RUN yes | pacman -U https://archive.archlinux.org/packages/p/python/python-3.8.5-2-x86_64.pkg.tar.zst
#RUN yes | pacman -U https://archive.archlinux.org/packages/t/tensorflow-opt-cuda/tensorflow-opt-cuda-2.2.0rc3-2-x86_64.pkg.tar.zst
#RUN yes | pacman -U https://archive.archlinux.org/packages/p/python-pip/python-pip-20.0.2-1-any.pkg.tar.zst
#RUN yes | pacman -U https://archive.archlinux.org/packages/p/python-numpy/python-numpy-1.18.2-1-x86_64.pkg.tar.zst
#RUN yes | pacman -U https://archive.archlinux.org/packages/p/python-pandas/python-pandas-1.0.2-1-x86_64.pkg.tar.xz
#RUN yes | pacman -U https://archive.archlinux.org/packages/p/python-matplotlib/python-matplotlib-3.2.1-1-x86_64.pkg.tar.zst
#RUN yes | pacman -U https://archive.archlinux.org/packages/p/python-scikit-learn/python-scikit-learn-0.22.2.post1-1-x86_64.pkg.tar.xz
#RUN yes | pacman -U https://archive.archlinux.org/packages/p/python-pytorch-opt-cuda/python-pytorch-opt-cuda-1.4.1-1-x86_64.pkg.tar.zst
#RUN yes | pacman -U https://archive.archlinux.org/packages/p/python-nltk/python-nltk-3.5-1-any.pkg.tar.zst
#RUN yes | pacman -U https://archive.archlinux.org/packages/p/python-opencv/python-opencv-4.5.2-2-x86_64.pkg.tar.zst
RUN yes | pacman -S python
RUN yes | pacman -S python-numpy python-pandas python-matplotlib python-scikit-learn
RUN yes | pacman -S python-tensorflow-opt-cuda tensorboard
RUN yes | pacman -S python-pytorch-opt-cuda
RUN yes | pacman -S python-nltk python-regex python-opencv
ENTRYPOINT source ~/.profile && bin/bash