#
# Nginx Dockerfile
#
# Written by:
#   Baptiste MOINE <bap.moine.86@gmail.com>
#

# Pull base image (ie, Debian 8).
FROM debian:8

MAINTAINER Baptiste MOINE <bap.moine.86@gmail.com>

# Non-interactive frontend.
ENV DEBIAN_FRONTEND noninteractive

# Copy sourcelist for APT.
COPY files/apt/sources.list /etc/apt/sources.list

# Note: Each RUN instruction will perform a commit of the image.
# Install Nginx and PHP using only one instruction.
RUN apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys ABF5BD827BD9BF62 \
&& apt-get update \
&& apt-get install -y --no-install-recommends --no-install-suggests \
                   ca-certificates \
                   nginx="1.9.0-1~jessie" \
                   spawn-fcgi \
                   gettext-base \
                   php5-fpm \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

# Create Nginx and PHP file structure.
RUN rm -rf /usr/share/nginx/html/ \
&& mkdir -p /etc/nginx.default/conf.d/ \
&& mkdir -p /etc/php5/fpm.default/pool.d/ \
&& mkdir -p /usr/share/nginx/logs \
&& mkdir -p /usr/share/nginx/static \
&& mkdir -p /usr/share/nginx/webroot \
&& touch /usr/share/nginx/logs/access.log \
&& touch /usr/share/nginx/logs/error.log \
&& rm /etc/nginx/nginx.conf \
&& rm /etc/php5/fpm/pool.d/www.conf

# Copy default Nginx configuration files using ADD to keep directory structure (issue #15858).
ADD files/nginx/conf/ /etc/nginx.default/

# Copy default PHP configuration files using ADD to keep directory structure (issue #15858).
ADD files/fpm/conf/ /etc/php5/fpm.default/

# Add default webroot.
ADD files/nginx/webroot.tar.gz /usr/share/nginx/

# Copy Startup script.
COPY files/start.sh /start.sh
RUN chmod u+x /start.sh

VOLUME ["/etc/nginx/"]
VOLUME ["/etc/php5/fpm/"]
VOLUME ["/usr/share/nginx/webroot/"]
VOLUME ["/var/www/"]

# TCP port that container will listen for connections.
# HTTP and HTTPS.
EXPOSE 80 443

# Alternative to: CMD ["nginx", "-g", "daemon off;"]
CMD ["/start.sh"]

