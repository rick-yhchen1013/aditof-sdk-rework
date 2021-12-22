# Analog Devices's i.MX8MP CMOS TOF build scripts

## Introduction
Main intention of this scripts set is to build environment for i.MX8MP based TOF product evaluation.

The build script provides ready to use images that can be deployed on microSD or eMMC.

The buildsystem is capable to create two different targets:
		1. Buildroot based initramfs (Intented for production)
		2. Ubuntu based ROOTFS (Intented for development)

Some BASH environment variables supported to change the building behavior.
User can specify local mirror location to speed up the fetch of packages and git sources.

* DISTRO_MIRROR is used to specify the mirror location of ports.ubuntu.com.
* NXP_GIT_LOCATION is used to specify the root location of git repositories for NXP firmware, kernel, bootloader and tools.
* TOF_GIT_LOCATION is used to specify the location of git repository of TOF SDK.

## Build with host tools
Simply running ./runme.sh, it will check for required tools, clone and build images and place results in images/ directory.
The selection of target is performed using "BUILD_TYPE" variable from runme.sh script. Valid options are: ubuntu | buildroot

## Deploying
For SD card bootable images, plug in a microSD and run the following, where sdX is the location of the SD card got mounted on your machine -

`sudo dd if=images/microsd-<hash>.img of=/dev/sdX`

Take care S3 boot switches to be configured accordingly.

## SD card creator
To write a image into a sdcard, run

`create_sd.sh images/microsd-xxxxxxx.img /dev/sdX`

The package hdparm is required to notify the partition change to the kernel. Please install it with your package management system.

## Switch between host mode and embedded mode(Ubuntu based OS)
The host mode is supported by default, the i.MX8MP(SolidRun) and the TOF camera will be treat as a USB device and connect to a PC running Windows.
Run the tof-viewer on Windows to access the TOF camera.

The basic embedded mode is implemented, too.
To switch between host and  embedded mode, install preferred wayland based desktop first:
`sudo apt-get install libwayland-bin wayland-protocols xwayland gdm3 gnome-core`

And run the following command to change to desired mode.

`sudo -s`

Host mode:
`adi_switch_mode.sh host`
Embedded mode:
`adi_switch_mode.sh embedded`
System reboot is required.

TODO:
  - GPU library integration. (libd*_viv.so and rebuild some packages to link the GPU libraries)
    Note: The gtkperf test takes ~12 seconds on non-GPU enabled SolidRun board and ~58 seconds on GPU enabled i.mx8mpevk board.
  - ML core support.
  - Gstreamer support.
  - Demo program for embedded mode
  - Tiny desktop environment and desktop manager to replace gnome and gdm3
