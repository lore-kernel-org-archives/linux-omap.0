From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/3] OMAP3: Only update pm-counters when needed
Date: Thu, 29 Oct 2009 16:07:43 -0700
Message-ID: <87k4ydx0hs.fsf@deeprootsystems.com>
References: <1256125881-12441-1-git-send-email-kalle.jokiniemi@digia.com>
	<1256125881-12441-2-git-send-email-kalle.jokiniemi@digia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:51827 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754823AbZJ2XHl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Oct 2009 19:07:41 -0400
Received: by pwj9 with SMTP id 9so333964pwj.21
        for <linux-omap@vger.kernel.org>; Thu, 29 Oct 2009 16:07:46 -0700 (PDT)
In-Reply-To: <1256125881-12441-2-git-send-email-kalle.jokiniemi@digia.com> (Kalle Jokiniemi's message of "Wed\, 21 Oct 2009 14\:51\:19 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@digia.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>

Kalle Jokiniemi <kalle.jokiniemi@digia.com> writes:

> From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
>
> The biggest source of latency in idle loop (omap_sram_idle
> function) comes from updating the state counters for each
> power domain. The two purposes of these counters are to
> provide debug data in debugfs, and to keep track of context
> losses occurring during idle transitions (off mode counters).
>
> I created new debugfs interface "enable_count" for
> enabling the "count" interface, which exposes the debug
> part of these counters. The counters are not updated
> anymore for CORE ON idle transitions, when the count
> interface is disabled. For deeper CORE states, counters
> are still updated to preserve context loss tracking.
>
> This change decreases C1/C2 state latency over 100us at
> OPP2.
>
> Signed-off-by: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>

I'm not opposed to this patch in principle, but I wonder if we might
be able to get rid of most of this delay with some optimizations in
the powerdomain code.

I'm guessing it's the reads from the PRCM that are causing such a
delay since otherwise, that should be a pretty fast codepath.  In this
case there are reads of PWRSTST and reads and writes of PREPWRSTST for
each powerdomain.

Paul has mentioned a few times the idea of having some powerdomain
enhancements that cache a copy of some of these registers so they
don't have to always be read/written from the PRCM, although I'm not
sure without digging some more if that makes sense for the PWRST and
PREPWRST registers.

I think we could also be a bit smarter about doing the transition
counters for every powerdomain.  During most of the transitions, we
don't actually expect a transition for many of the powerdomains
because a transition hasn't been programmed.  Maybe we can skip the
PRM reads in those cases.

Anyways, some comments on the actual patch below...


> ---
>  arch/arm/mach-omap2/pm-debug.c |   51 ++++++++++++++++++++++++++++++++++++++-
>  arch/arm/mach-omap2/pm.h       |    2 +
>  arch/arm/mach-omap2/pm34xx.c   |   12 +++++----
>  3 files changed, 58 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
> index 5aac64f..76c2696 100644
> --- a/arch/arm/mach-omap2/pm-debug.c
> +++ b/arch/arm/mach-omap2/pm-debug.c
> @@ -37,6 +37,9 @@
>  #include "prm-regbits-34xx.h"
>  
>  int omap2_pm_debug;
> +static int pm_dbg_count_active;
> +static struct dentry *de_pm_debug_count;
> +static struct dentry *de_pm_debug;
>  
>  #define DUMP_PRM_MOD_REG(mod, reg)    \
>  	regs[reg_count].name = #mod "." #reg; \
> @@ -327,6 +330,11 @@ int pm_dbg_regset_save(int reg_set)
>  	return 0;
>  }
>  
> +int pm_dbg_count_is_active(void)
> +{
> +	return pm_dbg_count_active;
> +}
> +
>  static const char pwrdm_state_names[][4] = {
>  	"OFF",
>  	"RET",
> @@ -460,6 +468,40 @@ static const struct file_operations debug_reg_fops = {
>  	.release        = single_release,
>  };
>  
> +static int pm_dbg_count_enable_get(void *data, u64 *val)
> +{
> +	*val = pm_dbg_count_active;
> +	return 0;
> +}
> +
> +static int pm_dbg_count_enable_set(void *data, u64 val)
> +{
> +	if (val > 1) {
> +		printk(KERN_ERR "Invalid value! 1 to enable, 0 to disable\n");
> +		return -EINVAL;
> +	}
> +
> +	if (val == 1 && !pm_dbg_count_active) {
> +		de_pm_debug_count = debugfs_create_file("count", S_IRUGO,
> +			de_pm_debug, (void *)DEBUG_FILE_COUNTERS, &debug_fops);
> +
> +		if (de_pm_debug_count == NULL) {
> +			printk(KERN_ERR "Error: could not create debugfs "
> +					"entry\n");
> +			return -ENOMEM;
> +		}
> +		pm_dbg_count_active = 1;
> +	} else if (val == 0 && pm_dbg_count_active) {
> +		debugfs_remove(de_pm_debug_count);
> +		de_pm_debug_count = NULL;
> +		pm_dbg_count_active = 0;
> +	}
> +	return 0;
> +}
> +
> +DEFINE_SIMPLE_ATTRIBUTE(enable_count_fops, pm_dbg_count_enable_get,
> +				pm_dbg_count_enable_set, "%llu\n");
> +
>  int pm_dbg_regset_init(int reg_set)
>  {
>  	char name[2];
> @@ -576,12 +618,17 @@ static int __init pm_dbg_init(void)
>  		return -ENODEV;
>  	}
>  
> +	pm_dbg_count_active = 0;
> +
>  	d = debugfs_create_dir("pm_debug", NULL);
>  	if (IS_ERR(d))
>  		return PTR_ERR(d);
> +	de_pm_debug = d;
> +
> +	(void) debugfs_create_file("enable_count", S_IRUGO |
> +				S_IWUGO, d, &pm_dbg_count_active,
> +				&enable_count_fops);
>  
> -	(void) debugfs_create_file("count", S_IRUGO,
> -		d, (void *)DEBUG_FILE_COUNTERS, &debug_fops);
>  	(void) debugfs_create_file("time", S_IRUGO,
>  		d, (void *)DEBUG_FILE_TIMERS, &debug_fops);
>  
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index f8d11a2..3f0202b 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -63,12 +63,14 @@ extern int omap2_pm_debug;
>  extern void pm_dbg_update_time(struct powerdomain *pwrdm, int prev);
>  extern int pm_dbg_regset_save(int reg_set);
>  extern int pm_dbg_regset_init(int reg_set);
> +extern int pm_dbg_count_is_active(void);
>  #else
>  #define omap2_pm_dump(mode, resume, us)		do {} while (0);
>  #define omap2_pm_debug				0
>  #define pm_dbg_update_time(pwrdm, prev) do {} while (0);
>  #define pm_dbg_regset_save(reg_set) do {} while (0);
>  #define pm_dbg_regset_init(reg_set) do {} while (0);
> +#define pm_dbg_count_is_active()		0
>  #endif /* CONFIG_PM_DEBUG */
>  
>  extern void omap24xx_idle_loop_suspend(void);
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 01260ec..237c819 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -378,15 +378,17 @@ void omap_sram_idle(void)
>  		return;
>  	}
>  
> -	pwrdm_pre_transition();
> +	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
> +	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
> +
> +	if (pm_dbg_count_is_active() || (core_next_state != PWRDM_POWER_ON))
> +		pwrdm_pre_transition();

I'm getting concerned abou tall the special case checking etc. that
we're doing inside omap_sram_idle().  It's starting to feel a bit
cluttered.

I think I'd rather see this checking moved into the powerdomain code
itself.

>  	/* NEON control */
>  	if (pwrdm_read_pwrst(neon_pwrdm) == PWRDM_POWER_ON)
>  		pwrdm_set_next_pwrst(neon_pwrdm, mpu_next_state);
>  
>  	/* PER */
> -	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
> -	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
>  	if (per_next_state < PWRDM_POWER_ON) {
>  		omap_uart_prepare_idle(2);
>  		omap2_gpio_prepare_for_idle(per_next_state);
> @@ -505,8 +507,8 @@ void omap_sram_idle(void)
>  		omap3_disable_io_chain();
>  	}
>  
> -
> -	pwrdm_post_transition();
> +	if (pm_dbg_count_is_active() || (core_next_state != PWRDM_POWER_ON))
> +		pwrdm_post_transition();
>  
>  	omap2_clkdm_allow_idle(mpu_pwrdm->pwrdm_clkdms[0]);
>  }
> -- 
> 1.5.4.3
