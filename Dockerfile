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

#WIP:
#Installs Conda compliant latest stable versions of libraries through pacman
#RUN yes | pacman -U https://archive.archlinux.org/packages/p/python/python-3.8.5-1-x86_64.pkg.tar.zst
#RUN yes | pacman -U https://archive.archlinux.org/packages/p/python-dateutil/python-dateutil-2.8.1-5-any.pkg.tar.zst
#RUN yes | pacman -U https://archive.archlinux.org/packages/p/python-numpy/python-numpy-1.19.2-1-x86_64.pkg.tar.zst
#RUN yes | pacman -U https://archive.archlinux.org/packages/p/python-pandas/python-pandas-1.1.3-3-x86_64.pkg.tar.zst
#RUN yes | pacman -U https://archive.archlinux.org/packages/p/python-matplotlib/python-matplotlib-3.3.2-1-x86_64.pkg.tar.zst
#RUN yes | pacman -U https://archive.archlinux.org/packages/p/python-scikit-learn/python-scikit-learn-0.23.2-1-x86_64.pkg.tar.zst
#RUN yes | pacman -U https://archive.archlinux.org/packages/p/python-tensorflow-opt-cuda/python-tensorflow-opt-cuda-2.2.0-1-x86_64.pkg.tar.zst
#RUN yes | pacman -U https://archive.archlinux.org/packages/t/tensorboard/tensorboard-2.4.0-1-x86_64.pkg.tar.zst
#RUN yes | pacman -U https://archive.archlinux.org/packages/p/python-pytorch-opt-cuda/python-pytorch-opt-cuda-1.4.0-1-x86_64.pkg.tar.zst
#RUN yes | pacman -U https://archive.archlinux.org/packages/p/python-nltk/python-nltk-3.5-1-any.pkg.tar.zst
#RUN yes | pacman -U https://archive.archlinux.org/packages/p/python-regex/python-regex-2020.10.15-1-x86_64.pkg.tar.zst


ENTRYPOINT source ~/.profile && bin/bash