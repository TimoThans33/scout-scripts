# scout-scripts
some useful scripts used for the PV scout.

## dependecies
update git submodules (automated mapping gui)
```
git submodule update --init --recursive
```

## getting started
simply run
```
./run.sh
```
Sometimes the following error message will show up:
```
docker: Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock
```
To prevent you from running the container with sudo you should change permissions of docker.sock.
```
chmod 666 /var/run/docker.sock
```

## docker (no sudo)
follow installation guidelines for your linux distro.
Ubuntu 18.04: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04 \\
Ubuntu 21.04: https://wiki.crowncloud.net/?How_to_Install_Docker_On_Ubuntu_21_04
```
sudo usermod -aG docker ${USER}
```
```
su - ${USER}
```