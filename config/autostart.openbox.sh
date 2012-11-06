xrandr --output LVDS1 --off
xrandr --output VGA1 --mode 1920x1080
feh --bg-center  ~/.background/trawa.jpg
xcompmgr &
sleep 1 # xcompmgr has to be started before next applications
tint2 -c ~/.config/tint2/launch.bar.tint2rc &
tint2 -c ~/.config/tint2/task.bar.tint2rc &
volumeicon &
nm-applet&
workrave &
# radiotray doesn't want to start, even after long sleep
radiotray > /home/tom/a.log 2>&1 &
