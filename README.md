# k3s-pi-cluster-dbz

This project provides an Ansible playbook to set up a Raspberry Pi Kubernetes cluster using k3s, specifically designed to run the Dragon Ball Z game using EmulatorJS.

## Prerequisites

### Setting Up Raspberry Pis

1. Use Raspberry Pi Imager to prepare your microSD cards.
2. Configure parameters: choose Raspberry Pi Zero 2 W, select Raspberry Pi OS Lite 64-bit, and set up network settings (enable SSH and enter network credentials).
3. Connect to the Raspberry Pi devices via SSH: `ssh pi@pi1.local`, `ssh pi@pi2.local`, `ssh pi@pi3.local` to make sure connectivity 

### Preparing the Virtual Machine

1. Create an Ubuntu VM using Hyper-V. 
2. In Hyper-V Manager, go to Virtual Switch Manager and create a new External Network switch. Connect it to your physical network adapter. 
3. Right-click the VM, select Settings, go to Network Adapter, and change the connection to the newly created external switch. 
4. Find the VM's IP address with `ip addr show`. 
5. Check the firewall status with `sudo ufw status`. If the firewall is active, allow SSH access: `sudo ufw allow ssh && sudo ufw reload`.
6. For ease of access, use SSH to connect to the VM. If SSH is disabled, start it with: `sudo systemctl start ssh`. Enable SSH to start on boot using: `sudo systemctl enable ssh`.

### Provisioning the Ansible Host

1. Update and upgrade the system: `sudo apt update && sudo apt upgrade -y` 
2. Install essential packages such as curl, git, and Python 3 pip: `sudo apt install curl git python3-pip -y`
3. Install Ansible: `sudo apt-add-repository --yes --update ppa:ansible/ansible && sudo apt install ansible -y`
4. Install Docker by following the official Docker installation guide: [https://docs.docker.com/engine/install/ubuntu/](https://docs.docker.com/engine/install/ubuntu/).

## Installation

1. Customize the `hosts.yaml` file to point to your Raspberry Pi devices. 
2. Run the Ansible playbook using: `./run.sh`

## Kubernetes Configuration

Once the Ansible playbook completes successfully, SSH into the VM and follow these steps:

1. Verify that all nodes are registered correctly: `kubectl get nodes -o wide` 
2. Navigate to the EmulatorJS deployment folder: `cd k3s_emulatorjs`
 3. Deploy the EmulatorJS application: `kubectl apply -f .`

## DBZ Game

1. Download the fileset from the main screen. 
2. Load the game file : "2 Games in 1! Dragon Ball Z - Buu's Fury + Dragon Ball GT - Transformation.zip". 
3. Enjoy playing the game!
