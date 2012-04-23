From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V3 3/3] ARM: OMAP: Make OMAP clocksource source
 selection using kernel param
Date: Mon, 23 Apr 2012 17:35:19 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83E9F9AD0@DBDE01.ent.ti.com>
References: <1334309947-25214-1-git-send-email-hvaibhav@ti.com>
	<1334309947-25214-4-git-send-email-hvaibhav@ti.com> <87k41bqm0j.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44262 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753064Ab2DWRfa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Apr 2012 13:35:30 -0400
In-Reply-To: <87k41bqm0j.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "tony@atomide.com" <tony@atomide.com>, "paul@pwsan.com" <paul@pwsan.com>, "Nayak, Rajendra" <rnayak@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Balbi, Felipe" <balbi@ti.com>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, Ming Lei <tom.leiming@gmail.com>

On Fri, Apr 20, 2012 at 06:04:20, Hilman, Kevin wrote:
> Vaibhav Hiremath <hvaibhav@ti.com> writes:
> 

Thanks Kevin for the review comments and sorry for delayed response... 
Please find my response in-lined below -


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
> > Also, in order to precisely configure/setup sched_clock for given
> > clocksource, decision has to be made early enough in boot sequence.
> >
> > So, the solution is,
> >
> > Use kernel parameter ("clocksource=") to override
> > default 32k_sync-timer, in addition to this, we also use hwmod database
> > lookup mechanism, through which at run-time we can identify availability
> > of 32k-sync timer on the device, else fall back to gptimer.
> >
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > CC: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Cc: Benoit Cousson <b-cousson@ti.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> > Cc: Ming Lei <tom.leiming@gmail.com>
> 
> [...]
> 
> > @@ -285,7 +273,32 @@ static u32 notrace dmtimer_read_sched_clock(void)
> >  }
> >
> >  /* Setup free-running counter for clocksource */
> > -static void __init omap2_gp_clocksource_init(int gptimer_id,
> > +static int __init omap2_sync32k_clocksource_init(void)
> > +{
> > +	int res;
> > +	u32 pbase, size;
> > +	struct omap_hwmod *oh;
> > +	struct resource mem_rsrc;
> 
> minor nit: personaly, I find 'rsrc' hard on the eyes.  I suggest just
> using 'res' for this variable name.
> 

Ok, I will change it accordingly.


> > +	const char *oh_name = "counter_32k";
> > +	oh = omap_hwmod_lookup(oh_name);
> > +	if (!oh || oh->slaves_cnt == 0)
> > +		return -ENODEV;
> > +
> > +	res = omap_hwmod_get_resource_byname(oh, IORESOURCE_MEM,
> > +				NULL, &mem_rsrc);
> > +	if (!res) {
> > +		pbase = mem_rsrc.start + OMAP2_32KSYNCNT_CR_OFF;
> > +		size = mem_rsrc.end - mem_rsrc.start;
> 
> This should be (end - start + 1), but instead, use the resource_size()
> helper should be used for this.
> 

Good point. I will change this for resource_size().


> Also note that because you're adding an offset of 0x10 to the start, the
> ioremap later is actually mapping 0x10 past the end.  More on the base
> address later...
> 

Comment on top of this code will enough, isn't it?


> > +
> > +		res = omap_init_clocksource_32k(pbase, size);
> > +	}
> > +
> > +	WARN_ON(res);
> 
> Just use pr_warn() here instead of WARN_ON() which will dump a full
> backtrace, and isn't necessary.
> 

Ok, will change it.

> [...]
> 
> > @@ -510,3 +541,28 @@ static int __init omap2_dm_timer_init(void)
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
> 
> Are you sure the clocksource= setup function is getting called in
> kernel/time/clocksource.c as well?  IOW, do both the generic one and
> this one get called?
> 

Yes, 100%.

> To be honest, I still don't like this.  The clocksource core will
> already sets the right clocksource, and this is duplicating that.
> 
> I do see why you're doing this though because both clocksource init
> functions call setup_sched_clock().
> 
> Ideally, we would just wait to call setup_sched_clock() until later
> (possibly in a late_initcall) after the clocksource selection is
> decided.   I'm not sure we have the right hooks to do that though.
> 
> Possibly by setting a flag in the ->enable method of each clocksource,
> and checking that in a late_initcall before calling setup_sched_clock.
> That would be easy for the GP timer, but the 32k timer is setting up an
> mmio clocksource, so we don't have an ->enable method.
> 
> Any other ideas?
> 

Based on all the discussion we had on this, I believe we do not have any 
other option here; this is the only solution we could come up with.


> [...]
> 
> > diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
> > index 5068fe5..bd4a3fd 100644
> > --- a/arch/arm/plat-omap/counter_32k.c
> > +++ b/arch/arm/plat-omap/counter_32k.c
> > @@ -35,8 +35,6 @@
> >   */
> >  static void __iomem *timer_32k_base;
> >
> > -#define OMAP16XX_TIMER_32K_SYNCHRONIZED		0xfffbc410
> > -
> >  static u32 notrace omap_32k_read_sched_clock(void)
> >  {
> >  	return timer_32k_base ? __raw_readl(timer_32k_base) : 0;
> > @@ -68,54 +66,43 @@ void read_persistent_clock(struct timespec *ts)
> >  	*ts = *tsp;
> >  }
> >
> > -int __init omap_init_clocksource_32k(void)
> > +int __init omap_init_clocksource_32k(u32 pbase, unsigned long size)
> 
> Now that this takes some arguments, this function wants some kerneldoc.
> 

Should I create new documentation inside Documentation/arm/OMAP/
with name "counter_32k"?

> In particular, you should document that 'pbase' is the address of the
> counter register, not the base of the IP.
> 
> That being said, I think the pbase passed in should probably be the base
> of the IP register, not the address of the counter register. It seems to
> me that it's at offset 0x10 on all SoCs anyways.
> 
> Doing that will also ensure that the ioremap'd range covers the whole
> IP, and not from the counter register to 0x10 past the end.
> 

Yeah, you are right, I can get rid of this offset and move it to 
counter_32k.c file.

Thanks,
Vaibhav

> Kevin
> 

