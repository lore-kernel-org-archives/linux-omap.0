From: "kanagesh radhakrishnan" <rkanagesh@gmail.com>
Subject: Problems with USB Gadget on the OMAP3EVM
Date: Tue, 5 Aug 2008 16:47:02 +0530
Message-ID: <ece1079f0808050417o49392d42if4b730b7d700bdab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f29.google.com ([209.85.217.29]:59850 "EHLO
	mail-gx0-f29.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234AbYHELRE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Aug 2008 07:17:04 -0400
Received: by gxk10 with SMTP id 10so3845106gxk.13
        for <linux-omap@vger.kernel.org>; Tue, 05 Aug 2008 04:17:02 -0700 (PDT)
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Hello,

I am trying to get USB gadget (RNDIS) working with an OMAP3EVM and a
Linux Host system.  I am looking for help since I have problems
setting up the USB network between the target and host systems.

Kernel Configuration
-----------------------------
The kernel I am using is Linux-2.6.22.18.  Its the release version
that comes with SDK_0.9.8 for the OMAP3EVM.  The default kernel
configuration (omap3evm_defconfig) does not enable USB gadget
functionality so I have made changes as suggested in the SDK_0.9.8
User Guide to the kernel configuration.  A summary is as follows:

# USB devices

-CONFIG_SND_USB_AUDIO=y

# USB Input Devices
-CONFIG_USB_HID=y

# OMAP 343x high speed USB support
-CONFIG_USB_MUSB_HOST=y
+CONFIG_USB_MUSB_PERIPHERAL=y
-CONFIG_USB_MUSB_HDRC_HCD=y
+CONFIG_USB_GADGET_MUSB_HDRC=y

# USB Device Class drivers
-CONFIG_USB_ACM=y
-CONFIG_USB_STORAGE=y
-CONFIG_USB_MON=y

# USB port drivers
-CONFIG_USB_TEST=y

# USB Gadget Support
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_SELECTED=y
+CONFIG_USB_GADGET_DUALSPEED=y
+CONFIG_USB_ETH=y
+CONFIG_USB_ETH_RNDIS=y

Running the Test
-------------------------
On the OMAP3EVM Target
#######################
On successful boot with this kernel on the target board, after
plugging in the USB cable, the following messages appear on the
console:

musb_stage2_irq 863: SUSPEND (b_idle) devctl 99 power e0
musb_stage0_irq 722: BUS RESET
musb_stage0_irq 722: BUS RESET
musb_stage0_irq 722: BUS RESET
musb_stage0_irq 722: BUS RESET
musb_stage0_irq 722: BUS RESET
musb_stage0_irq 722: BUS RESET
musb_stage0_irq 722: BUS RESET
musb_stage0_irq 722: BUS RESET
usb0: high speed config #2: 100 mA, Ethernet Gadget, using RNDIS
musb_stage0_irq 722: BUS RESET
musb_stage0_irq 722: BUS RESET
musb_stage2_irq 863: SUSPEND (b_peripheral) devctl 99 power f0

I then setup an IP address for the usb0 interface with the following command:

[root@OMAP3EVM /]# /sbin/ifconfig usb0 192.168.1.1 up netmask 255.255.255.0

On the Linux Host machine
#######################

On insertion of the USB cable, 'dmesg' shows the following messages:

usb 1-2: new high speed USB device using address 3
usb 1-2: configuration #1 chosen from 2 choices
usb 1-2: can't set config #1, error -71

The Problem
-------------------
On an attempt to setup an IP address for the usb0 interface, I get the
following error:

usb0: unknown interface: No such device
SIOCSIFADDR: No such device
usb0: unknown interface: No such device
SIOCSIFNETMASK: No such device
SIOCGIFADDR: No such device
SIOCSIFBROADCAST: No such device

The Test Setup
----------------------

Host
####
   Linux machine running Fedora Core 5.
   Manually loaded the module usbnet.ko.

Target
#####
   OMAP3EVM running OMAP35x_SDK_0.9.8 firmware: x-load, u-boot and
kernel (linux-2.6.22.18)
   Dip switches (SW4) set to boot from NAND flash (01010000)


Although my end objective is to test the USB functionality with
TWL4030 USB transceiver, I wanted to verify if USB functions as
expected through ISP1504 transceiver on my board with the SDK_0.9.8.
Has anyone tested the USB Gadget setup on the OMAP3EVM boards?

Thanks in advance,
Kanagesh.
