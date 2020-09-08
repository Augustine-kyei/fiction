FROM php:7.2-apache
COPY /tmp/workspace/  /var/www/html/
EXPOSE 80
