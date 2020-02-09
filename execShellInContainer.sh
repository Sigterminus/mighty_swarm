#!/bin/bash

ALL_SERVICES=$(docker service ls  --format "{{.ID}}:{{.Name}}:{{.Image}}")
declare -a SERVICE_MAP
i=1

echo "Container name    --   Image Name"
echo "----------------------------------"
for service in $ALL_SERVICES
  do
    SERVICE_MAP+=( $(echo $service | cut -d ":" -f 2) )
    serv=$(echo $service | cut -d ":" -f 2,3 --output-delimiter=' -- ')
    echo "$i. $serv"
    i=$((i+1))
done    

read -n 1 -p "Choose container number:" "conNum" 

printf "\n--------------------------------\n"
container=${SERVICE_MAP[$conNum-1]}
docker exec -ti $container.1.$(docker service ps -f "name=$container.1" $container -q --no-trunc | head -n1) /bin/sh
