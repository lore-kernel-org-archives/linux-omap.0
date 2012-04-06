From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/3] ARM: OMAP2+: 32k-counter: Use hwmod lookup to
	check presence of 32k timer
Date: Fri, 6 Apr 2012 11:04:52 -0700
Message-ID: <20120406180452.GB15734@atomide.com>
References: <CACVXFVMjSPhF_+CfbF2vD5ts+WtZGjofEWmknB0D1OpTM7geZw@mail.gmail.com>
 <CAMQu2gyEUhDyyng+_oC5NpXHzWMaTGsnCSTTZcMUi2pLV0z8RQ@mail.gmail.com>
 <87sjgmt211.fsf@ti.com>
 <79CD15C6BA57404B839C016229A409A8318461E8@DBDE01.ent.ti.com>
 <CAMQu2gxuFsovKTPK8wFOO8vMeiyMFnTqNDRZYgAcCsVWytpOTA@mail.gmail.com>
 <79CD15C6BA57404B839C016229A409A83184846A@DBDE01.ent.ti.com>
 <20120405095221.GC25053@n2100.arm.linux.org.uk>
 <79CD15C6BA57404B839C016229A409A831848621@DBDE01.ent.ti.com>
 <87hawxkgoi.fsf@ti.com>
 <79CD15C6BA57404B839C016229A409A831849432@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:27093 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756973Ab2DFSFA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Apr 2012 14:05:00 -0400
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A831849432@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Ming Lei <tom.leiming@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "johnstul@us.ibm.com" <johnstul@us.ibm.com>, "Balbi, Felipe" <balbi@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>

* Hiremath, Vaibhav <hvaibhav@ti.com> [120405 22:25]:
> On Fri, Apr 06, 2012 at 03:03:01, Hilman, Kevin wrote:
> > 
> > What we need is only one-time selection at boot based on presence (or
> > not) of various timers.  IOW, we still only ever need to call
> > setup_sched_clock() once based on which HW timers are available.
> > 
> > Why not just delay the setup_sched_clock() until the clocksource is
> > decided?

I think that's we're already doing for omap1 as 15xx does not
have the 32 KiHz timer and the CONFIG_OMAP_32K_TIMER is no longer
conflicting with the MPU timer.

> I liked Santosh's idea in using command line argument "clocksource=" and 
> make decision based on this. I have implemented it and tried it on both
> OMAP3EVM and beaglebone and it works great.
> 
> I have introduced something like this in mach-omap2/timer.c,
> 
> static int __init omap2_override_clocksource(char* str)
> {
> 	if (!str)
> 		return 0;
> 	/*
> 	 * For OMAP architecture, we only have two options
> 	 *    - sync_32k (default)
> 	 *    - gp timer
> 	 */
> 	if (!strcmp(str, "gp timer"))
> 		use_gptimer_clksrc = true;
> 
> 	return 0;
> }
> early_param("clocksource", omap2_override_clocksource);

Sure a cmdline override is nice to have for user selection.
But we should also by default do the right thing based on what the
board wants in .timer entry. 
 
> It solves all issues what we have been trying address.

I'm a bit confused.. Can you briefly summarize again what all
issues you're having? Just want to select a different clocksource
for beaglebone? If you don't have the 32 KiHz then that can't
be selected naturally?

Regards,

Tony
