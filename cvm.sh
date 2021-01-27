#!/usr/bin/env bash
set -x
# Update kickstart file
echo -en "Enter Hostname: "
read HOST_NAME
echo -en "Enter IP Address: "
read IP_ADDRESS
sed -ibackup 's/server1/'$HOST_NAME'/g' /root/baul/html/ks.cfg
#sudo sed -i 's/server1/'$HOST_NAME'/g' /srv/http/ks.cfg
sed -i 's/192.168.122.100/'$IP_ADDRESS'/g' /root/baul/html/ks.cfg

## Pre-defined variables
echo ""
MEM_SIZE=4096
VCPUS=1
#OS_VARIANT="rhel7"
OS_VARIANT="rhel7"
#ISO_FILE="$HOME/iso/CentOS-7-x86_64-Everything-1611.iso"
ISO_FILE="/var/lib/libvirt/images/CentOS-7-x86_64-Minimal-1611.iso"

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
virt-install \
     --name ${VM_NAME} \
     --memory=${MEM_SIZE} \
     --vcpus=${VCPUS} \
     --os-type ${OS_TYPE} \
     --location ${ISO_FILE} \
     --disk path=/mnt/sdg/images/${VM_NAME}.img,size=200 \
     --graphics=none \
     --hvm \
     --os-variant=${OS_VARIANT} \
     --console pty,target_type=serial \
     -x 'console=ttyS0,115200n8 serial' \
     -x "ks=http://121.14.254.234:60801/html/ks.cfg"



cp -f /root/baul/html/ks.cfgbackup /root/baul/html/ks.cfg
trap ctrl_c INT

function ctrl_c() {
        cp -f /root/baul/html/ks.cfgbackup /root/baul/html/ks.cfg
    }

