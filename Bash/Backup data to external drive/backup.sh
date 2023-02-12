#!/bin/bash
# script to backup files to external hard drive

# FUNCTIONS

# Function, Define a timestamp
function timestamp() {
          local NOW=$(date +"%Y-%m-%d-%H-%M-%S") # current time
          echo $NOW
}

# Function, create filename
function createFileName(){
          local parameter=$1
          local now=$(timestamp)
          local fileName="$parameter-$now"
          echo $fileName
}


# CONFIGS
FoldersToBackup=(
"/datalevy/bitwarden"
"/datalevy/dashy"
"/datalevy/freshrss"
"/datalevy/heimdall"
"/datalevy/homer"
"/datalevy/portainer"
"/datalevy/traefik"
"/datalevy/uptime-kuma"
"/datalevy/watchtower"
)

# Get device path by using sudo fdisk -l
Device="/dev/sdb1"
# Destination where device is mounted and files are copied
Destination="/media/external-backup"


# Main script

echo "Mounting drive "$Device "to" $Destination
sudo mount -t ntfs-3g $Device $Destination

echo "Starting backup operation"
for sourcePath in ${FoldersToBackup[@]}; do
          folderName=$(basename $sourcePath)
          FileName=$(createFileName "$folderName")
          destinationPath=$Destination"/"$FileName".tar.gz"
          sudo tar -zcvf $destinationPath $sourcePath
          echo $destinationPath
done

#Delete old files
echo Cleaning up old backups
find $Destination -name "*.tar.gz" -type f -mtime +60 -delete
ls -lah $Destination

echo "Unmounting" $Destination
sudo umount $Device



# For manual mounting
# sudo mount -t ntfs-3g /dev/sdb1 /media/external-backup

# Check files from mounted location
# ls -lah /media/external-backup

# List tar content
# tar -tvf /media/external-backup/filenamehere

# Unmount
# sudo umount /dev/sdb1


# Cron schedule (run every night at 2:00 AM)
# sudo crontab -e
# 0 2 * * * /bin/bash /datalevy/backup.sh
