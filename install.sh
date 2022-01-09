sudo apt-get update
sudo apt-get install xrdp -y
sudo apt-get install mate-core mate-desktop-environment mate-notification-daemon -y
sudo sed -i.bak '/fi/a #xrdp multiple users configuration \n mate-session \n' /etc/xrdp/startwm.sh
sudo /etc/init.d/xrdp restart
sudo apt install tigervnc-xorg-extension tigervnc-standalone-server tigervnc-common -y
