#Installs packages
RUN yes | pacman -Syyu
RUN yes | pacman -S wget jdk-openjdk git

RUN useradd -m work

#Installs Python Libraries
WORKDIR /home/work
RUN yes | pacman -S python
RUN yes | pacman -S python-numpy python-pandas python-matplotlib python-scikit-learn
RUN yes | pacman -S python-tensorflow-opt-cuda tensorboard
RUN yes | pacman -S python-pytorch-opt-cuda
RUN yes | pacman -S python-nltk python-regex python-opencv
