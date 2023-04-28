#!/bin/bash
echo "#########################################################################"
echo "## BACKUP GHOST BLOG - `date +%A` - `date +%Y-%m-%d_%Hh%Mm%Ss` ##########"
echo "#########################################################################"

cd "$(dirname "$0")"
cd ..

FULLDATE=$(date -I)
DATESTAMP=$(date +%Y-%m-%d_%Hh%Mm%Ss)
BKP_PATH="./dbdata/backups/ghost"
BKP_SNAPSHOTS="./dbdata/backups/snapshots"
OUTPUT_PATH=/var/lib/mysql/backups/ghost

export $(grep -v '^#' .env | xargs)

echo $APP_DOMAIN

echo "Creating Backup Folder and Snapshots Folder..."
mkdir -p $BKP_PATH
mkdir -p $BKP_SNAPSHOTS

echo "Creating backup with mysqldump"

command="/usr/bin/mysqldump -u root --password=${ROOT_PSD} ghostdb > ${OUTPUT_PATH}/backup-${DATESTAMP}.sql"

docker exec -t -i mysqldb sh -c "${command}"

echo "Backing up Ghost Data Folder..."
tar -zcvf $BKP_SNAPSHOTS/ghost-$FULLDATE.tar.gz $BKP_PATH

echo "## END BACKUP GHOST BLOG - `date +%A` - `date +%Y-%m-%d_%Hh%Mm%Ss` ##########"
