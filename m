From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: GPIO fixes for off-mode
Date: Mon, 01 Dec 2008 07:56:19 -0800
Message-ID: <87ej0ropng.fsf@deeprootsystems.com>
References: <1228131512-12099-1-git-send-email-tero.kristo@nokia.com>
	<1228131512-12099-2-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.236]:16492 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751930AbYLAP4W (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Dec 2008 10:56:22 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2517849rvb.1
        for <linux-omap@vger.kernel.org>; Mon, 01 Dec 2008 07:56:22 -0800 (PST)
In-Reply-To: <1228131512-12099-2-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Mon\,  1 Dec 2008 13\:38\:32 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> Off mode is now using the omap2 retention fix code for scanning GPIOs
> only during off-mode transitions. All the *non_wakeup_gpios variables
> are now used for off-mode transition tracking on OMAP3. This patch fixes
> cases where GPIO state changes are missed during off-mode.
>
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>

Can you rework this slightly to use runtime cpu_is_* checks instead
of compile-time #ifdefs?

This will currently not do the "right thing" on a kernel compiled
with both omap2 and omap3 support.

Thanks,

Kevin

> ---
>  arch/arm/mach-omap2/pm34xx.c |   10 ++++++----
>  arch/arm/plat-omap/gpio.c    |   18 ++++++++++++++++--
>  2 files changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 152b4e7..082e4f4 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -324,14 +324,15 @@ void omap_sram_idle(void)
>  	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
>  	if (per_next_state < PWRDM_POWER_ON) {
>  		omap_uart_prepare_idle(2);
> -		omap2_gpio_prepare_for_retention();
>  		if (per_next_state == PWRDM_POWER_OFF) {
>  			if (core_next_state == PWRDM_POWER_ON) {
>  				per_next_state = PWRDM_POWER_RET;
>  				pwrdm_set_next_pwrst(per_pwrdm, per_next_state);
>  				per_state_modified = 1;
> -			} else
> +			} else {
> +				omap2_gpio_prepare_for_retention();
>  				omap3_per_save_context();
> +			}
>  		}
>  	}
>  
> @@ -404,9 +405,10 @@ void omap_sram_idle(void)
>  	/* PER */
>  	if (per_next_state < PWRDM_POWER_ON) {
>  		per_prev_state = pwrdm_read_prev_pwrst(per_pwrdm);
> -		if (per_prev_state == PWRDM_POWER_OFF)
> +		if (per_prev_state == PWRDM_POWER_OFF) {
>  			omap3_per_restore_context();
> -		omap2_gpio_resume_after_retention();
> +			omap2_gpio_resume_after_retention();
> +		}
>  		omap_uart_resume_idle(2);
>  		if (per_state_modified)
>  			pwrdm_set_next_pwrst(per_pwrdm, PWRDM_POWER_OFF);
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index 62349fd..b45bf9d 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -556,7 +556,9 @@ static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
>  		else
>  			__raw_writel(1 << gpio, bank->base
>  					+ OMAP24XX_GPIO_CLEARWKUENA);
> +#ifdef CONFIG_ARCH_OMAP24XX
>  	} else {
> +#endif
>  		if (trigger != 0)
>  			bank->enabled_non_wakeup_gpios |= gpio_bit;
>  		else
> @@ -1485,9 +1487,11 @@ static int __init _omap_gpio_init(void)
>  
>  #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
>  		if (bank->method == METHOD_GPIO_24XX) {
> +#ifdef CONFIG_ARCH_OMAP24XX
>  			static const u32 non_wakeup_gpios[] = {
>  				0xe203ffc0, 0x08700040
>  			};
> +#endif
>  
>  			__raw_writel(0x00000000, bank->base + OMAP24XX_GPIO_IRQENABLE1);
>  			__raw_writel(0xffffffff, bank->base + OMAP24XX_GPIO_IRQSTATUS1);
> @@ -1495,8 +1499,10 @@ static int __init _omap_gpio_init(void)
>  
>  			/* Initialize interface clock ungated, module enabled */
>  			__raw_writel(0, bank->base + OMAP24XX_GPIO_CTRL);
> +#ifdef CONFIG_ARCH_OMAP24XX
>  			if (i < ARRAY_SIZE(non_wakeup_gpios))
>  				bank->non_wakeup_gpios = non_wakeup_gpios[i];
> +#endif
>  			gpio_count = 32;
>  		}
>  #endif
> @@ -1666,7 +1672,11 @@ void omap2_gpio_prepare_for_retention(void)
>  
>  	/* Remove triggering for all non-wakeup GPIOs.  Otherwise spurious
>  	 * IRQs will be generated.  See OMAP2420 Errata item 1.101. */
> +#ifdef CONFIG_ARCH_OMAP24XX
>  	for (i = 0; i < gpio_bank_count; i++) {
> +#else
> +	for (i = 1; i < gpio_bank_count; i++) {
> +#endif
>  		struct gpio_bank *bank = &gpio_bank[i];
>  		u32 l1, l2;
>  
> @@ -1681,7 +1691,7 @@ void omap2_gpio_prepare_for_retention(void)
>  		bank->saved_risingdetect = l2;
>  		l1 &= ~bank->enabled_non_wakeup_gpios;
>  		l2 &= ~bank->enabled_non_wakeup_gpios;
> -#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
> +#if defined(CONFIG_ARCH_OMAP24XX)
>  		__raw_writel(l1, bank->base + OMAP24XX_GPIO_FALLINGDETECT);
>  		__raw_writel(l2, bank->base + OMAP24XX_GPIO_RISINGDETECT);
>  #endif
> @@ -1700,7 +1710,11 @@ void omap2_gpio_resume_after_retention(void)
>  
>  	if (!workaround_enabled)
>  		return;
> +#ifdef CONFIG_ARCH_OMAP24XX
>  	for (i = 0; i < gpio_bank_count; i++) {
> +#else
> +	for (i = 1; i < gpio_bank_count; i++) {
> +#endif
>  		struct gpio_bank *bank = &gpio_bank[i];
>  		u32 l;
>  
> @@ -1720,7 +1734,7 @@ void omap2_gpio_resume_after_retention(void)
>  		l = __raw_readl(bank->base + OMAP24XX_GPIO_DATAIN);
>  #endif
>  		l ^= bank->saved_datain;
> -		l &= bank->non_wakeup_gpios;
> +		l &= bank->enabled_non_wakeup_gpios;
>  		if (l) {
>  			u32 old0, old1;
>  #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
> -- 
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
