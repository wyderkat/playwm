all: reconf

reconf: .reconf_openbox_FLAG .reconf_tint2_FLAG

.reconf_tint2_FLAG: task.bar.tint2rc launch.bar.tint2rc
	killall -USR1 tint2
	touch $@

.reconf_openbox_FLAG: windows.openbox.xml menu.openbox.xml system-menu.openbox.xml 
	killall -USR2 openbox
	touch $@

clean:
	rm -f .reconf_openbox_FLAG .reconf_tint2_FLAG


.PHONY: reconf clean
