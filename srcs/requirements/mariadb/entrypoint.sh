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
mariadb-install-db --user=mysql --skip-test-db --datadir=/var/lib/mysql
cd /usr/

sleep infinity

# bind database with socket
mariadbd-safe --user=mysql --bind-address="0.0.0.0" --verbose --datadir=/var/lib/mysql

echo "mariadb database was successfully created"


#/usr/bin/mariadbd
