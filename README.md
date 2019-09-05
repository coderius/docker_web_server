## Docker web server for launch websites.

Put your website to public-html folder.

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
## Run commands inside php service (composer, unit tests etc.)

Go to folder sie-name-dir and show all files and dirs
```
sudo docker exec -w /var/www/html/site-name-dir php ls -l

```
If in root folder exists composer.phar and composer.json.
Run composer update to require modules by composer.json:
```
sudo docker exec -w /var/www/html/site-name-dir php php composer.phar update
```