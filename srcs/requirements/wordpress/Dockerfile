# Description: Wordpress Dockerfile

# pull the base image
FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y php php-fpm php-mbstring php-bcmath php-xml php-mysql php-common php-gd php-cli php-curl php-zip php-imagick php-ldap php-intl wget tar && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/php

WORKDIR /var/www/html/

COPY ./script.sh /usr/local/bin/
COPY ./www.conf /etc/php/7.4/fpm/pool.d/
COPY ./wp-config.php /var/www/html/

RUN chmod +x /usr/local/bin/script.sh


# change the permission of the script to make it executable

ENTRYPOINT [ "/usr/local/bin/script.sh" ]
# Update the CMD with the correct path
CMD ["php-fpm7.4", "-F"]