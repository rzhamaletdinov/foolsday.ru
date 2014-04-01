#!/bin/bash

PROJNAME= "foolsday.ru"
CHARSET= "utf8"
DBNAME= "kraktumz_dd"
DBFILENAME= "mysql_dump"
ARFILENAME= "file_dump"
HOST= "localhost"
USER= "kraktumz_dd"
PASSWD= "marshall"
DATADIR= #Путь к каталогу где будут храниться резервные копии
SRCFILES= #Путь к каталогу файлов для архивирования
PREFIX=`date +%F` #Префикс по дате для структурирования резервных копий

#start backup
echo "[--------------------------------[`date +%F--%H-%M`]--------------------------------]"
echo "[----------][`date +%F--%H-%M`] Run the backup script..."
mkdir $DATADIR/$PREFIX 2> /dev/null
echo "[++--------][`date +%F--%H-%M`] Generate a database backup..."
#MySQL dump
mysqldump --user=$USER --host=$HOST --password=$PASSWD --default-character-set=$CHARSET $DBNAME > $DATADIR/$PREFIX/$DBFILENAME-`date +%F--%H-%M`.sql
if [[ $? -gt 0 ]];then
echo "[++--------][`date +%F--%H-%M`] Aborted. Generate database backup failed."
exit 1
fi
echo "[++++------][`date +%F--%H-%M`] Backup database [$DBNAME] - successfull."
echo "[++++++----][`date +%F--%H-%M`] Copy the source code project [$PROJNAME]..."
#Src dump
tar -czpf $DATADIR/$PREFIX/$ARFILENAME-`date +%F--%H-%M`.tar.gz $SRCFILES 2> /dev/null
if [[ $? -gt 0 ]];then
echo "[++++++----][`date +%F--%H-%M`] Aborted. Copying the source code failed."
exit 1
fi
echo "[++++++++--][`date +%F--%H-%M`] Copy the source code project [$PROJNAME] successfull."
echo "[+++++++++-][`date +%F--%H-%M`] Stat datadir space (USED): `du -h $DATADIR | tail -n1`"
echo "[+++++++++-][`date +%F--%H-%M`] Free HDD space: `df -h /home|tail -n1|awk '{print $4}'`"
echo "[++++++++++][`date +%F--%H-%M`] All operations completed successfully!"
exit 0