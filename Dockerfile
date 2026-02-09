FROM centos:7
# Establece el directorio de trabajo correctamente
WORKDIR /etc/yum.repos.d/
# Corrige los repositorios de CentOS 7 que también están movidos
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

RUN yum update -y
RUN yum install httpd wget zip unzip -y
ADD https://www.tooplate.com/zip-templates/2121_wave_cafe.zip /var/www/html
WORKDIR /var/www/html
RUN unzip -o 2121_wave_cafe.zip
RUN cp -r 2121_wave_cafe/* .
RUN rm -rf 2121_wave_cafe 2121_wave_cafe.zip
CMD ["/usr/sbin/httpd","-D","FOREGROUND"]
EXPOSE 80 30000