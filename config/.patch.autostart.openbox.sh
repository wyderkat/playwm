0a1,2
> xrandr --output LVDS1 --off
> xrandr --output VGA1 --mode 1920x1080
7a10,14
> workrave &
> mail-notification &
> # radiotray doesn't want to start, even after long sleep
> # but only from lightdm. from startx is OK
> radiotray > /home/tom/a.log 2>&1 &
