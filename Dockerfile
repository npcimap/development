FROM centos:6
MAINTAINER Takashi Kawamoto kawamoto@nihon-protec.co.jp
ENV container docker
RUN yum update -y && yum clean all
RUN yum -y install httpd && yum clean all
RUN echo "Hello Docker!" > /var/www/html/index.html
RUN chkconfig httpd on
RUN yum -y install java-1.6.0-openjdk
RUN yum -y install java-1.6.0-openjdk-devel
RUN yum -y install yum-priorities
RUN rpm -Uvh http://mirrors.dotsrc.org/jpackage/6.0/generic/free/RPMS/jpackage-release-6-3.jpp6.noarch.rpm
RUN yum -y --nogpgcheck install tomcat7-webapps
RUN yum -y --nogpgcheck install tomcat7-admin-webapps
RUN chkconfig tomcat7 on
RUN chkconfig --list tomcat7
EXPOSE 80
EXPOSE 8080
CMD ["/sbin/init"]
COPY httpd-proxy.conf /etc/httpd/conf.d/
COPY tomcat-users.xml /etc/tomcat7/
