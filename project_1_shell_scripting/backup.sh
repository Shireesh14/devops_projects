#!/bin/bash
<< comments
#################################################################################
AUTHOR: Shireesh N
VERSION: V.0.1
This Script is used to backup a folder and rotate the folder for 10 logs.
Useage: ./backup.sh <source_dir> <backup_dir> 
################################################################################
comments

# To check if the script is being used correctly

if [ $# -ne 2  ]
then 
	echo "./backup.sh <source_dir> <backup_dir>  "
fi

source_dir=$1
backup_dir=$2
timestamp=$(date +%y-%m-%d-%h-%m-%s)

# STARTING BACKUP OF LOGS

function create_backup {
zip -r "${backup_dir}/backups_${timestamp}.zip"  "${source_dir}" > /dev/null
}

# START OF LOG ROTATIONS
 
function rotating_logs {

backup=($(ls -t "${backup_dir}/backups_"*.zip ))

# CHECKING IF LOGS ARE MORE THAN 10.

if [ ${#backup[@]} -gt 10 ]
then 
	echo " SARTING LOG ROTATIONS  "
else
	echo " BACKUP IS SUCCEFULL WITH 10 LOGS	 "
fi

# CHECKING IF LOG ARE MORE 10

removal_logs=(${backup[@]:10})

# REMOVING THE LOG MORE THEN 10

for removal in ${removal_logs[@]};
do 
	rm -f ${removal}
done
}

create_backup

rotating_logs

