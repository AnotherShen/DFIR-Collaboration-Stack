#!/bin/bash

# Step 1 - Get POSIX Timezone
TIMEZONE=""
read -p "Enter Samba Share POSIX Timezone [GMT]: " TIMEZONE
if [ "$TIMEZONE" = "" ]; then
    TIMEZONE="GMT"
fi

# Step 2 - Get share name and set it on the portal
SHARENAME=""
read -p "Enter Samba Share Name [IRSHARE]: " SHARENAME
if [ "$SHARENAME" = "" ]; then
    SHARENAME="IRSHARE"
fi
sed -i -e "s|IRSHARE|$SHARENAME|g" ../nginx/html/index.html

# Step 3 - Get share username
USERNAME=""
read -p "Enter Samba Share Username [user]: " USERNAME
if [ "$USERNAME" = "" ]; then
    USERNAME="user"
fi

# Step 4 - Get share password
PASSWORD1=""
PASSWORD2=""
while [ "$PASSWORD1" = "" ]; do
    read -s -p "Enter Samba Share Password: " PASSWORD1
    echo
    read -s -p "Enter Samba Share Password Again: " PASSWORD2
    echo
    if [ "$PASSWORD1" != "$PASSWORD2" ]; then
        PASSWORD1=""
        PASSWORD2=""
        echo -e "\n[WARN] Provide two matching passwords.\n"
    fi
done

# Step 5 - Copy template to main
[[ -f docker-compose.yml ]] && rm -f docker-compose.yml
cp ./templates/docker-compose.yml.template docker-compose.yml

# Step 6 - Populate replacement values
sed -i -e "s|REPLACE1|$TIMEZONE|g" -e "s|REPLACE2|$SHARENAME|g" -e "s|REPLACE3|$USERNAME|g" -e "s|REPLACE4|$PASSWORD1|g" docker-compose.yml

# Step 7 - Make share directory, hide error if it exists
mkdir -p "/srv/$SHARENAME" 2> /dev/null

# Step 8 - Delete any volumes if they exist already (required if volumes mounted to enact some changes)
#if [[ "$(sudo docker volume ls | grep samba | wc -l)" -gt "0" ]]; then
#    sudo docker-compose down -v
#fi

# Step 9 - Bring up service
sudo docker-compose up -d