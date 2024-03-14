#!/bin/bash

vms=$(virsh list --all | awk '{if(NR>2) print $2}')

for vm in $vms;
do
  
   echo "Virtual machine: $vm"
   vm_status=$(virsh domstate "$vm")
   echo "Status: $vm_status"

   product_name=$(sudo virt-inspector -d "$vm" 2>/dev/null | grep "<product_name>" | head -n 1 | sed -e 's/<[^>]*>//g' | xargs)
   echo "Product name: $product_name"
    
   echo "---------------------------"
done


