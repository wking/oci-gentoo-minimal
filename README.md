A minimal [OCI bundle][bundle] based on [Gentoo's stage3s][stage3].

This is enough to run a public [IPFS][] gateway binding to all
available network addresses.

Usage
=====

Run with:

    $ make

which will setup a root filesystem by downloading the latest stage3
tarball from Gentoo's mirrors (the
`downloads/stage3-amd64-current.tar.bz2` target), copying a [minimal
subset](rootfs-files) of that tarball into `rootfs/` (the `rootfs`
target), adjusting permissions (the `setup` target), and calling
`runc` (the `run` target).  The `setup` and `run` steps require
elevated permissions, so the `Makefile` uses [sudo][].

If the `runc` command is not in you're superuser's `PATH`, you can
[override][] the `RUNC` variable.  For example:

  $ make RUNC=$(command -v runc)

or:

  $ make RUNC=./runc

To launch a shell for inspecting a similar container, you can use:

  $ make CONFIG=config-sh.json

[bundle]: https://github.com/opencontainers/specs/blob/master/bundle.md
[stage3]: https://www.gentoo.org/downloads/
[IPFS]: http://ipfs.io/
[sudo]: http://www.sudo.ws/
[override]: https://www.gnu.org/software/make/manual/html_node/Overriding.html
