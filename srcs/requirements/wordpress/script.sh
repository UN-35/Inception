#!/bin/bash




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

