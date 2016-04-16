<!--[metadata]>
+++
title = "Nginx Docker Image"
description = "PHP-FPM and Nginx Docker Image based on Debian"
author = "Baptiste MOINE <bap.moine.86@gmail.com>"
keywords = ["debian, jessie, 8, nginx, http, fpm, php, web, docker"]
+++
<![end-metadata]-->

Nginx Docker Image
==================

## Setup ##

The quickest but not the best way to get it up is:

```{r, engine='bash', count_lines}
docker run --detach --publish 80:80 --publish 443:443 creased/debian-nginx
```

When done, turn on your web browser and crawl your docker machine (e.g., http://127.0.0.1/) to see your phpinfo().

## Volumes

- `/etc/nginx/`: Nginx's configuration directory ;
- `/etc/php5/fpm/`: PHP-FPM's configuration directory ;
- `/usr/share/nginx/`: HTTP's data directory ;
- `/var/www/`: Alternative to default HTTP's data directory. Must be defined as root directory inside Nginx configuration file to be effective.

## Live display of logs

Let's suppose that `debian-nginx` is the name of your container.

Using `docker logs`:

```{r, engine='bash', count_lines}
docker logs --follow debian-nginx
```

Using `docker attach`:

```{r, engine='bash', count_lines}
docker attach --detach-keys="ctrl-w" debian-nginx
```

## Run bash on container

Let's suppose that `debian-nginx` is the name of your container:

```{r, engine='bash', count_lines}
docker exec --interactive --tty debian-nginx bash
```

Then you will be able to manage your configuration files, debug daemons and much more...