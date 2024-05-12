# OSMC Remote Support for Linux

## Overview

This is a small script that adjusts the button layout for any OSMC remotes connected to your system. This adjustment ensures all buttons on the remote work, and are consistent across all models of OSMC remotes released to date.

This adjustment is ideal if you are using the remote controller with Kodi on a non-OSMC system. Kodi has device specific support for OSMC remotes (including long press) via a custom keymap that auto-loads when it sees an OSMC remote. Running this script on Linux distributions will ensure Kodi is receiving the intended button presses. 

> One should not run this script on OSMC or LibreELEC installations as they have already been patched to fully support OSMC remotes.

## Installation

Currently this script has been tested with Ubuntu and Debian based systems. 

To install the keymap, please run the following commands in a Terminal session:

```
wget https://download.osmc.tv/linux_remote.sh
```

You can then check the script contents to verify it is not malicious and you can also check that you received the expected version as follows:

```
10be4262a61f90d0632905b96da477e1cfe28cb2  linux_remote.sh
```

We will update this checksum on this page whenever we update this script.

Once you are satisfied, you can now run the script with: 

```
sudo bash linux_remote.sh
```

If your system is compatible, you can now follow the on-screen instructions in the Terminal to complete the installation. 

> If you run the script and you receive a message stating that your operating system is not supported, please start a post on the [OSMC Forums](https://discourse.osmc.tv) and we will be happy to help add support for your distribution of choice. 
