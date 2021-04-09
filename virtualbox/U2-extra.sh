#!/bin/bash
# Path to store the Virtual machine configuration
export STORE_PATH=${PWD}/zero_to_asic_vm
# Name of the virtual machine OS
export NAME=ubuntu
# Size of the HDD in GB
export HDD_SIZE=12
export HDD_NAME=extra

# Create HDD
echo "[- Message -] Creating an HDD of size $HDD_SIZE GB stored in $STORE_PATH/$HDD_NAME.vdi"
VBoxManage createmedium disk --filename "$STORE_PATH/$HDD_NAME.vdi" --size $((HDD_SIZE*1024)) --format VDI --variant Standard

# Connect the HDD to the created VM
echo "[- Message -] Attaching the virtual HDD $HDD_NAME.vdi to the VM $NAME"
VBoxManage storageattach $NAME --storagectl SATA --port 1 --type hdd --medium $STORE_PATH/$HDD_NAME.vdi
