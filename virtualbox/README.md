# VirtualBox Script for Ubuntu Unattended Install
## Instructions
Dependin on the OS, you'll need to set the following variables to point to a correct path
```bash
# Templates for unattended install
export PRE=/usr/lib64/virtualbox/UnattendedTemplates/ubuntu_preseed.cfg
export POST=/usr/lib64/virtualbox/UnattendedTemplates/debian_postinstall.sh
export ADDITIONS_PATH=/home/diego/Downloads/VBoxGuestAdditions_6.1.18.iso
```

First launch `1-create_vm.sh`
```bash
./1-create_vm.sh
```

When this process is finished, launch `2-post_install.sh`
```bash
./2-post_install.sh
```

Then, run openlane script
```bash
./3-openlane.sh
```

## Editing VM Hardware Requirements
The head of `1-create_vm.sh` contains all the parameters that can be customised:
```bash
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
```
