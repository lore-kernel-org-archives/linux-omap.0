From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 5/8] OMAP3 PM: Adding conditional core powerdomain context save and restore
Date: Fri, 22 Jan 2010 16:15:07 -0800
Message-ID: <87zl45zng4.fsf@deeprootsystems.com>
References: <1264001442-20078-1-git-send-email-thara@ti.com>
	<1264001442-20078-2-git-send-email-thara@ti.com>
	<1264001442-20078-3-git-send-email-thara@ti.com>
	<1264001442-20078-4-git-send-email-thara@ti.com>
	<1264001442-20078-5-git-send-email-thara@ti.com>
	<1264001442-20078-6-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f190.google.com ([209.85.222.190]:49169 "EHLO
	mail-pz0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753412Ab0AWAPK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Jan 2010 19:15:10 -0500
Received: by pzk28 with SMTP id 28so458566pzk.4
        for <linux-omap@vger.kernel.org>; Fri, 22 Jan 2010 16:15:09 -0800 (PST)
In-Reply-To: <1264001442-20078-6-git-send-email-thara@ti.com> (Thara Gopinath's message of "Wed\, 20 Jan 2010 21\:00\:39 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org

Thara Gopinath <thara@ti.com> writes:

> This patch adds a parameter core_state , depicting the power state
> which the core domain will attempt to enter, to omap3_core_save_context
> and omap3_core_restore_context. This is so as to distinguish between
> the context save and restore required when core domain is attempting
> OSWR and OFF. Core OSWR does not require interrupt controller,
> system control module and dma controller context save and retore
> where as Core OFF reuires these.
>
> Signed-off-by: Thara Gopinath <thara@ti.com>

Looks good, pulling this into PM branch after one minor fixup below...

> ---
>  arch/arm/mach-omap2/pm34xx.c |   71 +++++++++++++++++++++++++-----------------
>  1 files changed, 42 insertions(+), 29 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 895e9ef..e4db1ea 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -150,44 +150,57 @@ static void omap3_disable_io_chain(void)
>  		prm_clear_mod_reg_bits(OMAP3430_EN_IO_CHAIN, WKUP_MOD, PM_WKEN);
>  }
>  
> -static void omap3_core_save_context(void)
> +static void omap3_core_save_context(int core_state)
>  {
> -	u32 control_padconf_off;
> +	if (core_state == PWRDM_POWER_OFF) {
> +		u32 control_padconf_off;
> +
> +		/* Save the padconf registers */
> +		control_padconf_off = omap_ctrl_readl(
> +				OMAP343X_CONTROL_PADCONF_OFF);
> +		control_padconf_off |= START_PADCONF_SAVE;
> +		omap_ctrl_writel(control_padconf_off,
> +				OMAP343X_CONTROL_PADCONF_OFF);
> +		/* wait for the save to complete */
> +		while (!(omap_ctrl_readl(
> +				OMAP343X_CONTROL_GENERAL_PURPOSE_STATUS) &
> +				PADCONF_SAVE_DONE))
> +			udelay(1);
>  
> -	/* Save the padconf registers */
> -	control_padconf_off = omap_ctrl_readl(OMAP343X_CONTROL_PADCONF_OFF);
> -	control_padconf_off |= START_PADCONF_SAVE;
> -	omap_ctrl_writel(control_padconf_off, OMAP343X_CONTROL_PADCONF_OFF);
> -	/* wait for the save to complete */
> -	while (!(omap_ctrl_readl(OMAP343X_CONTROL_GENERAL_PURPOSE_STATUS)
> -			& PADCONF_SAVE_DONE))
> -		udelay(1);
> +		/*
> +		 * Force write last pad into memory, as this can fail in some
> +		 * cases according to erratas 1.157, 1.185
> +		 */
> +		omap_ctrl_writel(omap_ctrl_readl(OMAP343X_PADCONF_ETK_D14),
> +				OMAP343X_CONTROL_MEM_WKUP + 0x2a0);
>  
> -	/*
> -	 * Force write last pad into memory, as this can fail in some
> -	 * cases according to erratas 1.157, 1.185
> -	 */
> -	omap_ctrl_writel(omap_ctrl_readl(OMAP343X_PADCONF_ETK_D14),
> -		OMAP343X_CONTROL_MEM_WKUP + 0x2a0);
> +		/* Save the Interrupt controller context */
> +		omap_intc_save_context();
> +
> +		/* Save the system control module context,
> +		 * padconf already save above
> +		 */
> +		omap3_control_save_context();
> +		omap_dma_global_context_save();
> +	}
>  
> -	/* Save the Interrupt controller context */
> -	omap_intc_save_context();
>  	/* Save the GPMC context */
>  	omap3_gpmc_save_context();
> -	/* Save the system control module context, padconf already save above*/
> -	omap3_control_save_context();
> -	omap_dma_global_context_save();
>  }
>  
> -static void omap3_core_restore_context(void)
> +static void omap3_core_restore_context(int core_state)
>  {
> -	/* Restore the control module context, padconf restored by h/w */
> -	omap3_control_restore_context();
> +	if (core_state == PWRDM_POWER_OFF) {
> +		/* Restore the control module context,
> +		 * padconf restored by h/w
> +		 */

changing this to proper multi-line comment.

Kevin

> +		omap3_control_restore_context();
> +		/* Restore the interrupt controller context */
> +		omap_intc_restore_context();
> +		omap_dma_global_context_restore();
> +	}
>  	/* Restore the GPMC context */
>  	omap3_gpmc_restore_context();
> -	/* Restore the interrupt controller context */
> -	omap_intc_restore_context();
> -	omap_dma_global_context_restore();
>  }
>  
>  /*
> @@ -445,7 +458,7 @@ void omap_sram_idle(void)
>  			prm_set_mod_reg_bits(voltctrl,
>  					     OMAP3430_GR_MOD,
>  					     OMAP3_PRM_VOLTCTRL_OFFSET);
> -			omap3_core_save_context();
> +			omap3_core_save_context(PWRDM_POWER_OFF);
>  			omap3_prcm_save_context();
>  		} else if (core_next_state == PWRDM_POWER_RET) {
>  			prm_set_mod_reg_bits(OMAP3430_AUTO_RET,
> @@ -497,7 +510,7 @@ void omap_sram_idle(void)
>  	if (core_next_state < PWRDM_POWER_ON) {
>  		core_prev_state = pwrdm_read_prev_pwrst(core_pwrdm);
>  		if (core_prev_state == PWRDM_POWER_OFF) {
> -			omap3_core_restore_context();
> +			omap3_core_restore_context(core_prev_state);
>  			omap3_prcm_restore_context();
>  			omap3_sram_restore_context();
>  			omap2_sms_restore_context();
> -- 
> 1.5.6.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
