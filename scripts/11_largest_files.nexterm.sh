#!/bin/bash
#title: Docker
#description: Install Docker
#icon: 📁

@NEXTERM:STEP "🛠️ Updating package index..."
sudo apt-get update -y

@NEXTERM:STEP "📦 Installing dependencies..."
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

@NEXTERM:STEP "🔑 Adding Docker's official GPG key..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release && echo "$ID")/gpg \
  | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

@NEXTERM:STEP "➕ Adding Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/$(. /etc/os-release && echo "$ID") \
  $(lsb_release -cs) stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

@NEXTERM:STEP "🔄 Updating package index with Docker repo..."
sudo apt-get update -y

@NEXTERM:STEP "🐳 Installing Docker Engine and CLI..."
sudo apt-get install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

@NEXTERM:STEP "🚀 Enabling and starting Docker service..."
sudo systemctl enable docker
sudo systemctl start docker

@NEXTERM:STEP "👤 Adding user $(whoami) to docker group..."
sudo usermod -aG docker $(whoami)

@NEXTERM:TABLE "Docker Components Installed" "Component,Status" "\"docker-ce,✅ Installed\"\n\"docker-compose-plugin,✅ Installed\"\n\"Service,✅ Running\""

@NEXTERM:STEP "✅ Docker installed! Please log out and back in to use docker without sudo."
