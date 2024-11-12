
# pull the base image
FROM debian:bullseye

# update and upgrade the system
RUN apt-get update && apt-get upgrade -y

# # install the required packages
RUN apt-get install -y nginx openssl


# copy the nginx configuration file
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY --chmod=755 ./script.sh /etc/nginx/script.sh

# create the wordpress directory
RUN mkdir -p /var/www/html/wordpress

# change the owner of the wordpress directory to www-data
RUN chown -R www-data:www-data /var/www/html/wordpress

# define the command to run when the container starts
CMD ["/etc/nginx/script.sh"]