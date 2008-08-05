From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: Problems with USB Gadget on the OMAP3EVM
Date: Tue, 5 Aug 2008 17:07:59 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593013C9AEDA9@dbde02.ent.ti.com>
References: <ece1079f0808050417o49392d42if4b730b7d700bdab@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44932 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755159AbYHELtc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Aug 2008 07:49:32 -0400
In-Reply-To: <ece1079f0808050417o49392d42if4b730b7d700bdab@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kanagesh radhakrishnan <rkanagesh@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Kanagesh,

This list may not be aware of the SDK_0.9.8 releases you mention.
I will forward the request.

You can look at the section "Reporting Issues" in the release notes to get the mail-id for support on the SDK.

~sanjeev

-----Original Message-----
From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of kanagesh radhakrishnan
Sent: Tuesday, August 05, 2008 4:47 PM
To: linux-omap@vger.kernel.org
Subject: Problems with USB Gadget on the OMAP3EVM

Hello,

I am trying to get USB gadget (RNDIS) working with an OMAP3EVM and a Linux Host system.  I am looking for help since I have problems setting up the USB network between the target and host systems.

Kernel Configuration
-----------------------------
The kernel I am using is Linux-2.6.22.18.  Its the release version that comes with SDK_0.9.8 for the OMAP3EVM.  The default kernel configuration (omap3evm_defconfig) does not enable USB gadget functionality so I have made changes as suggested in the SDK_0.9.8 User Guide to the kernel configuration.  A summary is as follows:

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
On successful boot with this kernel on the target board, after plugging in the USB cable, the following messages appear on the
console:

musb_stage2_irq 863: SUSPEND (b_idle) devctl 99 power e0 musb_stage0_irq 722: BUS RESET musb_stage0_irq 722: BUS RESET musb_stage0_irq 722: BUS RESET musb_stage0_irq 722: BUS RESET musb_stage0_irq 722: BUS RESET musb_stage0_irq 722: BUS RESET musb_stage0_irq 722: BUS RESET musb_stage0_irq 722: BUS RESET
usb0: high speed config #2: 100 mA, Ethernet Gadget, using RNDIS musb_stage0_irq 722: BUS RESET musb_stage0_irq 722: BUS RESET musb_stage2_irq 863: SUSPEND (b_peripheral) devctl 99 power f0

I then setup an IP address for the usb0 interface with the following command:

[root@OMAP3EVM /]# /sbin/ifconfig usb0 192.168.1.1 up netmask 255.255.255.0

On the Linux Host machine
#######################

On insertion of the USB cable, 'dmesg' shows the following messages:

usb 1-2: new high speed USB device using address 3 usb 1-2: configuration #1 chosen from 2 choices usb 1-2: can't set config #1, error -71

The Problem
-------------------
On an attempt to setup an IP address for the usb0 interface, I get the following error:

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
   OMAP3EVM running OMAP35x_SDK_0.9.8 firmware: x-load, u-boot and kernel (linux-2.6.22.18)
   Dip switches (SW4) set to boot from NAND flash (01010000)


Although my end objective is to test the USB functionality with TWL4030 USB transceiver, I wanted to verify if USB functions as expected through ISP1504 transceiver on my board with the SDK_0.9.8.
Has anyone tested the USB Gadget setup on the OMAP3EVM boards?

Thanks in advance,
Kanagesh.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in the body of a message to majordomo@vger.kernel.org More majordomo info at  http://vger.kernel.org/majordomo-info.html
