From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: GPIO: Avoid generating extra IRQs
Date: Wed, 5 Aug 2009 16:17:03 +0300
Message-ID: <20090805131703.GG7374@atomide.com>
References: <1246602393-8812-1-git-send-email-ext-eero.nurkkala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50452 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933326AbZHENRG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 09:17:06 -0400
Content-Disposition: inline
In-Reply-To: <1246602393-8812-1-git-send-email-ext-eero.nurkkala@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext-eero.nurkkala@nokia.com
Cc: linux-omap@vger.kernel.org

Hi,

* ext-eero.nurkkala@nokia.com <ext-eero.nurkkala@nokia.com> [090703 09:27]:
> From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
> 
> It is possible for GPIO IRQ lines configured with
> falling edge triggering only to get IRQs at the
> rising edge upon the exit of offmode. And vice
> versa. Prevent such IRQs to arrive by generating
> the IRQ obeying the detection scheme.

Is the situation still the same if we temporarily change the
level lines to edge for the duration of idle? This would allow
waking up even if the line is level.

Also one question below.

> Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
> ---
>  arch/arm/plat-omap/gpio.c |   27 +++++++++++++++++++++++----
>  1 files changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index 26b387c..7a270c0 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -1804,7 +1804,7 @@ void omap2_gpio_resume_after_retention(void)
>  		return;
>  	for (i = 0; i < gpio_bank_count; i++) {
>  		struct gpio_bank *bank = &gpio_bank[i];
> -		u32 l;
> +		u32 l, gen, gen0, gen1;
>  
>  		if (!(bank->enabled_non_wakeup_gpios))
>  			continue;
> @@ -1825,14 +1825,33 @@ void omap2_gpio_resume_after_retention(void)
>  #endif
>  		l ^= bank->saved_datain;
>  		l &= bank->non_wakeup_gpios;
> -		if (l) {
> +
> +		/*
> +		 * No need to generate IRQs for the rising edge for gpio IRQs
> +		 * configured with falling edge only; and vice versa.
> +		 */
> +		gen0 = l & bank->saved_fallingdetect;
> +		gen0 &= bank->saved_datain;
> +
> +		gen1 = l & bank->saved_risingdetect;
> +		gen1 &= ~(bank->saved_datain);
> +

Is the gen0 &= correct or should it also clear the bits?

Also, have you checked the code flow on omap1 when l, gen, gen0 & gen1
are not initialized? Just wondering ;)

Tony


> +		/* FIXME: Consider GPIO IRQs with level detections properly! */
> +		gen = l & (~(bank->saved_fallingdetect) &
> +				~(bank->saved_risingdetect));
> +		/* Consider all GPIO IRQs needed to be updated */
> +		gen |= gen0 | gen1;
> +
> +		if (gen) {
>  			u32 old0, old1;
>  #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
>  			defined(CONFIG_ARCH_OMAP4)
>  			old0 = __raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT0);
>  			old1 = __raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT1);
> -			__raw_writel(old0 | l, bank->base + OMAP24XX_GPIO_LEVELDETECT0);
> -			__raw_writel(old1 | l, bank->base + OMAP24XX_GPIO_LEVELDETECT1);
> +			__raw_writel(old0 | gen, bank->base +
> +					OMAP24XX_GPIO_LEVELDETECT0);
> +			__raw_writel(old1 | gen, bank->base +
> +					OMAP24XX_GPIO_LEVELDETECT1);
>  			__raw_writel(old0, bank->base + OMAP24XX_GPIO_LEVELDETECT0);
>  			__raw_writel(old1, bank->base + OMAP24XX_GPIO_LEVELDETECT1);
>  #endif
> -- 
> 1.6.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
