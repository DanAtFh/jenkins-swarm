FROM jenkins/jenkins:lts

COPY plugins.txt /usr/share/jenkins/plugins.txt
RUN /usr/local/bin/plugins.sh /usr/share/jenkins/plugins.txt

# install docker client
ARG DOCKER_CLIENT=docker-18.09.1.tgz

USER root

RUN cd /tmp/ \
&& curl -sSL -O https://download.docker.com/linux/static/stable/x86_64/${DOCKER_CLIENT} \
&& tar zxf ${DOCKER_CLIENT} \
# && mkdir -p /usr/local/bin \
&& mv /tmp/docker/docker /usr/bin \
&& chmod +x /usr/bin/docker \
&& rm -rf /tmp/*

# remove executors in master
# COPY master-executors.groovy /usr/share/jenkins/ref/init.groovy.d/