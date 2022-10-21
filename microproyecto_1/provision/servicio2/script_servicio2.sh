
#!/bin/bash
#Consul configuration for server (backend Service 2)
#consul agent -node=agent-servidor2 -bind=192.168.100.8 -enable-script-checks=true -data-dir=/tmp/consul -config-dir=/etc/consul.d
echo "configurando dependencias servicio2"
#consul agent -node=agent-servidor2 -bind=192.168.100.8 -enable-script-checks=true -data-dir=/tmp/consul -config-dir=/etc/consul.d -retry-join "192.168.100.6" -retry-join "192.168.100.7" &
echo "configurando service discovery con consul"

sudo cp --force /vagrant/provision/servicio2/config.json /etc/consul.d/ 
sudo cp --force /vagrant/provision/servicio2/consul-client.service /etc/systemd/system/

sudo systemctl enable consul.service
sudo systemctl start consul.service
sudo systemctl enable consul-client
sudo systemctl daemon-reload
sudo systemctl start consul-client

echo "configurando servicio web con apache"  
sudo apt update -y && apt upgrade -y
apt-get install net-tools -y
# apt install apache2 -y
# systemctl enable apache2
# sudo cp --force /vagrant/provision/servicio2/index.html /var/www/html/index.html
# systemctl start apache2
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt install nodejs -y
sudo apt install npm -y
sudo cp --force /vagrant/provision/servicio2/app/index.js /home/vagrant/ 
npm install consul
npm install express
node index.js 3000 &

echo "configurando haproxy-consul" 
sudo cp --force /vagrant/provision/servicio2/web-service.json /etc/consul.d/