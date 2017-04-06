#!/bin/bash

#var assignment

#var to name acrchinve
archname=$HOSTNAME_`date +%F-%H-%M`
NOW=$(date)
BACKUPDIR=/home/network/backups
LOGDIR=$BACKUPDIR/logs
LOGFILE=$LOGDIR/$HOSTNAME`date +%F-%H-%M`.log
pname='/home/network/backups/'$archname'.tar.gz'




#makes local backups directory if not there
if [ ! -d "$BACKUPDIR" ]
then
    echo "The specified backup directory $BACKUPDIR does not exist."
    mkdir $BACKUPDIR
        echo "Making $BACKUP directory"
else
        echo "Backing up to $BACKUPDIR directory."
fi

 #Does the log directory exist? If it doesn't it will create it.
if [ ! -d  $LOGDIR ]
then
        mkdir $LOGDIR
        echo "Making $LOGDIR directory"
else
        echo "$LOGDIR directory exists"
fi

echo "Piping to $LOGFILE"
exec 3>&1                         # create pipe (copy of stdout)
exec 1> "$LOGFILE"                   # direct stdout to file
exec 2>&1

echo "Start Time: $NOW" 1>&3
echo " "
echo "_____________________________________"
echo "Backup Script"
echo " "
echo "Start Time: $NOW"
echo "_____________________________________"
echo " "
echo " "



    sudo tar -cvpzf /home/network/backups/$archname.tar.gz --exclude '/home/network/backups' --exclude '/sys' --exclude '/tmp' --exclude '/run' --exclude '/mnt' --exclude '/media' / --exclude '/lost+found'  --one-file-system
        pname='/home/network/backups/'$archname'.tar.gz'
        scp $pname network@192.168.1.12:/home/network/test

SCRIPTFINISHTIME=`date`
echo " "
echo "_____________________________________"
echo "Backup Script"
echo " "
echo "Finish Time: $SCRIPTFINISHTIME"
echo "_____________________________________"
echo " "
echo " "
echo "Finish Time: $SCRIPTFINISHTIME" 1>&3
exit 1
