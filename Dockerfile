# pull again
FROM alpine-php-nginx:8.1

USER root 

RUN apk update 

COPY . /var/www/app
COPY .env.prod /var/www/app/.env
COPY ./docker/nginx.conf /etc/nginx/nginx.conf

RUN chown -R www:www /var/www/app/storage/

USER root

WORKDIR /var/www/app 
RUN composer install --optimize-autoloader --no-dev

# Optimize 
RUN php artisan config:cache
RUN php artisan route:cache
RUN php artisan view:cache