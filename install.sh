#!/usr/bin/env bash

set -e
echo "Katplan Installation startet!"

PROJECT_GIT_URL='https://github.com/Mitch1802/Katplan_Install.git'
PROJECT_BASE_PATH='/srv/katplan_2432/'
DOCKER_NETWORK_NAME='katplan_2432_nw'
TAG='2.1.0'

if [ ! -d $PROJECT_BASE_PATH ]
then
  mkdir -p $PROJECT_BASE_PATH
fi

sudo git clone $PROJECT_GIT_URL $PROJECT_BASE_PATH

echo "Lade Docker Images..."
sudo docker pull mitch122/katplan:nginx-$TAG
sudo docker pull mitch122/katplan:db-$TAG
sudo docker pull mitch122/katplan:api-$TAG

echo "Starte Docker..."
cd $PROJECT_BASE_PATH
sudo docker network create -d bridge $DOCKER_NETWORK_NAME
sudo docker compose up --build -d --remove-orphans
sleep 30
echo "Lade Initial Daten..."
sudo docker compose exec api python manage.py loaddata /app/backups/initial.json

echo "Starte Docker..."
sudo rm install.sh README.md
sudo rm -r .git
echo "Katplan Installation erfolgreich durchgeführt!"
