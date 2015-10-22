FROM		hauptmedia/java:oracle-java7
MAINTAINER	Julian Haupt <julian.haupt@hauptmedia.de>

ENV		DEBIAN_FRONTEND noninteractive

# install required packges
RUN	apt-get update -qq && \
	apt-get install -y python2.7 openssl python-openssl curl ca-certificates && \
	apt-get clean autoclean && \
	apt-get autoremove --yes && \
	rm -rf /var/lib/{apt,dpkg,cache,log}/

ENV	OPSCENTER_HOME /opt/opscenter
ENV	OPSCENTER_VERSION 5.2.1
ENV	OPSCENTER_DOWNLOAD_URL http://downloads.datastax.com/community/opscenter-${OPSCENTER_VERSION}.tar.gz

RUN	mkdir -p ${OPSCENTER_HOME} && \
	curl -L --silent ${OPSCENTER_DOWNLOAD_URL} | tar -xz --strip=1 -C ${OPSCENTER_HOME}

WORKDIR ${OPSCENTER_HOME}

COPY opscenterd.conf /opt/opscenter/conf/opscenterd.conf

# OpsCenter ports:
# 8888   OpsCenter website
# 50031  OpsCenter HTTP proxy for Job Tracker (enterprise only)
# 61620  OpsCenter Monitoring Port 

EXPOSE	8888 50031 61619 61620

CMD	["bin/opscenter", "-f"]


