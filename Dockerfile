FROM ubuntu

RUN apt-get update
RUN apt-get install -y wget nano htop screen
RUN echo 'deb http://security.ubuntu.com/ubuntu bionic-security main' >> /etc/apt/sources.list
RUN apt update && apt-cache policy libssl1.0-dev
RUN apt-get -y install libssl1.0-dev

COPY bash_aliases /root/.bash_aliases
#COPY startscript.sh /etc/init.d/superscript.sh
#RUN chmod 755 /etc/init.d/superscript.sh
#RUN update-rc.d superscript.sh defaults
