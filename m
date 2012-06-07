From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 02/11] ARM: OMAP4+: AESS: enable internal auto-gating
 during initial setup
Date: Thu, 7 Jun 2012 00:48:32 -0700
Message-ID: <20120607074831.GY12766@atomide.com>
References: <20120607060901.25532.68354.stgit@dusk>
 <20120607061306.25532.59488.stgit@dusk>
 <20120607071900.GW12766@atomide.com>
 <alpine.DEB.2.00.1206070121150.6684@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:62412 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754870Ab2FGHse (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jun 2012 03:48:34 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1206070121150.6684@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, =?utf-8?B?UMOpdGVy?= Ujfalusi <peter.ujfalusi@ti.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

* Paul Walmsley <paul@pwsan.com> [120607 00:35]:
> On Thu, 7 Jun 2012, Tony Lindgren wrote:
> 
> > It seems that most/many IP blocks need their custom reset hacks, and 
> > it's not limited to just few instances?
> 
> Only four out of the fifty-seven omap_hwmod_classes defined in 
> mach-omap2/omap_hwmod_44xx_data.c after this series have custom reset 
> functions used:
> 
> $ fgrep 'struct omap_hwmod_class ' arch/arm/mach-omap2/omap_hwmod_44xx_data.c | wc -l
> 57
> $ fgrep '.reset' arch/arm/mach-omap2/omap_hwmod_44xx_data.c | wc -l
> 4
> 
> That's 7% of the classes.  In terms of the total number of IP block 
> instances that use custom reset functions viewed against the total number 
> of instances on the chip, the percentage is even smaller.

OK so that's not too bad then. But there's also the omap2_wd_timer_disable
pre_shutdown too. And there's also the sysconfig autoidle bit for each driver
that we're tweaking in the bus level code?

If we can remove the ioremapping and accessing driver registers in the bus
level code things get much simpler for the bus level code.

> > AFAIK there's no need to reset the IP blocks before the driver init, 
> > it's really needed for PM. So it's not needed early on, and it's OK to 
> > require running the driver init for driver modules that are not in use 
> > to reset them properly. After all, the hardware is on the device, even 
> > if it's not being used.
> 
> I don't think I'm following you.  It's not just PM; the problem is also 
> with kexec or buggy bootloaders.  If an IP block isn't reset when the 
> kernel boots, and is doing DMA or anything else that could affect the 
> reset of the system, it could easily cause unpredictable behavior or 
> crashes in unrelated kernel code.

Still sounds like the responsibility of the bootloaders and drivers to
set things up properly, that's the standard behaviour.
 
> It's also worth mentioning that many IP blocks, such as AESS, don't have 
> Linux drivers.

Sounds like it should have a minimal driver then, just to reset it if
nothing else.

Regards,

Tony
