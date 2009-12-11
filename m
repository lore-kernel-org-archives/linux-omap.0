From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] [OMAP] gpio: Simultaneously requested rising and falling edge
Date: Fri, 11 Dec 2009 08:07:07 -0800
Message-ID: <873a3hmr4k.fsf@deeprootsystems.com>
References: <1260503994-27823-1-git-send-email-darkstar6262@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:57694 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933635AbZLKQHD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Dec 2009 11:07:03 -0500
Received: by pwj9 with SMTP id 9so661343pwj.21
        for <linux-omap@vger.kernel.org>; Fri, 11 Dec 2009 08:07:09 -0800 (PST)
In-Reply-To: <1260503994-27823-1-git-send-email-darkstar6262@gmail.com> (Cory Maccarrone's message of "Thu\, 10 Dec 2009 19\:59\:54 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: linux-omap@vger.kernel.org

Cory Maccarrone <darkstar6262@gmail.com> writes:

> Some chips, namely any OMAP1 chips using METHOD_MPUIO,
> OMAP15xx and OMAP7xx, cannot be setup to respond to on-chip GPIO
> interrupts in both rising and falling edge directions -- they can
> only respond to one direction or the other, depending on how the
> ICR is configured.
>
> This change implements a toggle function that will modify the ICR
> to flip the direction of interrupt for IRQs that are requested with
> both rising and falling flags.  The toggle function is a noop for
> chips and GPIOs it does not apply to.

I think this needs a little more description.  In particular you
should describe that this toggle happens on *every* interrupt, and
why.

Also, it's not exactly a noop for non-OMAP1.  More on this below...

> Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
> ---
>  arch/arm/plat-omap/gpio.c |   60 +++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 60 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index 055160e..b594398 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -749,6 +749,53 @@ static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
>  }
>  #endif
>  
> +/*
> + * This only applies to chips that can't do both rising and falling edge
> + * detection at once.  For all other chips, this function is a noop.
> + */

Not exactly a noop.  This function is called for non-OMAP1 as well...

> +static void _toggle_gpio_edge_triggering(struct gpio_bank *bank, int gpio)
> +{
> +	void __iomem *reg = bank->base;
> +	u32 l = 0;
> +
> +	switch (bank->method) {
> +#ifdef CONFIG_ARCH_OMAP1
> +	case METHOD_MPUIO:
> +		reg += OMAP_MPUIO_GPIO_INT_EDGE;
> +		l = __raw_readl(reg);
> +		if ((l >> gpio) & 1)
> +			l &= ~(1 << gpio);
> +		else
> +			l |= 1 << gpio;
> +		break;
> +#endif
> +#ifdef CONFIG_ARCH_OMAP15XX
> +	case METHOD_GPIO_1510:
> +		reg += OMAP1510_GPIO_INT_CONTROL;
> +		l = __raw_readl(reg);
> +		if ((l >> gpio) & 1)
> +			l &= ~(1 << gpio);
> +		else
> +			l |= 1 << gpio;
> +		break;
> +#endif
> +#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
> +	case METHOD_GPIO_7XX:
> +		reg += OMAP7XX_GPIO_INT_CONTROL;
> +		l = __raw_readl(reg);
> +		if ((l >> gpio) & 1) {
> +			l &= ~(1 << gpio);
> +		} else {
> +			l |= 1 << gpio;
> +		}
> +		break;
> +#endif
> +	default:
> +		return;
> +	}
> +	__raw_writel(l, reg);

...and will write a zero to offset zero of the GPIO bank regs
(GPIO_REVISION reg).  While ths is a read-only reg and *should* have
no effect, the point is that this function should not be called for
non-OMAP1.

> +}
> +
>  static int _set_gpio_triggering(struct gpio_bank *bank, int gpio, int trigger)
>  {
>  	void __iomem *reg = bank->base;
> @@ -1284,9 +1331,22 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
>  
>  		gpio_irq = bank->virtual_irq_start;
>  		for (; isr != 0; isr >>= 1, gpio_irq++) {
> +			struct irq_desc *desc = irq_to_desc(gpio_irq);
>  			if (!(isr & 1))
>  				continue;
>  
> +			/*
> +			 * Some chips can't respond to both rising and falling at the
> +			 * same time.  If this irq was requested with both flags, we
> +			 * need to flip the ICR data for the IRQ to respond to the
> +			 * IRQ for the opposite direction.
> +			 */
> +			if (desc->status & IRQ_TYPE_EDGE_FALLING &&
> +			    desc->status & IRQ_TYPE_EDGE_RISING)
> +				_toggle_gpio_edge_triggering(
> +						get_irq_chip_data(gpio_irq),
> +						get_gpio_index(irq_to_gpio(gpio_irq)));
> +

Rather than check the flags on every interrupt, it may be better to
create a per-bank mask for GPIOs that need this treatment.  

The code that sets that flag could be conditional on OMAP1 and also on
whether both edges are set.

>  			generic_handle_irq(gpio_irq);
>  		}
>  	}

Kevin
