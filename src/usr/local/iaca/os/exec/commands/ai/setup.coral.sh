#!/bin/bash

source "../../assets/utils.sh" || { echo "Error : Unable to source 'utils.sh'."; exit 1; }
source "vars" || { echo "Error : Unable to source 'vars'."; exit 2; }

TMP_DIR=

# -----------------------------------------------------------------------------------------------

function init_tmp() {
    TMP_DIR=$(mktemp -d)
}

function dispose_tmp() {
    rm -dr "$TMP_DIR"
}

function save_in_persistent() {
    os commit sync -y
}

function check_system_arch() {
    local arch=$(uname -a | awk '{printf $10}')

    if [ "$arch" != "aarch64" ]; then
        error "Bad system architecture, require aarch64 (actual = $arch)"
        exit 3
    fi
}

function download_gasket() {
    echo "Downloading gasket-dkms.."
    wget -P "$TMP_DIR" "${CORAL_REPO_URL}/${GASKET_PACKAGE}" > /dev/null
}

function install_gasket() {
    echo "Installing gasket-dkms.."
    apt-get install -y "${TMP_DIR}/${GASKET_PACKAGE}" > /dev/null
}

function apt_update() {
    apt-get update > /dev/null
}

# -----------------------------------------------------------------------------------------------

check_system_arch
init_tmp
download_gasket || { error "Unable to download gasket-dkms deb file."; dispose_tmp; exit 4; }
apt_update || { error "Unable to update aptitude."; dispose_tmp; exit 5; }
install_gasket || { error "Unable to install gasket-dkms deb file."; dispose_tmp; exit 6; }
dispose_tmp
save_in_persistent || { error "Unable to save coral installation in persistent file system."; exit 7; }

success "✅ Coral AI support installed."