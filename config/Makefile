all: reconf

reconf: .reconf_openbox_FLAG .reconf_tint2_FLAG

.reconf_tint2_FLAG: task.bar.tint2rc launch.bar.tint2rc
	killall -USR1 tint2
	touch $@

.reconf_openbox_FLAG: windows.openbox.xml menu.openbox.xml 
	killall -USR2 openbox
	touch $@

# this doesn't work for launching applications
# We need to exit and start again PlayWM
.restart_openbox_FLAG: autostart.openbox.sh
	killall -USR1 openbox
	touch $@

clean:
	rm -f .reconf_openbox_FLAG .reconf_tint2_FLAG .restart_openbox_FLAG


.PHONY: reconf clean
