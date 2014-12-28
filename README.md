# Docker container with SSH and PHP
[![Circle CI](https://circleci.com/gh/million12/docker-php-app-ssh.svg?style=svg)](https://circleci.com/gh/million12/docker-php-app-ssh)

This is a Docker container [million12/php-app-ssh](https://registry.hub.docker.com/u/million12/php-app-ssh/) based on [million12/php-app](https://registry.hub.docker.com/u/million12/php-app/), with only one addition: running SSHD daemon. 

Because it shares the same container as other running PHP apps (if based on million12/php-app), it can be used for development purposes, to easily get into the container, perform command-line tasks (eg. composer install, npm, gulp), upload files via SFTP etc.

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

**Sponsored by** [Typostrap.io - the new prototyping tool](http://typostrap.io/) for building highly-interactive prototypes of your website or web app. Built on top of TYPO3 Neos CMS and Zurb Foundation framework.
