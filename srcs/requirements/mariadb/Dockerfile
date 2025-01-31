FROM alpine:3.21.2

RUN apk add --no-cache mariadb mariadb-client

COPY my.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY ./entrypoint.sh ./entrypoint.sh

RUN chmod +x ./entrypoint.sh

#EXPOSE 3306

ENTRYPOINT ["./entrypoint.sh"]
