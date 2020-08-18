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

## Config for mariadb connection and usage
Port - 3306
User - root
Password - root

Find the IP address that has been assigned to the container `mariadb` when service is started by `docker-compose start`:
First way:
```
docker ps
docker inspect <container id> | grep "IPAddress"
```
In windows:
```
docker ps
docker inspect <container id> | findstr "IPAddress"
```

Second way:
```
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mariadbtest
```
**MariaDb usage command line**

When service running go inside container:
```
sudo docker exec -it mariadb  bash
```
Past login and password:
```
mysql -u root -p
```
And work in mysql cli...

### Use url in browser.
*Simple way to open website in browser by link* `http://localhost:8880/site_dir`.

*Or by passing ip in http.*

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

To exit from bash pass commant in terminal `exit` .

### Debugging docker containers.
Show started containers:
```
sudo docker ps
```
If container can`t starying, show logs by container name:
```
sudo docker logs php
```

### Using Xdebug with docker.
Xdebug install with php service and ready to use in any ide like vscode or netbeanse.

##### Steps to useage xdebug with vscode

**!Attention. It is important to check if port 9000 is free and the firewall settings**

First install **PHP Debug** and **PHP IntelliSense** extentions in vscode extentions menu (author Felix Becker)

1. Go to folder `docker_web_server` and create configuration file going to the menu `debug -> Add configuration`. 
`launch.json` contains this code:

```
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Listen for XDebug",
            "type": "php",
            "request": "launch",
            "port": 9000,
            "log": true,
            "pathMappings": {
                "/var/www/html": "${workspaceFolder}/public-html"
            },
            "xdebugSettings": {
                "max_data": 65535,
                "show_hidden": 1,
                "max_children": 100,
                "max_depth": 5
            }
        },
        {
            "name": "Launch currently open script",
            "type": "php",
            "request": "launch",
            "program": "${file}",
            "cwd": "${fileDirname}",
            "port": 9000
        }
    ]
}
```
2. Next open `docker_web_server/docker/php/php.ini` and find `xdebug.idekey="docker-xdebug"` .This is key to pass in browser url window to hendler xdebug request.

3. Start docker services:
```
sudo docker-compose up -d
```

4. Open needed php file inside `docker_web_server/public-html`  and set breakpoint

5. In menu `debugging` click to `start debugging`

6. Open in browser url with needed project:
```
http://localhost:8880/coderius.biz.ua/?XDEBUG_SESSION_START=netbeans-xdebug
```
7. Xdebug most stop script in breakpoint in vscode.

##### Steps to useage xdebug with netbeanse

1. Add prodject to ide.

2. Open menu/config by right click in root project folder.

_the text is still being written..._

### PhpUnit
Go to container
```
sudo docker exec -it php bash
```

Run tests in project folder inside `root@1f29f223665a:/var/www/html# `:

```
vendor/bin/phpunit
```

Set alias to phpunit in container:
```
alias phpunit="/var/www/html/{your-proj}/vendor/bin/phpunit"
```
