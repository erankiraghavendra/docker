FROM centos:latest

MAINTAINER Raghavendra Eranki

#installing the Required RPM's
RUN yum -y update
RUN yum -y install wget curl vim
RUN yum -y install tar
RUN yum -y install unzip
RUN yum -y install net-tools

#Creating a Directory.

RUN mkdir /abc/
RUN mkdir -p /abc/software
RUN mkdir -p /abc/software/java
RUN mkdir -p /abc/tools

#Settting the ENV for abc and JAVA

ENV JAVA_HOME /abc/software/java/jdk


#Copying the java tar file.

COPY jdk1.8.0_144 /abc/software/java/jdk1.8.0_144

#soft link for java jdk

RUN  ln -s /abc/software/java/jdk1.8.0_144/ /abc/software/java/jdk

# for old scripts

RUN ln -s /abc/software/java/jdk/ /abc/software/java/jdk1.7.0_67

#seting the profile of the abc , Ant, java or path.

COPY abc.sh /etc/profile.d/abc.sh
COPY ant.sh  /etc/profile.d/ant.sh
COPY java.sh /etc/profile.d/java.sh

WORKDIR /abc/tools

#Copying the folders.
#WORKDIR /abc/tools

COPY tools /abc/tools

RUN chmod -R 777 /abc/tools

EXPOSE 8800

COPY start.sh /

WORKDIR /

CMD ["/bin/sh", "start.sh"]

