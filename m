From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2] [OMAP] gpio: Simultaneously requested rising and falling edge
Date: Mon, 14 Dec 2009 08:24:30 -0800
Message-ID: <87eimxed6p.fsf@deeprootsystems.com>
References: <1260581153-4472-1-git-send-email-darkstar6262@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:29808 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757792AbZLNQYd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Dec 2009 11:24:33 -0500
Received: by qw-out-2122.google.com with SMTP id 3so694848qwe.37
        for <linux-omap@vger.kernel.org>; Mon, 14 Dec 2009 08:24:32 -0800 (PST)
In-Reply-To: <1260581153-4472-1-git-send-email-darkstar6262@gmail.com> (Cory Maccarrone's message of "Fri\, 11 Dec 2009 17\:25\:53 -0800")
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
> Additionally, current code forces rising edge detection if both
> flags are specified:
>
>         if (trigger & IRQ_TYPE_EDGE_RISING)
>                 l |= 1 << gpio;
>         else if (trigger & IRQ_TYPE_EDGE_FALLING)
>                 l &= ~(1 << gpio);
>         else
>                 goto bad;
>
> This change implements a toggle function that will modify the ICR
> to flip the direction of interrupt for IRQs that are requested with
> both rising and falling flags.  The toggle function is not called
> for chips and GPIOs it does not apply to through the use of a flip_mask
> that's added on a per-bank basis.  The mask is only set for those
> GPIOs where a toggle is necessary.  Edge detection starts out the
> same as above with FALLING mode first.
>
> The toggle happens on EACH interrupt; without it, we have the
> following sequence of actions on GPIO transition:
>
>   ICR    GPIO               Result
>   0x1    0 -> 1 (rising)    Interrupt
>   0x1    1 -> 0 (falling)   No interrupt
>
>   (set ICR to 0x0 manually)
>   0x0    0 -> 1 (rising)    No interrupt
>   0x0    1 -> 0 (falling)   Interrupt
>
> That is, with the ICR set to 1 for a gpio, only rising edge interrupts
> are caught, and with it set to 0, only falling edge interrupts are
> caught.  If we add in the toggle, we get this:
>
>   ICR    GPIO               Result
>   0x1    0 -> 1 (rising)    Interrupt (ICR set to 0x0)
>   0x0    1 -> 0 (falling)   Interrupt (ICR set to 0x1)
>   0x1    0 -> 1 ...
>
> so, both rising and falling are caught, per the request for both
> (IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING).
>
> Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>

Much better changelog, very thorough.  And I like the approach on this
version better as well.

Please run this through scripts/checkpatch.pl and fix the issues
reported there.

Just a few minor comments below...

> ---
>  arch/arm/plat-omap/gpio.c |   59 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 58 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index 055160e..a05c83d 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -192,6 +192,7 @@ struct gpio_bank {
>  	u32 saved_risingdetect;
>  #endif
>  	u32 level_mask;
> +	u32 flip_mask;

Maybe toggle_mask is a better name since you call this toggle in the
rest of your code.


>  	spinlock_t lock;
>  	struct gpio_chip chip;
>  	struct clk *dbck;
> @@ -749,6 +750,44 @@ static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
>  }
>  #endif
>  
> +/*
> + * This only applies to chips that can't do both rising and falling edge
> + * detection at once.  For all other chips, this function is a noop.
> + */
> +static void _toggle_gpio_edge_triggering(struct gpio_bank *bank, int gpio)
> +{
> +	void __iomem *reg = bank->base;
> +	u32 l = 0;
> +
> +	switch (bank->method) {
> +#ifdef CONFIG_ARCH_OMAP1
> +	case METHOD_MPUIO:
> +		reg += OMAP_MPUIO_GPIO_INT_EDGE;
> +		break;
> +#endif
> +#ifdef CONFIG_ARCH_OMAP15XX
> +	case METHOD_GPIO_1510:
> +		reg += OMAP1510_GPIO_INT_CONTROL;
> +		break;
> +#endif
> +#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
> +	case METHOD_GPIO_7XX:
> +		reg += OMAP7XX_GPIO_INT_CONTROL;
> +		break;
> +#endif
> +	default:
> +		return;
> +	}
> +
> +	l = __raw_readl(reg);
> +	if ((l >> gpio) & 1)
> +		l &= ~(1 << gpio);
> +	else
> +		l |= 1 << gpio;
> +
> +	__raw_writel(l, reg);
> +}
> +
>  static int _set_gpio_triggering(struct gpio_bank *bank, int gpio, int trigger)
>  {
>  	void __iomem *reg = bank->base;
> @@ -759,6 +798,8 @@ static int _set_gpio_triggering(struct gpio_bank *bank, int gpio, int trigger)
>  	case METHOD_MPUIO:
>  		reg += OMAP_MPUIO_GPIO_INT_EDGE;
>  		l = __raw_readl(reg);
> +		if (trigger & IRQ_TYPE_EDGE_RISING && trigger & IRQ_TYPE_EDGE_FALLING)

You could use this instead

                if (trigger & IRQ_TYPE_EDGE_BOTH)

and it will also solve the checkpatch warning about the long lines
here.

same for other instances of this below.

> +			bank->flip_mask |= 1 << gpio;
>  		if (trigger & IRQ_TYPE_EDGE_RISING)
>  			l |= 1 << gpio;
>  		else if (trigger & IRQ_TYPE_EDGE_FALLING)
> @@ -771,6 +812,8 @@ static int _set_gpio_triggering(struct gpio_bank *bank, int gpio, int trigger)
>  	case METHOD_GPIO_1510:
>  		reg += OMAP1510_GPIO_INT_CONTROL;
>  		l = __raw_readl(reg);
> +		if (trigger & IRQ_TYPE_EDGE_RISING && trigger & IRQ_TYPE_EDGE_FALLING)
> +			bank->flip_mask |= 1 << gpio;
>  		if (trigger & IRQ_TYPE_EDGE_RISING)
>  			l |= 1 << gpio;
>  		else if (trigger & IRQ_TYPE_EDGE_FALLING)
> @@ -803,6 +846,8 @@ static int _set_gpio_triggering(struct gpio_bank *bank, int gpio, int trigger)
>  	case METHOD_GPIO_7XX:
>  		reg += OMAP7XX_GPIO_INT_CONTROL;
>  		l = __raw_readl(reg);
> +		if (trigger & IRQ_TYPE_EDGE_RISING && trigger & IRQ_TYPE_EDGE_FALLING)
> +			bank->flip_mask |= 1 << gpio;
>  		if (trigger & IRQ_TYPE_EDGE_RISING)
>  			l |= 1 << gpio;
>  		else if (trigger & IRQ_TYPE_EDGE_FALLING)
> @@ -1217,7 +1262,7 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
>  {
>  	void __iomem *isr_reg = NULL;
>  	u32 isr;
> -	unsigned int gpio_irq;
> +	unsigned int gpio_irq, gpio_index;
>  	struct gpio_bank *bank;
>  	u32 retrigger = 0;
>  	int unmasked = 0;
> @@ -1284,9 +1329,21 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
>  
>  		gpio_irq = bank->virtual_irq_start;
>  		for (; isr != 0; isr >>= 1, gpio_irq++) {
> +			gpio_index = get_gpio_index(irq_to_gpio(gpio_irq));
> +
>  			if (!(isr & 1))
>  				continue;
>  

For better optimizaion for builds without OMAP1 support, you should wrap
this part:

#ifdef CONFIG_ARCH_OMAP1

> +			/*
> +			 * Some chips can't respond to both rising and falling at the
> +			 * same time.  If this irq was requested with both flags, we
> +			 * need to flip the ICR data for the IRQ to respond to the
> +			 * IRQ for the opposite direction.  This will be indicated in
> +			 * the bank flip_mask.
> +			 */

> +			if ((bank->flip_mask >> gpio_index) & 1)

minor nit, but elsewhere in the GPIO code we tend to mask with (1 <<
gpio_index).  So, for consistency,  this should be

                        if (bank->flip_mask && (1 << gpio_index))

> +				_toggle_gpio_edge_triggering(bank, gpio_index);
> +
>  			generic_handle_irq(gpio_irq);
>  		}
>  	}

#endif

Kevin
