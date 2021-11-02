#!/bin/bash

# If .installer doesn't exist, install packages
if [ ! -f ./.installer ]; then
    # Install base packages
    sudo apt -y update && sudo apt -y upgrade
    sudo apt -y install pwgen ssh fail2ban python3 python3-pip

    # Install docker
    sudo apt-get -y remove docker docker-engine docker.io containerd runc
    sudo apt-get -y install apt-transport-https ca-certificates curl gnupg lsb-release
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --yes --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get -y update
    sudo apt-get -y install docker-ce docker-ce-cli containerd.io
    sudo pip3 install docker-compose
    echo "Packages Installed:True" > ./.installer
fi

# Run each service install script
INSTALL=$(sudo find services -iname service_install.sh)
for line in $(echo "$INSTALL"); do
    echo -e "\e[36m>> $line <<\e[0m"
    DIR=$(echo "$line" | sed -e "s|/service_install.sh||g")
    cd "$DIR"
    ./service_install.sh
    cd ../..
    # Attempt to prevent PC/VM from chugging with 5s delays
    sleep 5
done