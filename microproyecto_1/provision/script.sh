
#!/bin/bash
echo "Installing dependencies Consul ..."
cd /usr/bin
sudo curl -o consul.zip https://releases.hashicorp.com/consul/1.6.0/consul_1.6.0_linux_amd64.zip
unzip consul.zip
sudo apt update -y && sudo apt install consul -y
apt-get install net-tools -y
sudo rm -f consul.zip
sudo mkdir -p /etc/consul.d/scripts
sudo mkdir -p /var/consul
sudo mkdir -p /etc/consul.d/client