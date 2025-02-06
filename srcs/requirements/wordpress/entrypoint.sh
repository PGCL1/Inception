#!/bin/sh

mkdir -p /var/www/wordpress && chmod -R 755 /var/www/wordpress

# wait for mariadb to start
echo "Waiting for temporary MariaDB instance to be ready..." 2>/dev/stderr
while ! ping mariadb -c1 &>/dev/null; do
		sleep 1
done

# Only install WordPress if not already installed.
if [ ! -f wp-config.php ]; then
  echo "Downloading WordPress core..."
  wp core download --allow-root --path='/var/www/wordpress'

  echo "this is the database: '$WP_DATABASE'";
  echo "this is the admin-user: '$WP_ADMIN_USER'";
  echo "this is the admin-password: '$WP_ADMIN_PASSWORD'";

  echo "Creating wp-config.php..."
  wp config create --path='/var/www/wordpress' \
      --dbname=$WP_DATABASE \
	  --dbuser=$WP_ADMIN_USER \
	  --dbpass=$WP_ADMIN_PASSWORD \
	  --dbhost='mariadb:3306' --allow-root


  echo "Installing WordPress..."
  wp core install --allow-root --path='/var/www/wordpress' \
      --url=$WP_URL \
	  --title=$WP_TITLE \
      --admin_user=$WP_ADMIN_USER \
	  --admin_password=$WP_ADMIN_PASSWORD \
	  --admin_email=$WP_ADMIN_EMAIL
else
  echo "WordPress already configured. Skipping installation."
fi

		  sleep infinity
	wp user create $WP_USER $WP_EMAIL --role='editor' --user_pass=$WP_PASSWORD

# Pass control to the CMD (PHP built-in server, for example)
exec "$@"
