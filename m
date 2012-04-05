From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V2 3/3] ARM: OMAP: Make OMAP clocksource source
 selection runtime
Date: Thu, 5 Apr 2012 14:46:51 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A831848AC2@DBDE01.ent.ti.com>
References: <1333115655-28530-1-git-send-email-hvaibhav@ti.com>
 <1333115655-28530-4-git-send-email-hvaibhav@ti.com> <4F794D8B.6030703@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50710 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753208Ab2DEOrD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Apr 2012 10:47:03 -0400
In-Reply-To: <4F794D8B.6030703@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "tom.leiming@gmail.com" <tom.leiming@gmail.com>, "Balbi, Felipe" <balbi@ti.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>

On Mon, Apr 02, 2012 at 12:26:11, Shilimkar, Santosh wrote:
> On Friday 30 March 2012 07:24 PM, Vaibhav Hiremath wrote:
> > Current OMAP code supports couple of clocksource options based
> > on compilation flag (CONFIG_OMAP_32K_TIMER). The 32KHz sync-timer
> > and a gptimer which can run on 32KHz or system clock (e.g 38.4 MHz).
> > So there can be 3 options -
> > 
> > 1. 32KHz sync-timer
> > 2. Sys_clock based (e.g 13/19.2/26/38.4 MHz) gptimer
> > 3. 32KHz based gptimer.
> > 
> > The optional gptimer based clocksource was added so that it can
> > give the high precision than sync-timer, so expected usage was 2
> > and not 3.
> > Unfortunately option 2, clocksource doesn't meet the requirement of
> > free-running clock as per clocksource need. It stops in low power states
> > when sys_clock is cut. That makes gptimer based clocksource option
> > useless for OMAP2/3/4 devices with sys_clock as a clock input.
> > Option 3 will still work but it is no better than 32K sync-timer
> > based clocksource.
> > 
> > So ideally we can kill the gptimer based clocksource option but there
> > are some OMAP based derivative SoCs like AM33XX which doesn't have
> > 32K sync-timer hardware IP and need to fallback on 32KHz based gptimer
> > clocksource.
> > Considering above, make sync-timer and gptimer clocksource runtime
> > selectable so that both OMAP and AMXXXX continue to use the same code.
> > 
> > Use hwmod database lookup mechanism, through which at run-time
> > we can identify availability of 32k-sync timer on the device,
> > else fall back to gptimer.
> > 
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > CC: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Cc: Benoit Cousson <b-cousson@ti.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> > Cc: Ming Lei <tom.leiming@gmail.com>
> > ---
> 
> Thanks for the change log update Vaibhav.
> Some more comments.
> 
> 
> >  arch/arm/mach-omap1/timer32k.c           |    6 ++-
> >  arch/arm/mach-omap2/timer.c              |   45 +++++++++-------
> >  arch/arm/plat-omap/counter_32k.c         |   86 ++++++++++++-----------------
> >  arch/arm/plat-omap/include/plat/common.h |    2 +-
> >  4 files changed, 68 insertions(+), 71 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap1/timer32k.c b/arch/arm/mach-omap1/timer32k.c
> > index a2e6d07..3f96a00 100644
> > --- a/arch/arm/mach-omap1/timer32k.c
> > +++ b/arch/arm/mach-omap1/timer32k.c
> > @@ -72,6 +72,7 @@
> > 
> >  /* 16xx specific defines */
> >  #define OMAP1_32K_TIMER_BASE		0xfffb9000
> > +#define OMAP1_32KSYNC_TIMER_BASE	0xfffbc410
> Shouldn't you just update OMAP1_32K_TIMER_BASE ?
> 

No, they are different. First one is normal timer base address
and next one is 32k-sync timer base address.

> >  #define OMAP1_32K_TIMER_CR		0x08
> >  #define OMAP1_32K_TIMER_TVR		0x00
> >  #define OMAP1_32K_TIMER_TCR		0x04
> > @@ -185,7 +186,10 @@ static __init void omap_init_32k_timer(void)
> >   */
> >  bool __init omap_32k_timer_init(void)
> >  {
> > -	omap_init_clocksource_32k();
> > +	u32 pbase;
> > +
> > +	pbase = cpu_is_omap16xx() ? OMAP1_32KSYNC_TIMER_BASE : NULL;
> > +	omap_init_clocksource_32k(pbase, SZ_1K);
> If pbase is NULL, you might not want to call the init.
> 

First check we do in _init function is, check for NULL, so you
can ignore it.

> >  	omap_init_32k_timer();
> > 
> >  	return true;
> > diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> > index 5c9acea..f35db1a 100644
> > --- a/arch/arm/mach-omap2/timer.c
> > +++ b/arch/arm/mach-omap2/timer.c
> > @@ -234,21 +234,6 @@ static void __init omap2_gp_clockevent_init(int gptimer_id,
> >  }
> > 
> >  /* Clocksource code */
> > -
> > -#ifdef CONFIG_OMAP_32K_TIMER
> > -/*
> > - * When 32k-timer is enabled, don't use GPTimer for clocksource
> > - * instead, just leave default clocksource which uses the 32k
> > - * sync counter.  See clocksource setup in plat-omap/counter_32k.c
> > - */
> > -
> > -static void __init omap2_gp_clocksource_init(int unused, const char *dummy)
> > -{
> > -	omap_init_clocksource_32k();
> > -}
> > -
> > -#else
> > -
> >  static struct omap_dm_timer clksrc;
> > 
> >  /*
> > @@ -280,13 +265,33 @@ static void __init omap2_gp_clocksource_init(int gptimer_id,
> >  						const char *fck_source)
> >  {
> >  	int res;
> > +	struct omap_hwmod *oh;
> > +	const char *oh_name = "counter_32k";
> > +
> > +	/*
> > +	 * First check for availability for 32k-sync timer.
> > +	 *
> > +	 * In case of failure in finding 32k_counter module or
> > +	 * registering it as clocksource, execution will fallback to
> > +	 * gp-timer.
> > +	 */
> > +	oh = omap_hwmod_lookup(oh_name);
> > +	if (oh && oh->slaves_cnt != 0) {
> > +		u32 pbase;
> > +		unsigned long size;
> > +
> > +		pbase = oh->slaves[0]->addr->pa_start + 0x10;
> Don't hardcode the offset here. This is error prone when the IP
> changes so use the register define.
> 

Ok, I will define macro for this and use it.

Thanks,
Vaibhav

