From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 1/3] ARM: OMAP2+: 32k-counter: Use hwmod lookup to	check
 presence of 32k timer
Date: Mon, 9 Apr 2012 06:19:27 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83184ABEF@DBDE01.ent.ti.com>
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
 <20120406180452.GB15734@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34637 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106Ab2DIGTv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Apr 2012 02:19:51 -0400
In-Reply-To: <20120406180452.GB15734@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, Ming Lei <tom.leiming@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "johnstul@us.ibm.com" <johnstul@us.ibm.com>, "Balbi, Felipe" <balbi@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>

On Fri, Apr 06, 2012 at 23:34:52, Tony Lindgren wrote:
> * Hiremath, Vaibhav <hvaibhav@ti.com> [120405 22:25]:
> > On Fri, Apr 06, 2012 at 03:03:01, Hilman, Kevin wrote:
> > > 
> > > What we need is only one-time selection at boot based on presence (or
> > > not) of various timers.  IOW, we still only ever need to call
> > > setup_sched_clock() once based on which HW timers are available.
> > > 
> > > Why not just delay the setup_sched_clock() until the clocksource is
> > > decided?
> 
> I think that's we're already doing for omap1 as 15xx does not
> have the 32 KiHz timer and the CONFIG_OMAP_32K_TIMER is no longer
> conflicting with the MPU timer.
> 

No we are not delaying anything here, we still are calling 
setup_sched_clock() function in timer->init() callback.
The call sequence for omap1 is,

struct sys_timer omap1_timer = {
	.init           = omap1_timer_init,
};

static void __init omap1_timer_init(void)
{
	if (!omap_32k_timer_usable())
		omap_mpu_timer_init();
}

omap_32k_timer_usable() is just return for omap730 & omap15xx and fallback to omap_mpu_timer_init(). For all other platforms, 32ksync timer init call 
happens.
In both the cases, setup_sched_clock() is called.


> > I liked Santosh's idea in using command line argument "clocksource=" and 
> > make decision based on this. I have implemented it and tried it on both
> > OMAP3EVM and beaglebone and it works great.
> > 
> > I have introduced something like this in mach-omap2/timer.c,
> > 
> > static int __init omap2_override_clocksource(char* str)
> > {
> > 	if (!str)
> > 		return 0;
> > 	/*
> > 	 * For OMAP architecture, we only have two options
> > 	 *    - sync_32k (default)
> > 	 *    - gp timer
> > 	 */
> > 	if (!strcmp(str, "gp timer"))
> > 		use_gptimer_clksrc = true;
> > 
> > 	return 0;
> > }
> > early_param("clocksource", omap2_override_clocksource);
> 
> Sure a cmdline override is nice to have for user selection.
> But we should also by default do the right thing based on what the
> board wants in .timer entry. 
>  

I did not understand what exactly you are trying to point here.
I think we are doing exactly what board needs in .timer. 

> > It solves all issues what we have been trying address.
> 
> I'm a bit confused.. Can you briefly summarize again what all
> issues you're having? Just want to select a different clocksource
> for beaglebone? If you don't have the 32 KiHz then that can't
> be selected naturally?
> 

Let me summarize it here again,

Currently, the timer code is using config option CONFIG_OMAP_32K_TIMER,
to choose between 32ksync counter and gptimer; it is compile time option.
If user wants to use gptimer for HR ticks, he must build the kernel without
CONFIG_OMAP_32K_TIMER option.

AM335x family of devices doesn't have 32ksync_counter available, only option 
here is to use gptimer for kernel clocksource and clockevents.

So in order to support, multi-omap build including devices like AM335x, we 
must get rid of this option CONFIG_OMAP_32K_TIMER, atleast from clocksource 
registration perspective.

So that means, we need to have some mechanism to handle or detect available 
clocksource runtime. Options would be,

 - Use HWMOD to detect availability of 32ksync_counter, else fallback 
   to gptimer. [This was my original patch]

   But this restricts the use of gptimer completely on omap architecture, 
   where we have 32ksync counter module.

 - So the next solution is to still keep compile time option, so that user 
   will get to use gptimer atleast just changing the kernel config option.

   But, still, this is going to be kernel rebuild.

 - Next option came up was, register both the timers and override using 
   kernel parameter. 

   This will work only if, both the timers run at same rate/frequency; since
   we have one more layer here setup_sched_clock(), which actually can be 
   called only once.

 - Next option suggested by Santosh, is to use kernel parameter as in parse
   it early, to make decision on if user wants to override default 
   clocksource (32ksync)
   
   This is something will work for us and solves all above issues.

I have validated it on OMAP3EVM and it seems to be working for me without 
any issues.

Thanks,
Vaibhav

