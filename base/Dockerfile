#FROM adoptopenjdk/openjdk8:jdk8u212-b04
FROM openjdk:8-jdk-alpine

LABEL version="1.0" maintainer="Tim Robinson "

RUN apk update && apk add --no-cache \
        bash \
        openssh \
        shadow \
        procps \
        rsync && \
        addgroup hadoop && \
        adduser  -S -G hadoop -s /bin/bash hadoop

WORKDIR /home/hadoop

ADD hadoop-2.9.2.tar.gz .
ADD files/startup.sh .
# copy hadoop configs
ADD files/*xml /home/hadoop/hadoop-2.9.2/etc/hadoop/
ADD files/hadoop-env.sh /home/hadoop/hadoop-2.9.2/etc/hadoop/

RUN usermod -p '*' root && \
        usermod -p '*' hadoop && \ 
        chown -R hadoop:hadoop /home/hadoop

# setup root ssh keys
RUN ssh-keygen -A 

#setup hadoop user ssh
ADD files/ssh_config /home/hadoop/.ssh/config
RUN ssh-keygen -t rsa -P '' -f /home/hadoop/.ssh/id_rsa && \
 #       mkdir /root/.ssh && \
        cat /home/hadoop/.ssh/id_rsa.pub >> /home/hadoop/.ssh/authorized_keys && \
        chown -R hadoop:hadoop /home/hadoop/.ssh && \
        chmod 0600 /home/hadoop/.ssh/config && \
        chmod 0600 /home/hadoop/.ssh/authorized_keys

# set environment vars
ENV HADOOP_HOME /home/hadoop/hadoop-2.9.2
ENV HADOOP_PREFIX=${HADOOP_HOME}
ENV HADOOP_COMMON_HOME=${HADOOP_HOME}
ENV HADOOP_HDFS_HOME=${HADOOP_HOME}
ENV HADOOP_MAPRED_HOME=${HADOOP_HOME}
ENV HADOOP_YARN_HOME=${HADOOP_HOME}
ENV HADOOP_CONF_DIR=${HADOOP_HOME}/etc/hadoop
ENV HADOOP_COMMON_LIB_NATIVE_DIR=${HADOOP_HOME}/lib/native

ENV PATH $PATH:$JAVA_HOME/bin:$HADOOP_HOME:$HADOOP_HOME/bin

RUN sed -i '/^export JAVA_HOME/ s:.*:export JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk:' $HADOOP_PREFIX/etc/hadoop/hadoop-env.sh

#USER hadoop

# expose various ports
EXPOSE 22 8088 50070 50075 50030 50060

CMD bash startup.sh