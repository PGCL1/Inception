FROM alpine:3.20

RUN apk add --no-cache mariadb mariadb-client

RUN mkdir -p /var/lib/mysql /run/mysqld /var/log/mysql && \
    chown -R mysql:mysql /var/lib/mysql /run/mysqld /var/log/mysql && \
    chmod 755 /var/lib/mysql /run/mysqld /var/log/mysql

COPY my.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY ./entrypoint.sh ./entrypoint.sh

RUN chmod +x ./entrypoint.sh

#EXPOSE 3306

ENTRYPOINT ["./entrypoint.sh"]
