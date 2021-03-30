echo "[- Message -] Installing OpenLANE ..."
ssh -p 2522 -XY zerotoasic@127.0.0.1 'chmod a+x /home/$USER/openlane.sh && exec sh /home/$USER/openlane.sh'
