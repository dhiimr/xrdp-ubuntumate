apt update

echo " INSTALLING DROPBEAR
apt-get install -y dropbear

cat > /etc/default/dropbear <<\EOF
# disabled because OpenSSH is installed
# change to NO_START=0 to enable Dropbear
NO_START=0

# the TCP port that Dropbear listens on
DROPBEAR_PORT=8080

# any additional arguments for Dropbear
DROPBEAR_EXTRA_ARGS=

# specify an optional banner file containing a message to be
# sent to clients before they connect, such as "/etc/issue.net"
DROPBEAR_BANNER=

# RSA hostkey file (default: /etc/dropbear/dropbear_rsa_host_key)
#DROPBEAR_RSAKEY="/etc/dropbear/dropbear_rsa_host_key"

# DSS hostkey file (default: /etc/dropbear/dropbear_dss_host_key)
#DROPBEAR_DSSKEY="/etc/dropbear/dropbear_dss_host_key"

# Receive window size - this is a tradeoff between memory and
# network performance
DROPBEAR_RECEIVE_WINDOW=65536

EOF

systemctl enable dropbear
systemctl start dropbear

clear
echo " FINISH DROPBEAR "
sleep 1
clear
echo " INSTALLING STUNNEL4"

apt-get install -y stunnel4
cat > /etc/stunnel/stunnel.conf <<\EOF
cert = /etc/stunnel/stunnel.pem
client = no
socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1

[dropbear]
connect = 127.0.0.1:8080
accept = 777

EOF

openssl genrsa -out key.pem 2048
openssl req -new -x509 -key key.pem -out cert.pem -days 1095
cat key.pem cert.pem >> /etc/stunnel/stunnel.pem

cat > /etc/default/stunnel4 <<\EOF

# /etc/default/stunnel
# Julien LEMOINE <speedblue@debian.org>
# September 2003

# Change to one to enable stunnel automatic startup
ENABLED=1
FILES="/etc/stunnel/*.conf"
OPTIONS=""

# Change to one to enable ppp restart scripts
PPP_RESTART=0
EOF

systemctl enable stunnel4
systemctl start stunnel4

clear
echo " FINISH INSTALLING STUNNEL"
sleep 1
clear
echo "INSTALLING SSLH"
apt-get install sslh
wget -O /etc/default/sslh "https://raw.githubusercontent.com/idtunnel/sslh/master/sslh-conf"
systemctl enable sslh
systemctl restart ssh
systemctl restart dropbear
systemctl restart stunnel4
systemctl restart sslh
echo " FINISH ALL DONE"
