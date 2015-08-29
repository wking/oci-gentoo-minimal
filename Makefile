.PRECIOUS: rootfs %.tar.bz2

RUNC = ./runc
CONFIG = config.json
ROOTFS =

run: setup
	sudo $(RUNC) $(CONFIG)

setup: $(ROOTFS)
	sudo chown -R root:root rootfs root
	sudo chmod 755 runc rootfs/bin/* rootfs/lib64/*

clean:
	sudo rm -rf root rootfs/etc/resolv.conf
	mkdir root
	echo '*' >root/.gitignore

downloads/stage3-amd64-current.tar.bz2: grab.sh
	./$<
	touch downloads/stage3-amd64-*.tar.bz2

rootfs/etc: downloads/stage3-amd64-current.tar.bz2 rootfs-files
	mkdir -p rootfs
	tar -xvf downloads/stage3-amd64-current.tar.bz2 -C rootfs \
		--no-recursion --wildcards $$(< rootfs-files)
