# VirtualBox Script for Ubuntu Unattended Install
## Instructions
First launch `1-create_vm.sh`
```bash
./1-create_vm.sh
```

When this process is finished, launch `2-post_install.sh`
```bash
./2-post_install.sh
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
