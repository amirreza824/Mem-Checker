#!/bin/bash

if [ $(drbd-overview | awk '{print $3}' | cut -d '/' -f1) = "Primary" ];
then
        TOTALMEM=$(free | grep Mem | awk '{print $2}')
        MEM_USED=`free | grep 'buffers/cache' | awk '{print $3/'$TOTALMEM' * 100.0}' | cut -d . -f1`
        echo $MEM_USED
        if [ $MEM_USED -ge 90 ]
        then
            echo "Memory is full - $MEM_USED % - $(date +%F_%H_%M_%S)" >> /var/log/IBSng/ibs_memory_check.log
            wget -O- "http:///SERVER_IP:PORT/send_sms.php?num=09194449557&mes=$(hostname) memory is full-$MEM_USED Percent"
        else
            echo "Memory is ok: $MEM_USED % - $(date +%F_%H_%M_%S)" >> /var/log/IBSng/ibs_memory_check.log
        fi
else
        echo "secondary srv - Memory is ok: $MEM_USED % - $(date +%F_%H_%M_%S)" >> /var/log/IBSng/ibs_memory_check.log
fi

