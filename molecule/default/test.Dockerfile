# syntax=docker/dockerfile:1
FROM geerlingguy/docker-debian11-ansible:latest
# https://ansible.jeffgeerling.com/

# Install GIT
RUN <<EOT
#!/bin/bash
apt-get update -y
apt-get install -y git

rm -rf /var/lib/apt/lists/*
EOT

# Install docker cli + compose plugin
RUN <<EOT
apt-get update -y
apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update -y
apt-get install -y \
  docker-ce-cli \
  docker-compose-plugin

rm -rf /var/lib/apt/lists/*
EOT