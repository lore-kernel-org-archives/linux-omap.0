From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 1/3] ARM: OMAP2+: 32k-counter: Use hwmod lookup to	check
 presence of 32k timer
Date: Fri, 6 Apr 2012 05:21:52 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A831849432@DBDE01.ent.ti.com>
References: <CACVXFVPbU2OqTN=S0AZCD10KuSBYxqyyRH_xee+WTaCD6VSmMQ@mail.gmail.com>
	<CAMQu2gzuQ-q+3RHsW0=U305jCF-td5-PEXkGZ6WnQTqA1K8oAQ@mail.gmail.com>
	<CACVXFVPu1GEQy+sCgXMB8JCszPBBs8zHRVm94TYb1-y2afkqgw@mail.gmail.com>
	<CAMQu2gwuRpZ133962r3N4Y4K3oQ88ySa=SyoS6v=sSHGA=SGKw@mail.gmail.com>
	<CACVXFVMjSPhF_+CfbF2vD5ts+WtZGjofEWmknB0D1OpTM7geZw@mail.gmail.com>
	<CAMQu2gyEUhDyyng+_oC5NpXHzWMaTGsnCSTTZcMUi2pLV0z8RQ@mail.gmail.com>
	<87sjgmt211.fsf@ti.com>
	<79CD15C6BA57404B839C016229A409A8318461E8@DBDE01.ent.ti.com>
	<CAMQu2gxuFsovKTPK8wFOO8vMeiyMFnTqNDRZYgAcCsVWytpOTA@mail.gmail.com>
	<79CD15C6BA57404B839C016229A409A83184846A@DBDE01.ent.ti.com>
	<20120405095221.GC25053@n2100.arm.linux.org.uk>
	<79CD15C6BA57404B839C016229A409A831848621@DBDE01.ent.ti.com>
 <87hawxkgoi.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54516 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752019Ab2DFFWQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Apr 2012 01:22:16 -0400
In-Reply-To: <87hawxkgoi.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Ming Lei <tom.leiming@gmail.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "johnstul@us.ibm.com" <johnstul@us.ibm.com>, "Balbi, Felipe" <balbi@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>

On Fri, Apr 06, 2012 at 03:03:01, Hilman, Kevin wrote:
> "Hiremath, Vaibhav" <hvaibhav@ti.com> writes:
> 
> > On Thu, Apr 05, 2012 at 15:22:21, Russell King - ARM Linux wrote:
> >> On Thu, Apr 05, 2012 at 09:36:00AM +0000, Hiremath, Vaibhav wrote:
> >> > There seems to be limitation for ARM architecture, it is restricted by
> >> > sched_clock implementation present in "arch/arm/kernel/sched_clock.c".
> >> > Natively, clocksource framework does support change in rate/frequency for
> >> > registered timer, using,
> >> 
> >> Any kind of switching of timing sources introduces loss of time issues
> >> by the mere fact that you can't instantly know the counter values of
> >> both timing sources at precisely the same instant - because CPUs can
> >> only do one thing at a time.  So any kind of repeated dynamic switching
> >> _will_ result in a gradual loss of time - which will be indeterminant
> >> as it depends on the frequency of the switching and the relative delta
> >> between the two.
> >> 
> >> To put it another way - it is not possible to maintain high precision
> >> and accuracy while dynamically switching your timing sources.
> >> 
> >> I'm not about to lift the restriction that there's only one source for
> >> sched_clock() just for OMAP.  That'd require a lot of additional code -
> >> it's not just about adjusting the multiplier and shift, you also have to
> >> correct the returned ns value as well, which means synchronizing against
> >> two counters.  (And as I've pointed out above, that's impossible to do
> >> accurately.)
> >> 
> >
> > Thanks a ton Russell for confirming on this,
> >
> > I understand, we also have to adjust ns value and such confirmation is what exactly I was looking for.
> >
> > So this means, we have to use compile time option, as existing
> > implementation in "arch/arm/mach-omap2/timer.c".
> 
> Not exactly.  A compile time option isn't (yet) the only option.
> 
> Russell points out the various problems with dynamic switching of
> clocksources, which is true.  However, we're not trying to dynamically
> switch clocksources.
> 
> What we need is only one-time selection at boot based on presence (or
> not) of various timers.  IOW, we still only ever need to call
> setup_sched_clock() once based on which HW timers are available.
> 
> Why not just delay the setup_sched_clock() until the clocksource is
> decided?
> 

Kevin,

I liked Santosh's idea in using command line argument "clocksource=" and 
make decision based on this. I have implemented it and tried it on both
OMAP3EVM and beaglebone and it works great.

I have introduced something like this in mach-omap2/timer.c,

static int __init omap2_override_clocksource(char* str)
{
	if (!str)
		return 0;
	/*
	 * For OMAP architecture, we only have two options
	 *    - sync_32k (default)
	 *    - gp timer
	 */
	if (!strcmp(str, "gp timer"))
		use_gptimer_clksrc = true;

	return 0;
}
early_param("clocksource", omap2_override_clocksource);


It solves all issues what we have been trying address.

Thanks,

Vaibhav

> Kevin
> 

