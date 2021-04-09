#!/bin/bash
export STORE_PATH=${PWD}/zero_to_asic_vm
export VM_NAME=ubuntu
export OLD_NAME=ubuntu
export NEW_NAME=ubuntu_40
export HDD_SIZE=40

# Create new HDD
echo "[- Message -] Creating an HDD of size $HDD_SIZE GB stored in $STORE_PATH/$NEW_NAME.vdi"
VBoxManage createmedium disk --filename "$STORE_PATH/$NEW_NAME.vdi" --size $((HDD_SIZE*1024)) --format VDI --variant Standard

# Clone the old hdd into this newly created VDI
echo "[- Message -] Cloning old HDD $STORE_PATH/$OLD_NAME.vdi to $STORE_PATH/$NEW_NAME.vdi"
VBoxManage clonemedium $STORE_PATH/$OLD_NAME.vdi $STORE_PATH/$NEW_NAME.vdi --variant Standard --existing

# Attach new HDD to the VM
# Disconnect old HDD
echo "[- Message -] Disconnecting old HDD"
VBoxManage storageattach $VM_NAME --storagectl SATA --port 0 --type hdd --medium none

# Connect the HDD to the created VM
echo "[- Message -] Attaching the virtual HDD $STORE_PATH/$NEW_NAME.vdi to the VM $NAME"
VBoxManage storageattach $VM_NAME --storagectl SATA --port 0 --type hdd --medium $STORE_PATH/$NEW_NAME.vdi

# IF UUIDs errors makes the HDD inaccesible, use this command to get the UUIDs of the disks
# VBoxManage list hdds
# and then delete them
# VBoxManage closemedium disk <UUID>

