From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] perf: add OMAP support for the new power events
Date: Thu, 10 Feb 2011 13:02:19 -0800
Message-ID: <87oc6jiox0.fsf@ti.com>
References: <1295878857-8983-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:52215 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751296Ab1BJVCX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 Feb 2011 16:02:23 -0500
Received: by mail-iy0-f177.google.com with SMTP id 42so1715359iyh.36
        for <linux-omap@vger.kernel.org>; Thu, 10 Feb 2011 13:02:22 -0800 (PST)
In-Reply-To: <1295878857-8983-1-git-send-email-j-pihet@ti.com> (jean pihet's
	message of "Mon, 24 Jan 2011 15:20:57 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: Thomas Renninger <trenn@suse.de>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

jean.pihet@newoldbits.com writes:

> From: Jean Pihet <j-pihet@ti.com>
>
> The patch adds the new power management trace points for
> the OMAP architecture.
>
> The trace points are for:
> - default idle handler. Since the cpuidle framework is
>   instrumented in the generic way there is no need to
>   add trace points in the OMAP specific cpuidle handler;
> - cpufreq (DVFS),
> - SoC clocks changes (enable, disable, set_rate),
> - change of power domains next power states.
>
> Tested on OMAP3 with suspend/resume, cpuidle, basic DVFS
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

Looks good to me.  Please post one more time with linux-arm-kernel in Cc.
After that, unless there are objections, I'll queue for 2.6.39.

Kevin

> ---
>  arch/arm/mach-omap2/clock.c       |    8 +++++++-
>  arch/arm/mach-omap2/pm34xx.c      |    7 +++++++
>  arch/arm/mach-omap2/powerdomain.c |    8 +++++++-
>  3 files changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
> index 2a2f152..72af75d 100644
> --- a/arch/arm/mach-omap2/clock.c
> +++ b/arch/arm/mach-omap2/clock.c
> @@ -22,7 +22,9 @@
>  #include <linux/clk.h>
>  #include <linux/io.h>
>  #include <linux/bitops.h>
> +#include <trace/events/power.h>
>  
> +#include <asm/cpu.h>
>  #include <plat/clock.h>
>  #include "clockdomain.h"
>  #include <plat/cpu.h>
> @@ -261,6 +263,7 @@ void omap2_clk_disable(struct clk *clk)
>  
>  	pr_debug("clock: %s: disabling in hardware\n", clk->name);
>  
> +	trace_clock_disable(clk->name, 0, smp_processor_id());
>  	clk->ops->disable(clk);
>  
>  	if (clk->clkdm)
> @@ -312,6 +315,7 @@ int omap2_clk_enable(struct clk *clk)
>  		}
>  	}
>  
> +	trace_clock_enable(clk->name, 1, smp_processor_id());
>  	ret = clk->ops->enable(clk);
>  	if (ret) {
>  		WARN(1, "clock: %s: could not enable: %d\n", clk->name, ret);
> @@ -349,8 +353,10 @@ int omap2_clk_set_rate(struct clk *clk, unsigned long rate)
>  	pr_debug("clock: set_rate for clock %s to rate %ld\n", clk->name, rate);
>  
>  	/* dpll_ck, core_ck, virt_prcm_set; plus all clksel clocks */
> -	if (clk->set_rate)
> +	if (clk->set_rate) {
> +		trace_clock_set_rate(clk->name, rate, smp_processor_id());
>  		ret = clk->set_rate(clk, rate);
> +	}
>  
>  	return ret;
>  }
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 8cbbead..7c5e0ee 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -29,6 +29,7 @@
>  #include <linux/delay.h>
>  #include <linux/slab.h>
>  #include <linux/console.h>
> +#include <trace/events/power.h>
>  
>  #include <plat/sram.h>
>  #include "clockdomain.h"
> @@ -518,8 +519,14 @@ static void omap3_pm_idle(void)
>  	if (omap_irq_pending() || need_resched())
>  		goto out;
>  
> +	trace_power_start(POWER_CSTATE, 1, smp_processor_id());
> +	trace_cpu_idle(1, smp_processor_id());
> +
>  	omap_sram_idle();
>  
> +	trace_power_end(smp_processor_id());
> +	trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
> +
>  out:
>  	local_fiq_enable();
>  	local_irq_enable();
> diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
> index eaed0df..e1feb50 100644
> --- a/arch/arm/mach-omap2/powerdomain.c
> +++ b/arch/arm/mach-omap2/powerdomain.c
> @@ -19,12 +19,15 @@
>  #include <linux/list.h>
>  #include <linux/errno.h>
>  #include <linux/string.h>
> +#include <trace/events/power.h>
> +
>  #include "cm2xxx_3xxx.h"
>  #include "prcm44xx.h"
>  #include "cm44xx.h"
>  #include "prm2xxx_3xxx.h"
>  #include "prm44xx.h"
>  
> +#include <asm/cpu.h>
>  #include <plat/cpu.h>
>  #include "powerdomain.h"
>  #include "clockdomain.h"
> @@ -406,8 +409,11 @@ int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
>  	pr_debug("powerdomain: setting next powerstate for %s to %0x\n",
>  		 pwrdm->name, pwrst);
>  
> -	if (arch_pwrdm && arch_pwrdm->pwrdm_set_next_pwrst)
> +	if (arch_pwrdm && arch_pwrdm->pwrdm_set_next_pwrst) {
> +		trace_power_domain_target(pwrdm->name, pwrst,
> +					  smp_processor_id());
>  		ret = arch_pwrdm->pwrdm_set_next_pwrst(pwrdm, pwrst);
> +	}
>  
>  	return ret;
>  }
