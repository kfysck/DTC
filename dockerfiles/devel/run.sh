#!/bin/bash

sleep_count=0

while [ $sleep_count -le 100 ]
do
    if [ -f "/usr/local/dtc/conf/dtc.yaml" ]; then 
        echo "Start running process: "$DTC_BIN","$DTC_ARGV
        if [ $DTC_ARGV == "-a" ]; then
            echo "sleeping for agent"
            sleep 5
        fi
        cd /usr/local/dtc/bin/
        ./$DTC_BIN $DTC_ARGV
        break
    else
        echo "sleeping: "$sleep_count"s"
        sleep 1s
        let sleep_count+=1
    fi
done
echo "Timeout waitting for dtc conf files."
