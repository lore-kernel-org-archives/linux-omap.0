From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH-V3 3/3] ARM: OMAP: Make OMAP clocksource source selection using kernel param
Date: Thu, 19 Apr 2012 17:34:20 -0700
Message-ID: <87k41bqm0j.fsf@ti.com>
References: <1334309947-25214-1-git-send-email-hvaibhav@ti.com>
	<1334309947-25214-4-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:44801 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754554Ab2DTAeX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Apr 2012 20:34:23 -0400
Received: by pbcuo5 with SMTP id uo5so422607pbc.18
        for <linux-omap@vger.kernel.org>; Thu, 19 Apr 2012 17:34:21 -0700 (PDT)
In-Reply-To: <1334309947-25214-4-git-send-email-hvaibhav@ti.com> (Vaibhav
	Hiremath's message of "Fri, 13 Apr 2012 15:09:07 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, rnayak@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Ming Lei <tom.leiming@gmail.com>

Vaibhav Hiremath <hvaibhav@ti.com> writes:

> Current OMAP code supports couple of clocksource options based
> on compilation flag (CONFIG_OMAP_32K_TIMER). The 32KHz sync-timer
> and a gptimer which can run on 32KHz or system clock (e.g 38.4 MHz).
> So there can be 3 options -
>
> 1. 32KHz sync-timer
> 2. Sys_clock based (e.g 13/19.2/26/38.4 MHz) gptimer
> 3. 32KHz based gptimer.
>
> The optional gptimer based clocksource was added so that it can
> give the high precision than sync-timer, so expected usage was 2
> and not 3.
> Unfortunately option 2, clocksource doesn't meet the requirement of
> free-running clock as per clocksource need. It stops in low power states
> when sys_clock is cut. That makes gptimer based clocksource option
> useless for OMAP2/3/4 devices with sys_clock as a clock input.
> Option 3 will still work but it is no better than 32K sync-timer
> based clocksource.
>
> So ideally we can kill the gptimer based clocksource option but there
> are some OMAP based derivative SoCs like AM33XX which doesn't have
> 32K sync-timer hardware IP and need to fallback on 32KHz based gptimer
> clocksource.
> Considering above, make sync-timer and gptimer clocksource runtime
> selectable so that both OMAP and AMXXXX continue to use the same code.
>
> Also, in order to precisely configure/setup sched_clock for given
> clocksource, decision has to be made early enough in boot sequence.
>
> So, the solution is,
>
> Use kernel parameter ("clocksource=") to override
> default 32k_sync-timer, in addition to this, we also use hwmod database
> lookup mechanism, through which at run-time we can identify availability
> of 32k-sync timer on the device, else fall back to gptimer.
>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> CC: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Cc: Ming Lei <tom.leiming@gmail.com>

[...]

> @@ -285,7 +273,32 @@ static u32 notrace dmtimer_read_sched_clock(void)
>  }
>
>  /* Setup free-running counter for clocksource */
> -static void __init omap2_gp_clocksource_init(int gptimer_id,
> +static int __init omap2_sync32k_clocksource_init(void)
> +{
> +	int res;
> +	u32 pbase, size;
> +	struct omap_hwmod *oh;
> +	struct resource mem_rsrc;

minor nit: personaly, I find 'rsrc' hard on the eyes.  I suggest just
using 'res' for this variable name.

> +	const char *oh_name = "counter_32k";
> +	oh = omap_hwmod_lookup(oh_name);
> +	if (!oh || oh->slaves_cnt == 0)
> +		return -ENODEV;
> +
> +	res = omap_hwmod_get_resource_byname(oh, IORESOURCE_MEM,
> +				NULL, &mem_rsrc);
> +	if (!res) {
> +		pbase = mem_rsrc.start + OMAP2_32KSYNCNT_CR_OFF;
> +		size = mem_rsrc.end - mem_rsrc.start;

This should be (end - start + 1), but instead, use the resource_size()
helper should be used for this.

Also note that because you're adding an offset of 0x10 to the start, the
ioremap later is actually mapping 0x10 past the end.  More on the base
address later...

> +
> +		res = omap_init_clocksource_32k(pbase, size);
> +	}
> +
> +	WARN_ON(res);

Just use pr_warn() here instead of WARN_ON() which will dump a full
backtrace, and isn't necessary.

[...]

> @@ -510,3 +541,28 @@ static int __init omap2_dm_timer_init(void)
>  	return 0;
>  }
>  arch_initcall(omap2_dm_timer_init);
> +
> +/**
> + * omap2_override_clocksource - clocksource override with user configuration
> + *
> + * Allows user to override default clocksource, using kernel parameter
> + *   clocksource="gp timer"
> + *
> + * Note that, here we are using same standard kernel parameter "clocksource=",
> + * and not introducing any OMAP specific interface.
> + */

Are you sure the clocksource= setup function is getting called in
kernel/time/clocksource.c as well?  IOW, do both the generic one and
this one get called?

To be honest, I still don't like this.  The clocksource core will
already sets the right clocksource, and this is duplicating that.

I do see why you're doing this though because both clocksource init
functions call setup_sched_clock().

Ideally, we would just wait to call setup_sched_clock() until later
(possibly in a late_initcall) after the clocksource selection is
decided.   I'm not sure we have the right hooks to do that though.

Possibly by setting a flag in the ->enable method of each clocksource,
and checking that in a late_initcall before calling setup_sched_clock.
That would be easy for the GP timer, but the 32k timer is setting up an
mmio clocksource, so we don't have an ->enable method.

Any other ideas?

[...]

> diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
> index 5068fe5..bd4a3fd 100644
> --- a/arch/arm/plat-omap/counter_32k.c
> +++ b/arch/arm/plat-omap/counter_32k.c
> @@ -35,8 +35,6 @@
>   */
>  static void __iomem *timer_32k_base;
>
> -#define OMAP16XX_TIMER_32K_SYNCHRONIZED		0xfffbc410
> -
>  static u32 notrace omap_32k_read_sched_clock(void)
>  {
>  	return timer_32k_base ? __raw_readl(timer_32k_base) : 0;
> @@ -68,54 +66,43 @@ void read_persistent_clock(struct timespec *ts)
>  	*ts = *tsp;
>  }
>
> -int __init omap_init_clocksource_32k(void)
> +int __init omap_init_clocksource_32k(u32 pbase, unsigned long size)

Now that this takes some arguments, this function wants some kerneldoc.

In particular, you should document that 'pbase' is the address of the
counter register, not the base of the IP.

That being said, I think the pbase passed in should probably be the base
of the IP register, not the address of the counter register. It seems to
me that it's at offset 0x10 on all SoCs anyways.

Doing that will also ensure that the ioremap'd range covers the whole
IP, and not from the counter register to 0x10 past the end.

Kevin
