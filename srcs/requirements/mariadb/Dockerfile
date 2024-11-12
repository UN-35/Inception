

FROM debian:bullseye

RUN apt-get update 
RUN apt-get install -y mariadb-server mariadb-client \
    && rm -rf /var/lib/apt/lists/*


COPY ./tools/script.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/script.sh

ENTRYPOINT [ "/usr/local/bin/script.sh" ]

CMD ["mysqld_safe"]
