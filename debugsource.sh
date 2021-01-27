#!/bin/bash
#bb2=$(cat /var/log/glusterfs/bricks/mnt-gbrick2g-subdir.log |grep args|tail -n 1|awk -F: '{print $8}'|rev|sed 's/^.//'|rev|sed 's/^.//')
#bb1=$(cat /var/log/glusterfs/bricks/mnt-gbrick-subdir.log |grep args|tail -n 1|awk -F: '{print $8}'|rev|sed 's/^.//'|rev|sed 's/^.//')
#tti=$(cat /var/log/glusterfs/tier/myvol1/tierd.log |grep args|tail -n 1|awk -F: '{print $8}'|rev|sed 's/^.//'|rev|sed 's/^.//')
##hot="gdb --args $bb2 --debug"
##cold="gdb --args $bb1 --debug"
##tier="gdb --args $tti --debug"
#gdb -ex 'break _gf_event' -ex 'run  -s ky-212 --volfile-id myvol1.ky-212.mnt-gbrick2g-subdir -p /var/run/gluster/vols/myvol1/ky-212-mnt-gbrick2g-subdir.pid -S /var/run/gluster/83615f8c068e2c8d.socket --brick-name /mnt/gbrick2g/subdir -l /var/log/glusterfs/bricks/mnt-gbrick2g-subdir.log --xlator-option *-posix.glusterd-uuid=5539d192-4b44-498e-8fa3-cc0ab5eba495 --process-name brick --brick-port 49152 --xlator-option myvol1-server.listen-port=49152 --debug' /usr/sbin/glusterfsd
#
bb2=$(cat /var/log/glusterfs/bricks/mnt-gbrick2g-subdir.log |grep args|tail -n 1|awk -F: '{print $8}'|rev|sed 's/^.//'|rev|sed 's/^.//'|cut -c 27-)
bb1=$(cat /var/log/glusterfs/bricks/mnt-gbrick-subdir.log |grep args|tail -n 1|awk -F: '{print $8}'|rev|sed 's/^.//'|rev|sed 's/^.//'|cut -c 27-)
tti=$(cat /var/log/glusterfs/tier/myvol1/tierd.log |grep args|tail -n 1|awk -F: '{print $8}'|rev|sed 's/^.//'|rev|sed 's/^.//'|cut -c 26-)
gfsd='/usr/local/sbin/glusterfsd'
gfs='/usr/local/sbin/glusterfs'

hot="gdb -ex 'break _gf_event' -ex 'run $bb2 --debug' $gfsd" 
cold="gdb -ex 'break _gf_event' -ex 'run $bb1 --debug' $gfsd" 
tier="gdb -ex 'break _gf_event' -ex 'run $tti --debug' $gfs" 

echo $hot
echo ""
echo ""
echo $cold 
echo ""
echo ""
echo $tier
