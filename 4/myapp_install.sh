#!/bin/bash

REPO_URL=https://github.com/akamsoft/shvirtd-example-python.git
APP_DIR=/opt/myapp
sudo mkdir -p $APP_DIR
cd $APP_DIR
sudo git clone $REPO_URL .
docker compose up -d