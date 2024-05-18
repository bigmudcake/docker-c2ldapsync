# bigmudcake v1.00 - Dockerfile to setup container image

FROM phusion/baseimage:noble-1.0.0

# Get phusion/baseimage version tag from 
##  https://hub.docker.com/r/phusion/baseimage/tags/
##  https://github.com/phusion/baseimage-docker/blob/master/Changelog.md

# Setup Installation folder
RUN mkdir -p /install 

# Install and update packages. Clean up APT when done.
RUN apt-get update && \
    apt-get upgrade -y -o Dpkg::Options::="--force-confold" && \
#   apt-get install -y --no-install-recommends gettext-base iproute2 net-tools && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install startup script
RUN mkdir -p /etc/my_init.d
ADD init_startup.sh /etc/my_init.d/
RUN chmod 0755 /etc/my_init.d/init_startup.sh

# Set to 1 for extra log messages
ENV LDAP_DEBUG "0"

# Interface the environment
VOLUME /install
# EXPOSE 80 443
# USER localuser

# Baseimage init process
ENTRYPOINT ["/sbin/my_init"]
