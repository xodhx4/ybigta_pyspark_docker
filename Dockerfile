FROM ubuntu:16.04

MAINTAINER Taeoh Kim <kimtaeoh95@gmail.com>

RUN apt-get update && apt-get install -yqq \
    wget \
    bzip2 \
    git
# RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-5.2.0-Linux-x86_64.sh -O ~/anaconda.sh && \
#     /bin/bash ~/anaconda.sh -b -p /opt/conda && \
#     rm ~/anaconda.sh
RUN wget https://repo.anaconda.com/archive/Anaconda3-5.2.0-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh
ENV ANACONDA_HOME /opt/conda
ENV PATH $ANACONDA_HOME/bin:$PATH

CMD jupyter notebook


