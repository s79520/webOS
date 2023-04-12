#生成的新镜像以centos镜像为基础
FROM      a79520/centos79:latest
MAINTAINER a79520,MTkej <1179697713@qq.com>
#升级系统
RUN yum -y update
#安装openssh-server
RUN yum -y install openssh-server
#安装openssh-clients
RUN yum -y install openssh-clients

#运行脚本，启动sshd服务
CMD ["/usr/local/sbin/run.sh"]

#安装java
RUN yum install java-1.8.0-openjdk* -y
#安装wget
RUN yum install wget -y
