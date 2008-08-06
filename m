From: "kanagesh radhakrishnan" <rkanagesh@gmail.com>
Subject: Re: Problems with USB Gadget on the OMAP3EVM
Date: Wed, 6 Aug 2008 10:42:40 +0530
Message-ID: <ece1079f0808052212r6f4b2830i2ace5e66263998dd@mail.gmail.com>
References: <ece1079f0808050417o49392d42if4b730b7d700bdab@mail.gmail.com>
	 <20080805112736.GZ30539@gandalf.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f29.google.com ([209.85.217.29]:54384 "EHLO
	mail-gx0-f29.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761703AbYHFFMl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Aug 2008 01:12:41 -0400
Received: by gxk10 with SMTP id 10so4528228gxk.13
        for <linux-omap@vger.kernel.org>; Tue, 05 Aug 2008 22:12:40 -0700 (PDT)
In-Reply-To: <20080805112736.GZ30539@gandalf.research.nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: felipe.balbi@nokia.com
Cc: linux-omap@vger.kernel.org

On 8/5/08, Felipe Balbi <felipe.balbi@nokia.com> wrote:
> Hi,
>
>
>  On Tue, Aug 05, 2008 at 04:47:02PM +0530, ext kanagesh radhakrishnan wrote:
>  > Running the Test
>  > -------------------------
>  > On the OMAP3EVM Target
>  > #######################
>  > On successful boot with this kernel on the target board, after
>  > plugging in the USB cable, the following messages appear on the
>  > console:
>  >
>  > musb_stage2_irq 863: SUSPEND (b_idle) devctl 99 power e0
>  > musb_stage0_irq 722: BUS RESET
>  > musb_stage0_irq 722: BUS RESET
>  > musb_stage0_irq 722: BUS RESET
>  > musb_stage0_irq 722: BUS RESET
>  > musb_stage0_irq 722: BUS RESET
>  > musb_stage0_irq 722: BUS RESET
>  > musb_stage0_irq 722: BUS RESET
>  > musb_stage0_irq 722: BUS RESET
>  > usb0: high speed config #2: 100 mA, Ethernet Gadget, using RNDIS
>  > musb_stage0_irq 722: BUS RESET
>  > musb_stage0_irq 722: BUS RESET
>  > musb_stage2_irq 863: SUSPEND (b_peripheral) devctl 99 power f0
>  >
>  > I then setup an IP address for the usb0 interface with the following command:
>  >
>  > [root@OMAP3EVM /]# /sbin/ifconfig usb0 192.168.1.1 up netmask 255.255.255.0
>  >
>  > On the Linux Host machine
>  > #######################
>  >
>  > On insertion of the USB cable, 'dmesg' shows the following messages:
>  >
>  > usb 1-2: new high speed USB device using address 3
>  > usb 1-2: configuration #1 chosen from 2 choices
>  > usb 1-2: can't set config #1, error -71
>
>
> That's weird since gadget api set config 2 as your dmesg states.
>
> usb0: high speed config #2: 100 mA, Ethernet Gadget, using RNDIS
>
>
> > The Problem
>  > -------------------
>  > On an attempt to setup an IP address for the usb0 interface, I get the
>  > following error:
>  >
>  > usb0: unknown interface: No such device
>  > SIOCSIFADDR: No such device
>  > usb0: unknown interface: No such device
>  > SIOCSIFNETMASK: No such device
>  > SIOCGIFADDR: No such device
>  > SIOCSIFBROADCAST: No such device
>
>
> Looks like the problem is in the host side usbnet.ko. What kernel
>  version is in your host machine ?
>
>
>  > The Test Setup
>  > ----------------------
>  >
>  > Host
>  > ####
>  >    Linux machine running Fedora Core 5.
>  >    Manually loaded the module usbnet.ko.
>
>
> Which kernel version is in this fedora core 5 ??
>
>
>  > Target
>  > #####
>  >    OMAP3EVM running OMAP35x_SDK_0.9.8 firmware: x-load, u-boot and
>  > kernel (linux-2.6.22.18)
>  >    Dip switches (SW4) set to boot from NAND flash (01010000)
>  >
>  >
>  > Although my end objective is to test the USB functionality with
>  > TWL4030 USB transceiver, I wanted to verify if USB functions as
>  > expected through ISP1504 transceiver on my board with the SDK_0.9.8.
>  > Has anyone tested the USB Gadget setup on the OMAP3EVM boards?
>
>
> I'd strongly suggest you to try out current linux-omap code [1] and check
>  if it works fine.
>
>  Also increase MUSB_LOGLEVEL to 3 in your .config file and reabuild that
>  2.6.22.18 kernel.
>
>  When you clone linux omap with:
>
>  $ git clone http://www.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
>
>  You can make omap3_evm_defconfig and later make menuconfig to choose the
>  gadget driver you want.
>
>  [1] http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=summary
>
>  --
>
> balbi
>

Hello everyone,

Thank you very much for the comments and suggestions.

The version of Linux kernel on the native host Fedora Core 5 machine
is the default 2.6.9-1.667 kernel that comes with the FC5 release.
Keeping in mind where we are, this does sound like an ancient kernel.
However, I have USB networking with Gadget drivers working on this
same machine with OMAP5912 OSK, OMAP2430 SDP and another custom
OMAP2430 based board.

Nevertheless, I decided to upgrade to a more recent version of the
Linux kernel on the host system.  I will test the setup once again and
update the observation.

Meanwhile, I tested the setup with a Windows XP host machine and these
are the observations:
On insertion of the USB cable to the Win XP host machine, the OMAP3EVM
board gets detected as 'RNDIS/Ethernet' Device.  I go through the
driver installation (driver used is file Documentation/usb/linux.inf
from the standard Linux kernel sources).  After the installation is
complete, I get an error from the Windows XP system saying "An error
was encountered while installing the driver and the hardware might not
function as intended"

Thank you all,
Regards,
Kanagesh
