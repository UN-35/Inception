#!/bin/bash
#---------------------------------------------------wp installation---------------------------------------------------#
# wp-cli installation
if [ -f /var/www/html/wordpress/testee.txt ]; then
    echo "wp already Done"
else
    cd wordpress
    wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar;
    chmod +x wp-cli.phar; 
	mv wp-cli.phar /usr/local/bin/wp;
    wp core download --allow-root;
    echo "Hello"
    mv /var/www/html/wp-config.php /var/www/html/wordpress/wp-config.php
    chown -R www-data:www-data wordpress
    find /var/www/html/wordpress -type d -exec chmod 755 {} \;
    find /var/www/html/wordpress -type f -exec chmod 644 {} \;
    sed -i "s/database_name_here/$MARIA_DB_NAME/" wp-config.php 
    sed -i "s/username_here/$MARIA_USER/" wp-config.php  
    sed -i "s/password_here/$MARIA_USR_PASSWD/" wp-config.php  
    sed -i "s/localhost/mariadb/" wp-config.php
    touch testee.txt

    wp core install --allow-root --url=${DOMAIN_NAME} --title=${WP_TITLE} --admin_user=${WP_ADMIN} --admin_password=${WP_ADMIN_PS} --admin_email=${WP_ADMIN_EMAIL}
	wp user create --allow-root ${WP_USER} ${WP_USER_EMAIL} --user_pass=${WP_USER_PS};
fi
exec "$@"
# download wordpress core files
# # create wp-config.php file with database details
# wp core config --dbhost=mariadb:3306 --dbname="$MARIA_DB_NAME" --dbuser="$MARIA_USER" --dbpass="$MARIA_RT_PASSWD" --allow-root
# # install wordpress with the given title, admin username, password and email
# wp core install --url="$DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN" --admin_password="$WP_PASSWD" --admin_email="$WP_ADMIN_EMAIL" --allow-root
# #create a new user with the given username, email, password and role
# wp user create "$WP_USER" "$WP_USER_EMAIL" --user_pass="$WP_PASSWD" --role="$WP_U_ROLE" --allow-root



# mv wp-config-sample.php wp-config.php
# sed -i "s/database_name_here/$MARIA_DB_NAME/1" wp-config.php
# sed -i "s/username_here/$MARIA_DB_NAME/1" wp-config.php
# sed -i "s/password_here/$MARIA_RT_PASSWD/1" wp-config.php
# sed -i "s/localhost/mariadb/1" wp-config.php



# # wp core download

# wp core install --url=$DOMAIN_NAME --title=$WP_USER --admin_user=$WP_USER --admin_password=$WP_PASSWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root

# wp user create $WP_USER $WP_USER_EMAIL --role=author --user_pass=$WP_PASSWD --allow-root




#---------------------------------------------------php config---------------------------------------------------#

# # change listen port from unix socket to 9000
# sed -i '36 s@/run/php/php7.4-fpm.sock@9000@' /etc/php/7.4/fpm/pool.d/www.conf
# # create a directory for php-fpm
# mkdir -p /run/php
# # start php-fpm service in the foreground to keep the container running
# /usr/sbin/php-fpm7.4 -F
