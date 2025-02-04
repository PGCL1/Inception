FROM alpine:3.21.2

RUN apk add --no-cache \
  php php-common php-fpm \
  php-mysqli php-json php-session php-zlib php-gd \
  php-mbstring php-openssl php-curl php-dom wget tar \
  mariadb-client curl \
  php-phar php-simplexml php-xmlwriter php-tokenizer php-zip

RUN curl -L https://github.com/wp-cli/wp-cli/releases/download/v2.7.1/wp-cli-2.7.1.phar \
  -o /usr/local/bin/wp \
 && chmod +x /usr/local/bin/wp

# Create a directory for Worpress and download Wordpress
COPY ./entrypoint.sh ./entrypoint.sh 
RUN chmod +x ./entrypoint.sh

EXPOSE 9000

ENTRYPOINT ["./entrypoint.sh"]

