FROM ubuntu:20.04

ARG PHP=7.4

WORKDIR /var/www/html

ENV DEBIAN_FRONTEND noninteractive
ENV TZ=UTC
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV ORACLE_HOME /opt/oracle/instantclient_11_2/
ENV LD_LIBRARY_PATH /opt/oracle/instantclient_11_2/
ENV PATH="/usr/bin:/var/www/.composer/vendor/bin:${PATH}"

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo $TZ > /etc/timezone \
    && apt-get update && apt-get install -y software-properties-common build-essential



RUN add-apt-repository ppa:ondrej/php \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        ffmpeg \
        frei0r-plugins \
        xml-twig-tools \
        ssh \
        gnupg \
        gosu \
        curl \
        libcurl4 \
        ca-certificates \
        zip \
        unzip \
        wget \
        git \
        sqlite3 \
        libcap2-bin \
        libssh2-1-dev \
        libssh2-1 \
        libssl-dev \
        zlib1g-dev \
        libpng-dev \
        libc-client-dev \
        libkrb5-dev \
        libldb-dev \
        libldap2-dev \
        libzip-dev \
        libaio-dev \
        libyaml-dev \
        libicu-dev \
        libsmbclient-dev \
        redis-tools \
        iputils-ping \
        supervisor \
        python2 \
        nginx \
        php$PHP \
        php-pear \
        php${PHP}-dev \
        php${PHP}-bcmath \
        php${PHP}-cli \
        php${PHP}-common \
        php${PHP}-curl \
        php${PHP}-fpm \
        php${PHP}-gd \
        php${PHP}-json \
        php${PHP}-mbstring \
        php${PHP}-mysql \
        php${PHP}-opcache \
        php${PHP}-mysql \
        php${PHP}-readline \
        php${PHP}-sqlite3 \
        php${PHP}-xml \
        php${PHP}-xsl \
        php${PHP}-imap \
        php${PHP}-zip \
        php${PHP}-ldap \
        php${PHP}-intl \
        php${PHP}-sockets \
    && php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer \
    && mkdir /run/php \
    && phpenmod \
        sockets


# Install Oracle Instantclient
RUN curl --output /instantclient-basic.zip http://10.2.1.1:8888/app-deps/instantclient-basic.zip
RUN curl --output /instantclient-sdk.zip http://10.2.1.1:8888/app-deps/instantclient-sdk.zip

RUN unzip /instantclient-basic.zip -d /opt/oracle \
    && unzip /instantclient-sdk.zip -d /opt/oracle \
    && ln -s /opt/oracle/instantclient_11_2/libclntsh.so.11.1 /opt/oracle/instantclient_11_2/libclntsh.so \
    && ln -s /opt/oracle/instantclient_11_2/libocci.so.11.1 /opt/oracle/instantclient_11_2/libocci.so \
    && echo 'extension=oci8.so' > /etc/php/$PHP/mods-available/oci.ini \
    && ln -s /etc/php/$PHP/mods-available/oci.ini /etc/php/$PHP/cli/conf.d/10-oci8.ini \
    && ln -s /etc/php/$PHP/mods-available/oci.ini /etc/php/$PHP/fpm/conf.d/10-oci8.ini \
    && rm -rf /instantclient-*.zip \
    && echo "instantclient,$ORACLE_HOME" | pecl install oci8-2.2.0 \
    && echo $ORACLE_HOME > /etc/ld.so.conf.d/oracle-instantclient.conf \
    && ldconfig

RUN pecl install \
    yaml \
    ssh2-1.2 \
&& echo "extension=yaml.so" > /etc/php/$PHP/cli/conf.d/10-yaml.ini \
&& echo "extension=yaml.so" > /etc/php/$PHP/fpm/conf.d/10-yaml.ini \
&& echo "extension=ssh2.so" > /etc/php/$PHP/cli/conf.d/10-ssh2.ini \
&& echo "extension=ssh2.so" > /etc/php/$PHP/fpm/conf.d/10-ssh2.ini

RUN echo "daemon off;" >> /etc/nginx/nginx.conf

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log



#RUN apt-get install -y --no-install-recommends \

# clean up
RUN apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && apt-get remove -y --purge software-properties-common

RUN alias php='/usr/bin/php'

