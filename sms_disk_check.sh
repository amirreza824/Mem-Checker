#!/bin/bash


## For Var Disk Partion:
SIZEVAR=$(df -h | grep /var | awk '{print $5}' | head -n 1 | cut -d % -f 1)
echo $SIZEVAR
if [ $SIZEVAR -ge 90 ]
then
    echo "VAR Disk is full - $SIZEVAR % - $(date +%F_%H_%M_%S)" >> /var/log/IBSng/ibs_vardisk_check.log
    wget -O- "http://SERVER_IP:PORT/send_sms.php?num=09194449557&mes=$(hostname) VarDisk is full-$SIZEVAR Percent"
else
    echo "VAR Disk is ok: $SIZEVAR % - $(date +%F_%H_%M_%S)" >> /var/log/IBSng/ibs_vardisk_check.log
fi

## For Postgres Disk Partion:
SIZEPOS=$(df -h | grep /var | awk '{print $5}' | tail -n 1 | cut -d % -f 1)
echo $SIZEPOS
if [ $SIZEPOS -ge 90 ]
then
    echo "PostgreSQL Disk is full - $SIZEPOS % - $(date +%F_%H_%M_%S)" >> /var/log/IBSng/ibs_vardisk_check.log
    wget -O- "http:///SERVER_IP:PORT/send_sms.php?num=09194449557&mes=$(hostname) SQLDisk is full-$SIZEPOS Percent"
else
    echo "PostgreSQL Disk is ok: $SIZEPOS % - $(date +%F_%H_%M_%S)" >> /var/log/IBSng/ibs_postgreSQL_disk_check.log
fi

