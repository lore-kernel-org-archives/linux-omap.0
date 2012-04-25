From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V4 3/3] ARM: OMAP: Make OMAP clocksource source
 selection using kernel param
Date: Wed, 25 Apr 2012 08:40:42 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83E9FD4DC@DBDE01.ent.ti.com>
References: <1335260749-25877-1-git-send-email-hvaibhav@ti.com>
 <1335260749-25877-4-git-send-email-hvaibhav@ti.com>
 <20120424162016.GK3739@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46270 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419Ab2DYIo0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Apr 2012 04:44:26 -0400
In-Reply-To: <20120424162016.GK3739@atomide.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Hilman, Kevin" <khilman@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Balbi, Felipe" <balbi@ti.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, Ming Lei <tom.leiming@gmail.com>

On Tue, Apr 24, 2012 at 21:50:16, Tony Lindgren wrote:

Thanks Tony for review comments, my response in-lined below -

> Hi,
> 
> * Vaibhav Hiremath <hvaibhav@ti.com> [120424 02:54]:
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
> 
> For some cases sys clock based timer is still valid if you don't
> care about PM. In that case deeper idle states need to be disabled,
> not the timer as discussed earlier. Please update the comments accordingly.
>  

Ok, I will add below statement, 

"Also, in order to use option 2, deeper idle stated MUST be disabled."


> > So ideally we can kill the gptimer based clocksource option but there
> > are some OMAP based derivative SoCs like AM33XX which doesn't have
> > 32K sync-timer hardware IP and need to fallback on 32KHz based gptimer
> > clocksource.
> 
> Maybe just say: "We must support both sync timer and gptimer based
> clocksource as some AM33XX hardware does not have the sync timer."
> 

Ok, I can change the description accordingly.

> > Considering above, make sync-timer and gptimer clocksource runtime
> > selectable so that both OMAP and AMXXXX continue to use the same code.
> > 
> > Also, in order to precisely configure/setup sched_clock for given
> > clocksource, decision has to be made early enough in boot sequence.
> > 
> > So, the solution is,
> > 
> > Use kernel parameter ("clocksource=") to override
> 
> Maybe say: "Use standard kernel parameter ("clocksource=")..."
> 

Ditto, I will change the description accordingly.

> > --- a/arch/arm/mach-omap1/timer32k.c
> > +++ b/arch/arm/mach-omap1/timer32k.c
> > @@ -71,6 +71,7 @@
> > 
> >  /* 16xx specific defines */
> >  #define OMAP1_32K_TIMER_BASE		0xfffb9000
> > +#define OMAP1_32KSYNC_TIMER_BASE	0xfffbc400
> >  #define OMAP1_32K_TIMER_CR		0x08
> >  #define OMAP1_32K_TIMER_TVR		0x00
> >  #define OMAP1_32K_TIMER_TCR		0x04
> > @@ -184,7 +185,10 @@ static __init void omap_init_32k_timer(void)
> >   */
> >  bool __init omap_32k_timer_init(void)
> >  {
> > -	omap_init_clocksource_32k();
> > +	u32 pbase;
> > +
> > +	pbase = cpu_is_omap16xx() ? OMAP1_32KSYNC_TIMER_BASE : NULL;
> > +	omap_init_clocksource_32k(pbase, SZ_1K);
> >  	omap_init_32k_timer();
> > 
> >  	return true;
> 
> Has this patch been tested on omap1?
> 

I do not have omap1 board with me, so I can not test it. If somebody can 
provide some help here, that would be really great?

> 
> > --- a/arch/arm/mach-omap2/timer.c
> > +++ b/arch/arm/mach-omap2/timer.c
> > @@ -510,3 +540,28 @@ static int __init omap2_dm_timer_init(void)
> >  	return 0;
> >  }
> >  arch_initcall(omap2_dm_timer_init);
> > +
> > +/**
> > + * omap2_override_clocksource - clocksource override with user configuration
> > + *
> > + * Allows user to override default clocksource, using kernel parameter
> > + *   clocksource="gp timer"
> > + *
> > + * Note that, here we are using same standard kernel parameter "clocksource=",
> > + * and not introducing any OMAP specific interface.
> > + */
> > +static int __init omap2_override_clocksource(char *str)
> > +{
> > +	if (!str)
> > +		return 0;
> > +	/*
> > +	 * For OMAP architecture, we only have two options
> > +	 *    - sync_32k (default)
> > +	 *    - gp timer
> > +	 */
> > +	if (!strcmp(str, "gp timer"))
> > +		use_gptimer_clksrc = true;
> > +
> > +	return 0;
> > +}
> > +early_param("clocksource", omap2_override_clocksource);
> 
> Should say "For omap2plus architectures" and should say three options.
> If the sys clock based timer is not currently supported, please mention
> that in the comments.
> 

"gp timer" above is nothing but, sys_clock based gptimer option only. May be I should add the source in bracket or something?
Like,
	*    - sync_32k (default)
	*    - gp timer (sys_clock)

Thanks,
Vaibhav

> Regards,
> 
> Tony
> 

