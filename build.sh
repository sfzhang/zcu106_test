#!/bin/bash

. /opt/xilinx/petalinux-v2021.2/settings.sh

petalinux-build
if [[ $? -ne 0 ]]
then
    echo "Build failed"
    exit 1
fi

cd image/linux 
petalinux-package --boot --fsbl zynqmp_fsbl.elf --u-boot u-boot.elf --pmufw pmufw.elf --fpga system.bit --force
if [[ $? -ne 0 ]]
then
    echo "Package failed"
    exit 1
fi

echo "Build successfully"
