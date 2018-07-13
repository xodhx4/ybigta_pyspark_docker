FROM ubuntu:16.04

MAINTAINER Taeoh Kim <kimtaeoh95@gmail.com>

# Install anaconda 3.5.2
RUN apt-get update && apt-get install -yqq \
    wget \
    bzip2 \
    git && \
    wget https://repo.anaconda.com/archive/Anaconda3-5.2.0-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh
ENV ANACONDA_HOME /opt/conda
ENV PATH $ANACONDA_HOME/bin:$PATH

# Install jupyter notebook
COPY jupyter_init.sh /root/
RUN sh /root/jupyter_init.sh
COPY jupyter_notebook_config.py /root/.jupyter/

# Install java
RUN apt-get update && apt-get install -yqq \
    openjdk-8-jdk
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV PATH $JAVA_HOME/bin:$PATH

# Install scala
RUN apt-get update && apt-get install -yqq \
    scala

# Install protobuf
RUN apt-get update && apt-get install -yqq \
    gcc \
    g++ \
    make \
    openssh-client \
    openssh-server && \
    update-rc.d ssh defaults && \
    cd /usr/local && \
    wget https://github.com/google/protobuf/releases/download/v2.6.1/protobuf-2.6.1.tar.gz && \
    tar xvzf protobuf-2.6.1.tar.gz && \
    cd protobuf-2.6.1 && \
    ./configure && \
    make && \
    make install && \
    ldconfig

# Install hadoop
RUN cd $HOME && \
    wget http://apache.mirror.cdnetworks.com/hadoop/common/hadoop-2.9.0/hadoop-2.9.0.tar.gz && \
    tar xvzf hadoop-2.9.0.tar.gz && \
    ln -s hadoop-2.9.0 hadoop && \
    rm hadoop-2.9.0.tar.gz
ENV HADOOP_HOME /root/hadoop
ENV HADOOP_CONFIG_HOME $HADOOP_HOME/etc/hadoop
ENV PATH $HADOOP_HOME/bin:$PATH

RUN echo "localhost" >> /root/hadoop/etc/hadoop/masters
COPY hadoop-env.sh /root/hadoop/etc/hadoop/hadoop-env.sh
COPY core-site.xml /root/hadoop/etc/hadoop/core-site.xml
COPY hdfs-site.xml /root/hadoop/etc/hadoop/hdfs-site.xml
COPY mapred-site.xml /root/hadoop/etc/hadoop/mapred-site.xml
COPY yarn-site.xml /root/hadoop/etc/hadoop/yarn-site.xml
COPY ssh_init.sh /root/
COPY start.sh /root/
RUN sh /root/ssh_init.sh && \
    $HADOOP_HOME/bin/hdfs namenode -format

# Install spark
RUN cd $HOME && \
    conda install pip -y && \
    pip install msgpack && \
    pip install py4j && \
    wget http://apache.mirror.cdnetworks.com/spark/spark-2.3.0/spark-2.3.0-bin-hadoop2.7.tgz && \
    tar xvzf spark-2.3.0-bin-hadoop2.7.tgz && \
    ln -s spark-2.3.0-bin-hadoop2.7 spark && \
    rm spark-2.3.0-bin-hadoop2.7.tgz
COPY spark-env.sh /root/spark/conf/spark-env.sh
ENV SPARK_HOME /root/spark
ENV PYSPARK_DRIVER_PYTHON jupyter
ENV PYSPARK_DRIVER_PYTHON_OPTS notebook
ENV PATH $SPARK_HOME/bin:$PATH

# Install hive
RUN cd $HOME && \
    wget http://apache.mirror.cdnetworks.com/hive/hive-2.3.3/apache-hive-2.3.3-bin.tar.gz && \
    tar xvzf apache-hive-2.3.3-bin.tar.gz && \
    ln -s apache-hive-2.3.3-bin hive && \
    rm apache-hive-2.3.3-bin.tar.gz
COPY hive-env.sh /root/hive/conf/hive-env.sh
COPY hive-site.xml /root/hive/conf/hive-site.xml
COPY hive_init.sh /root/
RUN sh /root/hive_init.sh

# Running start.sh when make new container
ENTRYPOINT sh /root/start.sh
