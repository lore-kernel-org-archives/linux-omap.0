From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/6] OMAP3: GPIO: Only enable WAKEUPEN for edge
 detection GPIOs
Date: Mon, 10 May 2010 14:11:05 -0700
Message-ID: <20100510211105.GI16460@atomide.com>
References: <1272929177-22685-1-git-send-email-khilman@deeprootsystems.com>
 <1272929177-22685-3-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53924 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932274Ab0EJVLF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 17:11:05 -0400
Content-Disposition: inline
In-Reply-To: <1272929177-22685-3-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, Chunqiu Wang <cqwang@motorola.com>

* Kevin Hilman <khilman@deeprootsystems.com> [100503 16:28]:
> From: Chunqiu Wang <cqwang@motorola.com>
> 
> According to the GPIO 'Wakeup and Interrupt' section of the TRM[1],
> wake-up requests can only be generated on edge transitions.
> 
> Also for OMAP3, only edge GPIOs may lose interrupts when PER enters
> RET/OFF state, this is addressed by gpio prepare|resume idle functions

There's a generic solution to this problem. The solution is to temporarily
set the level GPIO pins into edge for the duration of idle. Then
they need to be set back to level after the system is woken up.

Regards,

Tony

 
> [1] Section 25.5.3.1 OMAP34xx_ES3.1_TRM_V_Q
> 
> Signed-off-by: Chunqiu Wang <cqwang@motorola.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/plat-omap/gpio.c |   14 ++++++++++++--
>  1 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index 678fd08..4d43cda 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -724,7 +724,11 @@ static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
>  							 OMAP4_GPIO_IRQWAKEN0);
>  			}
>  		} else {
> -			if (trigger != 0)
> +			/*
> +			 * GPIO wakeup request can only be generated on edge
> +			 * transitions
> +			 */
> +			if (trigger & IRQ_TYPE_EDGE_BOTH)
>  				__raw_writel(1 << gpio, bank->base
>  					+ OMAP24XX_GPIO_SETWKUENA);
>  			else
> @@ -734,7 +738,13 @@ static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
>  	}
>  	/* This part needs to be executed always for OMAP34xx */
>  	if (cpu_is_omap34xx() || (bank->non_wakeup_gpios & gpio_bit)) {
> -		if (trigger != 0)
> +		/*
> +		 * Log the edge gpio and manually trigger the IRQ
> +		 * after resume if the input level changes
> +		 * to avoid irq lost during PER RET/OFF mode
> +		 * Applies for omap2 non-wakeup gpio and all omap3 gpios
> +		 */
> +		if (trigger & IRQ_TYPE_EDGE_BOTH)
>  			bank->enabled_non_wakeup_gpios |= gpio_bit;
>  		else
>  			bank->enabled_non_wakeup_gpios &= ~gpio_bit;
> -- 
> 1.7.0.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
