From: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
Subject: Re: [PATCH] gpio: omap: Fix regression for MPUIO interrupts
Date: Fri, 24 Apr 2015 17:58:29 +0300
Message-ID: <553A5A15.1030605@linaro.org>
References: <1429833257-28188-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1429833257-28188-1-git-send-email-tony@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Felipe Balbi <balbi@ti.com>, Javier Martinez Canillas <javier@dowhile0.org>, Kevin Hilman <khilman@deeprootsystems.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
List-Id: linux-omap@vger.kernel.org

On 04/24/2015 02:54 AM, Tony Lindgren wrote:
> At some point with all the GPIO clean-up we've broken the
> MPUIO interrupts. Those are just a little bit different from
> the GPIO interrupts, so we can fix it up just by setting
> different irqchip functions for it. And then we can just
> remove all old code trying to do the same.

Reviewed-by: Grygorii Strashko <grygorii.strashko@linaro.org>

>
> Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Cc: Grygorii Strashko <grygorii.strashko@linaro.org>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>   drivers/gpio/gpio-omap.c | 48 +++++++++---------------------------------------
>   1 file changed, 9 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 6553361..b59c3ca 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -1023,38 +1023,8 @@ static void omap_gpio_mod_init(struct gpio_bank *bank)
>   		dev_err(bank->dev, "Could not get gpio dbck\n");
>   }
>
> -static void
> -omap_mpuio_alloc_gc(struct gpio_bank *bank, unsigned int irq_start,
> -		    unsigned int num)
> -{
> -	struct irq_chip_generic *gc;
> -	struct irq_chip_type *ct;
> -
> -	gc = irq_alloc_generic_chip("MPUIO", 1, irq_start, bank->base,
> -				    handle_simple_irq);
> -	if (!gc) {
> -		dev_err(bank->dev, "Memory alloc failed for gc\n");
> -		return;
> -	}
> -
> -	ct = gc->chip_types;
> -
> -	/* NOTE: No ack required, reading IRQ status clears it. */
> -	ct->chip.irq_mask = irq_gc_mask_set_bit;
> -	ct->chip.irq_unmask = irq_gc_mask_clr_bit;
> -	ct->chip.irq_set_type = omap_gpio_irq_type;
> -
> -	if (bank->regs->wkup_en)
> -		ct->chip.irq_set_wake = omap_gpio_wake_enable;
> -
> -	ct->regs.mask = OMAP_MPUIO_GPIO_INT / bank->stride;
> -	irq_setup_generic_chip(gc, IRQ_MSK(num), IRQ_GC_INIT_MASK_CACHE,
> -			       IRQ_NOREQUEST | IRQ_NOPROBE, 0);
> -}
> -
>   static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
>   {
> -	int j;
>   	static int gpio;
>   	int irq_base = 0;
>   	int ret;
> @@ -1101,6 +1071,15 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
>   	}
>   #endif
>
> +	/* MPUIO is a bit different, reading IRQ status clears it */
> +	if (bank->is_mpuio) {
> +		irqc->irq_ack = dummy_irq_chip.irq_ack;
> +		irqc->irq_mask = irq_gc_mask_set_bit;
> +		irqc->irq_unmask = irq_gc_mask_clr_bit;
> +		if (!bank->regs->wkup_en)
> +			irqc->irq_set_wake = NULL;
> +	}
> +
>   	ret = gpiochip_irqchip_add(&bank->chip, irqc,
>   				   irq_base, omap_gpio_irq_handler,
>   				   IRQ_TYPE_NONE);
> @@ -1114,15 +1093,6 @@ static int omap_gpio_chip_init(struct gpio_bank *bank, struct irq_chip *irqc)
>   	gpiochip_set_chained_irqchip(&bank->chip, irqc,
>   				     bank->irq, omap_gpio_irq_handler);
>
> -	for (j = 0; j < bank->width; j++) {
> -		int irq = irq_find_mapping(bank->chip.irqdomain, j);
> -		if (bank->is_mpuio) {
> -			omap_mpuio_alloc_gc(bank, irq, bank->width);
> -			irq_set_chip_and_handler(irq, NULL, NULL);
> -			set_irq_flags(irq, 0);
> -		}
> -	}
> -
>   	return 0;
>   }
>
>


-- 
regards,
-grygorii
