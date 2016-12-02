.PHONY: all install dpkg osv lxc lxc-tar

all:
	true

install: fuzetsutmp.tar.gz
	mkdir -p $(DESTDIR)/usr/bin/
	mkdir -p $(DESTDIR)/var/flamehaze/
	cp fuzetsu fuzetsu-envs fuzetsu-lxc $(DESTDIR)/usr/bin/
	chmod +x $(DESTDIR)/usr/bin/fuzetsu
	
	mkdir -p $(DESTDIR)/etc/lxc/
	cp lxc-config-files/subuid $(DESTDIR)/etc/subuid
	cp lxc-config-files/subgid $(DESTDIR)/etc/subgid
	cp lxc-config-files/lxc-usernet-during-install $(DESTDIR)/etc/lxc/lxc-usernet
	
	mkdir -p $(DESTDIR)/var/flamehaze/.config/lxc/
	cp lxc-config-files/lxc-lxc.conf $(DESTDIR)/var/flamehaze/.config/lxc/lxc.conf
	cp lxc-config-files/lxc-default.conf $(DESTDIR)/var/flamehaze/.config/lxc/default.conf
	chown -Rf flamehaze.flamehaze $(DESTDIR)/var/flamehaze
	tar xzp --same-owner -C $(DESTDIR)/var/flamehaze/ -f fuzetsutmp.tar.gz

dpkg: fuzetsutmp.tar.gz
	rm debian/fuzetsu -Rf
	rm debian/fuzetsu.debhelper.log -f
	fakeroot debian/rules binary

osv:
	./osv-install.sh

lxc:
	./lxc-install.sh

lxc-tar:
	./lxc-install.sh
	(cd /var/flamehaze; tar czf fuzetsutmp.tar.gz fuzetsutmp/); mv /var/flamehaze/fuzetsutmp.tar.gz .
	rm -rf /var/flamehaze/fuzetsutmp
