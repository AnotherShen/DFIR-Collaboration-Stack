#!/bin/bash

# Kill all containers
sudo docker kill $(sudo docker ps | awk '{print $1}' | grep -v CONTAINER)

# Remove stopped containers
sudo docker container prune -f

# Remove all volumes
sudo docker volume rm $(sudo docker volume list | awk '{print $2}' | grep -v VOLUME)

# Clean up mounted volumes and generated files
sudo rm -rf services/timesketch/timesketch
sudo rm -rf services/rocketchat/data
sudo rm -f services/onlyoffice/docker-compose.yml
sudo rm -rf services/onlyoffice/config/mysql/docker-entrypoint-initdb.d
sudo rm -f services/timesketch/deploy_timesketch.sh
sudo rm -f services/samba/docker-compose.yml