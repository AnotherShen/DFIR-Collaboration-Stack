# DFIR Collaboration Stack

## Development Todo
1. Debug TimeSketch elasticstack error
2. Add a TimeSketch user helper script
3. Populate SMB IP on NGINX portal when installed

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
Run the the first time to configure the box (tested on Ubuntu 20.04), install containers and then run them
```
git clone https://github.com/AnotherShen/DFIR-Collaboration-Stack.git
cd DFIR-Collaboration-Stack
chmod +x *.sh
./install.sh
```

## Up
Starts docker containers
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
```
./reset_docker.sh
sudo rm -rf services/timesketch/timesketch
sudo rm -rf services/rocketchat/data
(4 other files)
```