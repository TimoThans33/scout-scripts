#!/bin/sh

# Relative path to gui settings
SETTINGS="./gui-settings.env"

# directory in which this script resides
BASE_DIR="$(cd "$(dirname "$0   ")" && pwd)/automated-mapping-gui"

# image name
DOCKER_IMAGE_NAME=$(grep DOCKER_IMAGE_NAME $SETTINGS | cut -d '=' -f2)

# run project
gnome-terminal --command "docker run -it -v $BASE_DIR:/app -w /app --net=host $DOCKER_IMAGE_NAME python3 ./main.py -d ./src"

# Relative path of settings file in project directory
SETTINGS="./settings.env"

# directory in which this script resides
BASE_DIR="$(cd "$(dirname "$0   ")" && pwd)/"

# image name
DOCKER_IMAGE_NAME=$(grep DOCKER_IMAGE_NAME $BASE_DIR/$SETTINGS | cut -d '=' -f2)

# run project
gnome-terminal --command "docker run -it --net=host $DOCKER_IMAGE_NAME /usr/local/bin/primevision/arq-mapp -P 4220 -n "scout_api" -p "pv" -c "/home/scout_navigation_cfg_real.yaml""
