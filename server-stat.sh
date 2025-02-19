#!/bin/bash
cpu_usage=$(top -bn1 | grep -o '[0-9]*,[0-9]* id' | grep -o '[0-9]*,[0-9]' | awk '{print 100 - $1}')

total=$(top -bn1 | grep 'MiB Mem'| grep -o '[0-9]*,[0-9]* total' | sed 's/,[0-9]* total//')
free=$(top -bn1 | grep 'MiB Mem'| grep -o '[0-9]*,[0-9]* free' | sed 's/,[0-9]* free//')
used=$(top -bn1 | grep 'MiB Mem'| grep -o '[0-9]*,[0-9]* used' | sed 's/,[0-9]* used//')
echo "cpu usage: $cpu_usage %"
echo "toal memory: $total MB"
echo "free memory:" $(( $free * 100 / $total )) "%"
echo "used memory:" $(( $used * 100 / $total )) "%"

disk_total=$(df -h | grep '/dev/nvme0n1p2' | awk '{print $2}')
disk_usage=$(df -h | grep '/dev/nvme0n1p2' | awk '{print $5}')
echo "disk total: $disk_total GB"
echo "disk used: $disk_usage"

echo "Top 5 process by CPU usage:"
ps aux --sort=-%cpu | head -n 6
echo "Top 5 process by MEMORY usage:"
ps aux --sort=-%mem | head -n 6

