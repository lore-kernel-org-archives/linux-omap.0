From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: Add support for DPLL3 divisor values higher than 2
Date: Mon, 15 Dec 2008 11:19:04 -0800
Message-ID: <874p15b61j.fsf@deeprootsystems.com>
References: <1229013366-23320-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f17.google.com ([209.85.219.17]:51445 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750965AbYLOTTM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2008 14:19:12 -0500
Received: by ewy10 with SMTP id 10so3231203ewy.13
        for <linux-omap@vger.kernel.org>; Mon, 15 Dec 2008 11:19:10 -0800 (PST)
In-Reply-To: <1229013366-23320-1-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Thu\, 11 Dec 2008 18\:36\:06 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> Previously only 1 and 2 was supported. This is needed for DVFS VDD2 control.
>

Tero,

What is this patch against?  It doesn't apply to current PM branch,
current l-o HEAD or on top of you DVFS patchset.

Kevin

> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
> ---
>  arch/arm/mach-omap2/clock34xx.c        |    9 +++------
>  arch/arm/mach-omap2/sram34xx.S         |    8 +++++---
>  arch/arm/plat-omap/include/mach/sram.h |    7 +++++--
>  arch/arm/plat-omap/sram.c              |    6 +++---
>  4 files changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
> index d6d4b46..b38cb30 100644
> --- a/arch/arm/mach-omap2/clock34xx.c
> +++ b/arch/arm/mach-omap2/clock34xx.c
> @@ -516,9 +516,9 @@ static int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
>  
>  	sdrcrate = sdrc_ick.rate;
>  	if (rate > clk->rate)
> -		sdrcrate <<= ((rate / clk->rate) - 1);
> +		sdrcrate <<= ((rate / clk->rate) >> 1);
>  	else
> -		sdrcrate >>= ((clk->rate / rate) - 1);
> +		sdrcrate >>= ((clk->rate / rate) >> 1);
>  
>  	sp = omap2_sdrc_get_params(sdrcrate);
>  	if (!sp)
> @@ -545,13 +545,10 @@ static int omap3_core_dpll_m2_set_rate(struct clk *clk, unsigned long rate)
>  	pr_debug("clock: SDRC timing params used: %08x %08x %08x\n",
>  		 sp->rfr_ctrl, sp->actim_ctrla, sp->actim_ctrlb);
>  
> -	/* REVISIT: SRAM code doesn't support other M2 divisors yet */
> -	WARN_ON(new_div != 1 && new_div != 2);
> -
>  	local_irq_disable();
>  	omap3_configure_core_dpll(sp->rfr_ctrl, sp->actim_ctrla,
>  				  sp->actim_ctrlb, new_div, unlock_dll, c,
> -				  sp->mr);
> +				  sp->mr, rate > clk->rate);
>  	local_irq_enable();
>  
>  	omap2_clksel_recalc(clk);
> diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
> index 16eb4ef..487fa86 100644
> --- a/arch/arm/mach-omap2/sram34xx.S
> +++ b/arch/arm/mach-omap2/sram34xx.S
> @@ -70,6 +70,7 @@
>   * r5 = number of MPU cycles to wait for SDRC to stabilize after
>   *      reprogramming the SDRC when switching to a slower MPU speed
>   * r6 = new SDRC_MR_0 register value
> + * r7 = increasing SDRC rate? (1 = yes, 0 = no)
>   *
>   */
>  ENTRY(omap3_sram_configure_core_dpll)
> @@ -77,9 +78,10 @@ ENTRY(omap3_sram_configure_core_dpll)
>  	ldr	r4, [sp, #52]		@ pull extra args off the stack
>  	ldr	r5, [sp, #56]		@ load extra args from the stack
>  	ldr	r6, [sp, #60]		@ load extra args from the stack
> +	ldr	r7, [sp, #64]		@ load extra args from the stack
>  	dsb				@ flush buffered writes to interconnect
> -	cmp	r3, #0x2		@ if increasing SDRC clk rate,
> -	blne	configure_sdrc		@ program the SDRC regs early (for RFR)
> +	cmp	r7, #1			@ if increasing SDRC clk rate,
> +	bleq	configure_sdrc		@ program the SDRC regs early (for RFR)
>  	cmp	r4, #SDRC_UNLOCK_DLL	@ set the intended DLL state
>  	bleq	unlock_dll
>  	blne	lock_dll
> @@ -89,7 +91,7 @@ ENTRY(omap3_sram_configure_core_dpll)
>  	cmp	r4, #SDRC_UNLOCK_DLL	@ wait for DLL status to change
>  	bleq	wait_dll_unlock
>  	blne	wait_dll_lock
> -	cmp	r3, #0x1		@ if increasing SDRC clk rate,
> +	cmp	r7, #1			@ if increasing SDRC clk rate,
>  	beq	return_to_sdram		@ return to SDRAM code, otherwise,
>  	bl	configure_sdrc		@ reprogram SDRC regs now
>  	mov	r12, r5
> diff --git a/arch/arm/plat-omap/include/mach/sram.h b/arch/arm/plat-omap/include/mach/sram.h
> index d07da3b..ad0a600 100644
> --- a/arch/arm/plat-omap/include/mach/sram.h
> +++ b/arch/arm/plat-omap/include/mach/sram.h
> @@ -24,7 +24,8 @@ extern u32 omap2_set_prcm(u32 dpll_ctrl_val, u32 sdrc_rfr_val, int bypass);
>  extern u32 omap3_configure_core_dpll(u32 sdrc_rfr_ctrl,
>  				     u32 sdrc_actim_ctrla,
>  				     u32 sdrc_actim_ctrlb, u32 m2,
> -				     u32 unlock_dll, u32 f, u32 sdrc_mr);
> +				     u32 unlock_dll, u32 f, u32 sdrc_mr,
> +				     u32 inc);
>  extern void omap3_sram_restore_context(void);
>  
>  /* Do not use these */
> @@ -62,7 +63,9 @@ extern unsigned long omap243x_sram_reprogram_sdrc_sz;
>  
>  extern u32 omap3_sram_configure_core_dpll(u32 sdrc_rfr_ctrl,
>  					  u32 sdrc_actim_ctrla,
> -					  u32 sdrc_actim_ctrlb, u32 m2);
> +					  u32 sdrc_actim_ctrlb, u32 m2,
> +					  u32 unlock_dll, u32 f, u32 sdrc_mr,
> +					  u32 inc);
>  extern unsigned long omap3_sram_configure_core_dpll_sz;
>  
>  #ifdef CONFIG_PM
> diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
> index 68a1f69..9f6232f 100644
> --- a/arch/arm/plat-omap/sram.c
> +++ b/arch/arm/plat-omap/sram.c
> @@ -372,10 +372,10 @@ static u32 (*_omap3_sram_configure_core_dpll)(u32 sdrc_rfr_ctrl,
>  					      u32 sdrc_actim_ctrla,
>  					      u32 sdrc_actim_ctrlb,
>  					      u32 m2, u32 unlock_dll,
> -					      u32 f, u32 sdrc_mr);
> +					      u32 f, u32 sdrc_mr, u32 inc);
>  u32 omap3_configure_core_dpll(u32 sdrc_rfr_ctrl, u32 sdrc_actim_ctrla,
>  			      u32 sdrc_actim_ctrlb, u32 m2, u32 unlock_dll,
> -			      u32 f, u32 sdrc_mr)
> +			      u32 f, u32 sdrc_mr, u32 inc)
>   {
>  	if (!_omap3_sram_configure_core_dpll)
>  		omap_sram_error();
> @@ -383,7 +383,7 @@ u32 omap3_configure_core_dpll(u32 sdrc_rfr_ctrl, u32 sdrc_actim_ctrla,
>  	return _omap3_sram_configure_core_dpll(sdrc_rfr_ctrl,
>  					       sdrc_actim_ctrla,
>  					       sdrc_actim_ctrlb, m2,
> -					       unlock_dll, f, sdrc_mr);
> +					       unlock_dll, f, sdrc_mr, inc);
>   }
>  
>  #ifdef CONFIG_PM
> -- 
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
