#!/bin/sh

#
#1. update/upgrade
#
sudo apt-get update
sudo apt-get upgrade -y
echo "update/upgrade finished"

#
#2. install tools
#
sudo apt-get install -y curl git-core vim wget open-ssh xsel
echo "install tools finished"

#
#3. install java
#
sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get update
DEBIAN_FRONTEND=noninteractive sudo apt-get install -y oracle-java7-installer
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
sudo add-apt-repository -y ppa:cassou/emacs
sudo apt-get update
sudo apt-get install -y emacs24 emacs24-el
echo "install Emacs finished"

#
#6. install sbt
#
SBT_VER=0.13.0
wget http://repo.typesafe.com/typesafe/ivy-releases/org.scala-sbt/sbt-launch/${SBT_VER}/sbt-launch.jar
if [ ! -e ~/bin ]; then
mkdir ~/bin
echo "export PATH=\$PATH:~/bin" >> ~/.profile
fi
mv -u sbt-launch.jar ~/bin/
if [ ! -e ~/bin/sbt ]; then
echo "SBT_OPTS=\"-Xms512M -Xmx1536M -Xss1M -XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=256M\"" >> ~/bin/sbt
echo "java \$SBT_OPTS -jar \`dirname \$0\`/sbt-launch.jar \"\$@\"" >> ~/bin/sbt
chmod u+x ~/bin/sbt
fi
echo "install sbt finished"

#
#7. install conscript
#
if [ ! -e ~/bin ]; then
mkdir ~/bin
echo "export PATH=\$PATH:~/bin" >> ~/.profile
fi
curl https://raw.github.com/n8han/conscript/master/setup.sh | sh
echo "install conscript finished"

#
#8. install giter8
#
cs n8han/giter8
echo "install giter8 finished"

echo "init finished!!"
