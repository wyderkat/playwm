xrandr --output LVDS1 --off
xrandr --output VGA1 --mode 1920x1080
feh --bg-center  /usr/lib/playwm/image/wallpaper19201080.jpg
xcompmgr &
sleep 1 # xcompmgr has to be started before next applications
tint2 -c ~/.playwm/launch.bar.tint2rc &
tint2 -c ~/.playwm/task.bar.tint2rc &
volumeicon &
nm-applet&
workrave &
mail-notification &
# radiotray doesn't want to start, even after long sleep
# but only from lightdm. from startx is OK
radiotray > /home/tom/a.log 2>&1 &
