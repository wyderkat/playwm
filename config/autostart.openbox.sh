LOG=~/.playwm/log
feh --bg-center  /usr/lib/playwm/image/wallpaper19201080.jpg
xcompmgr   &> $LOG/xcompmgr &
sleep 1 # xcompmgr has to be started before next applications with delay
tint2 -c ~/.playwm/launch.bar.tint2rc  &> $LOG/launch.bar &
tint2 -c ~/.playwm/task.bar.tint2rc  &> $LOG/task.bar  &
xrdb -merge ~/.playwm/terminal.Xresources
volumeicon &
nm-applet&
