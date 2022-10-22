
#!/bin/bash
echo "Installing dependencies Consul ..."
cd /usr/bin

wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
#sudo curl -o consul.zip https://releases.hashicorp.com/consul/1.6.0/consul_1.6.0_linux_amd64.zip
#unzip consul.zip
sudo apt update -y && sudo apt install consul -y
apt-get install net-tools -y

#sudo rm -f consul.zip
sudo mkdir -p /etc/consul.d/scripts
sudo mkdir -p /var/consul
sudo mkdir -p /etc/consul.d/client

echo "Consul Key Generator"