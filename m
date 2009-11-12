From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V3] [OMAP] GPIO module enable/disable
Date: Thu, 12 Nov 2009 14:28:25 -0800
Message-ID: <20091112222824.GG24837@atomide.com>
References: <1257856118-30950-1-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61616 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753656AbZKLW2V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Nov 2009 17:28:21 -0500
Content-Disposition: inline
In-Reply-To: <1257856118-30950-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: charu@ti.com
Cc: linux-omap@vger.kernel.org

* charu@ti.com <charu@ti.com> [091110 04:28]:
> From: Charulatha V <charu@ti.com>
> 
> This patch disables a GPIO module when all pins of a GPIO
> module are inactive (clock gating forced at module level) and
> enables the module when any gpio in the module is requested.
> 
> The module is enabled only when "mod_usage" indicates that no GPIO
> in that module is currently active and the GPIO being requested
> is the 1st one to be active in that module.
> 
> Each module would be disabled in omap_gpio_free() API when all
> GPIOs in a particular module becomes inactive. The module is
> re-enabled in omap_gpio_request() API when a GPIO is requested
> from the module that was previously disabled.
> 
> Since individual GPIO's bookkeeping is added in this patch
> via "mod_usage", the same is used in omap_set_gpio_debounce()
> & omap_set_gpio_debounce_time() APIs to ensure that the gpio being
> used is actually "requested" prior to being used (Nishant Menon's
> Suggestion <nm@ti.com>)
> 
> GPIO module level details are specific to hardware and hence
> introducing this patch in low level layer (plat-omap/gpio.c)

Looks like this needs to be refreshed against current for-next
branch in linux-omap.

Regards,

Tony
 
> Signed-off-by: Charulatha V <charu@ti.com>
> Acked-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/plat-omap/gpio.c |   32 ++++++++++++++++++++++++++++++++
>  1 files changed, 32 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index 4c35f9f..06a391b 100644
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
> @@ -690,6 +691,10 @@ void omap_set_gpio_debounce(int gpio, int enable)
>  #else
>  	reg += OMAP24XX_GPIO_DEBOUNCE_EN;
>  #endif
> +	if (!(bank->mod_usage & l)) {
> +		printk(KERN_ERR "GPIO %d not requested\n", gpio);
> +		return;
> +	}
>  
>  	spin_lock_irqsave(&bank->lock, flags);
>  	val = __raw_readl(reg);
> @@ -726,6 +731,11 @@ void omap_set_gpio_debounce_time(int gpio, int enc_time)
>  	bank = get_gpio_bank(gpio);
>  	reg = bank->base;
>  
> +	if (!bank->mod_usage) {
> +		printk(KERN_ERR "GPIO not requested\n");
> +		return;
> +	}
> +
>  	enc_time &= 0xff;
>  #ifdef CONFIG_ARCH_OMAP4
>  	reg += OMAP4_GPIO_DEBOUNCINGTIME;
> @@ -1219,6 +1229,16 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
>  		__raw_writel(__raw_readl(reg) | (1 << offset), reg);
>  	}
>  #endif
> +	if (!cpu_class_is_omap1()) {
> +		if (!bank->mod_usage) {
> +			u32 ctrl;
> +			ctrl = __raw_readl(bank->base + OMAP24XX_GPIO_CTRL);
> +			ctrl &= 0xFFFFFFFE;
> +			/* Module is enabled, clocks are not gated */
> +			__raw_writel(ctrl, bank->base + OMAP24XX_GPIO_CTRL);
> +		}
> +		bank->mod_usage |= 1 << offset;
> +	}
>  	spin_unlock_irqrestore(&bank->lock, flags);
>  
>  	return 0;
> @@ -1245,6 +1265,16 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
>  		__raw_writel(1 << offset, reg);
>  	}
>  #endif
> +	if (!cpu_class_is_omap1()) {
> +		bank->mod_usage &= ~(1 << offset);
> +		if (!bank->mod_usage) {
> +			u32 ctrl;
> +			ctrl = __raw_readl(bank->base + OMAP24XX_GPIO_CTRL);
> +			/* Module is disabled, clocks are gated */
> +			ctrl |= 1;
> +			__raw_writel(ctrl, bank->base + OMAP24XX_GPIO_CTRL);
> +		}
> +	}
>  	_reset_gpio(bank, bank->chip.base + offset);
>  	spin_unlock_irqrestore(&bank->lock, flags);
>  }
> @@ -1879,6 +1909,8 @@ static int __init _omap_gpio_init(void)
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
