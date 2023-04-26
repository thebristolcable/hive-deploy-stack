#!/bin/bash

# Check if API_VERSION and FRONTEND_VERSION are compatible
# TODO: check ROUTER_VERSION too
API_VERSION=$(cat API_VERSION)
FRONTEND_VERSION=$(cat FRONTEND_VERSION)

echo "API_VERSION: $API_VERSION"
echo "FREONTEND_VERSION: $FRONTEND_VERSION"

part="major"
if [ $(./semver.sh get major ${API_VERSION:1}) -eq 0 ]; then
    part="minor"
fi

if [ $(./semver.sh get $part ${API_VERSION:1}) -ne $(./semver.sh get $part ${FRONTEND_VERSION:1}) ]; then
    echo "API_VERSION and FRONTEND_VERSION are not compatible, ignoring"
    exit
fi

cat docker-compose.tmpl.yml |
    sed "s/API_VERSION/$API_VERSION/" |
    sed "s/FRONTEND_VERSION/$FRONTEND_VERSION/" |
    sed "s/ROUTER_VERSION/$(cat ROUTER_VERSION)/" > docker-compose.yml
