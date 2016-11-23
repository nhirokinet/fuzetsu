#!/bin/bash

. $(dirname $0)/fuzetsu-envs
FLAMEHAZE_USER=flamehaze

function wait_for_network () {
	vm_name=$1
	while true
	do
		sudo -H -u $FLAMEHAZE_USER lxc-attach -P $VMPATH -n $vm_name --  /sbin/ip addr | grep inet | grep eth && break
		sleep 1
	done
	sleep 1
}

function start_vm () {
	vm_name=$1
	sudo -H -u $FLAMEHAZE_USER lxc-start -P $VMPATH -n $vm_name -d --logfile /tmp/fuzetsu-log
	sudo -H -u $FLAMEHAZE_USER lxc-wait -P $VMPATH -n $vm_name -s RUNNING
	wait_for_network $vm_name
}

function disconnect_from_network () {
	vm_name=$1
	sudo -H -u $FLAMEHAZE_USER sed -i -e 's/^.*\/etc\/lxc\/default\.conf$//g' $VMPATH'/'$vm_name'/config'
	sudo -H -u $FLAMEHAZE_USER /bin/bash -c 'echo "lxc.network.type = empty" >>'$VMPATH'/'$vm_name'/config'
	sudo -H -u $FLAMEHAZE_USER /bin/bash -c 'echo "lxc.cgroup.memory.limit_in_bytes = 192M" >>'$VMPATH'/'$vm_name'/config'
}

function install_app_template () {
	vm_name=$1
	sudo -H -u $FLAMEHAZE_USER lxc-destroy -P $VMPATH -n $vm_name -f
	sudo -H -u $FLAMEHAZE_USER lxc-copy -P $VMPATH -p $VMPATH -N $vm_name -n `cat ./lxc-app-templates/$vm_name/base_image` -B overlayfs -s
	start_vm $vm_name
	sudo -H -u $FLAMEHAZE_USER lxc-attach -P $VMPATH -n $vm_name -- /usr/bin/tee /usr/bin/install < ./lxc-app-templates/$vm_name/install > /dev/null
	sudo -H -u $FLAMEHAZE_USER lxc-attach -P $VMPATH -n $vm_name -- chmod +x /usr/bin/install
	sudo -H -u $FLAMEHAZE_USER lxc-attach -P $VMPATH -n $vm_name -- /usr/bin/install
	sudo -H -u $FLAMEHAZE_USER lxc-attach -P $VMPATH -n $vm_name -- /usr/bin/tee /usr/bin/compile < ./lxc-app-templates/$vm_name/compile > /dev/null
	sudo -H -u $FLAMEHAZE_USER lxc-attach -P $VMPATH -n $vm_name -- chmod +x /usr/bin/compile
	sudo -H -u $FLAMEHAZE_USER lxc-attach -P $VMPATH -n $vm_name -- /usr/bin/tee /usr/bin/run < ./lxc-app-templates/$vm_name/run > /dev/null
	sudo -H -u $FLAMEHAZE_USER lxc-attach -P $VMPATH -n $vm_name -- chmod +x /usr/bin/run
	sudo -H -u $FLAMEHAZE_USER lxc-stop -P $VMPATH -n $vm_name
	disconnect_from_network $vm_name
}

function install_base_image () {
	vm_name=$1
	./lxc-base-images/$vm_name/setup
}

function init_lxc () {
	user=$1
	home=`echo $(eval echo ~${user})`
	export HOME=$home
	mkdir -p $home/.config/lxc/
	cat > $home/.config/lxc/lxc.conf < lxc-config-files/lxc-lxc.conf
	cat > $home/.config/lxc/default.conf < lxc-config-files/lxc-default.conf
	chown -Rf $user.$user $home
}

function after_install () {
	cp lxc-config-files/lxc-usernet-after-install /etc/lxc/lxc-usernet
}

id -u $FLAMEHAZE_USER || sudo useradd $FLAMEHAZE_USER -d /var/flamehaze
mkdir ~$FLAMEHAZE_USER -p
chown $FLAMEHAZE_USER ~$FLAMEHAZE_USER

cp lxc-config-files/subuid /etc/subuid
cp lxc-config-files/subgid /etc/subgid
cp lxc-config-files/lxc-usernet-during-install /etc/lxc/lxc-usernet

rm -rf $VMPATH
mkdir -p $VMPATH

init_lxc $FLAMEHAZE_USER

for i in lxc-base-images/*
do
	install_base_image `basename $i`
done

for i in lxc-app-templates/*
do
	install_app_template `basename $i`
done

after_install
