From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
Date: Sat, 1 Nov 2014 00:44:51 +0000
Message-ID: <20141101004451.GE12379@n2100.arm.linux.org.uk>
References: <20141027200008.GR2560@atomide.com> <20141031193057.GC12379@n2100.arm.linux.org.uk> <20141031211325.GC31454@atomide.com> <20141031223332.GD12379@n2100.arm.linux.org.uk> <20141031233722.GE31454@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:51906 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753560AbaKAAo6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 Oct 2014 20:44:58 -0400
Content-Disposition: inline
In-Reply-To: <20141031233722.GE31454@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>

On Fri, Oct 31, 2014 at 04:37:23PM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [141031 15:35]:
> > On Fri, Oct 31, 2014 at 02:13:26PM -0700, Tony Lindgren wrote:
> > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [141031 12:32]:
> > > 
> > > > WARNING: CPU: 0 PID: 1 at arch/arm/mach-omap2/omap_hwmod.c:2538 _init+0xc8/0x170()
> > > > omap_hwmod: ssi: doesn't have mpu register target base
> > > > ...
> > > 
> > > Not seeing this one, is this maybe from the legacy mode boot?
> > > 
> > > > omap_hwmod: usb_host_hs: could not associate to clkdm l3_init_clkdm
> > > > omap_hwmod: usb_tll_hs: could not associate to clkdm l3_init_clkdm
> > > 
> > > Not seeing these either. Is this maybe from your 4430sdp instead?
> > 
> > This is /all/ from the 3430 LDP.
> > 
> > Compare these two URLs:
> > 
> > http://www.arm.linux.org.uk/developer/build/result.php?type=boot&idx=2891
> > http://www.arm.linux.org.uk/developer/build/result.php?type=boot&idx=2892
> 
> Not able to load the second one because of the broken battery
> driver :)
> 
> But based on the link above I can see that you're mixing in both
> legacy mode warnings and DT mode warnings at least for the SSI,
> so that explains why I'm not seeing the SSI error.
> 
> Still no idea where the l3_init_clkdm errors come from, are they
> from your huge log?
> 
> Like I posted in this thread, I'm not seeing same errors as you are
> with your config modified for DT:
> 
> http://muru.com/for-rmk/dmesg-ldp-dt-v3.18-rc2

Gah, the build system hadn't copied the wrapped image over since 3.14 days,
so it was a boot of the 3.14 kernel.  Sorry about that.

Now fixed, things are looking better, but not good enough.  The biggest
problem for the autobooter is this:

Deactivating swap...
Unmounting local filesystems...
Can't find /mnt/ram in /etc/fstab
umount: forced umount of tmpfs failed!
reboot: Power down
...4.T.......

Texas Instruments X-Loader 1.41mmc
Starting OS Bootloader from MMC/SD1 ...


U-Boot 1.1.4 (May 22 2008 - 18:10:53)

... which then proceeds with a full boot, and a re-run of everything,
which will continue endlessly.

Power down *means* you're supposed to power down or halt.  You're *NOT*
supposed to reboot.  This needs fixing.  Diffing the two log files
gives this at that point:

-reboot: System halted
+reboot: Power down

I guess the problem is that someone's decided with DT to hook a power
down handler which reboots instead.  That's soo fscking broken.  Reboot
means reboot.  Power off (and halt) means shutdown and _do_ _not_ reboot.
If I want it to reboot, I'd have asked for a reboot.

The battery problem is gone (so must have been fixed between 3.14 and
3.18-rc2) as is the omap_hwmod warning with backtrace.

New errors are:

+omap_l3_smx omap_l3_smx.0: couldn't request debug irq
+omap_l3_smx: probe of omap_l3_smx.0 failed with error -22
+irq: no irq domain found for /ocp/pinmux@48002030 !
+vddvario: no parameters
+vdd33a: no parameters
+omap2_set_init_voltage: unable to find boot up OPP for vdd_mpu_iva
+omap2_set_init_voltage: unable to set vdd_mpu_iva
+omap2_set_init_voltage: unable to find boot up OPP for vdd_core
+omap2_set_init_voltage: unable to set vdd_core

However, these are minor compared to the dreadful poweroff behaviour.
Still going to have to disable DT booting for the LDP because of that.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
