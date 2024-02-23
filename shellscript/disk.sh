#!/bin/bash

cpu_utilization=$(top -bn1 | grep 'Cpu' | awk '{print $2}' | cut -d "." -f1)
memory_usage=$(free -m | awk NR==2'{printf "%.2f%%", $3*100/$2}' | cut -d "%" -f1 | cut -d "." -f1)
disk_usage=$(df -h | grep 'dev' | grep -E -v '(tmp|boot)' | awk '{print $5}' | cut -d "%" -f1)
if [ $memory_usage -gt 30 ]; then
	echo "memory usage is up to the limit"
else
	echo "memory usage within the limit"
fi
if [ $cpu_utilization -gt 20 ]; then
	echo "cpu utilization upto limit"
else
	echo "cpu utilization within limit"
fi
if [ $disk_utilization -gt 20 ]; then
        echo "disk utilization upto limit"
else
        echo "disk utilization within limit"
fi
