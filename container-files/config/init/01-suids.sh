#!/bin/sh

# Add suid bit to some tools so 'www' user can use then w/o sudo command
chmod u+s /usr/local/bin/gem 
chmod u+s /usr/local/bin/node 

# Change ownership of some tools used entirely by 'www' user
chown www /usr/local/bin/composer
