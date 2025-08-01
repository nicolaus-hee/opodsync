FROM alpine:edge
RUN apk --no-cache add git php83 php83-ctype php83-opcache php83-session php83-sqlite3

# Setup document root
RUN mkdir -p /var/www
RUN mkdir -p /var/www/server
RUN mkdir -p /var/www/server/data

# Add application
WORKDIR /var/www/

RUN git clone --depth 1 https://github.com/nicolaus-hee/opodsync.git /tmp/opodsync \
 && cp -a /tmp/opodsync/server/. /var/www/server  \
 && rm -rf /tmp/opodsync

EXPOSE 8080

VOLUME ["/var/www/server/data"]

ENV PHP_CLI_SERVER_WORKERS=2
CMD ["php", "-S", "0.0.0.0:8080", "-t", "server", "server/index.php"]