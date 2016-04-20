#!/bin/bash

#
# Startup script for Nginx-Docker Container
#
# Written by:
#   Baptiste MOINE <bap.moine.86@gmail.com>
#

# Cause that configuration files are visible from volumes, let's verify that there is configuration file before trying to run.
if [ ! -f /etc/nginx/nginx.conf ]; then
    cp -R /etc/nginx.default/* /etc/nginx/
fi

if [ ! -f /etc/php5/fpm/pool.d/www.conf ]; then
    cp -R /etc/php5/fpm.default/* /etc/php5/fpm/
fi

PHP=/usr/sbin/php5-fpm
NGINX=/usr/sbin/nginx

# Show PHP version then exit.
${PHP} -v

# Test PHP configuration then exit.
${PHP} -t

# Run PHP in background (ignoring daemon option from configuration file).
${PHP} --daemonize

# Show Nginx version and configure options then exit.
${NGINX} -V

# Test Nginx configuration then exit.
${NGINX} -t

# Run Nginx in background (ignoring daemon option from configuration file) then display logs.
${NGINX} -g "daemon on;" && tail -f /usr/share/nginx/log/error.log -f /usr/share/nginx/log/access.log

