From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
Date: Sat, 1 Nov 2014 14:57:46 -0700
Message-ID: <20141101215745.GF31454@atomide.com>
References: <20141027200008.GR2560@atomide.com>
 <20141031193057.GC12379@n2100.arm.linux.org.uk>
 <20141031211325.GC31454@atomide.com>
 <20141031223332.GD12379@n2100.arm.linux.org.uk>
 <20141031233722.GE31454@atomide.com>
 <20141101004451.GE12379@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:23442 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750728AbaKAV7F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 Nov 2014 17:59:05 -0400
Content-Disposition: inline
In-Reply-To: <20141101004451.GE12379@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [141031 17:46]:
> On Fri, Oct 31, 2014 at 04:37:23PM -0700, Tony Lindgren wrote:
> > 
> > Like I posted in this thread, I'm not seeing same errors as you are
> > with your config modified for DT:
> > 
> > http://muru.com/for-rmk/dmesg-ldp-dt-v3.18-rc2
> 
> Gah, the build system hadn't copied the wrapped image over since 3.14 days,
> so it was a boot of the 3.14 kernel.  Sorry about that.

Ah-hah-hah!
 
> Now fixed, things are looking better, but not good enough.  The biggest
> problem for the autobooter is this:
> 
> Deactivating swap...
> Unmounting local filesystems...
> Can't find /mnt/ram in /etc/fstab
> umount: forced umount of tmpfs failed!
> reboot: Power down
> ...4.T.......
> 
> Texas Instruments X-Loader 1.41mmc
> Starting OS Bootloader from MMC/SD1 ...
> 
> 
> U-Boot 1.1.4 (May 22 2008 - 18:10:53)
> 
> ... which then proceeds with a full boot, and a re-run of everything,
> which will continue endlessly.
> 
> Power down *means* you're supposed to power down or halt.  You're *NOT*
> supposed to reboot.  This needs fixing.  Diffing the two log files
> gives this at that point:
> 
> -reboot: System halted
> +reboot: Power down
> 
> I guess the problem is that someone's decided with DT to hook a power
> down handler which reboots instead.  That's soo fscking broken.  Reboot
> means reboot.  Power off (and halt) means shutdown and _do_ _not_ reboot.
> If I want it to reboot, I'd have asked for a reboot.

That's a regression for sure. Does not seem to happen with a later
version of the PMIC here, but I too am seeing it at least with my
LDP. I'll take a look what's the proper way to fix that as there's
now some PM support with DT based booting that's not there for legacy
booting. So the PMIC configuration is different between legacy booting
and DT booting.
 
> The battery problem is gone (so must have been fixed between 3.14 and
> 3.18-rc2) as is the omap_hwmod warning with backtrace.

OK well that's good.
 
> New errors are:
> 
> +omap_l3_smx omap_l3_smx.0: couldn't request debug irq
> +omap_l3_smx: probe of omap_l3_smx.0 failed with error -22
> +irq: no irq domain found for /ocp/pinmux@48002030 !
> +vddvario: no parameters
> +vdd33a: no parameters
> +omap2_set_init_voltage: unable to find boot up OPP for vdd_mpu_iva
> +omap2_set_init_voltage: unable to set vdd_mpu_iva
> +omap2_set_init_voltage: unable to find boot up OPP for vdd_core
> +omap2_set_init_voltage: unable to set vdd_core

OK good these are known issues but can be dealt with later on.
 
> However, these are minor compared to the dreadful poweroff behaviour.
> Still going to have to disable DT booting for the LDP because of that.

Sure, I'll let you know as soon as I have something available
for the PMIC powerdown issue.

Regards,

Tony
