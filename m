From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
Date: Fri, 31 Oct 2014 16:37:23 -0700
Message-ID: <20141031233722.GE31454@atomide.com>
References: <20141027200008.GR2560@atomide.com>
 <20141031193057.GC12379@n2100.arm.linux.org.uk>
 <20141031211325.GC31454@atomide.com>
 <20141031223332.GD12379@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:41532 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752564AbaJaXik (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Oct 2014 19:38:40 -0400
Content-Disposition: inline
In-Reply-To: <20141031223332.GD12379@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [141031 15:35]:
> On Fri, Oct 31, 2014 at 02:13:26PM -0700, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [141031 12:32]:
> > 
> > > WARNING: CPU: 0 PID: 1 at arch/arm/mach-omap2/omap_hwmod.c:2538 _init+0xc8/0x170()
> > > omap_hwmod: ssi: doesn't have mpu register target base
> > > ...
> > 
> > Not seeing this one, is this maybe from the legacy mode boot?
> > 
> > > omap_hwmod: usb_host_hs: could not associate to clkdm l3_init_clkdm
> > > omap_hwmod: usb_tll_hs: could not associate to clkdm l3_init_clkdm
> > 
> > Not seeing these either. Is this maybe from your 4430sdp instead?
> 
> This is /all/ from the 3430 LDP.
> 
> Compare these two URLs:
> 
> http://www.arm.linux.org.uk/developer/build/result.php?type=boot&idx=2891
> http://www.arm.linux.org.uk/developer/build/result.php?type=boot&idx=2892

Not able to load the second one because of the broken battery
driver :)

But based on the link above I can see that you're mixing in both
legacy mode warnings and DT mode warnings at least for the SSI,
so that explains why I'm not seeing the SSI error.

Still no idea where the l3_init_clkdm errors come from, are they
from your huge log?

Like I posted in this thread, I'm not seeing same errors as you are
with your config modified for DT:

http://muru.com/for-rmk/dmesg-ldp-dt-v3.18-rc2
 
> I'm not trying with omap2plus_defconfig as this is supposed to be a
> separate build.  Given that - as I say - the /exact/ same kernel binary
> works in legacy mode, it suggests that there's some pretty major
> differences between what devices are supported in a legacy boot mode
> and what devices are supported in DT boot mode.

Sure no problem. Your .config works just fine for me in DT mode
with the the options enabled like I posted in this thread.
 
> I really /can't/ risk letting the platform boot again in DT mode having
> just played around with some options - if it spews like it did again
> last night, it'll spew for the whole day tomorrow, and I really don't
> want the database filling up with another gigabyte of log.

Looks like the twl4030_charger.c driver just does printk in the irq
handler for errors :) I'm almost certain you'd get the same errors
in legacy mode too if board-ldp.c passed the platform_data to the
battery driver.. No ideas why the battery detection during probe
won't work for your hardware unless your PMIC is partially fried
or some earlier revision that's broken.

Anyways, let me know what happens with the options I suggested and
CONFIG_CHARGER_TWL4030 disabled so we can see if the other problems
are gone.

Regards,

Tony
