FROM php:8.4.8-apache-bookworm@sha256:67d471f9ce2d1185f0b30f2d89bed811e206462fb2afb0c835932338506e6a19

# Install mysql PHP extension
# Use production PHP config
# Enable rewrite, headers, and remoteip modules
# Set RemoteIPHeader to X-Forwarded-For
# Replace port 80 from base image with port 8080
RUN docker-php-ext-install pdo_mysql && \
    mv /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini && \
    a2enmod rewrite headers remoteip && \
    echo "RemoteIPHeader X-Forwarded-For" >> \
        /etc/apache2/conf-enabled/remoteip.conf && \
    sed -i 's/Listen 80$/Listen 8080/' /etc/apache2/ports.conf && \
    sed -i 's/:80>/:8080>/' /etc/apache2/sites-enabled/000-default.conf

# Extract ezXSS archive, excluding unncessesary files
# Change owner to www-data:www-data
# Allow execution to image directory for uploading screenshots
ARG VERSION=master
RUN curl -s -L https://api.github.com/repos/ssl/ezXSS/tarball/$VERSION | \
    tar -xvz -C /var/www/html --strip-components=1 && \
    cd /var/www/html/ && \
    rm -rf .dockerignore \
           .env.example \
           .github \
           .gitignore \
           Dockerfile \
           docker-compose.yml \
           docker-entrypoint.sh \
           ezProxy.py \
           license.txt \
           msmtprc \
           nginx-rewrite.conf \
           readme.md && \
    chown www-data:www-data -R /var/www/html && \
    chmod +x /var/www/html/assets/img

# Copy entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/

# Set default environment variables
ENV EZXSS_DBHOST="localhost"
ENV EZXSS_DBUSER="ezxss"
ENV EZXSS_DBPASSWORD="ezxss"
ENV EZXSS_DBNAME="ezxss"
ENV EZXSS_DBPORT=3306
ENV EZXSS_DEBUG="false"
ENV EZXSS_HTTPMODE="true"
ENV EZXSS_SIGNUPENABLED="false"

# Run as www-data:www-data
USER 33:33
EXPOSE 8080/tcp
ENTRYPOINT ["docker-entrypoint.sh"]
