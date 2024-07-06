bash <(curl -Ls https://raw.githubusercontent.com/Mitch1802/Katplan_Install/main/install.sh)

docker network ls
docker images
docker ps -als
docker volume ls

docker network rm katplan_nw
docker image rm mitch122/katplan:nginx-2.0.0
docker image rm mitch122/katplan:api-2.0.0
docker image rm mitch122/katplan:db-2.0.0

docker logs katplan_api