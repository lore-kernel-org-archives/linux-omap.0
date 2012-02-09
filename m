From: Rex Feany <rfeany@laeos.net>
Subject: Re: OMAP34xx
Date: Thu, 9 Feb 2012 11:34:42 -0800
Message-ID: <20120209193442.GA1767@rexfeany.com>
References: <20120208231551.GA9009@kroah.com>
 <alpine.DEB.2.00.1202081648510.9540@utopia.booyaka.com>
 <20120209004731.GA11343@kroah.com>
 <4F3374F0.3080002@bitmer.com>
 <20120209133739.GB2590@sirena.org.uk>
 <20120209183624.GJ1426@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ilona.fnordsoft.com ([173.230.144.79]:35514 "EHLO
	ilona.fnordsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758458Ab2BITom (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Feb 2012 14:44:42 -0500
Content-Disposition: inline
In-Reply-To: <20120209183624.GJ1426@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Greg KH <gregkh@linuxfoundation.org>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Grazvydas Ignotas <notasas@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

Thus spake Tony Lindgren (tony@atomide.com):

> Please everybody using omaps with mainline give a test for the
> merge of the various fixes planned. I've done a branch with
> v3.3-rc3 + Russell's fixes + Paul's serial port fixes + fixes
> that I've queued up.
> 
> If you still see problems with compiling, booting, or slow serial
> port, please post the issues to linux-omap and LAKML lists
> immediately.

With the testing branch, my serial port is still very slow. 
The console is set to 115200, dmesg takes almost a minute to print out.
I'm testing on a beagleboard-xm, which has the DM3730.
(if I change omap2_pm_idle() to never call omap_sram_idle() things improve *a lot*).

config: http://tonya.fnordsoft.com/omap-testing/config
dmesg: http://tonya.fnordsoft.com/omap-testing/testing-dmesg

I also get these warnings when compiling:

  CC      arch/arm/mach-omap2/usb-host.o
arch/arm/mach-omap2/usb-host.c: In function 'usbhs_init':
arch/arm/mach-omap2/usb-host.c:528: warning: assignment from incompatible pointer type

  CC      kernel/trace/trace.o
kernel/trace/trace.c: In function 'tracing_mark_write':
kernel/trace/trace.c:3697: warning: 'page2' may be used uninitialized in this function

  CC      drivers/usb/host/ehci-hcd.o
drivers/usb/host/ehci-hub.c:1079: warning: 'ehci_relinquish_port' defined but not used
drivers/usb/host/ehci-hub.c:1088: warning: 'ehci_port_handed_over' defined but not used

with this gcc:
{rfeany@etalinux:~}(0)$ arm-angstrom-linux-gnueabi-gcc --version
arm-angstrom-linux-gnueabi-gcc (GCC) 4.3.3

take care!
/rex.
