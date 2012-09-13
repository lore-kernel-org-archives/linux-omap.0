From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 01/10] ARM: OMAP3+: Implement timer workaround for
 errata i103 and i767
Date: Thu, 13 Sep 2012 10:24:53 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EAB7BCE@DBDE01.ent.ti.com>
References: <1346871872-24413-1-git-send-email-jon-hunter@ti.com>
 <1346871872-24413-2-git-send-email-jon-hunter@ti.com>
 <50482FAC.3080807@ti.com> <5048ADD0.4050804@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33401 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752627Ab2IMKZF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Sep 2012 06:25:05 -0400
In-Reply-To: <5048ADD0.4050804@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Thu, Sep 06, 2012 at 19:36:08, Hunter, Jon wrote:
> 
> On 09/06/2012 12:07 AM, Vaibhav Hiremath wrote:
> > 
> > 
> > On 9/6/2012 12:34 AM, Jon Hunter wrote:
> >> Errata Titles:
> >> i103: Delay needed to read some GP timer, WD timer and sync timer registers
> >>       after wakeup (OMAP3/4)
> >> i767: Delay needed to read some GP timer registers after wakeup (OMAP5)
> >>
> >> Description (i103/i767):
> >> If a General Purpose Timer (GPTimer) is in posted mode (TSICR [2].POSTED=1),
> >> due to internal resynchronizations, values read in TCRR, TCAR1 and TCAR2
> >> registers right after the timer interface clock (L4) goes from stopped to
> >> active may not return the expected values. The most common event leading to
> >> this situation occurs upon wake up from idle.
> >>
> >> GPTimer non-posted synchronization mode is not impacted by this limitation.
> >>
> >> Workarounds:
> >> 1). Disable posted mode
> >> 2). Use static dependency between timer clock domain and MPUSS clock domain
> >> 3). Use no-idle mode when the timer is active
> >>
> >> Workarounds #2 and #3 are not pratical from a power standpoint and so
> >> workaround #1 has been implemented. Disabling posted mode adds some CPU overhead
> >> for configuring the timers as the CPU has to wait for the write to complete.
> >> However, disabling posted mode guarantees correct operation.
> >>
> >> Please note that it is safe to use posted mode for timers if the counter (TCRR)
> >> and capture (TCARx) registers will never be read. An example of this is the
> >> clock-event system timer. This is used by the kernel to schedule events however,
> >> the timers counter is never read and capture registers are not used. Given that
> >> the kernel configures this timer often yet never reads the counter register it
> >> is safe to enable posted mode in this case. Hence, for the timer used for kernel
> >> clock-events, posted mode is enabled by overriding the errata for devices that
> >> are impacted by this defect.
> >>
> >> Although both dmtimers and watchdogs are impacted by this defect this patch only
> >> implements the workaround for the dmtimer. Currently the watchdog driver does
> >> not read the counter register and so no workaround is necessary.
> >>
> >> Confirmed with Vaibhav Hiremath that this bug also impacts AM33xx devices.
> >>
> > 
> > Thanks for pinging me on this and getting it confirmed.
> > 
> >> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> >> ---
> >>  arch/arm/mach-omap2/timer.c               |    9 +++++++
> >>  arch/arm/plat-omap/dmtimer.c              |    2 ++
> >>  arch/arm/plat-omap/include/plat/dmtimer.h |   39 +++++++++++++++++++++++++++++
> >>  3 files changed, 50 insertions(+)
> >>
> >> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> >> index 2ff6d41..5471706 100644
> >> --- a/arch/arm/mach-omap2/timer.c
> >> +++ b/arch/arm/mach-omap2/timer.c
> >> @@ -208,6 +208,13 @@ static void __init omap2_gp_clockevent_init(int gptimer_id,
> >>  {
> >>  	int res;
> >>  
> >> +	/*
> >> +	 * For clock-event timers we never read the timer counter and
> >> +	 * so we are not impacted by errata i103 and i767. Therefore,
> >> +	 * we can safely ignore this errata for clock-event timers.
> >> +	 */
> >> +	__omap_dm_timer_populate_errata(&clkev, OMAP_TIMER_ERRATA_I103_I767);
> >> +
> > 
> > Couple of points,
> > 
> > 1. It is confusing to me, as you are passing the errata flag so i expect
> > api should set it. Why can't we do reverse way, you pass 0 here, since
> > you don't want to set and pass this flag every other places where you
> > want to enable this errata.
> 
> Per the design of the __omap_dm_timer_populate_errata function, the 2nd
> argument is called override to allow us to override an errata. I am not
> a huge fan of this, but I wanted to be explicit in the code that we are
> intentionally allowing posted mode for the clock-events timer.
> 
> I did not wish to pass the flags we want to set because if there more
> flags added in the future then we will have to keep changing the calls
> to the populate_errata function to add these.
> 

Isn't that would self-explain himself which flag is going to set without 
looking at the implementation?
I do not have any reservations here, it just doesn't seem easily readable to 
me.
You can make a call here.


> > 2. Why can't we enable for all timers? Even though clock-event is anyway
> > not reading it, but still is is applicable to it, right?
> 
> Yes it is still applicable but we never read it so it is ok to override.
> If you see Richard W's original patch for enabling posted mode it is to
> reduce overhead of programming timers, specifically the clock-events
> timer which is program very often.
> 
> For other timers, we do not know how they will be used and so by default
> we disable posted mode as this is safe.
> 
> > 3. Why can't we just simply Add this flag to hwmod_data file and read it
> > back in omap_timer_init() and omap_dm_timer_init_one(). Wouldn't that be
> > a good approach to handle it?
> 
> It could be done in this case, but typically I have not seen errata
> flags added to HWMOD. 

We are already using it, look at I2C, MMC. And in some cases, we have done 
indirect implementation of errata. So I still feel, we should leverage hwmod 
info for this, and anyway going forward DT will replace it.

Thanks,
Vaibhav

> One limitation you would have with HWMOD is if an
> erratum is only specific to a certain revision of the device. In this
> case it is not and so it could work.
> 
> In general I think that having errata described by HWMOD would be a good
> thing, but if think that should be a longer term goal with agreement
> from Benoit and add some general errata helpers to HWMOD.
> 
> Cheers
> Jon
> 

