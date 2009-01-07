From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3: GPIO fixes for off-mode
Date: Wed, 07 Jan 2009 15:35:51 -0800
Message-ID: <8763kqofjc.fsf@deeprootsystems.com>
References: <1229948832-26695-1-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:28115 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755509AbZAGXf4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Jan 2009 18:35:56 -0500
Received: by qw-out-2122.google.com with SMTP id 3so7630429qwe.37
        for <linux-omap@vger.kernel.org>; Wed, 07 Jan 2009 15:35:55 -0800 (PST)
In-Reply-To: <1229948832-26695-1-git-send-email-tero.kristo@nokia.com> (Tero Kristo's message of "Mon\, 22 Dec 2008 14\:27\:12 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>
Cc: linux-omap@vger.kernel.org

Tero Kristo <tero.kristo@nokia.com> writes:

> From:	Tero Kristo <tero.kristo@nokia.com>
> Subject: [PATCH] OMAP3: GPIO fixes for off-mode
> To:	linux-omap@vger.kernel.org
> Date:	Mon, 22 Dec 2008 14:27:12 +0200
>
> Off mode is now using the omap2 retention fix code for scanning GPIOs
> during off-mode transitions. All the *non_wakeup_gpios variables
> are now used for off-mode transition tracking on OMAP3. This patch fixes
> cases where GPIO state changes are missed during off-mode.
>
> Signed-off-by: Tero Kristo <tero.kristo@nokia.com>

Looks good now, thanks.  Pulling into PM branch.

Kevin

> ---
>  arch/arm/mach-omap2/pm34xx.c |   10 ++++++----
>  arch/arm/plat-omap/gpio.c    |   29 ++++++++++++++++++++---------
>  2 files changed, 26 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index c67d770..66f2b22 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -330,14 +330,15 @@ void omap_sram_idle(void)
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
> @@ -411,9 +412,10 @@ void omap_sram_idle(void)
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
> index 83a5953..db40037 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -540,7 +540,9 @@ static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
>  		else
>  			__raw_writel(1 << gpio, bank->base
>  					+ OMAP24XX_GPIO_CLEARWKUENA);
> -	} else {
> +	}
> +	/* This part needs to be executed always for OMAP34xx */
> +	if (cpu_is_omap34xx() || (bank->non_wakeup_gpios & gpio_bit)) {
>  		if (trigger != 0)
>  			bank->enabled_non_wakeup_gpios |= gpio_bit;
>  		else
> @@ -1456,7 +1458,8 @@ static int __init _omap_gpio_init(void)
>  
>  			/* Initialize interface clock ungated, module enabled */
>  			__raw_writel(0, bank->base + OMAP24XX_GPIO_CTRL);
> -			if (i < ARRAY_SIZE(non_wakeup_gpios))
