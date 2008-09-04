From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 08/12] update sram restore function
Date: Thu, 04 Sep 2008 12:21:09 +0300
Message-ID: <87tzcwz2pm.fsf@deeprootsystems.com>
References: <62087.192.168.10.89.1220276488.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:9938 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755101AbYIDJVQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Sep 2008 05:21:16 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3191636wfd.4
        for <linux-omap@vger.kernel.org>; Thu, 04 Sep 2008 02:21:16 -0700 (PDT)
In-Reply-To: <62087.192.168.10.89.1220276488.squirrel@dbdmail.itg.ti.com> (Rajendra Nayak's message of "Mon\, 1 Sep 2008 19\:11\:28 +0530 \(IST\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

"Rajendra Nayak" <rnayak@ti.com> writes:

> This patch updates the context restore function for sram
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/pm34xx.c |   12 ++++++++----
>  arch/arm/plat-omap/sram.c    |   10 +++++++---
>  2 files changed, 15 insertions(+), 7 deletions(-)
>
> Index: linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/pm34xx.c	2008-09-01
> 18:11:35.000000000 +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/pm34xx.c	2008-09-01 18:11:54.000000000
> +0530
> @@ -50,7 +50,7 @@ struct power_state {
>
>  static LIST_HEAD(pwrst_list);
>
> -static void (*_omap_sram_idle)(u32 *addr, int save_state);
> +void (*_omap_sram_idle)(u32 *addr, int save_state);

Why remove the static here?  This shouldn't need to be exposed if
omap_push_sram_idle() is exposed.

>  static void (*saved_idle)(void);
>
> @@ -798,6 +798,12 @@ static int __init pwrdms_setup(struct po
>  	return set_pwrdm_state(pwrst->pwrdm, pwrst->next_state);
>  }
>
> +void omap_push_sram_idle()
> +{
> +	_omap_sram_idle = omap_sram_push(omap34xx_cpu_suspend,
> +					omap34xx_cpu_suspend_sz);
> +}
> +
>  int __init omap3_pm_init(void)
>  {
>  	struct power_state *pwrst;
> @@ -835,9 +841,7 @@ int __init omap3_pm_init(void)
>  	per_pwrdm = pwrdm_lookup("per_pwrdm");
>  	core_pwrdm = pwrdm_lookup("core_pwrdm");
>
> -	_omap_sram_idle = omap_sram_push(omap34xx_cpu_suspend,
> -					omap34xx_cpu_suspend_sz);
> -
> +	omap_push_sram_idle();
>  	suspend_set_ops(&omap_pm_ops);
>
>  #ifndef CONFIG_CPU_IDLE
> Index: linux-omap-2.6/arch/arm/plat-omap/sram.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/plat-omap/sram.c	2008-09-01 18:11:28.000000000
> +0530
> +++ linux-omap-2.6/arch/arm/plat-omap/sram.c	2008-09-01 18:11:54.000000000 +0530
> @@ -26,6 +26,7 @@
>  #include <mach/board.h>
>
>  #include <mach/control.h>
> +#include <mach/pm.h>
>
>  #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
>  # include "../mach-omap2/prm.h"
> @@ -75,6 +76,8 @@ extern unsigned long omapfb_reserve_sram
>  					 unsigned long sram_size,
>  					 unsigned long pstart_avail,
>  					 unsigned long size_avail);
> +extern void (*_omap_sram_idle)(u32 *addr, int save_state);
> +extern void omap_push_sram_idle();
>
>  /*
>   * Depending on the target RAMFS firewall setup, the public usable amount of
> @@ -367,14 +370,14 @@ u32 omap3_configure_core_dpll(u32 sdrc_r
>  					       sdrc_actim_ctrlb, m2);
>   }
>
> -/* REVISIT: Should this be same as omap34xx_sram_init() after off-idle? */
> -void restore_sram_functions(void)
> +void omap3_restore_sram_ctx(void)
>  {
>  	omap_sram_ceil = omap_sram_base + omap_sram_size;
>
>  	_omap3_sram_configure_core_dpll =
>  		omap_sram_push(omap3_sram_configure_core_dpll,
>  			       omap3_sram_configure_core_dpll_sz);
> +	omap_push_sram_idle();
>  }
>
>  int __init omap3_sram_init(void)
> @@ -382,7 +385,8 @@ int __init omap3_sram_init(void)
>  	_omap3_sram_configure_core_dpll =
>  		omap_sram_push(omap3_sram_configure_core_dpll,
>  			       omap3_sram_configure_core_dpll_sz);
> -
> +	_omap_sram_idle = omap_sram_push(omap34xx_cpu_suspend,
> +				omap34xx_cpu_suspend_sz);
>  	return 0;
>  }
>  #else

Why not omap_push_sram_idle() here?

>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
