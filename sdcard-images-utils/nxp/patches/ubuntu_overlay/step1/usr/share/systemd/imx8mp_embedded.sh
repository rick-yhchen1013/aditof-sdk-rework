#!/bin/bash
# This file contains required actions to run the board in embedded mode

# Set usb to host mode
echo "host" > /sys/kernel/debug/usb/38100000.dwc3/mode


echo "embedded" >  /tmp/evm_mode

