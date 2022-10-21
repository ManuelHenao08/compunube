
#!/bin/bash
#Consul configuration for server (frontend Haproxy)
#consul agent with user interface, devolper mode, server(leader)
echo "configurando dependencias haproxy"
#consul agent -ui -dev -server -bootstrap-expect=1 -node=agent-haproxy -bind=192.168.100.6 -http-addr=0.0.0.0:8500 -client=0.0.0.0 -data-dir=/tmp/consul -config-dir=/etc/consul.d -enable-script-checks=true -retry-join "192.168.100.7" -retry-join "192.168.100.8" &
echo "configurando service discovery con consul"

sudo cp --force /vagrant/provision/haproxy/config.json /etc/consul.d/
sudo cp --force /vagrant/provision/haproxy/consul.service /etc/systemd/system/

sudo systemctl enable consul
sudo systemctl daemon-reload
sudo systemctl start consul

echo "configurando haproxy" 
sudo apt update -y && apt upgrade -y
apt-get install net-tools -y
sudo apt install haproxy -y
sudo systemctl enable haproxy
sudo cp --force /vagrant/provision/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg
sudo systemctl restart haproxy
sudo systemctl start haproxy

echo "configurando haproxy-consul" 
sudo cp --force /vagrant/provision/haproxy/web-service.json /etc/consul.d/