# docker-gobetween

### Configure the docker-gobetween requirements
> WARNING: Only this commands requires root permissions, all next should be run under your user


Allow the staff group to configure ip balancer without password prompt  
```bash
sudo tee /etc/sudoers.d/docker-gobetween <<SUDOERS
%staff ALL=(ALL) NOPASSWD: $(brew --prefix)/opt/docker-virtualbox/bin/gobetween
SUDOERS
```

> Reboot your system to be sure that sudoers applied
