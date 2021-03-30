#!/bin/bash
export TOOLS_ROOT="/home/$(whoami)/asic_tools"
export OPENLANE_SRC="$TOOLS_ROOT/openlane_rc6"
export PDK_ROOT="$TOOLS_ROOT/PDK"
# Adding Openlane to the end, bc this is so badly managed that breaks and blocks the entire build flow for no reason
git clone https://github.com/efabless/openlane.git --branch rc6 $OPENLANE_SRC
cd $OPENLANE_SRC
sed -i 's/\-it/\-i/g' Makefile
make openlane
make pdk
make test
make regression_test
