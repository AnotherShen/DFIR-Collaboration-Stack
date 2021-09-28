#!/bin/bash

# Step 1 - Generate passwords using pwgen
PASS1=$(pwgen -s 20 1)
PASS2=$(pwgen -s 20 1)
PASS3=$(pwgen -s 20 1)
PASS4=$(pwgen -s 20 1)

# Step 2 - Delete existing files before copying templates to locations
[[ -d config/mysql/docker-entrypoint-initdb.d ]] && rm -rf config/mysql/docker-entrypoint-initdb.d
[[ -f docker-compose.yml ]] && rm -f docker-compose.yml
mkdir config/mysql/docker-entrypoint-initdb.d
cp ./templates/docker-compose.yml.template docker-compose.yml
cp ./templates/onlyoffice-initdb.sql.template config/mysql/docker-entrypoint-initdb.d/onlyoffice-initdb.sql

# Step 3 - Replace password place holders
sed -i -e "s|REPLACE1|$PASS1|g" -e "s|REPLACE2|$PASS2|g" -e "s|REPLACE3|$PASS3|g" -e "s|REPLACE4|$PASS4|g" docker-compose.yml
sed -i -e "s|REPLACE4|$PASS4|g" config/mysql/docker-entrypoint-initdb.d/onlyoffice-initdb.sql

# Step 4 - Set DNS for offline environements
DNS="127.0.0.1"
read -p "Is OnlyOffice going to be internet connected? (Y/[N]) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    DNS="8.8.8.8"
fi
sed -i -e "s|REPLACE5|$DNS|g" docker-compose.yml

# Step 5 - Generate Certs for 365 days
[[ -d certs ]] && sudo rm -rf certs
mkdir certs
cd certs
openssl genrsa -out onlyoffice.key 2048
openssl req -new -key onlyoffice.key -out onlyoffice.csr
openssl x509 -req -days 365 -in onlyoffice.csr -signkey onlyoffice.key -out onlyoffice.crt
openssl dhparam -out dhparam.pem 2048
cd ..

# Step 6 - Delete any volumes if they exist already (equired if volumes mounted to enact some changes)
#if [[ "$(sudo docker volume ls | grep onlyoffice | wc -l)" -gt "0" ]]; then
#    sudo docker-compose down -v
#fi

# Step 7 - Bring service up
sudo docker-compose up -d