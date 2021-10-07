#!/bin/bash

# Step 1 - Get Timesketch user
USERNAME=""
read -p "Enter TimeSketch Username [user]: " USERNAME
if [ "$USERNAME" = "" ]; then
    USERNAME="user"
fi

# Step 2 - Download time sketch helper script
curl -s https://raw.githubusercontent.com/google/timesketch/master/contrib/deploy_timesketch.sh -o timesketch_temp.sh

# Step 2 - Remove warning and run script
grep -i -B999999 "Installation Done" timesketch_temp.sh > deploy_timesketch.sh
rm -f timesketch_temp.sh
chmod 755 deploy_timesketch.sh
sudo ./deploy_timesketch.sh

# Step 3 - Enable SSL <- Unsure if possible

# Step 4 - Change ports
sudo sed -i -e "s/80/8004/g" -e "s/443:443/4444:4444/g" timesketch/etc/nginx.conf
sudo sed -i -e "s/80:80/8004:8004/g" -e "s/443:443/4444:4444/g" timesketch/docker-compose.yml

# Step 5 - Deploy service
cd timesketch
sudo docker-compose up -d
sudo docker-compose exec timesketch-web tsctl add_user --username "$USERNAME"