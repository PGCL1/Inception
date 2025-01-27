FROM alpine:3.21.2

RUN apk add --no-cache \
    php82 \
    php82-fpm \
    php82-mysqli \
    php82-pdo \
    php82-pdo_mysql \
    php82-gd \
    php82-xml \
    php82-mbstring \
    php82-curl \
    php82-zip \
	curl


# Set the working directory
WORKDIR /var/www/html

# Copy PHP-FPM configuration and script
COPY php-fpm.conf /etc/php82/php-fpm.conf
COPY ./entrypoint.sh ./entrypoint.sh

# Expose the PHP-FPM port
EXPOSE 9000

RUN chmod +x ./entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
