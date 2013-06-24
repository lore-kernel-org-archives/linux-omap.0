From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH v2 1/2] gpio/omap: don't create an IRQ mapping for every GPIO on DT
Date: Mon, 24 Jun 2013 13:53:47 +0100
Message-ID: <20130624125347.43AE73E0A89@localhost>
References: <[PATCH v2 0/2]: auto request GPIO as input if used as IRQ via DT> <1371855054-27958-1-git-send-email-javier.martinez@collabora.co.uk> <1371855054-27958-2-git-send-email-javier.martinez@collabora.co.uk>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f178.google.com ([209.85.215.178]:62690 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750872Ab3FXMxv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Jun 2013 08:53:51 -0400
Received: by mail-ea0-f178.google.com with SMTP id l15so5961027eak.37
        for <linux-omap@vger.kernel.org>; Mon, 24 Jun 2013 05:53:50 -0700 (PDT)
In-Reply-To: <1371855054-27958-2-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: jgchunter@gmail.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, eballetbo@gmail.com, thomas.petazzoni@free-electrons.com, linux-omap@vger.kernel.org, Florian Vaussard <florian.vaussard@epfl.ch>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

On Sat, 22 Jun 2013 00:50:53 +0200, Javier Martinez Canillas <javier.martinez@collabora.co.uk> wrote:
> When a GPIO is defined as an interrupt line using Device
> Tree, a call to irq_create_of_mapping() is made that calls
> irq_create_mapping(). So, is not necessary to do the mapping
> on the OMAP GPIO platform_driver and in fact is wrong to
> assume that all GPIO lines will be used as an IRQ.
> 
> Add a custom IRQ domain .map function handler that will be
> called by the IRQ core to map only the GPIO lines used as
> IRQ. This also allows to execute needed setup code such as
> configuring a GPIO as input and enabling the GPIO bank.
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
> 
> Changes since v1:
>   - Split the addition of the .map function handler and the
>     automatic gpio request in two different patches.
>   - Add GPIO IRQ setup logic to the irq domain mapping function.
>   - Only call irq_create_mapping for every GPIO on legacy boot.
>   - Only setup a GPIO IRQ on the .map function for DeviceTree boot.
> 
>  drivers/gpio/gpio-omap.c |   52 ++++++++++++++++++++++++++++++++++++---------
>  1 files changed, 41 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index d3f7d2d..31cbe65 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -1068,16 +1068,18 @@ static void omap_gpio_chip_init(struct gpio_bank *bank)
>  
>  	gpiochip_add(&bank->chip);
>  
> -	for (j = 0; j < bank->width; j++) {
> -		int irq = irq_create_mapping(bank->domain, j);
> -		irq_set_lockdep_class(irq, &gpio_lock_class);
> -		irq_set_chip_data(irq, bank);
> -		if (bank->is_mpuio) {
> -			omap_mpuio_alloc_gc(bank, irq, bank->width);
> -		} else {
> -			irq_set_chip_and_handler(irq, &gpio_irq_chip,
> -						 handle_simple_irq);
> -			set_irq_flags(irq, IRQF_VALID);
> +	if (!of_have_populated_dt()) {
> +		for (j = 0; j < bank->width; j++) {
> +			int irq = irq_create_mapping(bank->domain, j);
> +			irq_set_lockdep_class(irq, &gpio_lock_class);
> +			irq_set_chip_data(irq, bank);
> +			if (bank->is_mpuio) {
> +				omap_mpuio_alloc_gc(bank, irq, bank->width);
> +			} else {
> +				irq_set_chip_and_handler(irq, &gpio_irq_chip,
> +							 handle_simple_irq);
> +				set_irq_flags(irq, IRQF_VALID);
> +			}
>  		}
>  	}
>  	irq_set_chained_handler(bank->irq, gpio_irq_handler);
> @@ -1086,6 +1088,34 @@ static void omap_gpio_chip_init(struct gpio_bank *bank)
>  
>  static const struct of_device_id omap_gpio_match[];
>  
> +static int omap_gpio_irq_map(struct irq_domain *d, unsigned int virq,
> +			     irq_hw_number_t hwirq)
> +{
> +	struct gpio_bank *bank = d->host_data;
> +
> +	if (!bank)
> +		return -EINVAL;
> +
> +	if (of_have_populated_dt()) {
> +		irq_set_lockdep_class(virq, &gpio_lock_class);
> +		irq_set_chip_data(virq, bank);
> +		if (bank->is_mpuio) {
> +			omap_mpuio_alloc_gc(bank, virq, bank->width);
> +		} else {
> +			irq_set_chip_and_handler(virq, &gpio_irq_chip,
> +						 handle_simple_irq);
> +			set_irq_flags(virq, IRQF_VALID);
> +		}
> +	}

Actually, this looks wrong. You'll notice that the same block of code is
now duplicated in the map function and outside the map. The problem is
that the original code is manually walking through all the irqs and
doing the mapping work, but all of that stuff is what the .map() hook is
for!

Instead, the entire of the above block should be executed
unconditionally inside the map hook. In the DT case, it will get called
automatically only on referenced irqs. In the non-DT case, the for loop
in omap_gpio_chip_init() will only need to call irq_create_mapping() for
each irq, which in turn will call ->map().

g.

> +
> +	return 0;
> +}
> +
> +static struct irq_domain_ops omap_gpio_irq_ops = {
> +	.xlate  = irq_domain_xlate_onetwocell,
> +	.map    = omap_gpio_irq_map,
> +};
> +
>  static int omap_gpio_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -1137,7 +1167,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
>  
>  
>  	bank->domain = irq_domain_add_linear(node, bank->width,
> -					     &irq_domain_simple_ops, NULL);
> +					     &omap_gpio_irq_ops, bank);
>  	if (!bank->domain)
>  		return -ENODEV;
>  
> -- 
> 1.7.7.6
> 

-- 
email sent from notmuch.vim plugin
