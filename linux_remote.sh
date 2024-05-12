#!/bin/bash

# Sam Nazarko
# <email@samnazarko.co.uk>

VERSION="1.0.0 - 12/05/2024"

DB_FILE="/etc/udev/hwdb.d/osmcrf.hwdb"

info_notice() {
	echo -e "NOTICE: ${1}"
}

info_warning() {
        echo -e "WARNING: ${1}"
}

info_error() {
        echo -e "ERROR: ${1}"
}

exitnow() {
	info_error "${1}"
	exit 1
}

trigger_update() {
    info_notice "Updating system"
    systemd-hwdb update
    if [ $? != 0 ]
    then
        info_error "systemd-hwdb update failed"
    fi
    udevadm trigger
    if [ $? != 0 ]
    then
        info_error "udevadm trigger update failed"
    fi
}

install_keymap()
{
cat << EOF > $DB_FILE
evdev:input:b0003v2017p1689*
 KEYBOARD_KEY_c0226=x
 KEYBOARD_KEY_c00cd=p
 KEYBOARD_KEY_7002e=volumeup
 KEYBOARD_KEY_7002d=volumedown

evdev:input:b0003v2017p1690*
 KEYBOARD_KEY_c0226=x
 KEYBOARD_KEY_c00cd=p
 KEYBOARD_KEY_7002e=volumeup
 KEYBOARD_KEY_7002d=volumedown

evdev:input:b0003v2017p1688*
 KEYBOARD_KEY_7004a=esc
 KEYBOARD_KEY_c0060=i
 KEYBOARD_KEY_10084=c
 KEYBOARD_KEY_c0226=x
 KEYBOARD_KEY_c00cd=p
 KEYBOARD_KEY_7002e=volumeup
 KEYBOARD_KEY_7002d=volumedown

evdev:input:b0003v2252p1037*
 KEYBOARD_KEY_7004a=esc
 KEYBOARD_KEY_c0060=i
 KEYBOARD_KEY_10084=c
 KEYBOARD_KEY_c0226=x
 KEYBOARD_KEY_c00cd=p
 KEYBOARD_KEY_c00b3=f
 KEYBOARD_KEY_c00b4=r
EOF
    trigger_update
}

remove_keymap()
{
    info_notice "Removing keymap"
    rm -f $DB_FILE
    trigger_update
    info_notice "You may need to reboot your system to remove the effects of the keymap previously installed"
}

menu_existing() {
    info_notice "\n\nExisting installation detected"
    info_notice "1. Update installation with latest keymap"
    info_notice "2. Remove installation from this system"
    info_notice "3. Exit program"
    read n
    case $n in
    1) install_keymap;;
    2) remove_keymap;;
    3) exit 0;;
    *) echo "Invalid choice selected"; menu_existing;;
    esac
}

main() {
clear
info_notice "OSMC remote support for Linux"
info_notice "$VERSION"

# Check privileges

if [ "$EUID" -ne 0 ]; then exitnow "Please run this script as root"; fi

# Get dependencies

info_notice "Checking that you are running a compatible platform"

if [ ! -f "/etc/os-release" ]
then
    info_error "Cannot determine operating system"
fi

grep -qi debian /etc/os-release
if [ "$?" -eq 0 ] # Add other distros later
then
    info_notice "Compatible operating system detected"
    info_notice "Checking for existing installation"
    if [ -f "$DB_FILE" ]
    then
        menu_existing
    else
        install_keymap
    fi
else
    info_error "Unsupported operating system. For support please post at https://discourse.osmc.tv"
fi

}

main # Call now so we don't run anything truncated
