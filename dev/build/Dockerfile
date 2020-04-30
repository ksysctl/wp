FROM wordpress:php7.3-apache

LABEL maintainer="moises.brenes@gmail.com"
LABEL description="WP Project"

ENV \
    WP_CLI_URL=https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

ARG \
    PHP_EXTENSION_XDEBUG=0

# Update && install basic utilities
RUN apt-get update && \
    apt-get install -y apt-utils 

# Install dependencies
RUN apt-get install -y less ssl-cert

# Enable modules
RUN a2enmod ssl  && \
    a2enmod headers && \
    a2ensite default-ssl

# Set http configuration
COPY dev/deploy/apache/security.conf \
    /etc/apache2/conf-available/security.conf
COPY dev/deploy/apache/default.conf \
    /etc/apache2/sites-available/000-default.conf
COPY dev/deploy/apache/default.ssl.conf \
    /etc/apache2/sites-available/default-ssl.conf
COPY dev/deploy/apache/http.conf \
    /etc/apache2/apache2.conf

# Install xdebug
COPY dev/deploy/xdebug.ini \
    /usr/local/etc/php/conf.d/xdebug.ini
RUN if [ ${PHP_EXTENSION_XDEBUG} = 1 ]; then \
    yes | pecl install xdebug; \
    sed -i "s/xdebug.remote_autostart=0/xdebug.remote_autostart=1/g" /usr/local/etc/php/conf.d/xdebug.ini && \
    sed -i "s/xdebug.remote_enable=0/xdebug.remote_enable=1/g" /usr/local/etc/php/conf.d/xdebug.ini && \
    echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" >> \
        /usr/local/etc/php/conf.d/xdebug.ini; \
fi

# Install WP-CLI
RUN curl -s -o /usr/local/bin/wp ${WP_CLI_URL} \
    && chmod +x /usr/local/bin/wp

# Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm /var/log/lastlog /var/log/faillog && \
    rm /var/log/apt/term.log /var/log/apt/history.log 

EXPOSE 10000 80 443