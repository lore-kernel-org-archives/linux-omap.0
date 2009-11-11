From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 02/11] OMAP3: Disable Smartreflex before pwrdm enters RET
Date: Wed, 11 Nov 2009 15:17:20 -0800
Message-ID: <87iqdgzm67.fsf@deeprootsystems.com>
References: <1256313835-2391-1-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-2-git-send-email-tero.kristo@nokia.com>
	<1256313835-2391-3-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f226.google.com ([209.85.217.226]:36245 "EHLO
	mail-gx0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759360AbZKKXRR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Nov 2009 18:17:17 -0500
Received: by gxk26 with SMTP id 26so1548243gxk.1
        for <linux-omap@vger.kernel.org>; Wed, 11 Nov 2009 15:17:22 -0800 (PST)
In-Reply-To: <1256313835-2391-3-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Fri\, 23 Oct 2009 19\:03\:46 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> From: Tero Kristo <tero.kristo@nokia.com>
>
> Smartreflex for the corresponding powerdomain (MPU/CORE) must be disabled
> before the domain enters retention, otherwise the device may hang. This is
> caused by overlapping smartreflex / auto retention command on the voltage
> channel resulting in incorrect voltage.
>
> This fix has been confirmed from TI.
>
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>

Thanks, applying to PM branch, queuing in pm-fixes.

Kevin

> ---
>  arch/arm/mach-omap2/pm34xx.c |   22 +++++++++++++++++-----
>  1 files changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 8353764..6782792 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -403,11 +403,17 @@ void omap_sram_idle(void)
>  	if (pwrdm_read_pwrst(cam_pwrdm) == PWRDM_POWER_ON)
>  		omap2_clkdm_deny_idle(mpu_pwrdm->pwrdm_clkdms[0]);
>  
> -	/* CORE */
> -	if (core_next_state < PWRDM_POWER_ON) {
> -		/* Disable smartreflex before entering WFI */
> +	/*
> +	 * Disable smartreflex before entering WFI.
> +	 * Only needed if we are going to enter retention or off.
> +	 */
> +	if (mpu_next_state <= PWRDM_POWER_RET)
>  		disable_smartreflex(SR1);
> +	if (core_next_state <= PWRDM_POWER_RET)
>  		disable_smartreflex(SR2);
> +
> +	/* CORE */
> +	if (core_next_state < PWRDM_POWER_ON) {
>  		omap_uart_prepare_idle(0);
>  		omap_uart_prepare_idle(1);
>  		if (core_next_state == PWRDM_POWER_OFF) {
> @@ -480,10 +486,16 @@ void omap_sram_idle(void)
>  			prm_clear_mod_reg_bits(OMAP3430_AUTO_RET,
>  						OMAP3430_GR_MOD,
>  						OMAP3_PRM_VOLTCTRL_OFFSET);
> -		/* Enable smartreflex after WFI */
> +	}
> +
> +	/*
> +	 * Enable smartreflex after WFI. Only needed if we entered
> +	 * retention or off
> +	 */
> +	if (mpu_next_state <= PWRDM_POWER_RET)
>  		enable_smartreflex(SR1);
> +	if (core_next_state <= PWRDM_POWER_RET)
>  		enable_smartreflex(SR2);
> -	}
>  
>  	/* PER */
>  	if (per_next_state < PWRDM_POWER_ON) {
> -- 
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
