#!/bin/env bash
# Install VirtualBox additions
echo 12345 | sudo -S apt-get update
echo 12345 | sudo -S apt-get -y install dkms build-essential linux-headers-$(uname -r) autoconf make bison flex gperf libreadline-dev libncurses5-dev docker.io -o Dpkg::Options::=--force-confnew 
echo 12345 | sudo -S apt-get -y install virtualbox-guest-utils virtualbox-guest-x11 virtualbox-guest-dkms -o Dpkg::Options::=--force-confnew 

# Now the tools
export TOOLS_ROOT="/home/$(whoami)/asic_tools"
export MAGIC_ROOT="$TOOLS_ROOT/magic"
export IVERILOG_ROOT="$TOOLS_ROOT/iverilog"
export FPGA_VER="https://github.com/YosysHQ/fpga-toolchain/releases/download/nightly-20210101/fpga-toolchain-linux_x86_64-nightly-20210101.tar.xz"
export FPGA_ROOT="$TOOLS_ROOT/yosys_nightly"
export RISCV_GCC="$TOOLS_ROOT/riscv-gcc"
export OPENLANE_SRC="$TOOLS_ROOT/openlane_rc6"
export PDK_ROOT="$TOOLS_ROOT/PDK"

# Create directory
mkdir $TOOLS_ROOT

# OpenLANE stuff
# first docker
#echo 12345 | sudo -S groupadd docker
echo 12345 | sudo -S usermod -aG docker zerotoasic
newgrp docker << END

# Prepare and clone magic
echo "[-- Message --] Installing required packages for magic"
echo 12345 | sudo -S apt-get -y install m4 tcsh csh libx11-dev tcl-dev tk-dev libcairo2-dev libncurses-dev git
git clone git://opencircuitdesign.com/magic $MAGIC_ROOT
cd $MAGIC_ROOT
git checkout 8.3.108
./configure
make -j$(nproc)
echo "[-- Message --] Installing magic"
echo 12345 | sudo -S make -j$(nproc) install

# Install ngspice
echo "[-- Message --] Installing ngspice"
echo 12345 | sudo -S apt install -y ngspice

# Install klayout
echo "[-- Message --] Installing Klayout"
echo 12345 | sudo -S apt install klayout

# Install iverilog
echo "[-- Message --] Downloading iverilog release"
wget -P $IVERILOG_ROOT https://github.com/steveicarus/iverilog/archive/refs/tags/v11_0.tar.gz
cd $IVERILOG_ROOT
echo "[-- Message --] Installing iverilog"
tar -xf v11_0.tar.gz
cd iverilog-11_0/
autoconf
./configure
make -j$(nproc)
echo 12345 | sudo -S make -j$(nproc) install

# Installing cocotb
echo "[-- Message --] Installing cocotb"
echo 12345 | sudo -S apt install python3-pip
pip3 install cocotb --user

# Now GTKWave
echo "[-- Message --] Installing GTKWave"
echo 12345 | sudo -S apt install gtkwave

# FPGA tools
wget -P $FPGA_ROOT $FPGA_VER
cd $FPGA_ROOT
tar -xf fpga-toolchain-linux_x86_64-nightly-20210101.tar.xz
echo 'export PATH=$PATH:$FPGA_ROOT/fpga-toolchain/bin' >> ~/.bashrc && . ~/.bashrc

# Lastly, SiFive
wget -P $RISCV_GCC https://static.dev.sifive.com/dev-tools/riscv64-unknown-elf-gcc-8.3.0-2020.04.1-x86_64-linux-ubuntu14.tar.gz 
cd $RISCV_GCC
tar -xf riscv64-unknown-elf-gcc-8.3.0-2020.04.1-x86_64-linux-ubuntu14.tar.gz
echo 'export PATH=$PATH:$RISCV_GCC/riscv64-unknown-elf-gcc-8.3.0-2020.04.1-x86_64-linux-ubuntu14/bin' >> ~/.bashrc && . ~/.bashrc

# Adding Openlane to the end, bc this is so badly managed that breaks and blocks the entire build flow for no reason
git clone https://github.com/efabless/openlane.git --branch rc6 $OPENLANE_SRC
cd $OPENLANE_SRC
sed -i 's/\-it/\-i/g' Makefile
make openlane
make pdk
make test
make regression_test

END
