# hardening_scripts
# run as `sudo ./hardening.sh`

## To check script worked 
- Run `sudo ufw status verbose` and make sure only specified ports in script are allowed default 534
- ufw is active
- Run `sudo systemctl status fail2ban` and make sure service is active
