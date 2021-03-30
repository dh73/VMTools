echo "[- Message -] Installing OpenLANE ..."
export NAME=ubuntu
VBoxManage --nologo guestcontrol $NAME run --exe "/home/zerotoasic/openlane_wrapper.sh" --username zerotoasic --password 12345 --wait-stdout
