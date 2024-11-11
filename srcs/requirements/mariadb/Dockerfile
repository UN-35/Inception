# Use Debian as the base image
FROM debian:bullseye

# Install MariaDB
RUN apt-get update 
RUN apt-get install -y mariadb-server mariadb-client \
    && rm -rf /var/lib/apt/lists/*


COPY ./tools/script.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/script.sh
# Expose the default MariaDB port

ENTRYPOINT [ "/usr/local/bin/script.sh" ]
# Start MariaDB when the container starts
CMD ["mysqld_safe"]