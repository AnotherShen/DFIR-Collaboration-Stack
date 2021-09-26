!#/bin/bash

# Step 1 - Generate passwords using pwgen

# Step 2 - Generate Certs for 365 days
[[ -f certs ]] && rm -rf certs
mkdir certs
cd certs
openssl genrsa -out onlyoffice.key 2048
openssl req -new -key onlyoffice.key -out onlyoffice.csr
openssl x509 -req -days 365 -in onlyoffice.csr -signkey onlyoffice.key -out onlyoffice.crt
openssl dhparam -out dhparam.pem 2048
cd ..

# Step 3 - Bring service up
sudo docker-compose up -d
