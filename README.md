Nginx Docker Image
==================

[![](https://badge.imagelayers.io/creased/debian-nginx:latest.svg)](https://imagelayers.io/?images=creased/debian-nginx:latest 'Get your own badge on imagelayers.io')

## Setup ##

The quickest but not the best way to get it up is:

```bash
docker run --detach --publish 80:80/tcp --publish 443:443/tcp --interactive --tty --name debian-nginx creased/debian-nginx
```

Please consider using:

```bash
docker create --publish 80:80/tcp --publish 443:443/tcp --interactive --tty --name debian-nginx creased/debian-nginx
docker start debian-nginx
```

When done, turn on your web browser and crawl your docker machine (e.g., http://127.0.0.1/) to see your phpinfo().

## Volumes ##

- `/etc/nginx/`: Nginx's configuration directory ;
- `/etc/php5/fpm/`: PHP-FPM's configuration directory ;
- `/usr/share/nginx/webroot/`: HTTP's data directory ;
- `/var/www/`: Alternative to default HTTP's data directory. Must be defined as root directory inside Nginx configuration file to be effective.

## Live display of logs ##

Let's suppose that `debian-nginx` is the name of your container.

Using `docker logs`:

```bash
docker logs --follow debian-nginx
```

Using `docker attach`:

```bash
docker attach --detach-keys="ctrl-w" debian-nginx
```

## Run bash on container ##

Let's suppose that `debian-nginx` is the name of your container:

```bash
docker exec --interactive --tty debian-nginx bash
```

Then you will be able to manage your configuration files, debug daemons and much more...
