FROM ubuntu:16.04
MAINTAINER Learning Bird Development <lbdev@learningbird.com>

##########################################################################################
# Simplify the FROM 8-jdk that uses jessie to use ubuntu and just install the default jre
# because jessie is so old that jq is outdated...
##########################################################################################
RUN apt-get update && apt-get install -y --no-install-recommends bzip2 unzip xz-utils default-jre curl git

##########################################
# This is the jenkinsci:ssh-slave portion
##########################################
ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000
ARG JENKINS_AGENT_HOME=/home/${user}

ENV JENKINS_AGENT_HOME ${JENKINS_AGENT_HOME}

RUN groupadd -g ${gid} ${group} \
    && useradd -d "${JENKINS_AGENT_HOME}" -u "${uid}" -g "${gid}" -m -s /bin/bash "${user}"

# setup SSH server
RUN apt-get update \
    && apt-get install --no-install-recommends -y openssh-server \
    && apt-get clean \
    && sed -i 's/#PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config \
    && sed -i 's/#RSAAuthentication.*/RSAAuthentication yes/' /etc/ssh/sshd_config \
    && sed -i 's/#PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config \
    && sed -i 's/#SyslogFacility.*/SyslogFacility AUTH/' /etc/ssh/sshd_config \
    && sed -i 's/#LogLevel.*/LogLevel INFO/' /etc/ssh/sshd_config \
    && mkdir /var/run/sshd

VOLUME "${JENKINS_AGENT_HOME}" "/tmp" "/run" "/var/run"
WORKDIR "${JENKINS_AGENT_HOME}"

COPY setup-sshd /usr/local/bin/setup-sshd
RUN chmod +x /usr/local/bin/setup-sshd

EXPOSE 22

ENTRYPOINT ["/usr/local/bin/setup-sshd"]

##########################################
# This is our custom portion
##########################################

# Install aws
RUN apt update && apt install -y python3 python-pip jq gawk sshpass nano vim ruby
RUN pip install awscli --upgrade