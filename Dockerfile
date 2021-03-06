# Dockerfile
# https://github.com/fcwu/docker-ubuntu-vnc-desktop

# FROM dorowu/ubuntu-desktop-lxde-vnc:bionic-lxqt
FROM dorowu/ubuntu-desktop-lxde-vnc

#ENV DEBIAN_FRONTEND noninteractive

COPY init.sh /usr/local/bin/

RUN sudo sed -i 's|http://tw.|http://de.|g' /etc/apt/sources.list
RUN sudo apt update
RUN sudo apt -y install dirmngr

# for clion phpstorm, but they don't work in docker
#RUN sudo apt-key adv --fetch-keys https://s3.eu-central-1.amazonaws.com/jetbrains-ppa/0xA6E8698A.pub.asc
#RUN echo "deb http://jetbrains-ppa.s3-website.eu-central-1.amazonaws.com bionic main" | sudo tee /etc/apt/sources.list.d/jetbrains-ppa.list > /dev/null

# add Signal repository
RUN sudo apt-key adv --fetch-keys https://updates.signal.org/desktop/apt/keys.asc
RUN echo "deb https://updates.signal.org/desktop/apt xenial main" | sudo tee /etc/apt/sources.list.d/signal.list > /dev/null

RUN sudo add-apt-repository -y ppa:pbek/qownnotes
RUN sudo add-apt-repository -y ppa:fish-shell/release-3
RUN sudo add-apt-repository -y ppa:nextcloud-devs/client
RUN sudo add-apt-repository -y ppa:phoerious/keepassxc
RUN sudo add-apt-repository -y ppa:peek-developers/stable

RUN sudo apt -y upgrade
RUN sudo apt -y install qownnotes fish nextcloud-client less mc htop git qtcreator qt5-default g++ qttools5-dev build-essential qtdeclarative5-dev libqt5svg5-dev qttools5-dev-tools libqt5xmlpatterns5-dev libqt5websockets5-dev libqt5x11extras5-dev keepassxc vim telnet nmap inetutils-ping peek xscreensaver synaptic signal-desktop netcat

# install Rambox
RUN cd /tmp && wget https://github.com/ramboxapp/community-edition/releases/download/0.7.7/Rambox-0.7.7-linux-amd64.deb && sudo dpkg -i Rambox-0.7.7-linux-amd64.deb || sudo apt install -fy
# disable Chromium sandbox so it will Electron will run in the container
RUN sudo sed -i 's/rambox %U/rambox --no-sandbox %U/g' /usr/share/applications/rambox.desktop

# install smartgit (eugensan ppa has only version 19 which cannot be used any more)
RUN cd /tmp && wget https://www.syntevo.com/downloads/smartgit/smartgit-20_2_2.deb && sudo dpkg -i smartgit-20_2_2.deb || sudo apt install -fy

# install GitHub Hub
RUN cd /usr && curl -fsSL https://github.com/github/hub/raw/master/script/get | sudo bash -s 2.14.2

#RUN sudo snap install clion

#RUN sudo useradd -s /usr/bin/fish omega
#RUN sudo chsh -s /usr/bin/fish ubuntu

# Run it
#EXPOSE 22
#CMD ["/usr/sbin/sshd", "-D"]

COPY panel.conf /home/omega/.config/lxqt

#CMD ["/usr/local/bin/init.sh"]

