FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive 
ENV PS_VERSION=1.7.4.2

RUN apt-get update -y \
    && apt-get install apache2 -y \
    && apt-get update -y 

RUN apt-get install software-properties-common -y\
    && add-apt-repository ppa:ondrej/php -y \
    && apt-get update -y \
    && apt-get install php7.2 -y \
    && apt-get install php-pear php7.2-curl php7.2-dev php7.2-gd php7.2-mbstring php7.2-zip php7.2-mysql php7.2-xml php7.2-pgsql -y \
    && apt-get update -y && apt-get upgrade -y

RUN apt-get install nano -y

RUN mkdir -p /var/www/prestashop

RUN apt-get install unzip

COPY prestashop_${PS_VERSION}.zip /var/www/

RUN unzip /var/www/prestashop_${PS_VERSION}.zip -d /var/www/prestashop \
    && rm /var/www/prestashop_${PS_VERSION}.zip

COPY run.sh /var/www/prestashop/

RUN chmod a+x /var/www/prestashop/run.sh \
    && chmod -R a+w /var/www/prestashop

COPY prestashop.conf /etc/apache2/sites-available/

RUN a2dissite 000-default.conf && a2ensite prestashop.conf

EXPOSE 80

ENTRYPOINT ["/var/www/prestashop/run.sh" ]