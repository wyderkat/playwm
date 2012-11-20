### 
# Copyright: © 2012 by Tomasz Wyderka, 
# COFOH international, www.cofoh.com
# License: GPL-2
##

VERSION=0.1
VERSIONING=config/.versioning
TARBALL=playwm_$(VERSION).orig.tar.gz
PACKAGEDIR=playwm-$(VERSION)
IMAGE=$(wildcard image/*)
DEBIAN=$(wildcard debian/*)
CONFIGS=applications.openbox.xml autostart.openbox.sh fonts.conf keyboard.openbox.xml launch.bar.tint2rc Makefile menu.openbox.xml mouse.openbox.xml START.txt task.bar.tint2rc terminal.Xresources theme windows.openbox.xml
CONFIGS_PRE=$(VERSIONING) $(addprefix config/,$(CONFIGS))
ALL_CONFIGS=$(shell find config/ -type f )
SRC=Makefile bin/playwm bin/update-playwm $(IMAGE) xsession/playwm.desktop applications/urxvt.desktop $(CONFIGS_PRE) $(DEBIAN)


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

.PHONY: all dist install dsc deb dput $(VERSIONING) clean self diff

all: $(VERSIONING)

dist: $(TARBALL)

install: 
	install -D -m 0755 bin/playwm $(DESTDIR)$(bindir)/playwm
	install -D -m 0755 bin/update-playwm $(DESTDIR)$(bindir)/update-playwm
	install -D -m 0644 image/logo48.png $(DESTDIR)$(pixmapsdir)/playwm.png
	install -D -m 0644 image/logo32.xpm $(DESTDIR)$(pixmapsdir)/playwm.xpm
	install -D -m 0644 image/wallpaper19201080.jpg $(DESTDIR)$(playwmlibdirimage)/wallpaper19201080.jpg
	install -D -m 0644 xsession/playwm.desktop $(DESTDIR)$(xsessionsdir)/playwm.desktop
	install -D -m 0644 applications/urxvt.desktop $(DESTDIR)$(playwmlibdirapplications)/urxvt.desktop
	mkdir -p $(DESTDIR)$(playwmlibdirconf)
	cp -r $(CONFIGS_PRE)  $(DESTDIR)$(playwmlibdirconf)


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



$(VERSIONING):
	@echo "versioning"
	@echo "_VERSION_=$(VERSION)" > $@
	@$(foreach c,$(ALL_CONFIGS),md5sum $(c) | awk '{ file=$$2;sub(/^config\//,"",file);print file"="$$1 }' >> $@;)


clean:
	@rm -rf $(PACKAGEDIR) playwm_*.orig.tar.gz playwm_*.debian.tar.gz playwm_*.dsc playwm_*.build playwm_*.changes playwm_*ppa.upload
	

# author testing environment

MYCONFIGSPATCHES=autostart.openbox.sh launch.bar.tint2rc
# update configs for development
self:
	@mkdir -p $(HOME)/.playwm
	cp -r $(CONFIGS_PRE)  $(HOME)/.playwm
	@$(foreach p,$(MYCONFIGSPATCHES),patch $(HOME)/.playwm/$(p) < config/.patch.$(p);)

# generate config patches for development
diff:
	@$(foreach p,$(MYCONFIGSPATCHES),diff config/$(p) $(HOME)/.playwm/$(p) > config/.patch.$(p) || true;)

