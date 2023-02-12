# Backup data to usb drive (ubuntu)

First bash script for ages. This can be done differently (easier) but *it is what it is*.

## Logic
1. Mount external drive
2. Copy every specified folder to external drive as TAR file
3. cleanup "old" TAR-files
4. unmount external drive 

>**warning**  
>**The Importance of Unmounting**  
>Failure to unmount before disconnecting the device can result in loss of data and/or a corrupted file system.  