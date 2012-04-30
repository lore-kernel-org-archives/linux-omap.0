From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH/RFT 0/8] ARM: OMAP: remove IP checks from SoC family
 detection
Date: Mon, 30 Apr 2012 09:30:30 -0700
Message-ID: <20120430163030.GC18669@animalcreek.com>
References: <1335482993-14035-1-git-send-email-khilman@ti.com>
 <20120427220813.GE19196@animalcreek.com>
 <87aa1wyfq5.fsf@ti.com>
 <20120428202047.GA7068@numbers.woodsts.org>
 <79CD15C6BA57404B839C016229A409A83EA024D6@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:48968 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753636Ab2D3Qac (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Apr 2012 12:30:32 -0400
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA024D6@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Derald D. Woods" <woods.rt@gmail.com>, "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Sun, Apr 29, 2012 at 09:48:26AM +0000, Hiremath, Vaibhav wrote:
> On Sun, Apr 29, 2012 at 01:50:48, Derald D. Woods wrote:
> > On Fri, Apr 27, 2012 at 03:25:38PM -0700, Kevin Hilman wrote:

> > 
> > Hello Kevin,
> > 
> > I have a Logic PD AM3517 Zoom Experimenter [SOMAM3517-10-1780RJXR-C (REV A)].
> > 
> > My board booted to the Linux login on MMC rootfs.
> > 
> 
> I tried to validate these patches now with latest baseline, and I am not 
> getting Linux prompt though,
> 
> I am based on linux-omap/master (1e32b7eee) and applied all 8 patches from 
> Kevin, it always halts at,

> Starting kernel ...
> 
> Uncompressing Linux... done, booting the kernel.
> [    0.000000] Booting Linux on physical CPU 0
> [    0.000000] Linux version 3.4.0-rc3-11794-gbbc91ff (a0393758@psplinux064) (gcc version 4.5.3 20110311 (prerelease) (GCC) ) #1 SMP Sun Apr 29 14:52:26 IST 2012

> [    0.000000] Kernel command line: root=/dev/ram0 rw mem=128M console=ttyS2,115200n8 console=ttyO2,115200n8 initrd=0x81600000,16M

> [    2.566741] ThumbEE CPU extension supported.
> [    2.582977] voltdm_scale: No voltage scale API registered for vdd_mpu_iva
> [    2.590332] voltdm_scale: No voltage scale API registered for vdd_core
> [    2.597503] PM: no software I/O chain control; some wakeups may be lost
> [    2.645935] clock: disabling unused clocks to save power
> [    2.659515] drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
> [    2.671844] RAMDISK: gzip image found at block 0

Try adding 'nohlt' to your cmdline and make sure that CONFIG_CPU_IDLE
is disabled.

Mark
