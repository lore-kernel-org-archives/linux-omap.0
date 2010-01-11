From: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Subject: RE: [PATCH] OMAP3 PM: Disable SR only during Device Retention/OFF
Date: Mon, 11 Jan 2010 11:03:26 +0530
Message-ID: <FCCFB4CDC6E5564B9182F639FC3560870300519F0E@dbde02.ent.ti.com>
References: <1262843526-22578-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33923 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751035Ab0AKFda convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jan 2010 00:33:30 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o0B5XRj1002762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sun, 10 Jan 2010 23:33:29 -0600
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o0B5XQLe016329
	for <linux-omap@vger.kernel.org>; Mon, 11 Jan 2010 11:03:26 +0530 (IST)
In-Reply-To: <1262843526-22578-1-git-send-email-vishwanath.bs@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Kevin,
Can you pls take this patch if there are no comments?

Regards
Vishwa

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Sripathy, Vishwanath
> Sent: Thursday, January 07, 2010 11:22 AM
> To: linux-omap@vger.kernel.org
> Subject: [PATCH] OMAP3 PM: Disable SR only during Device Retention/OFF
> 
> Currently in omap_sram_idle function, SR is disabled whenever next state
> is retention/OFF w/o checking whether system can really enter retention/off.
> This patch adds another condition to disable SR. Basically FCLK register for
> Core and PER are checked before disabling SR. THis will give some more power
> savings in MP3 usecase (where Core enters retention where as PER does not).
> 
> Tested OMAP3430 ZOOM2
> 
> Signed-off-by: Vishwanath BS <Vishwanath.bs@ti.com>
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
