FROM python:3-slim

# Install required packages
RUN apt-get update \
  && mkdir -p /usr/share/man/man1 \
  && apt-get install -y \
    apt ca-certificates curl git locales openssh-client sudo unzip sshpass

# Add User
RUN groupadd --gid 997 jenkins \
  && useradd --uid 997 --gid jenkins --shell /bin/bash --create-home jenkins \
  && echo 'jenkins ALL=NOPASSWD: ALL' >> /etc/sudoers.d/50-jenkins \
  && echo 'Defaults    env_keep += "DEBIAN_FRONTEND"' >> /etc/sudoers.d/env_keep

# Install Ansible 
RUN sudo -u jenkins pip3 install --user ansible boto boto3 yq

USER jenkins
ENV PATH /home/jenkins/.local/bin:/home/jenkins/bin:${PATH}

CMD ["/bin/sh"]
