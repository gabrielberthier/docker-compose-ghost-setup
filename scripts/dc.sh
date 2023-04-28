#!/usr/bin/env bash

cd "$(dirname "$0")"
cd ..


if [ "$1" == "start" ]; then
    docker-compose start
fi

if [ "$1" == "stop" ]; then
    docker-compose stop
fi

if [ "$1" == "update" ]; then
    docker-compose down
    docker-compose pull && docker-compose up -d
fi

if [ "$1" == "purge" ]; then
    docker stop $(docker ps -a -q)
    docker rm $(docker ps -a -q)
    docker rmi $(docker images -q)
fi

