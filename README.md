# bricksync
Docker Image/container for running bicksync in a debian server

#WARNING: Total beginner. Use at your own risk. It is total wip.

Issue with bricksync and debian and running the server from SSH:
 - When starting bricksync from debian from putty, the following error message is returned: 

There is a a problem with the OpenSSL in debian when running BrickSync. 
BrickSync requires an older version of OpenSSL (1.0.0) but all versions of Debian only support a newer one (1.0.1e) and can't be downgraded.

Therefore BrickSync needs to be installed in an Ubuntu. 

To be able to keep BrickSync running even after the exiting the docker shell, the docker container needs GNU Screen.

## Prepare BrickSync folder

I am placing my BrickSync folder in the ``` /srv/ ``` directory.

If you already have a BrickSync folder and data, copy it to ``` /srv/ ```

After pulled and installed (or copied), the folder structure will look as following:
```sh
srv
├── bricksync
│   └── data
│       ├── backups
│       ├── logs
│       ├── orders
│       └── pgcache
```

Download, unpack, rename BrickSync folder and files:
```sh
cd /srv
wget http://www.bricksync.net/bricksync-linux64-171.tar.gz
tar xvfz bricksync-linux64-171.tar.gz
mv bricksync-linux64 bricksync
rm bricksync-linux64-171.tar.gz
```

The BrickSync folder is mapped to the container with the volumes variable.
```sh
-v /srv/bricksync:/bricksync \
```
## Get the image:

Pull the image from Docker hub using command
```sh
$ docker pull greenshark12/bricksync
```
## Create the container:

```sh
$ docker create \
  -itd \ 
  --name=brick \
  -e PUID=1000 \
  -e PGID=999 \
  -e TZ=America/New_York \
  -v /srv/bricksync:/bricksync \
  --restart unless-stopped \
  greenshark12/bricksync
```

  - Start the container: ```docker start brick```
  - Shell access whilst the container is running: ```docker exec -it brick bash ```

## Start BrickSync using GNU Screens

 - Access the container shell: 
 ```
 docker exec -it brick bash 
 ```
 - Start BrickSync with GNU Screens in detached mode: 
 ``` 
 cd /bricksync && screen -S scrb -d -m ./bricksync  
 ```
 - To attach to the GNU Screens session:
 ```
 screens -r root/
 ```
 - To detach from the GNU Screens session:
 ```
 Ctrl+a followed by d
```

## Update the container
To update the container, you need to recreate the container. It is not recommended updating the apps inside the container. 

  - Update the image: ``` docker pull greenshark12/bricksync ```
  - Stop the container: ``` docker stop brick ```
  - Delete the container: ``` docker rm brick ```
  - Recreate a new container with the same docker create parameters as instructed above (if mapped correctly to a host folder, your /bricksync folder and settings will be preserved)
  - Start the new container: ``` docker start brick ```
  - You can also remove the old dangling images: ``` docker image prune ```



