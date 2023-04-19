#!/bin/bash

cat docker-compose.tmpl.yml |
    sed "s/API_VERSION/$(cat API_VERSION)/" |
    sed "s/FRONTEND_VERSION/$(cat FRONTEND_VERSION)/" |
    sed "s/ROUTER_VERSION/$(cat ROUTER_VERSION)/" > docker-compose.yml
