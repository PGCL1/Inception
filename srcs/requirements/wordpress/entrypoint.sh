#!/bin/bash
set -e

mkdir -p /var/www/html
cd /var/www/html
mkdir -p /var/www/wordpress && chmod -R 755 /var/www/wordpress

# Only install WordPress if not already installed.
if [ ! -f wp-config.php ]; then
  echo "Downloading WordPress core..."
  wp core download --allow-root --path=/var/www/html

  echo "Creating wp-config.php..."
  wp config create --allow-root --path=/var/www/html \
      --dbname="$MYSQL_DATABASE" \
	  --dbuser="$MYSQL_ROOT_USER" \ 
	  --dbpass="$MYSQL_ROOT_PASSWORD" \
	  --dbhost="$MYSQL_HOST"

  echo "Installing WordPress..."
  wp core install --allow-root --path=/var/www/html \
      --url="$WP_URL" \
	  --title="$WP_TITLE" \
      --admin_user="$WP_ADMIN_USER" \
	  --admin_password="$WP_ADMIN_PASSWORD" \
	  --admin_email="$WP_ADMIN_EMAIL"
else
  echo "WordPress already configured. Skipping installation."
fi

# Pass control to the CMD (PHP built-in server, for example)
exec "$@"

