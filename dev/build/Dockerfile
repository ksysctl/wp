FROM wordpress:php7.3-apache

LABEL maintainer="moises.brenes@gmail.com"
LABEL description="WP Project"

ENV \
    WP_CLI_URL=https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN echo "\nServerName localhost\n" \
    >>/etc/apache2/apache2.conf

# Update && install basic utilities
RUN apt-get update && \
    apt-get install -y apt-utils 

# Install dependencies
RUN apt-get install -y less ssl-cert
RUN a2enmod ssl && a2ensite default-ssl
 
# Install WP-CLI
RUN curl -s -o /usr/local/bin/wp ${WP_CLI_URL} \
    && chmod +x /usr/local/bin/wp

EXPOSE 80 443