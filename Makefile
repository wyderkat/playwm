###
# Copyright: © 2012 by Tomasz Wyderka, 
# COFOH international, www.cofoh.com
# License: GPL-2
##

VERSION=0.1
TARBALL=playwm_$(VERSION).orig.tar.gz
PACKAGEDIR=playwm-$(VERSION)
IMAGE=$(wildcard image/*)
CONFIGS=$(wildcard config/*)
DEBIAN=$(wildcard debian/*)
SRC=Makefile bin/playwm $(IMAGE) xsession/playwm.desktop $(CONFIGS) $(DEBIAN)

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
	@tar zcf $@ --transform 's%^%$(PACKAGEDIR)/%' $^
	@tar tf $@


dsc: $(TARBALL)
	tar xf *.orig.*
	cd $(PACKAGEDIR) && debuild -S
	@rm -r $(PACKAGEDIR)

deb: $(TARBALL)
	tar xf *.orig.*
	cd $(PACKAGEDIR) && debuild -us -uc
	@rm -r $(PACKAGEDIR)

dput:
	dput ppa:wyderka-t/playwm playwm_*.changes

clean:
	@rm -rf $(PACKAGEDIR) playwm_*.orig.tar.gz playwm_*.debian.tar.gz playwm_*.dsc playwm_*.build playwm_*.changes playwm_*.deb playwm_*ppa.upload
	

.PHONY: html dist dsc all build install clean
