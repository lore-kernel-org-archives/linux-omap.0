From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] [OMAP] GPIO Module disable if all pins inactive
Date: Fri, 23 Oct 2009 19:35:35 -0500
Message-ID: <4AE24BD7.2040506@ti.com>
References: <1256313317-24653-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57050 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751504AbZJXAfb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Oct 2009 20:35:31 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9O0Zaqv006450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 19:35:36 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id n9O0Zags027883
	for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 19:35:36 -0500 (CDT)
Received: from dlee73.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id n9O0Za1v006053
	for <linux-omap@vger.kernel.org>; Fri, 23 Oct 2009 19:35:36 -0500 (CDT)
In-Reply-To: <1256313317-24653-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Varadarajan, Charu Latha" <charu@ti.com>

Varadarajan, Charu Latha had written, on 10/23/2009 10:55 AM, the following:
> From: Charulatha V <charu@ti.com>
> 
> This patch disables a GPIO module when all the pins of GPIO
> module are inactive (clock gating forced at module level) and
> enables the module when any gpio in the module is requested.
> 
> Signed-off-by: Charulatha V <charu@ti.com>
> ---
>  arch/arm/plat-omap/gpio.c |   22 ++++++++++++++++++++++
>  1 files changed, 22 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index cdc2a58..2304a5d 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -194,6 +194,7 @@ struct gpio_bank {
>  	spinlock_t lock;
>  	struct gpio_chip chip;
>  	struct clk *dbck;
> +	u32 gpio_status;
please rename this as gpio_usage?

maybe OMAP1 could also benefit out of this..
>  };
>  
>  #define METHOD_MPUIO		0
> @@ -1080,6 +1081,7 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
>  {
>  	struct gpio_bank *bank = container_of(chip, struct gpio_bank, chip);
>  	unsigned long flags;
> +	u32 ctrl = 0;
Remove this to the {} no point in wasting stack space when you dont need 
to + you will generate warning for OMAP1 platforms.
>  
>  	spin_lock_irqsave(&bank->lock, flags);
>  
> @@ -1097,6 +1099,15 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
>  		__raw_writel(__raw_readl(reg) | (1 << offset), reg);
>  	}
>  #endif
> +	if (cpu_is_omap24xx() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
> +		if (!bank->gpio_status) {
> +			ctrl = __raw_readl(bank->base + OMAP24XX_GPIO_CTRL);
> +			/* Module is enabled, clocks are not gated */
> +			ctrl &= 0xFFFFFFFE;
> +			__raw_writel(ctrl, bank->base + OMAP24XX_GPIO_CTRL);
> +		}
> +		bank->gpio_status |= 1 << offset;
> +	}
why do this every time a gpio is enabled? why not do this iff gpio was
never used before.. how about the following:
if (!bank->gpio_status && (cpu_is_omap24xx() || cpu_is_omap34xx() ||
cpu_is_omap44xx())) {
	u32 ctrl = __raw_readl(bank->base + OMAP24XX_GPIO_CTRL);
	/* Module is enabled, clocks are not gated */
	ctrl &= 0xFFFFFFFE;
	__raw_writel(ctrl, bank->base + OMAP24XX_GPIO_CTRL);
}
bank->gpio_status |= 1 << offset;
>  	spin_unlock_irqrestore(&bank->lock, flags);
>  
>  	return 0;
> @@ -1106,6 +1117,7 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
>  {
>  	struct gpio_bank *bank = container_of(chip, struct gpio_bank, chip);
>  	unsigned long flags;
> +	u32 ctrl = 0;
used just once -> move it to the {} + warning to OMAP1
>  
>  	spin_lock_irqsave(&bank->lock, flags);
>  #ifdef CONFIG_ARCH_OMAP16XX
> @@ -1123,6 +1135,15 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
>  		__raw_writel(1 << offset, reg);
>  	}
>  #endif
> +	if (cpu_is_omap24xx() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
> +		bank->gpio_status &= ~(1 << offset);
> +		if (!bank->gpio_status) {
> +			ctrl = __raw_readl(bank->base + OMAP24XX_GPIO_CTRL);
> +			/* Module is disabled, clocks are gated */
> +			ctrl |= 1;
> +			__raw_writel(ctrl, bank->base + OMAP24XX_GPIO_CTRL);
> +		}
> +	}
how about this:
	bank->gpio_status &= ~(1 << offset);
if (!bank->gpio_status && (cpu_is_omap24xx() || cpu_is_omap34xx() ||
cpu_is_omap44xx())) {
	u32 ctrl = __raw_readl(bank->base + OMAP24XX_GPIO_CTRL);
	/* Module is disabled, clocks are gated */
	ctrl |= 1;
	__raw_writel(ctrl, bank->base + OMAP24XX_GPIO_CTRL);
}
>  	_reset_gpio(bank, bank->chip.base + offset);
>  	spin_unlock_irqrestore(&bank->lock, flags);
>  }
> @@ -1700,6 +1721,7 @@ static int __init _omap_gpio_init(void)
>  			gpio_count = 32;
>  		}
>  #endif
> +		bank->gpio_status = 0;
>  		/* REVISIT eventually switch from OMAP-specific gpio structs
>  		 * over to the generic ones
>  		 */

Regards,
Nishanth Menon
