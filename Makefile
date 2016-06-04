.PHONY: clean

clean:
	rm -Rf out

install:
	mkdir -p /opt/fuzetsu
	cp -Rf ./* /opt/fuzetsu
	cp /opt/fuzetsu/fuzetsu-bin /usr/bin/fuzetsu
	chmod +x /usr/bin/fuzetsu

osv:
	./osv-install.sh
