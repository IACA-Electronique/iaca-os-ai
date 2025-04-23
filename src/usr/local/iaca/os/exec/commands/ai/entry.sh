#!/bin/bash

source "assets/utils.sh" || { echo "Error : Unable to source 'utils.sh'."; exit 1; }
cd commands/ai || { error "Unable to set up execution environment."; exit 2; }
source "vars" || { echo "Error : Unable to source 'vars'."; exit 3; }

# ---------------------------------------------------------------------------------------------------------------

VERSION=$(cat version)

# ---------------------------------------------------------------------------------------------------------------

function check_system() {
    if ! ./check.sh; then
        error "Incompatible system."
        exit 10
    fi
}

function show_help {
    echo -e "Version : $VERSION\n"
    cat help
    echo -e "\n"
}


function request_confirmation() {
        echo -e "\033[33m$1\033[0m"
        read -p "Continue? [y/N]"
        if [[ ! $REPLY =~ ^[Yy]$ ]]
        then
                echo "Aborted"
                exit 2
        fi
}

function install_coral() {
    if ! . setup.coral.sh; then
       error "Unable to setup coral AI support."
       exit 20
    fi
}

# ---------------------------------------------------------------------------------------------------------------

check_system

case "$1" in
    help|-h|--help)
        show_help
        ;;
    setup)
        if [ "$2" == "coral" ]; then
            echo "📖 PLEASE READ DOC BEFORE DO THIS : https://gitlab.iaca-electronique.com/iaca-os/iaca-os-ai"
            request_confirmation "⚠️Persistent system will be updated. Don't unplug power and don't shutdown system during the process.\n⭕️ SYSTEM WILL REBOOT AT THE END !"
            install_coral
            reboot
        else
            error "AI support type arg missing."
            show_help
        fi
        ;;
    *)
        error "Bad usage."
        echo -e "\n"
        show_help
        ;;
esac