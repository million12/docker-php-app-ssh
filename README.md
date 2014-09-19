# Docker container with SSH and PHP

This is a Docker container based on [million12/php-app](https://registry.hub.docker.com/u/million12/php-app/), with only one addition: running SSHD daemon. Because it shares the same container as other running PHP apps (if based on million12/php-app), it can be used for development purposes, to easily get into the container, perform command-line tasks (eg. composer, npm, gulp), upload files via SFTP etc.
