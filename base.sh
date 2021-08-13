#1. Enable and configure firewall

sudo ufw default allow outgoing 
sudo ufw default deny incoming

# Allow application and ports which are needed on firewall
sudo ufw allow ssh
sudo ufw allow 534

sudo ufw enable

#2. Disable Root Account Password
sudo passwd -l root

# can be re-enabled with `sudo passwd root`

#3. Including IPS(Intrustion Prevention System)
sudo apt-get install fail2ban -y

cp ./jail.local /etc/fail2ban/

sudo systemctl restart fail2ban

# To list banend offender run `sudo iptables -L f2b-sshd --line-numbers`
# To remove from ban `sudo iptables -D fail2ban <Chain Num>`