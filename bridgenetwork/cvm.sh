#!/usr/bin/env bash
set -x
# Update kickstart file
echo -en "Enter Hostname: "
read HOST_NAME
#echo -en "Enter IP Address: "
#read IP_ADDRESS
KSLOC="/root/oss/misc/bridgenetwork/ks.cfg"
#sed -ibackup 's/server1/'$HOST_NAME'/g' ./ks.cfg
#if grep -Fxq "server1" ${KSLOC}
#if grep -Fq "server1" ${KSLOC}
#    then
#    # code if found
#    else
#       exit
#fi
str="server1"
if grep "$str" ${KSLOC} > /dev/null
then
   echo "ok to continue"
else
   echo "please to change to server1.tc.com in ks.cfg, then retry"
   exit
fi

sed -ibackup 's/server1/'$HOST_NAME'/g' ${KSLOC}
#sudo sed -i 's/server1/'$HOST_NAME'/g' /srv/http/ks.cfg
#sed -i 's/192.168.122.100/'$IP_ADDRESS'/g' ./ks.cfg


## Pre-defined variables
echo ""
MEM_SIZE=4096
VCPUS=1
#OS_VARIANT="rhel7"
#OS_VARIANT="rhel7"
OS_VARIANT="centos7.0"
#ISO_FILE="$HOME/iso/CentOS-7-x86_64-Everything-1611.iso"
#ISO_FILE="/var/lib/libvirt/images/CentOS-7-x86_64-Minimal-1611.iso"
ISO_FILE="/sdb/images/CentOS-7-x86_64-Minimal-1810.iso"

echo -en "Enter vm name: "
read VM_NAME
OS_TYPE="linux"
#echo -en "Enter virtual disk size : "
#read DISK_SIZE

# nat ,onboot?
#sudo virt-install \
#     --disk size=${DISK_SIZE}  \
#     --network bridge=virbr0 --network bridge=docker0 \
   #  --wait 1 \
   #  --noreboot \
     #--disk path=/mnt/sdg/images/${VM_NAME}.img,size=200 \
    # -x "ks=http://121.14.254.234:60801/html/ks.cfg"
virt-install \
     --name ${VM_NAME} \
     --memory=${MEM_SIZE} \
     --vcpus=${VCPUS} \
     --os-type ${OS_TYPE} \
     --location ${ISO_FILE} \
     --disk path=/sdb/vms/${VM_NAME}.img,size=30,format=qcow2,bus=virtio,boot_order=1 \
     --disk path=/sdb/vms/${VM_NAME}-1.img,size=20,format=qcow2,bus=virtio,boot_order=2 \
     --graphics=none \
     --hvm \
     --os-variant=${OS_VARIANT} \
     --network bridge=br0 \
     --network bridge=virbr1 \
     --network bridge=virbr2 \
     --console pty,target_type=serial \
     --initrd-inject ${KSLOC} \
     -x 'console=ttyS0,115200n8 serial' \
     -x "ks=file:/ks.cfg"



cp -f ./ks.cfgbackup ./ks.cfg
trap ctrl_c INT

function ctrl_c() {
        cp -f ./ks.cfgbackup ./ks.cfg
    }

