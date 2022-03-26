cd ~/
wget https://raw.githubusercontent.com/dhiimr/xrdp-ubuntumate/main/sudoers
wget https://raw.githubusercontent.com/dhiimr/xrdp-ubuntumate/main/sshd_config
sudo mv sudoers /etc/
sudo mv sshd_config /etc/ssh/
sudo service sshd restart
