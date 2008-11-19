From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] PM: Fix a bug with noncore dpll rate calculation
Date: Wed, 19 Nov 2008 09:32:28 -0800
Message-ID: <87r657fwpf.fsf@deeprootsystems.com>
References: <1227086881-16261-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f11.google.com ([209.85.221.11]:33840 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549AbYKSRcg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Nov 2008 12:32:36 -0500
Received: by qyk4 with SMTP id 4so34217qyk.13
        for <linux-omap@vger.kernel.org>; Wed, 19 Nov 2008 09:32:32 -0800 (PST)
In-Reply-To: <1227086881-16261-1-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Wed\, 19 Nov 2008 11\:28\:01 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> Noncore dpll can enter autoidle state, in which case the rate calculation
> fails. Fixed by checking dpll mode instead of idle status.
>
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

> ---
>  arch/arm/mach-omap2/clock.c           |   16 +++++++++++-----
>  arch/arm/mach-omap2/cm-regbits-34xx.h |    2 ++
>  2 files changed, 13 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
> index 522ce6f..bbd3e82 100644
> --- a/arch/arm/mach-omap2/clock.c
> +++ b/arch/arm/mach-omap2/clock.c
> @@ -212,9 +212,16 @@ u32 omap2_get_dpll_rate(struct clk *clk)
>  		return 0;
>  
>  	/* Return bypass rate if DPLL is bypassed */
> -	v = cm_read_mod_reg(clk->prcm_mod, dd->idlest_reg);
> -	v &= dd->idlest_mask;
> -	v >>= __ffs(dd->idlest_mask);
> +	if (cpu_is_omap34xx()) {
> +		v = cm_read_mod_reg(clk->prcm_mod, dd->control_reg);
> +		v &= dd->enable_mask;
> +		v >>= __ffs(dd->enable_mask);
> +	} else {
> +		v = cm_read_mod_reg(clk->prcm_mod, dd->idlest_reg);
> +		v &= dd->idlest_mask;
> +		v >>= __ffs(dd->idlest_mask);
> +	}
> +
>  	if (cpu_is_omap24xx()) {
>  
>  		if (v == ST_CORE_CLK_REF)
> @@ -224,9 +231,8 @@ u32 omap2_get_dpll_rate(struct clk *clk)
>  
>  	} else if (cpu_is_omap34xx()) {
>  
> -		if (!v)
> +		if (v == OMAP3430_EN_MPU_DPLL_BYPASS)
>  			return dd->bypass_clk->rate;
> -
>  	}
>  
>  	v = cm_read_mod_reg(clk->prcm_mod, dd->mult_div1_reg);
> diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
> index 6f3f5a3..9995353 100644
> --- a/arch/arm/mach-omap2/cm-regbits-34xx.h
> +++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
> @@ -112,6 +112,8 @@
>  #define OMAP3430_EN_MPU_DPLL_DRIFTGUARD_MASK		(1 << 3)
>  #define OMAP3430_EN_MPU_DPLL_SHIFT			0
>  #define OMAP3430_EN_MPU_DPLL_MASK			(0x7 << 0)
> +#define OMAP3430_EN_MPU_DPLL_LOCK			(0x7 << 0)
> +#define OMAP3430_EN_MPU_DPLL_BYPASS			(0x5 << 0)
>  
>  /* CM_IDLEST_MPU */
>  #define OMAP3430_ST_MPU					(1 << 0)
> -- 
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
