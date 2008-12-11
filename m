From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 20/23] OMAP3: Add support for DPLL3 divisor values higher
 than 2
Date: Thu, 11 Dec 2008 09:06:40 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0812110905330.26754@utopia.booyaka.com>
References: <> <1229010762-3150-6-git-send-email-tero.kristo@nokia.com> <1229010762-3150-7-git-send-email-tero.kristo@nokia.com> <1229010762-3150-8-git-send-email-tero.kristo@nokia.com> <1229010762-3150-9-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-10-git-send-email-tero.kristo@nokia.com> <1229010762-3150-11-git-send-email-tero.kristo@nokia.com> <1229010762-3150-12-git-send-email-tero.kristo@nokia.com> <1229010762-3150-13-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-14-git-send-email-tero.kristo@nokia.com> <1229010762-3150-15-git-send-email-tero.kristo@nokia.com> <1229010762-3150-16-git-send-email-tero.kristo@nokia.com> <1229010762-3150-17-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-18-git-send-email-tero.kristo@nokia.com> <1229010762-3150-19-git-send-email-tero.kristo@nokia.com> <1229010762-3150-20-git-send-email-tero.kristo@nokia.com> <1229010762-3150-21-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34140 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756110AbYLKQGl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2008 11:06:41 -0500
In-Reply-To: <1229010762-3150-21-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Hi Tero

one comment on this patch ...

On Thu, 11 Dec 2008, Tero Kristo wrote:

> Previously only 1 and 2 was supported. This is needed for DVFS VDD2 control.

> diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
> index 16eb4ef..832cd76 100644
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
> @@ -78,8 +79,8 @@ ENTRY(omap3_sram_configure_core_dpll)
>  	ldr	r5, [sp, #56]		@ load extra args from the stack
>  	ldr	r6, [sp, #60]		@ load extra args from the stack

you will also need a

	ldr     r7, [sp, #64]           @ load extra args from the stack

here

>  	dsb				@ flush buffered writes to interconnect
> -	cmp	r3, #0x2		@ if increasing SDRC clk rate,
> -	blne	configure_sdrc		@ program the SDRC regs early (for RFR)
> +	cmp	r7, #1			@ if increasing SDRC clk rate,
> +	bleq	configure_sdrc		@ program the SDRC regs early (for RFR)
>  	cmp	r4, #SDRC_UNLOCK_DLL	@ set the intended DLL state
>  	bleq	unlock_dll
>  	blne	lock_dll
> @@ -89,7 +90,7 @@ ENTRY(omap3_sram_configure_core_dpll)
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
> 


- Paul
