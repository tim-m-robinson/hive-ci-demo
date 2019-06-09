FROM openjdk:8-jdk-alpine

LABEL version="1.0" maintainer="Tim Robinson "

RUN apk update && apk add --no-cache \
        openssh \
        shadow

WORKDIR /root

RUN usermod -p '*' root

#setup ssh
RUN ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa && \
        cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

RUN mv /etc/ssh/ssh_config /etc/ssh/ssh_config.orig
ADD ssh_config /etc/ssh/ssh_config

# expose various ports
EXPOSE 22

CMD /usr/sbin/sshd