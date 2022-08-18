#!/bin/sh

device="/dev/nvme0n1"

error_check() {
	if [ $1 -ne 0 ]
	then
		echo "$2 failed: $1"
		exit 1
	else
		echo "$2 successfully!"
	fi
}

echo "Check NVMe device..."
if [ ! -e $device ]
then
	echo "$device is not exist!"
	exit 1
fi

read -p "All data in $device will be erased. Continue? [Y]/n?" answer
if [ "$anwer" != "" ] && [ "$answer" != "Y" ] && [ "$answer" != "n" ]
then
	exit 1
fi

# umount all partitions
for partition in `lsblk $device -o mountpoint --noheadings`
do
	if [ -e "$partition" ]
	then
		umount $partition
		error_check $? "umount $partition"
	fi
done

# remove all partitions
for partition in `parted -s $device print | awk '/^ /{ print $1 }'`
do
	parted -s $device rm $partition
	error_check $? "remove $device partition $partition"
done

# make new partitions
parted -s $device mklabel gpt
error_check $? "make gpt label"

# partition 1: 1.5T
parted -s $device mkpart primary ext4 0% 1536GB
error_check $? "mkpart primary ext4 0% 1536GB"

# partition 2: remain
parted -s $device mkpart primary ext4 1536GB 100%
error_check $? "mkpart primary ext4 1536GB 100%"

partprobe $device
error_check $? "partprobe $device"
sleep 2

# umount all partitions
for partition in `lsblk $device -o mountpoint --noheadings`
do
	if [ -e "$partition" ]
	then
		umount $partition
		error_check $? "umount $partition"
	fi
done

for part in `lsblk -l $device | grep part | awk '{print $1}'`
do
	partition=${part:2}
	mkfs.ext4 -qF /dev/$part
	error_check $? "mkfs.ext4 /dev/$part"
done

echo "Make partitions for $device successfully!"

