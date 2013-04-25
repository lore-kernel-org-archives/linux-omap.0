From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v3] gpio/omap: implement irq mask/disable with proper
 semantic.
Date: Thu, 25 Apr 2013 14:40:39 -0500
Message-ID: <517986B7.9020506@ti.com>
References: <51728BA6.1090800@ti.com> <1366620861-5489-1-git-send-email-andreas.fenkart@streamunlimited.com> <1366620861-5489-2-git-send-email-andreas.fenkart@streamunlimited.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56303 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757176Ab3DYTkr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 25 Apr 2013 15:40:47 -0400
In-Reply-To: <1366620861-5489-2-git-send-email-andreas.fenkart@streamunlimited.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Cc: santosh.shilimkar@ti.com, khilman@deeprootsystems.com, grant.likely@secretlab.ca, linus.walleij@linaro.org, balbi@ti.com, linux-omap@vger.kernel.org, daniel@zonque.org


On 04/22/2013 03:54 AM, Andreas Fenkart wrote:
> When a gpio interrupt is masked, the gpio event will still be latched in
> the interrupt status register so when you unmask it later you may get an
> interrupt straight away. However, if the interrupt is disabled then gpio
> events occurring will not be latched/stored.
> 
> Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
> ---
>  drivers/gpio/gpio-omap.c |   69 ++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 60 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 159f5c5..0b66c45 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -772,6 +772,12 @@ static void gpio_ack_irq(struct irq_data *d)
>  	_clear_gpio_irqstatus(bank, gpio);
>  }
>  
> +/**
> + * gpio_mask_irq - mask IRQ signalling
> + * @d : the gpio data we're acting upon
> + *
> + * Only signalling disabled. New IRQ still latched to IRQ status register.
> + */
>  static void gpio_mask_irq(struct irq_data *d)
>  {
>  	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
> @@ -780,33 +786,76 @@ static void gpio_mask_irq(struct irq_data *d)
>  
>  	spin_lock_irqsave(&bank->lock, flags);
>  	_set_gpio_irqenable(bank, gpio, 0);
> -	_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), IRQ_TYPE_NONE);
>  	spin_unlock_irqrestore(&bank->lock, flags);
>  }
>  
> +/**
> + * gpio_unmask_irq - unmask IRQ signalling
> + * @d : the gpio data we're acting upon
> + *
> + * If an IRQ occured while IRQ was masked, you will get an IRQ straight away.
> + */
>  static void gpio_unmask_irq(struct irq_data *d)
>  {
>  	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
>  	unsigned int gpio = irq_to_gpio(bank, d->irq);
>  	unsigned int irq_mask = GPIO_BIT(bank, gpio);
> -	u32 trigger = irqd_get_trigger_type(d);
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&bank->lock, flags);
> -	if (trigger)
> -		_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), trigger);
>  
> -	/* For level-triggered GPIOs, the clearing must be done after
> -	 * the HW source is cleared, thus after the handler has run */
> -	if (bank->level_mask & irq_mask) {
> -		_set_gpio_irqenable(bank, gpio, 0);
> +	/*
> +	 * For level-triggered GPIOs, clear the IRQ. If the HW
> +	 * still needs service, IRQ will be latched again
> +	 */
> +	if (bank->level_mask & irq_mask)
>  		_clear_gpio_irqstatus(bank, gpio);
> -	}
>  
>  	_set_gpio_irqenable(bank, gpio, 1);
>  	spin_unlock_irqrestore(&bank->lock, flags);
>  }
>  
> +/**
> + * gpio_disable_irq - disable the interrupt
> + * @d : the gpio data we're acting upon
> + *
> + * While disabled all IRQ events are ignored. No latching to IRQ status
> + * register.
> + */
> +static void gpio_disable_irq(struct irq_data *d)
> +{
> +	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
> +	unsigned int gpio = irq_to_gpio(bank, d->irq);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&bank->lock, flags);
> +	_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), IRQ_TYPE_NONE);
> +	_set_gpio_irqenable(bank, gpio, 0);
> +	spin_unlock_irqrestore(&bank->lock, flags);
> +}
> +
> +/**
> + * gpio_enable_irq - enable the interrupt
> + * @d : the gpio data we're acting upon
> + *
> + * Enables latching and signalling IRQ.
> + */
> +static void gpio_enable_irq(struct irq_data *d)
> +{
> +	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
> +	unsigned int gpio = irq_to_gpio(bank, d->irq);
> +	unsigned int irq_mask = GPIO_BIT(bank, gpio);
> +	u32 trigger = irqd_get_trigger_type(d);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&bank->lock, flags);
> +	if (trigger)
> +		_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), trigger);
> +	_clear_gpio_irqstatus(bank, gpio);
> +	_set_gpio_irqenable(bank, gpio, 1);
> +	spin_unlock_irqrestore(&bank->lock, flags);
> +}

This generates the following warning ...

drivers/gpio/gpio-omap.c: In function 'gpio_enable_irq':
drivers/gpio/gpio-omap.c:852:15: warning: unused variable 'irq_mask'
[-Wunused-variable]

So you can get rid of irq_mask in the above function.

Jon
