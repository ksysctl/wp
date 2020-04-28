FROM wordpress:php7.3-apache

LABEL maintainer="moises.brenes@gmail.com"
LABEL description="WP Project"

ENV \
    WP_CLI_URL=https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# Update && install basic utilities
RUN apt-get update && \
    apt-get install -y apt-utils 

# Install dependencies
RUN apt-get install -y less ssl-cert
RUN yes | pecl install xdebug

# Enable modules
RUN a2enmod ssl  && \
    a2enmod headers
RUN a2ensite default-ssl

# Set http configuration
COPY dev/deploy/apache/security.conf \
    /etc/apache2/conf-available/security.conf
COPY dev/deploy/apache/default.conf \
    /etc/apache2/sites-available/000-default.conf
COPY dev/deploy/apache/default.ssl.conf \
    /etc/apache2/sites-available/default-ssl.conf
COPY dev/deploy/apache/http.conf \
    /etc/apache2/apache2.conf

# Install WP-CLI
RUN curl -s -o /usr/local/bin/wp ${WP_CLI_URL} \
    && chmod +x /usr/local/bin/wp

EXPOSE 10000 80 443