
# Needed to run this script as sudo since it changes few root level settings

# Assuming Config file is in folder /etc/modprode.d/blacklist.conf
# Adding usb-storage to blacklist
echo "blacklist usb-storage" >> /etc/modprobe.d/blacklist.conf 

# Adding SSH Daemon Services Configuration 
# Remove Password Authentication
# Removing Logging in as a Root
# Changing Default ssh port and Account Lockout Policy
# Adding Protocol 2 as default in ssh

# TODO : Better to make a sshd_config file and replace files

echo " ChallengeResponseAuthentication no \n PasswordAuthentication no \n PermitRootLogin no \n PermitEmptyPasswords no \n Port 534 \n MaxAuthTries 5 \n Protocol 2" >> /etc/ssh/sshd_config

systemctl restart ssh

# Patching Software and Upgrade
sudo apt update -y
sudo apt upgrade -y

# Base Level
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