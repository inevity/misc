#!/bin/bash
systemctl stop glusterd
yum remove -y --noautoremove glusterfs glusterfs-api glusterfs-api-devel glusterfs-cli glusterfs-client-xlators glusterfs-debuginfo glusterfs-debugsource glusterfs-devel glusterfs-events glusterfs-fuse glusterfs-libs glusterfs-server python3-gluster
#cd rpmbuild/RPMS/
cd mybuildwithgcc/RPMS
yum localinstall -y ./aarch64/glusterfs-6.0-37.1.p1.ky10.aarch64.rpm ./aarch64/glusterfs-api-6.0-37.1.p1.ky10.aarch64.rpm ./aarch64/glusterfs-api-devel-6.0-37.1.p1.ky10.aarch64.rpm ./aarch64/glusterfs-cli-6.0-37.1.p1.ky10.aarch64.rpm ./aarch64/glusterfs-client-xlators-6.0-37.1.p1.ky10.aarch64.rpm ./aarch64/glusterfs-fuse-6.0-37.1.p1.ky10.aarch64.rpm ./aarch64/glusterfs-libs-6.0-37.1.p1.ky10.aarch64.rpm ./aarch64/glusterfs-debuginfo-6.0-37.1.p1.ky10.aarch64.rpm ./aarch64/glusterfs-debugsource-6.0-37.1.p1.ky10.aarch64.rpm ./aarch64/glusterfs-devel-6.0-37.1.p1.ky10.aarch64.rpm ./aarch64/glusterfs-events-6.0-37.1.p1.ky10.aarch64.rpm ./aarch64/glusterfs-server-6.0-37.1.p1.ky10.aarch64.rpm ./aarch64/python3-gluster-6.0-37.1.p1.ky10.aarch64.rpm
cp -f /var/lib/glusterd/vols/myvol1/myvol1.ky-212.mnt-gbrick-subdir.vol.rpmsave /var/lib/glusterd/vols/myvol1/myvol1.ky-212.mnt-gbrick-subdir.vol
cp -f /var/lib/glusterd/vols/myvol1/trusted-myvol1.tcp-fuse.vol.rpmsave /var/lib/glusterd/vols/myvol1/trusted-myvol1.tcp-fuse.vol
cp -f /var/lib/glusterd/vols/myvol1/trusted-myvol1.tcp-gfproxy-fuse.vol.rpmsave /var/lib/glusterd/vols/myvol1/trusted-myvol1.tcp-gfproxy-fuse.vol
cp -f /var/lib/glusterd/vols/myvol1/myvol1.tcp-fuse.vol.rpmsave /var/lib/glusterd/vols/myvol1/myvol1.tcp-fuse.vol
cp -f /var/lib/glusterd/vols/myvol1/myvol1.gfproxyd.vol.rpmsave /var/lib/glusterd/vols/myvol1/myvol1.gfproxyd.vol
cp -f /var/lib/glusterd/vols/myvol1/myvol1.ky-212.mnt-gbrick2g-subdir.vol.rpmsave /var/lib/glusterd/vols/myvol1/myvol1.ky-212.mnt-gbrick2g-subdir.vol
cp -f /var/lib/glusterd/vols/myvol1/myvol1-rebalance.vol.rpmsave /var/lib/glusterd/vols/myvol1/myvol1-rebalance.vol
cp -f /var/lib/glusterd/vols/myvol1/myvol1-tierd.vol.rpmsave /var/lib/glusterd/vols/myvol1/myvol1-tierd.vo
systemctl start glusterd
sleep 60
ps -ef|grep glus
bb2=$(cat /var/log/glusterfs/bricks/mnt-gbrick2g-subdir.log |grep args|tail -n 1|awk -F: '{print $8}'|rev|sed 's/^.//'|rev|sed 's/^.//')
bb1=$(cat /var/log/glusterfs/bricks/mnt-gbrick-subdir.log |grep args|tail -n 1|awk -F: '{print $8}'|rev|sed 's/^.//'|rev|sed 's/^.//')
tti=$(cat /var/log/glusterfs/tier/myvol1/tierd.log |grep args|tail -n 1|awk -F: '{print $8}'|rev|sed 's/^.//'|rev|sed 's/^.//')
hot="gdb --args $bb2 --debug"
cold="gdb --args $bb1 --debug"
tier="gdb --args $tti --debug"

echo $hot
echo $cold
echo $tier
