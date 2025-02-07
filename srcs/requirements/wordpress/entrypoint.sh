#!/bin/sh

mkdir -p /var/www/wordpress && chmod -R 755 /var/www/wordpress

# wait for mariadb to start
echo "Waiting for temporary MariaDB instance to be ready..." 2>/dev/stderr
while ! nc -z mariadb 3306; do
		sleep 1
done

# Only install WordPress if not already installed.
if [ ! -f /var/www/wordpress/wp-config.php ]; then
  echo "Downloading WordPress core..."
  wp core download --allow-root --path='/var/www/wordpress'

  echo "Creating wp-config.php..."
  wp config create --path='/var/www/wordpress' \
      --dbname=$WP_DATABASE \
	  --dbuser=$WP_ADMIN_USER \
	  --dbpass=$WP_ADMIN_PASSWORD \
	  --dbhost='mariadb' --allow-root

sed -i "s/<?php/<?php\
if (! isset(\$_SERVER['HTTP_HOST']) ) { \$_SERVER['HTTP_HOST'] = 'glacroix.42.fr';}\
/" "$WORDPRESS_PATH/wp-config.php"

  echo "Installing WordPress..."
  wp core install --allow-root --path='/var/www/wordpress' \
      --url=$WP_URL \
	  --title=$WP_TITLE \
      --admin_user=$WP_ADMIN_USER \
	  --admin_password=$WP_ADMIN_PASSWORD \
	  --admin_email=$WP_ADMIN_EMAIL --skip-email

cd /var/www/wordpress
wp user create $WP_USER $WP_EMAIL --role='editor' --user_pass=$WP_PASSWORD

else
  echo "WordPress already configured. Skipping installation."
fi

sed -i "s/127.0.0.1/0.0.0.0/" /etc/php83/php-fpm.d/www.conf

# Pass control to the CMD (PHP built-in server, for example)
exec "$@"
