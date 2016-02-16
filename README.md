# Docker container with SSH and PHP
[![Circle CI](https://circleci.com/gh/million12/docker-php-app-ssh.svg?style=svg)](https://circleci.com/gh/million12/docker-php-app-ssh)

This is a Docker container [million12/php-app-ssh](https://registry.hub.docker.com/u/million12/php-app-ssh/) based on [million12/nginx-php](https://registry.hub.docker.com/u/million12/nginx-php/), with **only one addition: running SSH** daemon.

Assuming you use `million12/nginx-php` for running the actual app, you can use this image as a side container to easily get into the container via ssh, perform command-line tasks (eg. composer install, npm, gulp), upload files via SFTP etc.

For different PHP versions, look up different branches of this repository.  
On Docker Hub you can find them under different tags:  
* `million12/php-app-ssh:latest` - PHP 7.0 # built from `master` branch [![Circle CI](https://circleci.com/gh/million12/docker-php-app-ssh.svg?style=svg)](https://circleci.com/gh/million12/docker-php-app-ssh)
* `million12/php-app-ssh:php70` - PHP 7.0 # built from `php70` branch [![Circle CI](https://circleci.com/gh/million12/docker-php-app-ssh/tree/php70.svg?style=svg)](https://circleci.com/gh/million12/docker-php-app-ssh/tree/php70)
* `million12/php-app-ssh:php56` - PHP 5.6 # built from `php56` branch [![Circle CI](https://circleci.com/gh/million12/docker-php-app-ssh/tree/php56.svg?style=svg)](https://circleci.com/gh/million12/docker-php-app-ssh/tree/php56)
* `million12/php-app-ssh:php55` - PHP 5.5 # built from `php55` branch [![Circle CI](https://circleci.com/gh/million12/docker-php-app-ssh/tree/php55.svg?style=svg)](https://circleci.com/gh/million12/docker-php-app-ssh/tree/php55)

## Keys management

SSH keys are added from GitHub via GitHub API. The only thing you need to do is to provide your username (or usernames, coma-separated) via env variable `IMPORT_GITHUB_PUB_KEYS`. Of course you need to have your pubkey added on your GitHub account.

## Usage

`docker run -d -p 1122:22 --volumes-from="webdata-container" --env="IMPORT_GITHUB_PUB_KEYS=user1,user2" million12/php-app-ssh`

After container is launched, you can login:  
`ssh -p 1122 www@docker-host`

##### Fig example:  
```
dev:
  image: million12/php-app-ssh
  ports:
    - '1122:22'
  volumes_from:
    - webdata-container
  environment:
    IMPORT_GITHUB_PUB_KEYS: user1,user2,user3
```

## Author

Marcin ryzy Ryzycki <marcin@m12.io>

---

**Sponsored by [Prototype Brewery](http://prototypebrewery.io/)** - the new prototyping tool for building highly-interactive prototypes of your website or web app. Built on top of [Neos CMS](https://www.neos.io/) and [Zurb Foundation](http://foundation.zurb.com/) framework.
