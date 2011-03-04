From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/1] omap3: Save and restore CM_AUTOIDLE_PLL across off
 mode
Date: Fri, 4 Mar 2011 15:46:29 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1103041540540.10981@utopia.booyaka.com>
References: <1297353724-11665-1-git-send-email-premi@ti.com> <1297353724-11665-2-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50213 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932555Ab1CDWqa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 17:46:30 -0500
In-Reply-To: <1297353724-11665-2-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello Sanjeev,

On Thu, 10 Feb 2011, Sanjeev Premi wrote:

> As per commit "bb33cc58", ROM code is expected to restore
> context related to CORE domain. As part of this change,
> CM_AUTOIDLE_PLL is neither saved nor restored.

... by Linux.

> This results in loosing the value of AUTO_PERIPH_DPLL.

A few questions:

- Is ROM code supposed to restore this register?

- Is there a documented list of which registers/bitfields the ROM code 
will and won't restore?

- Are the entire contents of the register lost, or just AUTO_PERIPH_DPLL?

> The concern of setting the AUTOIDLE flag before the DPLL
> is locked seems valid. Hence, the restoration of this
> register is delayed until after the context of PER
> domain is restored.

Could you explain a little more about this?  Is there a hardware 
limitation where AUTO_PERIPH_DPLL shouldn't be set unless the DPLL is 
locked?

> 
> The patch has been verified on OMAP3EVM by checking value
> of CM_AUTOIDLE_PLL register across the suspend/resume
> sequence (using devmem) with flags sleep_while_idle and
> enable_off_mode set to 1.
> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  arch/arm/mach-omap2/cm2xxx_3xxx.c |   13 +++++++++++++
>  arch/arm/mach-omap2/pm34xx.c      |   25 ++++++++++++++++++++++++-
>  2 files changed, 37 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/cm2xxx_3xxx.c b/arch/arm/mach-omap2/cm2xxx_3xxx.c
> index 96954aa..a775d8a 100644
> --- a/arch/arm/mach-omap2/cm2xxx_3xxx.c
> +++ b/arch/arm/mach-omap2/cm2xxx_3xxx.c
> @@ -178,6 +178,7 @@ struct omap3_cm_regs {
>  	u32 per_cm_clksel;
>  	u32 emu_cm_clksel;
>  	u32 emu_cm_clkstctrl;
> +	u32 pll_cm_autoidle;
>  	u32 pll_cm_autoidle2;
>  	u32 pll_cm_clksel4;
>  	u32 pll_cm_clksel5;
> @@ -250,6 +251,8 @@ void omap3_cm_save_context(void)
>  		omap2_cm_read_mod_reg(OMAP3430_EMU_MOD, CM_CLKSEL1);
>  	cm_context.emu_cm_clkstctrl =
>  		omap2_cm_read_mod_reg(OMAP3430_EMU_MOD, OMAP2_CM_CLKSTCTRL);
> +	cm_context.pll_cm_autoidle =
> +		 omap2_cm_read_mod_reg(PLL_MOD, CM_AUTOIDLE);
>  	cm_context.pll_cm_autoidle2 =
>  		omap2_cm_read_mod_reg(PLL_MOD, CM_AUTOIDLE2);
>  	cm_context.pll_cm_clksel4 =
> @@ -468,4 +471,14 @@ void omap3_cm_restore_context(void)
>  	omap2_cm_write_mod_reg(cm_context.cm_clkout_ctrl, OMAP3430_CCR_MOD,
>  			       OMAP3_CM_CLKOUT_CTRL_OFFSET);
>  }
> +
> +
> +/**
> + * Returns the value corresponding to CM_AUTOIDLE_PLL from the most recent
> + * context saved before entering the OFF mode.
> + */
> +u32 stored_cm_autoidle_pll(void)
> +{
> +	return cm_context.pll_cm_autoidle;
> +}
>  #endif
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 8bb85fb..25bd230 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -91,6 +91,8 @@ static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
>  static struct powerdomain *core_pwrdm, *per_pwrdm;
>  static struct powerdomain *cam_pwrdm;
>  
> +extern u32 stored_cm_autoidle_pll(void);
> +
>  static inline void omap3_per_save_context(void)
>  {
>  	omap_gpio_save_context();
> @@ -163,6 +165,25 @@ static void omap3_core_restore_context(void)
>  	omap_dma_global_context_restore();
>  }
>  
> +/**
> + * Restore the contents of CM_AUTOIDLE_PLL register.
> + *
> + * The implementation below restores AUTO_CORE_DPLL as 'good' redundancy.

I don't understand this part.  Are the entire contents of the register 
lost, or just the AUTO_PERIPH_DPLL field?

> + */
> +static void pll_mod_restore_autoidle(void)
> +{
> +	u32 ctx = stored_cm_autoidle_pll();
> +	u32 val = omap2_cm_read_mod_reg(PLL_MOD, CM_AUTOIDLE);
> +
> +	if (ctx & OMAP3430_AUTO_CORE_DPLL_MASK)
> +		val |= ctx & OMAP3430_AUTO_CORE_DPLL_MASK;
> +
> +	if (ctx & OMAP3430_AUTO_PERIPH_DPLL_MASK)
> +		val |= ctx & OMAP3430_AUTO_PERIPH_DPLL_MASK;
> +
> +	omap2_cm_write_mod_reg(val, PLL_MOD, CM_AUTOIDLE);
> +}
> +
>  /*
>   * FIXME: This function should be called before entering off-mode after
>   * OMAP3 secure services have been accessed. Currently it is only called
> @@ -488,8 +509,10 @@ void omap_sram_idle(void)
>  	if (per_next_state < PWRDM_POWER_ON) {
>  		per_prev_state = pwrdm_read_prev_pwrst(per_pwrdm);
>  		omap2_gpio_resume_after_idle();
> -		if (per_prev_state == PWRDM_POWER_OFF)
> +		if (per_prev_state == PWRDM_POWER_OFF) {
>  			omap3_per_restore_context();
> +			pll_mod_restore_autoidle();
> +		}
>  		omap_uart_resume_idle(2);
>  		omap_uart_resume_idle(3);
>  	}
> -- 
> 1.7.2.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
