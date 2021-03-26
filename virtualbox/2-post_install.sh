# Name of the virtual machine OS
export NAME=ubuntu
# Copy the tools script to the VM, first install SSH
echo "[- Message -] Installing ssh in $NAME"
VBoxManage --nologo guestcontrol $NAME run --exe "/usr/bin/apt-get" --username root --password 12345  --wait-stdout -- apt/arg0 install -y ssh
# Now copy the script
echo "[- Message -] Copying the script to $NAME"
scp -P 2522 ./install_tools.sh ./fix_sudo.sh zerotoasic@127.0.0.1:/home/zerotoasic
# Give permissions to the script
VBoxManage --nologo guestcontrol $NAME run --exe "/usr/bin/chmod" --username zerotoasic --password 12345  --wait-stdout -- chmod/arg0 a+x /home/zerotoasic/install_tools.sh /home/zerotoasic/fix_sudo.sh
# Run script
echo "[- Message -] Installing tools"
VBoxManage --nologo guestcontrol $NAME run --exe "/home/zerotoasic/fix_sudo.sh" --username root --password 12345 --wait-stdout
VBoxManage --nologo guestcontrol $NAME run --exe "/home/zerotoasic/install_tools.sh" --username zerotoasic --password 12345 --wait-stdout
