#生成的新镜像以centos镜像为基础
FROM      a79520/centos79:latest
MAINTAINER a79520,MTkej <1179697713@qq.com>
#升级系统
RUN yum -y update

#安装java
RUN yum install java-1.8.0-openjdk* -y
#安装wget
RUN yum install wget -y
