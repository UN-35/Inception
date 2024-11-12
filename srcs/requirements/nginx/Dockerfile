
FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y nginx openssl

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
COPY --chmod=755 ./tools/script.sh /etc/nginx/script.sh

RUN mkdir -p /var/www/html/wordpress

RUN chown -R www-data:www-data /var/www/html/wordpress

CMD ["/etc/nginx/script.sh"]