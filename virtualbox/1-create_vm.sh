#!/bin/bash
# Diego H, 24/03/2021
# Define your arguments here
# Path to store the Virtual machine configuration
export STORE_PATH=${PWD}/zero_to_asic_vm
# Name of the virtual machine OS
export NAME=ubuntu
# PAth of the ISO file
export ISO=/home/diego/Downloads/ubuntu-20.04.2.0-desktop-amd64.iso
# Size of the RAM in GB
export RAM_SIZE=4
# Size of the HDD in GB
export HDD_SIZE=24
# Number of CPUs
export N_CPU=2

# Templates for unattended install
export PRE=/usr/lib64/virtualbox/UnattendedTemplates/ubuntu_preseed.cfg
export POST=/usr/lib64/virtualbox/UnattendedTemplates/debian_postinstall.sh
export ADDITIONS_PATH=/home/diego/Downloads/VBoxGuestAdditions_6.1.18.iso

echo "[- Message -]: Creating a VM with name $NAME and path $STORE_PATH"
# --register will enable the VM in the VirtualBox GUI
# --default will create the machine with minimal config for
# the hardware.
# For the ostype, use the command VBoxManage list ostypes
VBoxManage createvm --name $NAME --ostype Ubuntu_64 --register --basefolder $STORE_PATH --default
# Increase a little bit the HW capabilities
echo "[- Message -] Modifying the hardware RAM with $RAM_SIZE GB and $N_CPU CPUs"
VBoxManage modifyvm $NAME --memory $((RAM_SIZE * 1024)) --cpus $N_CPU
# and the hdd
echo "[- Message -] Creating an HDD of size $HDD_SIZE GB stored in $STORE_PATH/$NAME.vdi"
VBoxManage createmedium disk --filename "$STORE_PATH/$NAME.vdi" --size $((HDD_SIZE*1024)) --format VDI --variant Standard
# connect the HDD to the created VM
echo "[- Message -] Attaching the virtual HDD $NAME.vdi to the VM $NAME"
VBoxManage storageattach $NAME --storagectl SATA --port 0 --type hdd --medium $STORE_PATH/$NAME.vdi
# Prepare boot from ISO
echo "[- Message -] Attaching ISO DVD $ISO"
VBoxManage storageattach $NAME --storagectl IDE --device 0 --port 0 --type dvddrive --medium $ISO
# Creating a port forwarding for SSH connection
echo "[- Message -] Enabling ssh port forwarding"
VBoxManage modifyvm "ubuntu" --natpf1 "SSH,tcp,127.0.0.1,2522,10.0.2.15,22"
# Launch
echo "[- Message -] Launching virtual machine $NAME"
VBoxManage unattended install $NAME --iso=$ISO --user=zerotoasic --password=12345  --install-additions --additions-iso=$ADDITIONS_PATH --script-template=$PRE --post-install-template=$POST --time-zone=CET --hostname=zerotoasic.vm.com --start-vm=gui
