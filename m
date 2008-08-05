From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: Problems with USB Gadget on the OMAP3EVM
Date: Tue, 5 Aug 2008 14:27:36 +0300
Message-ID: <20080805112736.GZ30539@gandalf.research.nokia.com>
References: <ece1079f0808050417o49392d42if4b730b7d700bdab@mail.gmail.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:34522 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753471AbYHEL1p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Aug 2008 07:27:45 -0400
Content-Disposition: inline
In-Reply-To: <ece1079f0808050417o49392d42if4b730b7d700bdab@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext kanagesh radhakrishnan <rkanagesh@gmail.com>
Cc: linux-omap@vger.kernel.org

Hi,

On Tue, Aug 05, 2008 at 04:47:02PM +0530, ext kanagesh radhakrishnan wrote:
> Running the Test
> -------------------------
> On the OMAP3EVM Target
> #######################
> On successful boot with this kernel on the target board, after
> plugging in the USB cable, the following messages appear on the
> console:
> 
> musb_stage2_irq 863: SUSPEND (b_idle) devctl 99 power e0
> musb_stage0_irq 722: BUS RESET
> musb_stage0_irq 722: BUS RESET
> musb_stage0_irq 722: BUS RESET
> musb_stage0_irq 722: BUS RESET
> musb_stage0_irq 722: BUS RESET
> musb_stage0_irq 722: BUS RESET
> musb_stage0_irq 722: BUS RESET
> musb_stage0_irq 722: BUS RESET
> usb0: high speed config #2: 100 mA, Ethernet Gadget, using RNDIS
> musb_stage0_irq 722: BUS RESET
> musb_stage0_irq 722: BUS RESET
> musb_stage2_irq 863: SUSPEND (b_peripheral) devctl 99 power f0
> 
> I then setup an IP address for the usb0 interface with the following command:
> 
> [root@OMAP3EVM /]# /sbin/ifconfig usb0 192.168.1.1 up netmask 255.255.255.0
> 
> On the Linux Host machine
> #######################
> 
> On insertion of the USB cable, 'dmesg' shows the following messages:
> 
> usb 1-2: new high speed USB device using address 3
> usb 1-2: configuration #1 chosen from 2 choices
> usb 1-2: can't set config #1, error -71

That's weird since gadget api set config 2 as your dmesg states.
usb0: high speed config #2: 100 mA, Ethernet Gadget, using RNDIS

> The Problem
> -------------------
> On an attempt to setup an IP address for the usb0 interface, I get the
> following error:
> 
> usb0: unknown interface: No such device
> SIOCSIFADDR: No such device
> usb0: unknown interface: No such device
> SIOCSIFNETMASK: No such device
> SIOCGIFADDR: No such device
> SIOCSIFBROADCAST: No such device

Looks like the problem is in the host side usbnet.ko. What kernel
version is in your host machine ?

> The Test Setup
> ----------------------
> 
> Host
> ####
>    Linux machine running Fedora Core 5.
>    Manually loaded the module usbnet.ko.

Which kernel version is in this fedora core 5 ??

> Target
> #####
>    OMAP3EVM running OMAP35x_SDK_0.9.8 firmware: x-load, u-boot and
> kernel (linux-2.6.22.18)
>    Dip switches (SW4) set to boot from NAND flash (01010000)
> 
> 
> Although my end objective is to test the USB functionality with
> TWL4030 USB transceiver, I wanted to verify if USB functions as
> expected through ISP1504 transceiver on my board with the SDK_0.9.8.
> Has anyone tested the USB Gadget setup on the OMAP3EVM boards?

I'd strongly suggest you to try out current linux-omap code [1] and check
if it works fine.

Also increase MUSB_LOGLEVEL to 3 in your .config file and reabuild that
2.6.22.18 kernel.

When you clone linux omap with:

$ git clone http://www.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git

You can make omap3_evm_defconfig and later make menuconfig to choose the
gadget driver you want.

[1] http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=summary

-- 
balbi
