#!/usr/bin/env bash
# Switches ngnix configurations based on input

# Define Variables
INPUT=$1
CONFIG_STORE_PATH="./nginx-config"
NGINX_CONFIG_PATH="/etc/nginx/sites-available/default"

# replace config and restart nginx
if [ -f $CONFIG_STORE/$INPUT ]; then
    sudo cp $CONFIG_STORE/$INPUT $NGINX_CONFIG_PATH
    sudo service nginx restart
else
    echo "configuration: $CONFIG_STORE/$INPUT does not exist."
fi
