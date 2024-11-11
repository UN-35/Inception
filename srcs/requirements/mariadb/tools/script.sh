#!/bin/bash

sed -i "s/127.0.0.1/0.0.0.0/" /etc/mysql/mariadb.conf.d/50-server.cnf

service mariadb start

mysql_secure_installation << EOF

Y
$MYSQL_ROOT_PW
$MYSQL_ROOT_PW
Y
Y
Y
Y
EOF

echo "CREATE DATABASE IF NOT EXISTS $MARIA_DB_NAME ;" | mysql -uroot
echo "CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED BY '$MARIA_RT_PASSWD' ;" | mysql -uroot
echo "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%';" | mysql -uroot
echo "CREATE USER IF NOT EXISTS '$MARIA_USER'@'%' IDENTIFIED BY '$MARIA_USR_PASSWD' ;" | mysql -uroot
echo "GRANT ALL PRIVILEGES ON $MARIA_DB_NAME.* TO '$MARIA_USER'@'%';" | mysql -uroot
echo "FLUSH PRIVILEGES;" | mysql -uroot

service mariadb stop

exec "$@"