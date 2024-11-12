
# pull the base image
FROM debian:bullseye

# update and upgrade the system
RUN apt-get update && apt-get upgrade -y

# # install the required packages
RUN apt-get install -y nginx openssl

# generate the certif certificate
# RUN openssl req -x509 -nodes -out /etc/nginx/certif/inception.crt -keyout \
#     /etc/nginx/certif/inception.key -subj "/C=MO/ST=KH/L=KH/O=42/OU=42/CN=domain_name.fr/UID=admin_name"

RUN openssl genrsa -out inception.key 2048
RUN openssl req -new -x509 -key inception.key -out inception.crt -days 365


# COPY ./inception.crt /etc/nginx/ssl/

# COPY ./inception.key /etc/nginx/ssl/

# copy the nginx configuration file
COPY ./nginx.conf /etc/nginx/nginx.conf

# create the wordpress directory
RUN mkdir -p /var/www/html/wordpress

# change the owner of the wordpress directory to www-data
RUN chown -R www-data:www-data /var/www/html/wordpress

# define the command to run when the container starts
CMD ["nginx", "-g", "daemon off;"]