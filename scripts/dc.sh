#!/usr/bin/env bash

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