FROM centos:centos6
MAINTAINER yuubon

RUN yum install -y openssh openssh-server openssh-clients
RUN yum install -y vim
RUN yum install -y httpd
RUN yum install -y php php-mbstring php-pear
RUN yum install -y opnessl-devel zlib-devel 
RUN yum install -y ruby ruby-dev rdoc irb
RUN yum install -y python-setuptools

RUN mkdir ~/.ssh
RUN chmod 777 ~/.ssh

RUN mkdir -p /var/run/sshd && chmod 755 /var/run/sshd

RUN easy_install supervisor

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2

ADD ./sshd_config /etc/ssh/sshd_config
ADD ./supervisord.conf /etc/supervisord.conf

RUN echo 'root:root' | chpasswd

RUN /etc/init.d/sshd start
RUN /etc/init.d/sshd stop

EXPOSE 22 80 8022

CMD ["supervisord", "-n"]


