#生成的新镜像以centos镜像为基础
FROM a79520/centos79
MAINTAINER by zzb (zhangzhengbo@hotmail.com)
#升级系统
RUN yum -y update
#安装openssh-server
RUN yum -y install openssh-server
#安装openssh-clients
RUN yum -y install openssh-clients
#修改/etc/ssh/sshd_config
RUN sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config \
    && sed -i '$a\RSAAuthentication yes' /etc/ssh/sshd_config \
    && sed -i '$a\PubkeyAuthentication yes' /etc/ssh/sshd_config \
    && sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config \
    && sed -i '$a\IdentityFile /etc/ssh/ssh_host_rsa_key' /etc/ssh/ssh_config
    #将密钥文件复制到/etc/ssh/目录中
ADD ssh_host_rsa_key /etc/ssh/ssh_host_rsa_key
ADD ssh_host_rsa_key.pub /etc/ssh/ssh_host_rsa_key.pub
RUN mkdir -p /root/.ssh
ADD authorized_keys /root/.ssh/authorized_keys
#更改秘钥的文件权限
RUN chmod 700 /root/.ssh
RUN chmod 600 /root/.ssh/authorized_keys
#将ssh服务启动脚本复制到/usr/local/sbin目录中，并改变权限为755
ADD run.sh /usr/local/sbin/run.sh
RUN chmod 755 /usr/local/sbin/run.sh
#变更root密码为123456
RUN echo "root:123456"|chpasswd
#开放窗口的22端口
EXPOSE 22
#运行脚本，启动sshd服务
CMD ["/usr/local/sbin/run.sh"]

#安装java
RUN yum install java-1.8.0-openjdk* -y
#安装wget
RUN yum install wget -y
