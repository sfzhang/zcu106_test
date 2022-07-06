#!/bin/bash

cd images/linux
cp BOOT.BIN boot.scr image.ub /media/sfzhang/BOOT/
if [[ $? -ne 0 ]]
then
    echo "Deploy BOOT.bin failed"
    exit 1
fi

sudo tar -zxf rootfs.tar.gz -C /media/sfzhang/rootfs/
if [[ $? -ne 0 ]]
then
    echo "Deploy rootfs failed"
    exit 1
fi

sudo cp -r /home/sfzhang/Workspace/Temp/root-zynqmp /media/sfzhang/rootfs/home/root
if [[ $? -ne 0 ]]
then
    echo "Deploy application failed"
    exit 1
fi

sudo mkdir -p /media/sfzhang/rootfs/opt && sudo cp -r /home/sfzhang/Workspace/Temp/opt-zynqmp /media/sfzhang/rootfs/opt
if [[ $? -ne 0 ]]
then
    echo "Deploy library failed"
    exit 1
fi

sudo cp /home/sfzhang/Workspace/Temp/profile /media/sfzhang/rootfs/etc
if [[ $? -ne 0 ]]
then
    echo "Deploy profile failed"
    exit 1
fi

sync
echo "Deploy successfully"
