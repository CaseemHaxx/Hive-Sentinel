#!/bin/bash

os_name=$(grep ^NAME= /etc/os-release | awk -F= '{print $2}' | tr -d '"')

version=$(grep ^VERSION= /etc/os-release | awk -F= '{print $2}' | tr -d '"')

os_info="$os_name $version"

total_ram=$(free -m | grep Mem | awk '{print $2/1024}')

total_cpus=$(nproc)

vm_list=$(virsh list --all | sed '1,2d')

total_vms=$(echo "$vm_list" | wc -l)

cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9]\)%* id.*/\1/" | awk '{print 100 - $1"%"}')

memory_usage=$(free -m | grep Mem | awk '{print $3/1024 "GB" }')


echo '{ "Machine Name": "'$os_info'",'
echo '"Total RAM Allocated (GB)": "'$total_ram'",'
echo '"Total CPUs": "'$total_cpus'",'
echo '"Total Machines": "'$total_vms'",'
echo '"Current CPU Usage": "'$cpu_usage'",'
echo '"Current Memory Usage": "'$memory_usage'" }'

   
