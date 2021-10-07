#!/bin/bash

# Kill all containers
sudo docker kill $(sudo docker ps | awk '{print $1}' | grep -v CONTAINER)

# Remove stopped containers
sudo docker container prune

# Remove all volumes
sudo docker volume rm $(sudo docker volume list | awk '{print $2}' | grep -v VOLUME)