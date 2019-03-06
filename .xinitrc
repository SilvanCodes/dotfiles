xscreensaver &

xrdb -merge .Xresources

# load background image
~/.fehbg &

# keyboard layout switcher
setxkbmap -layout de,us -option 'grp:alt_shift_toggle'

# start window manager
exec xmonad
# exec awesome
