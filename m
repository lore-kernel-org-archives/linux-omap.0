From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] gpio: do not set up hardware for IRQ_TYPE_NONE
Date: Wed, 23 Apr 2014 10:11:56 -0500
Message-ID: <5357D83C.1040904@ti.com>
References: <1398264610-12663-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1398264610-12663-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org
Cc: Alexandre Courbot <acourbot@nvidia.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Javier Martinez Canillas <javier@dowhile0.org>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 04/23/2014 09:50 AM, Linus Walleij wrote:
> Some GPIO irqchip drivers exploit the irqdomain mapping
> function to set up the IRQ default type in the hardware,
> make sure that if we pass IRQ_TYPE_NONE, no hardware setup
> whatsoever takes place (this should be the norm) until
> later when the IRQ gets utilized.
> 
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: linux-omap <linux-omap@vger.kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> TI folks: can you provide a Tested-by tag if this makes your
> OMAPs work? I am pretty sure the other platforms will be
> unaffected, if they aren't I will switch them over to react
> to IRQ_TYPE_DEFAULT.

Tested-by: Nishanth Menon <nm@ti.com>

AM335x-sk (which fails to boot previously), now with this patch:
	http://slexy.org/raw/s20dMOz3ke
Discussion thread: http://marc.info/?t=139817273800014&r=1&w=2

> ---
>  drivers/gpio/gpiolib.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index ee1819fdcf35..97d173e9aa2d 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -1409,7 +1409,12 @@ static int gpiochip_irq_map(struct irq_domain *d, unsigned int irq,
>  #else
>  	irq_set_noprobe(irq);
>  #endif
> -	irq_set_irq_type(irq, chip->irq_default_type);
> +	/*
> +	 * No set-up of the hardware will happen if IRQ_TYPE_NONE
> +	 * is passed as default type.
> +	 */
> +	if (chip->irq_default_type != IRQ_TYPE_NONE)
> +		irq_set_irq_type(irq, chip->irq_default_type);
>  
>  	return 0;
>  }
> @@ -1490,7 +1495,8 @@ static void gpiochip_irqchip_remove(struct gpio_chip *gpiochip)
>   * @first_irq: if not dynamically assigned, the base (first) IRQ to
>   * allocate gpiochip irqs from
>   * @handler: the irq handler to use (often a predefined irq core function)
> - * @type: the default type for IRQs on this irqchip
> + * @type: the default type for IRQs on this irqchip, pass IRQ_TYPE_NONE
> + * to have the core avoid setting up any default type in the hardware.
>   *
>   * This function closely associates a certain irqchip with a certain
>   * gpiochip, providing an irq domain to translate the local IRQs to
> 

Acked-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
