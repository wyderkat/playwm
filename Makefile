###
# Copyright: © 2012 by Tomasz Wyderka, 
# COFOH international, www.cofoh.com
# License: GPL-2
##

VERSION=0.1
TARBALL=playwm_$(VERSION).orig.tar.gz
PACKAGEDIR=playwm-$(VERSION)
IMAGE=$(wildcard image/*)
DEBIAN=$(wildcard debian/*)
SRC=Makefile bin/playwm $(IMAGE) xsession/playwm.desktop applications/urxvt.desktop config $(DEBIAN)


prefix=/usr
bindir=$(prefix)/bin
sharedir=$(prefix)/share
pixmapsdir=$(sharedir)/pixmaps
xsessionsdir=$(sharedir)/xsessions
docdir=$(sharedir)/doc
mandir=$(sharedir)/man
man1dir=$(mandir)/man1
playwmlibdir=$(prefix)/lib/playwm
playwmlibdirconf=$(playwmlibdir)/config
playwmlibdirimage=$(playwmlibdir)/image
playwmlibdirapplications=$(playwmlibdir)/applications

all: 

dist: $(TARBALL)

install: 
	install -D -m 0755 bin/playwm $(DESTDIR)$(bindir)/playwm
	install -D -m 0644 image/logo48.png $(DESTDIR)$(pixmapsdir)/playwm.png
	install -D -m 0644 image/logo32.xpm $(DESTDIR)$(pixmapsdir)/playwm.xpm
	install -D -m 0644 image/wallpaper19201080.jpg $(DESTDIR)$(playwmlibdirimage)/wallpaper19201080.jpg
	install -D -m 0644 xsession/playwm.desktop $(DESTDIR)$(xsessionsdir)/playwm.desktop
	install -D -m 0644 applications/urxvt.desktop $(DESTDIR)$(playwmlibdirapplications)/urxvt.desktop
	cp -r config  $(DESTDIR)$(playwmlibdir)

MYCONFIGSPATCHES=autostart.openbox.sh launch.bar.tint2rc windows.openbox.xml
self:
	@mkdir -p $(HOME)/.playwm
	cp -r config/* $(HOME)/.playwm
	@$(foreach p,$(MYCONFIGSPATCHES),patch $(HOME)/.playwm/$(p) < config/.patch.$(p);)

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
	@rm -rf $(PACKAGEDIR) playwm_*.orig.tar.gz playwm_*.debian.tar.gz playwm_*.dsc playwm_*.build playwm_*.changes playwm_*ppa.upload
	

.PHONY: html dist dsc all build install clean
