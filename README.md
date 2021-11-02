# DFIR Collaboration Stack

## Development Todo
1. Debug TimeSketch elasticstack error
2. Add a TimeSketch user helper script
3. Populate SMB IP on NGINX portal when installed
4. Rename reset_docker to reset and add a confirmation

## Docker Services
1. CyberChef
2. OnlyOffice
3. Samba
4. TimeSketch
5. RocketChat
6. Portainer
7. NGINX (portal)

![image](https://user-images.githubusercontent.com/9160174/135201899-4d002085-87b5-4459-9377-dadcf8a7c061.png)

## Install
To install, download this repository and run the installer (tested on Ubuntu 20.04)
```
wget https://github.com/AnotherShen/DFIR-Collaboration-Stack/releases/latest (yet to be released)
(extract & move)
chmod +x *.sh
./install.sh
sudo apt update && sudo apt install git
```

## Development Environment Set-up
To develop, follow the steps below (tested on Ubuntu 20.04)
Install packages and configure
```
sudo apt update && sudo apt install git
sudo snap install code --classic
git config --global user.name "GITHUBUSERNAME"
git config --global user.email "CHECKYOURPROFILE@users.noreply.github.com"
```
Clone repository and install (or do it through VS Code)
```
mkdir ~/Documents/git && mv ~/Documents/git
git clone https://github.com/AnotherShen/DFIR-Collaboration-Stack.git
cd DFIR-Collaboration-Stack
chmod +x *.sh
./install.sh
```

## Up
Starts docker containers (Docker auto starts on PC/VM start-up, only needed if manually stopped.)
```
./up.sh
```

## Down
Stops docker containers
```
./down.sh
```

## Add additional TimeSketch users
```
cd service/timesketch/timesketch
sudo docker-compose exec timesketch-web tsctl add_user --username <USERNAME>
```

## Reset Environment
The following script will kill all containers and remove all volumes & generated files.
```
./reset_docker.sh
```