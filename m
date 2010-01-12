From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3 PM: Disable SR only during Device Retention/OFF
Date: Tue, 12 Jan 2010 10:40:40 -0800
Message-ID: <874omrcgk7.fsf@deeprootsystems.com>
References: <1262843526-22578-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f194.google.com ([209.85.221.194]:58334 "EHLO
	mail-qy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754060Ab0ALSkn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jan 2010 13:40:43 -0500
Received: by qyk32 with SMTP id 32so2573143qyk.4
        for <linux-omap@vger.kernel.org>; Tue, 12 Jan 2010 10:40:42 -0800 (PST)
In-Reply-To: <1262843526-22578-1-git-send-email-vishwanath.bs@ti.com> (Vishwanath BS's message of "Thu\,  7 Jan 2010 11\:22\:06 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath BS <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org

Vishwanath BS <vishwanath.bs@ti.com> writes:

> Currently in omap_sram_idle function, SR is disabled whenever next state 
> is retention/OFF w/o checking whether system can really enter retention/off.
> This patch adds another condition to disable SR. Basically FCLK register for
> Core and PER are checked before disabling SR. THis will give some more power
> savings in MP3 usecase (where Core enters retention where as PER does not).
>
> Tested OMAP3430 ZOOM2
>
> Signed-off-by: Vishwanath BS <Vishwanath.bs@ti.com>

I'm not going to take this one in it's current form as we had
discussions about this kind of thing earler when Tero had a series of
adding various fclk checks into the idle path.

I'm holding off on this patch until Tero's series is reviewed/merged.
He has added some functionality to check idleness of clockdomains and
powerdomains that could be used here.

Kevin

> ---
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 3868cdf..13c5dfb
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -479,6 +479,7 @@ void omap_sram_idle(void)
>  	int mpu_logic_state, mpu_mem_state, core_logic_state, core_mem_state;
>  	u32 sdrc_pwr = 0;
>  	int per_state_modified = 0;
> +	u32 fclk_status;
>  
>  	if (!_omap_sram_idle)
>  		return;
> @@ -545,15 +546,6 @@ void omap_sram_idle(void)
>  	if (pwrdm_read_pwrst(cam_pwrdm) == PWRDM_POWER_ON)
>  		omap2_clkdm_deny_idle(mpu_pwrdm->pwrdm_clkdms[0]);
>  
> -	/*
> -	 * Disable smartreflex before entering WFI.
> -	 * Only needed if we are going to enter retention or off.
> -	 */
> -	if (mpu_next_state <= PWRDM_POWER_RET)
> -		disable_smartreflex(SR1);
> -	if (core_next_state <= PWRDM_POWER_RET)
> -		disable_smartreflex(SR2);
> -
>  	/* CORE */
>  	if (core_next_state < PWRDM_POWER_ON) {
>  		omap_uart_prepare_idle(0, core_next_state & core_logic_state);
> @@ -600,6 +592,21 @@ void omap_sram_idle(void)
>  	omap3_intc_prepare_idle();
>  
>  	/*
> +	 * Disable smartreflex before entering WFI.
> +	 * Only needed if we are going to enter retention or off.
> +	 */
> +	fclk_status = cm_read_mod_reg(OMAP3430_PER_MOD, CM_FCLKEN) |
> +			cm_read_mod_reg(CORE_MOD, CM_FCLKEN1) |
> +			cm_read_mod_reg(CORE_MOD, OMAP3430ES2_CM_FCLKEN3);
> +
> +	if (!fclk_status) {
> +		if (mpu_next_state <= PWRDM_POWER_RET)
> +			disable_smartreflex(SR1);
> +		if (core_next_state <= PWRDM_POWER_RET)
> +			disable_smartreflex(SR2);
> +	}
> +
> +	/*
>  	* On EMU/HS devices ROM code restores a SRDC value
>  	* from scratchpad which has automatic self refresh on timeout
>  	* of AUTO_CNT = 1 enabled. This takes care of errata 1.142.
> @@ -685,11 +692,12 @@ void omap_sram_idle(void)
>  	 * Enable smartreflex after WFI. Only needed if we entered
>  	 * retention or off
>  	 */
> -	if (mpu_next_state <= PWRDM_POWER_RET)
> -		enable_smartreflex(SR1);
> -	if (core_next_state <= PWRDM_POWER_RET)
> -		enable_smartreflex(SR2);
> -
> +	if (!fclk_status) {
> +		if (mpu_next_state <= PWRDM_POWER_RET)
> +			enable_smartreflex(SR1);
> +		if (core_next_state <= PWRDM_POWER_RET)
> +			enable_smartreflex(SR2);
> +	}
>  	/* PER */
>  	if (per_next_state < PWRDM_POWER_ON) {
>  		if (per_next_state == PWRDM_POWER_OFF) {
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
