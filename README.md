# DFIR-Collaboration-Stack
## Docker Services
1. CyberChef
2. OnlyOffice
3. Samba
4. TimeSketch
5. NGINX (portal)

## Install
```
git clone https://github.com/AnotherShen/DFIR-Collaboration-Stack.git
cd DFIR-Collaboration-Stack
chmod +x install.sh
./install.sh
```

## Add additional TimeSketch users
```
cd service/timesketch/timesketch
sudo docker-compose exec timesketch-web tsctl add_user --username <USERNAME>
```
