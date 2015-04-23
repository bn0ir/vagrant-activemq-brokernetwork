#get variables
source /etc/environment
export MYPASS=`python /vagrant/swarm/getpass.py 16`
export CLIENTPASS=`python /vagrant/swarm/getpass.py 16`

#add java repos
add-apt-repository ppa:webupd8team/java -y

#install docker
curl -sSL https://get.docker.com/ubuntu/ | sudo sh

#auto accept java license
echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections

#add $DOCKER_OPTS
echo 'DOCKER_OPTS="-H '$MYIP':2375 -H unix:///var/run/docker.sock"' >> /etc/default/docker
service docker restart

#install java
apt-get install -y oracle-java8-installer

#get docker-activemq image
docker pull bn0ir/docker-activemq

mkdir -p /data/broker/conf

#generate keys for activemq
keytool -genkey -alias broker -keyalg RSA -keystore /data/broker/conf/broker.ks -storepass $MYPASS -keypass $MYPASS -dname "CN=activemq, OU=IT, O=Company, L=City, S=Region, C=RU"
keytool -export -alias broker -keystore /data/broker/conf/broker.ks -file /data/broker/conf/broker_cert -storepass $MYPASS
keytool -genkey -alias client -keyalg RSA -keystore /data/broker/conf/client.ks -storepass $CLIENTPASS -keypass $CLIENTPASS -dname "CN=activemq-client, OU=IT, O=Company, L=City, S=Region, C=RU"
keytool -import -alias broker -keystore /data/broker/conf/client.ts -file /data/broker/conf/broker_cert -storepass $CLIENTPASS -noprompt
#generate configs for activemq
rsync -av /vagrant/swarm/activemq/ /data/broker/conf/
sed -i -e 's/{{ brokerpass }}/'$MYPASS'/g' /data/broker/conf/activemq.xml
sed -i -e 's/{{ clientpass }}/'$CLIENTPASS'/g' /data/broker/conf/activemq.xml
sed -i -e 's/{{ remoteip }}/'$ANIP'/g' /data/broker/conf/activemq.xml

docker run -d -v /data/broker:/data/broker -p $MYIP:61616:61616 -p $MYIP:61612:61612 -p $MYIP:8161:8161 -e 'XMS=256M' -e 'XMX=256M' --name activemq bn0ir/docker-activemq
docker stop activemq
