From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] gpio/omap: auto-setup a GPIO when used as an IRQ
Date: Mon, 23 Sep 2013 09:45:19 -0700
Message-ID: <20130923164519.GF2684@atomide.com>
References: <1379860848-29020-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1379860848-29020-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-gpio-owner@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Lars Poeschel <larsi@wh2.tu-dresden.de>, Grant Likely <grant.likely@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ian.campbell@citrix.com>, Kumar Gala <galak@codeaurora.org>, Pawel Moll <pawel.moll@arm.com>, Tomasz Figa <tomasz.figa@gmail.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Balaji T K <balajitk@ti.com>, Jon Hunter <jgchunter@gmail.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Javier Martinez Canillas <javier.martinez@collabora.co.uk> [130922 07:49]:
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -420,6 +420,29 @@ static int _set_gpio_triggering(struct gpio_bank *bank, int gpio,
>  	return 0;
>  }
>  
> +static void _set_gpio_mode(struct gpio_bank *bank, unsigned offset)
> +{
> +	if (bank->regs->pinctrl) {
> +		void __iomem *reg = bank->base + bank->regs->pinctrl;
> +
> +		/* Claim the pin for MPU */
> +		__raw_writel(__raw_readl(reg) | (1 << offset), reg);
> +	}
> +
> +	if (bank->regs->ctrl && !bank->mod_usage) {
> +		void __iomem *reg = bank->base + bank->regs->ctrl;
> +		u32 ctrl;
> +
> +		ctrl = __raw_readl(reg);
> +		/* Module is enabled, clocks are not gated */
> +		ctrl &= ~GPIO_MOD_CTRL_BIT;
> +		__raw_writel(ctrl, reg);
> +		bank->context.ctrl = ctrl;
> +	}
> +
> +	bank->mod_usage |= 1 << offset;
> +}
> +
>  static int gpio_irq_type(struct irq_data *d, unsigned type)
>  {
>  	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
> @@ -427,8 +450,8 @@ static int gpio_irq_type(struct irq_data *d, unsigned type)
>  	int retval;
>  	unsigned long flags;
>  
> -	if (WARN_ON(!bank->mod_usage))
> -		return -EINVAL;
> +	if (!bank->mod_usage)
> +		pm_runtime_get_sync(bank->dev);
>  
>  #ifdef CONFIG_ARCH_OMAP1
>  	if (d->irq > IH_MPUIO_BASE)
> @@ -438,6 +461,11 @@ static int gpio_irq_type(struct irq_data *d, unsigned type)
>  	if (!gpio)
>  		gpio = irq_to_gpio(bank, d->hwirq);
>  
> +	spin_lock_irqsave(&bank->lock, flags);
> +	_set_gpio_mode(bank, GPIO_INDEX(bank, gpio));
> +	_set_gpio_direction(bank, GPIO_INDEX(bank, gpio), 1);
> +	spin_unlock_irqrestore(&bank->lock, flags);
> +
>  	if (type & ~IRQ_TYPE_SENSE_MASK)
>  		return -EINVAL;
>  

Hmm does this still work for legacy platform data based
drivers that are doing gpio_request() first?

And what's the path for clearing things for PM when free_irq()
gets called? It seems that this would leave the GPIO bank
enabled causing a PM regression?

Other than the two concerns above it seems that this might
be the way to go to fix the regression for the -rc cycle.

Regards,

Tony
