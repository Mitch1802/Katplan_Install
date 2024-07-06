#!/usr/bin/env bash

set -e
echo "Katplan Installation startet!"

PROJECT_GIT_URL='https://github.com/Mitch1802/Katplan_Install.git'
PROJECT_BASE_PATH='/srv/katplan/'
TAG='2432v2.1.0'

if [ ! -d $PROJECT_BASE_PATH ]
  sudo rm -r /srv/katplan/*
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
sudo docker compose up --build -d --remove-orphans

echo "Starte Docker..."
sudo rm install.sh update.sh README.md
sudo rm -r .git
echo "Katplan Update erfolgreich durchgeführt!"