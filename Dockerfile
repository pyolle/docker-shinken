FROM ubuntu:14.04
MAINTAINER Renzo Meister <rm@jamotion.ch>

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list

# Update Package index
RUN apt-get update 

# Install needed packages
RUN apt-get install -y --force-yes --no-install-recommends curl python-pymongo wget gawk build-essential libperl-dev \
                    python-setuptools libsqlite3-dev python-dev pyro sqlite3 nmap unzip libmysqlclient-dev python-ldap \ 
					libevent-dev python-paste python-pycurl libsnmp-python snmpd supervisor mongodb-org

RUN easy_install paramiko 
RUN easy_install netifaces 
RUN easy_install simplejson 
RUN easy_install MySQL_python 
RUN easy_install kombu
					
RUN curl -L http://install.shinken-monitoring.org | /bin/bash
ADD supervisor.conf /etc/supervisor/conf.d/supervisor.conf
ADD shinken-specific.cfg /usr/local/shinken/etc/shinken-specific.cfg

EXPOSE 7767
CMD ["/usr/bin/supervisord"]
