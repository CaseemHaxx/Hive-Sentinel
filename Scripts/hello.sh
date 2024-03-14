#!/bin/bash

vm_list=$(virsh list --all | sed '1,2d')

total_vms=$(echo "$vm_list" | wc -l)

echo "Total Machines: $total_vms"
