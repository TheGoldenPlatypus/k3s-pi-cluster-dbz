#!/bin/bash

set -x

function copy_k3s_config() {

    local src=$1
    local dest=$2

    cp "$src" "$dest"
    chmod 0644 "$dest"
}

function install_k3s_master() {

    curl -sfL https://get.k3s.io | sh -s - server

    if [ $? -ne 0 ]; then
        echo "K3s master installation failed"
        exit 1
    fi
}

function install_k3s_agent() {

    curl -sfL https://get.k3s.io | sh -s - agent

    if [[ $? -ne 0 ]]; then
        echo "K3s agent setup failed."
        exit 1
    fi
}

function restart_k3s_service() {
   
    systemctl restart k3s
}

function get_k3s_server_token() {
    cat /var/lib/rancher/k3s/server/token
}

function setup_kubeconfig() {

    local dest=$1

    mkdir -p "$dest"
    cp /etc/rancher/k3s/k3s.yaml "$dest/config"
    chmod 0644 "$dest/config"
}

function update_boot_params() {

    sed -i '/console=tty1/s/$/ cgroup_memory=1 cgroup_enable=memory/' /boot/firmware/cmdline.txt
}

function restart_system() {

    shutdown -r now
}

"$@"
