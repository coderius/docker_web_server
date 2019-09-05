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
