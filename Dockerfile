FROM centos:latest
ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
RUN yum -y update
RUN yum -y install httpd httpd-tools;systemctl enable httpd.service
RUN yum install php php-fpm php-mysqlnd php-json php-mbstring -y
CMD mkdir -p /var/www
COPY ./centos_deploy_apache_data/ /var/www/
COPY ./centos_deploy_apache_conf/ /etc/httpd/conf.d/
CMD systemctl restart httpd
EXPOSE 80
CMD ["/usr/sbin/init"]
CMD ["/usr/sbin/httpd","-D","FOREGROUND"]
