## Docker web server for launch websites.

Put your website to public-html folder.

## Config for mariadb connection
Port - 3306
User - root
Password - root

Find the IP address that has been assigned to the container `mariadb` when service is started by `docker-compose start`:
```
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mariadbtest
```
### Start
Go to docker folder in terminal and run next commands to build an services.

Build containers and run it:
```
sudo docker-compose up -d

```
Stop servises:
```
sudo docker-compose stop
```

### Use url in browser.
To get a Docker container's IP address from the host run command.
Which will return just the IP address for use in browser.
**If you rebuild image and containers then ip can change.

```
sudo docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' php
```
Or first get the container ID
```
docker ps
docker inspect <container id> | grep "IPAddress"
```
### Composer commands for sites in docker
Since the root path to the projects on the web server in docker is `/var/www/html/`. Need to go to this folder and and work internally with projects.

The first way to start composer via `docker exec`
```
sudo docker exec -w /var/www/html php git clone your_repo_url
sudo docker exec -w /var/www/html/your_site php php composer.phar update
```

The second way by going to container bash.
Go to server bash by container name 'php'
```
sudo docker exec -it php bash
```
And run commands like:
```
git clone your_repo_url
cd ./your_repo_url
php composer.phar update
```
### Install xhprof in php bash

Link to extention repo https://github.com/longxinH/xhprof
When services running go to bash and run commands:

```
git clone https://github.com/longxinH/xhprof xhprof
cd xhprof/extension
phpize
./configure --with-php-config=/usr/bin/php-config
sudo make && sudo make install
mkdir /var/tmp/xhprof
```
To find needed paths run commands step by step
```
find /usr -name phpize -type f
find /usr -name php -type f
find /usr -name php-config -type f
```
Output:
```
root@3e300efa12f5:/xhprof/extension# find /usr -name phpize -type f
/usr/local/bin/phpize
root@3e300efa12f5:/xhprof/extension# find /usr -name php -type f
/usr/local/bin/php
root@3e300efa12f5:/xhprof/extension# find /usr -name php-config -type f
/usr/local/bin/php-config

```
Next add config to php.ini in docker_web_server/docker/php/php.ini
```
[xhprof]
extension=xhprof.so
xhprof.output_dir="/var/tmp/xhprof"
```
Then restart services and check updates by phpinfo() in some web page
If in output config has row `xhprof` it installed to php