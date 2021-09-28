# DFIR Collaboration Stack
# IN DEVELOPMENT (NOT CURRENTLY WORKING)
## Docker Services
1. CyberChef
2. OnlyOffice
3. Samba
4. TimeSketch
5. NGINX (portal)

## Install
Run the the first time to configure the box (tested on Ubuntu 20.04), install containers and then run them
```
git clone https://github.com/AnotherShen/DFIR-Collaboration-Stack.git
cd DFIR-Collaboration-Stack
chmod +x install.sh
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