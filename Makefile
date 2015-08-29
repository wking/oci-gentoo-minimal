.PRECIOUS: rootfs %.tar.bz2

RUNC = runc
CONFIG = config.json
ROOTFS =

TEMPLATE_VARIABLES = UID GID
UID = $(shell id -u)
GID = $(shell id -g)

run: setup
	sudo $(RUNC) $(CONFIG)

setup: config.json $(ROOTFS)
	chmod 755 rootfs/bin/* rootfs/lib64/*

clean:
	rm -rf root rootfs/etc/resolv.conf config*.json
	mkdir root
	echo '*' >root/.gitignore

downloads/stage3-amd64-current.tar.bz2: grab.sh
	./$<
	touch downloads/stage3-amd64-*.tar.bz2

rootfs: downloads/stage3-amd64-current.tar.bz2 rootfs-files
	mkdir rootfs
	tar -xvf downloads/stage3-amd64-current.tar.bz2 -C rootfs \
		--no-recursion --wildcards $$(< rootfs-files)

config.json: %: %.template
	env -i \
		UID=$(UID) \
		GID=$(GID) \
		envsubst '$(TEMPLATE_VARIABLES:%=$${%})' <"$<" >"$@"
