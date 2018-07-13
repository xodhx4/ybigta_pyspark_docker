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

COPY jupyter_init.sh /root/
RUN sh /root/jupyter_init.sh
COPY jupyter_notebook_config.py /root/.jupyter/

# CMD jupyter notebook

RUN apt-get update && apt-get install -yqq \
    openjdk-8-jdk
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV PATH $JAVA_HOME/bin:$PATH

RUN apt-get update && apt-get install -yqq \
    scala

RUN apt-get update && apt-get install -yqq \
    gcc \
    g++ \
    make \
    openssh-client \
    openssh-server && \
    cd /usr/local && \
    wget https://github.com/google/protobuf/releases/download/v2.6.1/protobuf-2.6.1.tar.gz && \
    tar xvzf protobuf-2.6.1.tar.gz && \
    cd protobuf-2.6.1 && \
    ./configure && \
    make && \
    make install && \
    ldconfig

RUN cd $HOME && \
    wget http://apache.mirror.cdnetworks.com/hadoop/common/hadoop-2.9.0/hadoop-2.9.0.tar.gz && \
    tar xvzf hadoop-2.9.0.tar.gz && \
    ln -s hadoop-2.9.0 hadoop && \
    rm hadoop-2.9.0.tar.gz
ENV HADOOP_HOME /root/hadoop
ENV HADOOP_CONFIG_HOME $HADOOP_HOME/etc/hadoop
ENV PATH $HADOOP_HOME/bin:$PATH

RUN echo "localhost" >> /root/hadoop/etc/hadoop/masters
COPY core-site.xml /root/hadoop/etc/hadoop/core-site.xml
COPY hdfs-site.xml /root/hadoop/etc/hadoop/hdfs-site.xml
COPY mapred-site.xml /root/hadoop/etc/hadoop/mapred-site.xml
COPY yarn-site.xml /root/hadoop/etc/hadoop/yarn-site.xml

ENTRYPOINT service ssh start