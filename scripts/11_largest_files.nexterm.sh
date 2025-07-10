#!/bin/bash
# @name: Install Docker
# @description: Install Docker Engine and Docker Compose on Debian/Ubuntu.
# @icon: 🐳

@NEXTERM:STEP "🧹 Removing old Docker or Podman-related packages..."
for pkg in docker.io docker-doc docker-compose podman-docker containerd runc; do
  sudo apt-get remove -y "$pkg" || true
done


@NEXTERM:STEP "🔄 Updating package index and installing prerequisites..."
sudo apt-get update -y
sudo apt-get install -y ca-certificates curl

@NEXTERM:STEP "🔐 Adding Docker GPG key..."
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

@NEXTERM:STEP "➕ Adding Docker APT repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] \
  https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
  | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

@NEXTERM:STEP "🔄 Updating package list with Docker repo..."
sudo apt-get update -y

@NEXTERM:STEP "📦 Installing Docker Engine and components..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

@NEXTERM:STEP "✅ Docker installed! Please log out and back in to use Docker without sudo."
