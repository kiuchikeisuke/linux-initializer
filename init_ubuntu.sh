#!/bin/sh

if [ $(whoami) != "root" ]; then
echo "You must be root to do!" 2>&1
    exit 1
fi

#
#1. update/upgrade
#
apt-get update
apt-get upgrade -y
echo "update/upgrade finished"

#
#2. install tools
#
apt-get install -y curl git-core vim wget open-ssh xsel
echo "install tools finished"

#
#3. install java
#
add-apt-repository -y ppa:webupd8team/java
apt-get update
DEBIAN_FRONTEND=noninteractive apt-get install -y oracle-java7-installer
echo "install java finished"

#
#4. install scala
#
SCALA_VER=scala-2.10.3
wget http://www.scala-lang.org/files/archive/${SCALA_VER}.tgz
tar xvzf ${SCALA_VER}.tgz
mv ${SCALA_VER} /usr/local/lib/
ln -s /usr/local/lib/${SCALA_VER} /usr/local/scala 
echo "# scala" >> ~/.profile
echo "export SCALA_HOME=/usr/local/scala" >> ~/.profile
echo "export PATH=\$PATH:\$SCALA_HOME/bin" >> ~/.profile
echo "install scala finished"

#
#5. install Emacs
#
add-apt-repository -y ppa:cassou/emacs
apt-get update
apt-get install -y emacs24 emacs24-el
echo "install Emacs finished"

echo "init finished!!"
