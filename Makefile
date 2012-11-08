###
# Copyright: © 2012 by Tomasz Wyderka, 
# COFOH international, www.cofoh.com
# License: GPL-2
##

VERSION=0.1
TARBALL=playwm_$(VERSION).orig.tar.gz
PACKAGEDIR=playwm-$(VERSION)
CONFIGS=$(wildcard config/*)

prefix=/usr
bindir=$(prefix)/bin
sharedir=$(prefix)/share
pixmapsdir=$(sharedir)/pixmaps
xsessionsdir=$(sharedir)/xsessions
docdir=$(sharedir)/doc
mandir=$(sharedir)/man
man1dir=$(mandir)/man1
playwmlibdir=$(prefix)/lib/playwm
playwmconflibdir=$(playwmlibdir)/config
playwmimagelibdir=$(playwmlibdir)/image

all: 

dist: $(TARBALL)

install: 
	install -D -m 0755 bin/playwm $(DESTDIR)$(bindir)/playwm
	install -D -m 0644 image/logo64.png $(DESTDIR)$(pixmapsdir)/playwm.png
	install -D -m 0644 image/wallpaper19201080.jpg $(DESTDIR)$(playwmimagelibdir)/wallpaper19201080.jpg
	install -D -m 0644 xsession/playwm.desktop $(DESTDIR)$(xsessionsdir)/playwm.desktop
	mkdir -p $(DESTDIR)$(playwmconflibdir)
	install -D -m 0644 $(CONFIGS) $(DESTDIR)$(playwmconflibdir)

# for develop environment, should be run after make install
selfdevelop:
	ln -sf $(CURDIR)/bin/playwm $(DESTDIR)$(bindir)/playwm
	ln -sf $(CURDIR)/image/logo64.png $(DESTDIR)$(pixmapsdir)/playwm.png
	ln -sf $(CURDIR)/xsession/playwm.desktop $(DESTDIR)$(xsessionsdir)/playwm.desktop
	ln -sf $(addprefix $(CURDIR)/,$(CONFIGS)) $(DESTDIR)$(playwmconflibdir)
	ln -sf $(addprefix $(CURDIR)/,$(CONFIGS)) $(DESTDIR)$(HOME)/.playwm

$(TARBALL) : $(SRC)
	@mkdir $(PACKAGEDIR)
	@cp -r $(SRC) $(PACKAGEDIR)
	@tar zcf $@ $(PACKAGEDIR)
	@tar tf $@
	@rm -r $(PACKAGEDIR)


dsc: $(TARBALL)
	tar xf *.orig.*
	cd $(PACKAGEDIR) && debuild -S
	@rm -r $(PACKAGEDIR)

deb: $(TARBALL)
	tar xf *.orig.*
	cd $(PACKAGEDIR) && debuild -us -uc
	@rm -r $(PACKAGEDIR)

dput:
	dput ppa:wyderka-t/terminalforhuman terminalforhuman_*.changes

clean:
	@rm -f waitforcharacter
	@rm -f $(TARBALL) terminalforhuman.html
	@rm -rf $(PACKAGEDIR) terminalforhuman_*.debian.tar.gz terminalforhuman_*.dsc terminalforhuman_*.build terminalforhuman_*.changes terminalforhuman_*.deb terminalforhuman_*ppa.upload
	

.PHONY: html dist dsc all build install clean
