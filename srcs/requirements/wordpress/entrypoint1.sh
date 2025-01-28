#!/bin/sh

# exit the program if command exits with a non zero
set -e 

# creating php directory
mkdir -p /run/php

# Check if www-data group exists
if ! getent group www > /dev/null; then
	echo "Group www doesn't exist. Creating group"
    addgroup www
fi

# Check if www-data user exists
if ! grep -q "^www:" /etc/passwd; then
    echo "User www does not exist. Creating user"
    adduser -D -G www www
	chown -R www:www /run/php
	chmod 770 /run/php
else
    echo "User www already exists."
fi

# need to do php-fpm82 
sleep infinity
