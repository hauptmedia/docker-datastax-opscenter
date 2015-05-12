FROM		hauptmedia/java:oracle-java7
MAINTAINER	Julian Haupt <julian.haupt@hauptmedia.de>

ENV		DEBIAN_FRONTEND noninteractive

# install required packges
RUN	apt-get update -qq && \
	apt-get install -y python2.7 openssl python-openssl curl && \
	apt-get clean autoclean && \
	apt-get autoremove --yes && \
	rm -rf /var/lib/{apt,dpkg,cache,log}/

ENV	OPSCENTER_HOME /opt/opscenter
ENV	OPSCENTER_VERSION 5.1.1
ENV	OPSCENTER_DOWNLOAD_URL http://downloads.datastax.com/community/opscenter-${OPSCENTER_VERSION}.tar.gz

RUN		mkdir -p ${OPSCENTER_HOME} && \
		curl -L --silent ${OPSCENTER_DOWNLOAD_URL} | tar -xz --strip=1 -C ${OPSCENTER_HOME}



