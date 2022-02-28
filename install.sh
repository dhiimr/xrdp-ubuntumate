sudo apt-get update
sudo apt-get install xrdp -y
sudo apt-get install mate-core mate-desktop-environment mate-notification-daemon -y
sudo sed -i.bak '/fi/a #xrdp multiple users configuration \n mate-session \n' /etc/xrdp/startwm.sh
sudo /etc/init.d/xrdp restart
sudo apt install tigervnc-xorg-extension tigervnc-standalone-server tigervnc-common -y
mkdir $HOME/.vnc

cat > $HOME/.vnc/xstartup <<\EOF
#!/bin/sh

# Start up the standard system desktop
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS

/usr/bin/mate-session

[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
x-window-manager &

EOF

# Setup correct permission to xstartup
chmod +x $HOME/.vnc/xstartup
