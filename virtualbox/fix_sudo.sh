#!/bin/env bash
# Add user to sudo group
echo "zerotoasic  ALL=(ALL)  ALL" |  sudo -S tee /etc/sudoers.d/zerotoasic
