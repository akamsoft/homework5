#!/bin/bash

if [ -f .secret/env.env ]; then
    export $(cat .secret/env.env | xargs)
else
    echo ".secret/env.env file not found!"
    exit 1
fi

BACKUP_DIR="/opt/backup"

sudo mkdir -p $BACKUP_DIR
sudo chmod 777 $BACKUP_DIR

NOW=$(date +"%Y%m%d_%H%M%S")
BACKUP_FILE="/backup/${MYSQL_DATABASE}_$NOW.sql"

docker run --rm  --entrypoint "" \
  -v /"$BACKUP_DIR":/backup \
  --network myapp_backend \
  schnitzler/mysqldump \
  mysqldump --opt -h db -u $MYSQL_USER -p"$MYSQL_PASSWORD" \
  "--result-file=$BACKUP_FILE" $MYSQL_DATABASE

echo "Резервная копия базы данных $MYSQL_DATABASE сохранена в $BACKUP_FILE"

