From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2] [OMAP] GPIO Module disable when all pins are
 inactive
Date: Mon, 9 Nov 2009 13:03:49 -0800
Message-ID: <20091109210349.GC23952@atomide.com>
References: <1257776766-8884-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:65008 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754074AbZKIVDp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Nov 2009 16:03:45 -0500
Content-Disposition: inline
In-Reply-To: <1257776766-8884-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: charu@ti.com
Cc: linux-omap@vger.kernel.org

* charu@ti.com <charu@ti.com> [091109 06:25]:
> From: Charulatha V <charu@ti.com>
> 
> This patch disables a GPIO module when all pins of a GPIO
> module are inactive (clock gating forced at module level) and
> enables the module when any gpio in the module is requested.
> 
> The module is enabled only when mod_usage indicates that no GPIO
> in that  module is currently active and the GPIO being requested
> is the 1st one to be active in that module.
> 
> Each module would be disabled in omap_gpio_free() API when all
> GPIOs in a particular module becomes inactive. The module is
> re-enabled in omap_gpio_request() API when a GPIO is requested
> from the module that was previously disabled.
> 
> Since individual GPIO's bookkeeping is introduced automatically
> in this patch(mod_usage), the same is used in omap_set_gpio_debounce()
> & omap_set_gpio_debounce_time() APIs to ensure that the gpio being
> used is actually "requested" prior to being used (Nishant Menon's
> <nm@ti.com> Suggestion)
> 
> Higher layer keeps track of GPIOs individually. This patch
> introduces bookkeeping information, modulewise in lower layer
> since disabling clock is done at module level. GPIO module level
> details are specific to hardware and introducing APIs in higher
> level layer to handle them might not be correct. Hence GPIO module
> level information (mod_usage) has to be handled only in
> low-level layer.
> 
> Signed-off-by: Charulatha V <charu@ti.com>
> Acked-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/plat-omap/gpio.c |   35 +++++++++++++++++++++++++++++++++++
>  1 files changed, 35 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index 4c35f9f..5ee6a60 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -199,6 +199,7 @@ struct gpio_bank {
>  	struct gpio_chip chip;
>  	struct clk *dbck;
>  	u32 dbck_enable_mask;
> +	u32 mod_usage;
>  };
>  
>  #define METHOD_MPUIO		0
> @@ -691,6 +692,12 @@ void omap_set_gpio_debounce(int gpio, int enable)
>  	reg += OMAP24XX_GPIO_DEBOUNCE_EN;
>  #endif
>  
> +	if ((cpu_is_omap24xx() || cpu_is_omap34xx() || cpu_is_omap44xx())
> +			&& (!(bank->mod_usage & l))) {
> +		printk(KERN_ERR "GPIO not requested\n");
> +		return;
> +	}
> +
>  	spin_lock_irqsave(&bank->lock, flags);
>  	val = __raw_readl(reg);
>  
> @@ -726,6 +733,12 @@ void omap_set_gpio_debounce_time(int gpio, int enc_time)
>  	bank = get_gpio_bank(gpio);
>  	reg = bank->base;
>  
> +	if ((cpu_is_omap24xx() || cpu_is_omap34xx() || cpu_is_omap44xx())
> +			&& (!bank->mod_usage)) {
> +		printk(KERN_ERR "GPIO not requested\n");
> +		return;
> +	}
> +
>  	enc_time &= 0xff;
>  #ifdef CONFIG_ARCH_OMAP4
>  	reg += OMAP4_GPIO_DEBOUNCINGTIME;

Please just use:

	if (!cpu_class_is_omap1()) {
		...
	}

> @@ -1219,6 +1232,16 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
>  		__raw_writel(__raw_readl(reg) | (1 << offset), reg);
>  	}
>  #endif
> +	if (cpu_is_omap24xx() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
> +		u32 ctrl;
> +		if (!bank->mod_usage) {
> +			ctrl = __raw_readl(bank->base + OMAP24XX_GPIO_CTRL);
> +			/* Module is enabled, clocks are not gated */
> +			ctrl &= 0xFFFFFFFE;
> +			__raw_writel(ctrl, bank->base + OMAP24XX_GPIO_CTRL);
> +		}
> +		bank->mod_usage |= 1 << offset;
> +	}
>  	spin_unlock_irqrestore(&bank->lock, flags);
>  
>  	return 0;

Here too.


> @@ -1245,6 +1268,16 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
>  		__raw_writel(1 << offset, reg);
>  	}
>  #endif
> +	if (cpu_is_omap24xx() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
> +		u32 ctrl;
> +		bank->mod_usage &= ~(1 << offset);
> +		if (!bank->mod_usage) {
> +			ctrl = __raw_readl(bank->base + OMAP24XX_GPIO_CTRL);
> +			/* Module is disabled, clocks are gated */
> +			ctrl |= 1;
> +			__raw_writel(ctrl, bank->base + OMAP24XX_GPIO_CTRL);
> +		}
> +	}
>  	_reset_gpio(bank, bank->chip.base + offset);
>  	spin_unlock_irqrestore(&bank->lock, flags);
>  }

Here too.


> @@ -1879,6 +1912,8 @@ static int __init _omap_gpio_init(void)
>  			gpio_count = 32;
>  		}
>  #endif
> +
> +		bank->mod_usage = 0;
>  		/* REVISIT eventually switch from OMAP-specific gpio structs
>  		 * over to the generic ones
>  		 */
> -- 
> 1.6.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
