# Name of the virtual machine OS
export NAME=ubuntu
# Copy the tools script to the VM, first install SSH
echo "[- Message -] Installing ssh in $NAME"
VBoxManage --nologo guestcontrol $NAME run --exe "/usr/bin/apt-get" --username root --password 12345  --wait-stdout -- apt/arg0 install -y ssh
echo "[- Message -] Installing VirtualBox tools in $NAME"
VBoxManage --nologo guestcontrol $NAME run --exe "/usr/bin/apt-get" --username root --password 12345  --wait-stdout -- apt/arg install -y dkms build-essential linux-headers-5.8.0-48-generic autoconf make bison flex gperf libreadline-dev libncurses5-dev docker.io -o Dpkg::Options::=--force-confnew
VBoxManage --nologo guestcontrol $NAME run --exe "/usr/bin/apt-get" --username root --password 12345  --wait-stdout -- apt/arg0 install -y virtualbox-guest-utils virtualbox-guest-x11 virtualbox-guest-dkms -o Dpkg::Options::=--force-confnew
echo "[- Message -] Installing EDA dependencies [GTKWave/ngspice/klayout] in $NAME"
VBoxManage --nologo guestcontrol $NAME run --exe "/usr/bin/apt-get" --username root --password 12345  --wait-stdout -- apt/arg install -y m4 tcsh csh libx11-dev tcl-dev tk-dev libcairo2-dev libncurses-dev git ngspice klayout python3-pip gtkwave -o Dpkg::Options::=--force-confnew

# Now copy the script
echo "[- Message -] Copying the script to $NAME"
scp -P 2522 ./install_tools.sh ./fix_sudo.sh ./openlane.sh openlane_wrapper.sh zerotoasic@127.0.0.1:/home/zerotoasic
# Give permissions to the script
VBoxManage --nologo guestcontrol $NAME run --exe "/usr/bin/chmod" --username zerotoasic --password 12345  --wait-stdout -- chmod/arg0 a+x /home/zerotoasic/install_tools.sh /home/zerotoasic/fix_sudo.sh
# Run script
echo "[- Message -] Installing tools"
VBoxManage --nologo guestcontrol $NAME run --exe "/home/zerotoasic/fix_sudo.sh" --username root --password 12345 --wait-stdout
VBoxManage --nologo guestcontrol $NAME run --exe "/usr/bin/bash" --username zerotoasic --password 12345 --wait-stdout -- source/arg0 -c "source /home/zerotoasic/install_tools.sh"
# Rebooting to apply new group
echo "[- Message -] Rebooting machine to reflect docker group"
VBoxManage controlvm $NAME restart
