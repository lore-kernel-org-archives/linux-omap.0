From: "Wang Sawsd-A24013" <cqwang@motorola.com>
Subject: RE: [PATCH] OMAP2/3 Avoid GPIO pending irq status been set after irq_disable
Date: Sat, 6 Jun 2009 03:06:40 +0800
Message-ID: <B00E06E2766C2744B022DE9BAF3C59D5372EFA@zmy16exm69.ds.mot.com>
References: <87d49jeh7p.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail55.messagelabs.com ([216.82.241.163]:60138 "EHLO
	mail55.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683AbZFETHX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Jun 2009 15:07:23 -0400
Received: from il06exr04.mot.com (il06exr04.mot.com [129.188.137.134])
	by motgate8.mot.com (8.14.3/8.14.3) with ESMTP id n55J7NmS003630
	for <linux-omap@vger.kernel.org>; Fri, 5 Jun 2009 12:07:23 -0700 (MST)
Received: from il06vts04.mot.com (il06vts04.mot.com [129.188.137.144])
	by il06exr04.mot.com (8.13.1/Vontu) with SMTP id n55J7NsR016585
	for <linux-omap@vger.kernel.org>; Fri, 5 Jun 2009 14:07:23 -0500 (CDT)
Received: from zmy16exm69.ds.mot.com (zmy16exm69.ap.mot.com [10.179.4.36])
	by il06exr04.mot.com (8.13.1/8.13.0) with ESMTP id n55J7M0e016582
	for <linux-omap@vger.kernel.org>; Fri, 5 Jun 2009 14:07:22 -0500 (CDT)
Content-class: urn:content-classes:message
In-Reply-To: <87d49jeh7p.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, nm@ti.com, Mike Chan <mikechan@google.com>


> 
> Could you try this patch with your TS GPIO configured as 
> level-triggered?
> 
> Kevin
> 
I tried the below patch, it can solve the issue also.

> commit f8eb69a2edd684c9e0b72bc3c84c6af9718bd4a4
> Author: Kevin Hilman <khilman@deeprootsystems.com>
> Date:   Thu Jun 4 15:57:10 2009 -0700
> 
>     OMAP: GPIO: clear/restore level/edge detect settings on 
> mask/unmask
>     
>     <needs detailed description>
> 
>     Signed-off-by: Kevin Hilman <khilman@ti.deeprootsystems.com>
> 
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index 3b2054b..83ac494 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -1135,6 +1135,7 @@ static void gpio_mask_irq(unsigned int irq)
>  	struct gpio_bank *bank = get_irq_chip_data(irq);
>  
>  	_set_gpio_irqenable(bank, gpio, 0);
> +	_set_gpio_triggering(bank, get_gpio_index(gpio), IRQ_TYPE_NONE);
>  }
>  
>  static void gpio_unmask_irq(unsigned int irq)
> @@ -1142,6 +1143,11 @@ static void gpio_unmask_irq(unsigned int irq)
>  	unsigned int gpio = irq - IH_GPIO_BASE;
>  	struct gpio_bank *bank = get_irq_chip_data(irq);
>  	unsigned int irq_mask = 1 << get_gpio_index(gpio);
> +	struct irq_desc *desc = irq_to_desc(irq);
> +	u32 trigger = desc->status & IRQ_TYPE_SENSE_MASK;
> +
> +	if (trigger)
> +		_set_gpio_triggering(bank, 
> get_gpio_index(gpio), trigger);
>  
>  	/* For level-triggered GPIOs, the clearing must be done after
>  	 * the HW source is cleared, thus after the handler has run */
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
