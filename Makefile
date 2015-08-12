.PRECIOUS: rootfs %.tar.bz2

RUNC = runc

run: setup
	sudo $(RUNC)

setup: rootfs
	sudo chown -R root:root rootfs root
	sudo chmod 755 rootfs/bin/* rootfs/lib64/*

clean:
	sudo rm -rf root rootfs/etc/resolv.conf
	mkdir root
	echo '*' >root/.gitignore

downloads/stage3-amd64-current.tar.bz2: grab.sh
	./$<
	touch downloads/stage3-amd64-*.tar.bz2

rootfs: downloads/stage3-amd64-current.tar.bz2 rootfs-files
	mkdir rootfs
	tar -xvf downloads/stage3-amd64-current.tar.bz2 -C rootfs \
		--no-recursion --wildcards $$(< rootfs-files)
