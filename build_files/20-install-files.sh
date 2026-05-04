#!/bin/bash

set -ouex pipefail

## Installing bash and profile files
rm /etc/skel/.bash_profile
cp -f /ctx/files/shell/.bashrc /etc/skel/
cp /ctx/files/shell/.bash_aliases /etc/skel/
cp /ctx/files/shell/.bash_functions /etc/skel/
cp /ctx/files/shell/.profile /etc/skel/

## Installing executables for WMs
# tray-apps
tee /usr/bin/tray-apps << 'EOF'
#!/bin/bash
pasystray &
nm-applet &
blueman-applet &
battray &
EOF
chmod 755 /usr/bin/tray-apps

# fvwm-bgconvert
tee /usr/bin/fvwm-bgconvert << 'EOF'
#!/bin/bash

shopt -s nullglob nocaseglob

rm -f "$HOME/.fvwm/images/icons/bgicons/"*
for i in "$HOME"/Pictures/Wallpapers/*.{png,jpg,jpeg}; do
        convert "$i" -scale 64 "$HOME/.fvwm/images/icons/bgicons/$(basename "${i%.*}").png"
done

rm -f "$HOME/.fvwm/wallpaperMenu"
{
echo "DestroyMenu BGMenu"
echo "AddToMenu BGMenu \"Wallpapers\" Title"

for i in "$HOME"/Pictures/Wallpapers/*.{png,jpg,jpeg}; do
        echo "+ \"$(basename "${i%.*}")%images/icons/bgicons/$(basename "${i%.*}").png%\" \
                SetBG \"$(basename "$i")\""
done
} >> "$HOME/.fvwm/wallpaperMenu"
EOF
chmod 755 /usr/bin/fvwm-bgconvert

# FVWM Config files
rm /usr/share/fvwm3/default-config/FvwmScript-ConfirmCopyConfig \
	/usr/share/fvwm3/default-config/FvwmScript-ConfirmQuit
cp -f /ctx/files/fvwm/config /usr/share/fvwm3/default-config/
cp /ctx/files/fvwm/confirmCopyConfig /usr/share/fvwm3/default-config/
cp /ctx/files/fvwm/confirmExit /usr/share/fvwm3/default-config/
cp /ctx/files/fvwm/confirmReboot /usr/share/fvwm3/default-config/
cp /ctx/files/fvwm/confirmShutdown /usr/share/fvwm3/default-config/
cp -f /ctx/files/fvwm/stalonetrayrc /usr/share/fvwm3/default-config/
