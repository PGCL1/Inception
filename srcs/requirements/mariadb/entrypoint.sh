#!/bin/sh

# create directories mariadb
mkdir -p /var/lib/mysql /run/mysqld 

if [ ! -d /var/lib/mysql ] && [ ! -d /run/mysqld ]; then
		echo "Directories were not correctly created"
		exit 1
fi

# change ownership to mysql user and group
chown -R mysql:mysql /var/lib/mysql /run/mysqld

# set working dir
cd /var/lib/mysql

# initalize database
mariadb-install-db --user=mysql --datadir=/var/lib/mysql

echo "mariadb database was successfully created"

sleep infinity

#/usr/bin/mariadbd
