# MUST TO READ - HEADER
#
# This is just set of shell commands (executed by "bash")
# Those commands are run when PlayWM is started. 
# Notice background mark (&) at the end of commands which should be running 
# all the time.
#
# END OF HEADER

# directory for log files
LOG=~/.playwm/log
# setting background photo (wallpaper)
feh --bg-center  /usr/lib/playwm/image/wallpaper19201080.jpg
# xcompmgr is responsible for transparency. It is very important to PlayWM.
xcompmgr   &> $LOG/xcompmgr &
# xcompmgr has to be started before next applications with a slight delay
sleep 1
# Keyboard_layout_example: setxkbmap 'pl,th' -option 'grp:menu_toggle'
# top panel 
tint2 -c ~/.playwm/task.bar.tint2rc  &> $LOG/task.bar  &
# right panel
tint2 -c ~/.playwm/launch.bar.tint2rc  &> $LOG/launch.bar &
# settings for terminal. xrdb is just for configure terminal
xrdb -merge ~/.playwm/terminal.Xresources
# application to control volume
volumeicon &
# standard Ubuntu application to control WiFi
nm-applet &
