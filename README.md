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
!If you rebuild image and containers then ip can change.

```
sudo docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' php
```
Or first get the container ID
```
docker ps
docker inspect <container id> | grep "IPAddress"
```
### Composer commands for sites in docker
```
sudo docker-compose exec php composer update
```
