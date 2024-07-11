#!/usr/bin/env bash

set -e
echo "Katplan Installation startet!"

PROJECT_GIT_URL='https://github.com/Mitch1802/Katplan_Install.git'
PROJECT_BASE_PATH='/srv/katplan_2432/'
TAG='2.1.0'

if [ ! -d $PROJECT_BASE_PATH ]
  # sudo rm -r /srv/katplan_2432
then
  mkdir -p $PROJECT_BASE_PATH
fi

# sudo git clone $PROJECT_GIT_URL $PROJECT_BASE_PATH
cd $PROJECT_BASE_PATH

echo "Herunterladen neuer Konfigurationen..."
wget https://raw.githubusercontent.com/Mitch1802/Katplan_Install/main/docker-compose.yml
wget https://raw.githubusercontent.com/Mitch1802/Katplan_Install/main/.env

echo "Stoppe Docker Container..."
sudo docker stop katplan_2432_nginx
sudo docker stop katplan_2432_db
sudo docker stop katplan_2432_api

echo "Enterne Docker Container..."
sudo docker remove katplan_2432_nginx
sudo docker remove katplan_2432_db
sudo docker remove katplan_2432_api

echo "Herunterladen neuer Docker Images..."
sudo docker pull mitch122/katplan:nginx-$TAG
sudo docker pull mitch122/katplan:db-$TAG
sudo docker pull mitch122/katplan:api-$TAG

echo "Starte Anwendung..."
sudo docker compose up --build -d --remove-orphans

# echo "Entferne Install/Update Datein"
# sudo rm install.sh update.sh README.md
# sudo rm -r .git
echo "Katplan Update erfolgreich durchgeführt!"