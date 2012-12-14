RE_FILES=.reconf_openbox_FLAG .reconf_tint2_FLAG .reconf_terminal_FLAG .restart_openbox_FLAG

.PHONY: all reconf clean markconfigured

all: reconf

reconf: $(RE_FILES)

.reconf_tint2_FLAG: task.bar.tint2rc launch.bar.tint2rc
	killall -USR1 tint2
	touch $@

.reconf_openbox_FLAG: applications.openbox.xml keyboard.openbox.xml menu.openbox.xml mouse.openbox.xml internal.openbox.xml
	killall -USR2 openbox
	touch $@

.reconf_terminal_FLAG: terminal.Xresources
	xrdb -merge terminal.Xresources
	touch $@

# this doesn't work for launching applications
# We need to exit and start again PlayWM
.restart_openbox_FLAG: autostart.openbox.sh
	#killall -USR1 openbox
	@echo "File autostart.openbox.sh has changed so you need to restart your session."
	@echo "Please logout/login again if you want changes work."


markconfigured: 
	touch $(RE_FILES)

clean:
	rm -f $(RE_FILES)


