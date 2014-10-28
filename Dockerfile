FROM ubuntu:14.04
MAINTAINER Renzo Meister <rm@jamotion.ch>

# Update Package index
RUN apt-get update 

# Install needed packages
RUN apt-get install -y --force-yes --no-install-recommends curl
RUN curl -L http://install.shinken-monitoring.org | /bin/bash

RUN apt-get install -y --force-yes --no-install-recommends supervisor
ADD supervisor.conf /etc/supervisor/conf.d/supervisor.conf

EXPOSE 7767
CMD ["/usr/bin/supervisord"]
