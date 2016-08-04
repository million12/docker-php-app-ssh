#
# million12/php-app-ssh
#
FROM million12/nginx-php:latest
MAINTAINER Marcin Ryzycki marcin@m12.io

# - Install OpenSSH server
# - Generate required host keys
# - Remove 'Defaults secure_path' from /etc/sudoers which overrides path when using 'sudo' command
# - Add 'www' user to sudoers
# - Remove non-necessary Supervisord services from parent image 'million12/nginx-php'
# - Remove warning about missing locale while logging in via ssh
RUN \
  yum install -y openssh-server pwgen sudo vim mc links && \
  yum clean all && \

  sed -i -r 's/.?UseDNS\syes/UseDNS no/' /etc/ssh/sshd_config && \
  sed -i -r 's/.?PasswordAuthentication.+/PasswordAuthentication no/' /etc/ssh/sshd_config && \
  sed -i -r 's/.?UsePAM.+/UsePAM no/' /etc/ssh/sshd_config && \
  sed -i -r 's/.?ChallengeResponseAuthentication.+/ChallengeResponseAuthentication no/' /etc/ssh/sshd_config && \
  sed -i -r 's/.?PermitRootLogin.+/PermitRootLogin no/' /etc/ssh/sshd_config && \

  sed -i '/secure_path/d' /etc/sudoers && \
  echo 'www  ALL=(ALL)  NOPASSWD: ALL' > /etc/sudoers.d/www && \

  rm -rf /config/init/10-nginx-data-dirs.sh /etc/supervisor.d/nginx.conf /etc/supervisor.d/php-fpm.conf && \
  echo > /etc/sysconfig/i18n

# Add config/init scripts to run after container has been started
ADD container-files /

EXPOSE 22

# Run container with following ENV variable to add listed users' keys from GitHub.
# Note: separate with coma, space is not allowed here!
#ENV IMPORT_GITHUB_PUB_KEYS github,usernames,coma,separated
