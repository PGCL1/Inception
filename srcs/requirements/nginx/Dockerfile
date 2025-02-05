FROM alpine:3.20

RUN apk add --no-cache nginx openssl 

RUN openssl req -x509 -nodes -days 365 \
  -subj "/C=ES/ST=Madrid/L=Madrid/O=glacroix/OU=glacroix/CN=glacroix.42.fr" \
  -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key \
  -out /etc/ssl/certs/nginx-selfsigned.crt 

COPY default.conf /etc/nginx/http.d/default.conf 

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
