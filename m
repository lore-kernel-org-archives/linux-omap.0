From: "TK, Pratheesh Gangadhar" <pratheesh@ti.com>
Subject: RE: Problems with USB Gadget on the OMAP3EVM
Date: Wed, 6 Aug 2008 18:30:36 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593013CA23902@dbde02.ent.ti.com>
References: <ece1079f0808050417o49392d42if4b730b7d700bdab@mail.gmail.com>
	 <20080805112736.GZ30539@gandalf.research.nokia.com>
 <ece1079f0808052212r6f4b2830i2ace5e66263998dd@mail.gmail.com>
 <19F8576C6E063C45BE387C64729E7394034F30ABEF@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33372 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756275AbYHFNLt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Aug 2008 09:11:49 -0400
In-Reply-To: <19F8576C6E063C45BE387C64729E7394034F30ABEF@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, kanagesh radhakrishnan <rkanagesh@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Kanagesh,

You can give it a shot using a different cable - I have seen similar issues when using a faulty cable.

Regards,
Pratheesh

-----Original Message-----
From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Gupta, Ajay Kumar
Sent: Wednesday, August 06, 2008 6:12 PM
To: kanagesh radhakrishnan
Cc: linux-omap@vger.kernel.org
Subject: RE: Problems with USB Gadget on the OMAP3EVM

Kanagesh,

I tested it with Windows XP machine and it works all fine. I had to use linux.inf file which is at
Documetation\usb\ folder.

linux.inf file should have same VID/PID as reported by gadget rndis driver to host.

Regards,
Ajay

-----Original Message-----
From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of kanagesh radhakrishnan
Sent: Wednesday, August 06, 2008 10:43 AM
To: felipe.balbi@nokia.com
Cc: linux-omap@vger.kernel.org
Subject: Re: Problems with USB Gadget on the OMAP3EVM

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
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
