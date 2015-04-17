From: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
Subject: Re: [RFC/RFT PATCH 2/2] gpio: omap: ensure that runtime pm will disable
 unused gpio banks
Date: Fri, 17 Apr 2015 20:32:06 +0300
Message-ID: <55314396.20907@linaro.org>
References: <1425670017-19598-1-git-send-email-grygorii.strashko@linaro.org> <1425670017-19598-2-git-send-email-grygorii.strashko@linaro.org> <20150306231513.GB2651@atomide.com> <20150319230326.GP31346@atomide.com> <20150416162941.GI18048@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:32896 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932908AbbDQRcL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Apr 2015 13:32:11 -0400
Received: by layy10 with SMTP id y10so85713979lay.0
        for <linux-omap@vger.kernel.org>; Fri, 17 Apr 2015 10:32:09 -0700 (PDT)
In-Reply-To: <20150416162941.GI18048@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, ssantosh@kernel.org, Javier Martinez Canillas <javier@dowhile0.org>, Alexandre Courbot <gnurou@gmail.com>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org

Hi Tony,
On 04/16/2015 07:29 PM, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [150319 16:08]:
>> * Tony Lindgren <tony@atomide.com> [150307 00:08]:
>>> * grygorii.strashko@linaro.org <grygorii.strashko@linaro.org> [150306 11:27]:
>>>> From: Grygorii Strashko <grygorii.strashko@linaro.org>
>>>>
>>>> Now there are two points related to Runtime PM usage:
>>>> 1) bank state doesn't need to be checked in places where
>>>> Rintime PM is used, bacause Runtime PM maintains its
>>>> own usage counter:
>>>>        if (!BANK_USED(bank))
>>>>                 pm_runtime_get_sync(bank->dev);
>>>> so, it's safe to drop such checks.
>>>>
>>>> 2) There is a call of pm_runtime_get_sync() in omap_gpio_irq_type(),
>>>> but no corresponding put. As result, GPIO devices could be
>>>> powered on forever if at least one GPIO was used as IRQ.
>>>> Hence, allow powering off GPIO banks by adding missed
>>>> pm_runtime_put(bank->dev) at the end of omap_gpio_irq_type().
>>>
>>> Nice to see this happening, but I think before merging this we need
>>> to test to be sure that the pm_runtime calls actually match.. I'm
>>> not convinced right now.. We may still have uninitialized entry
>>> points similar to 3d009c8c61f9 ("gpio: omap: Fix bad device
>>> access with setup_irq()").
>>
>> OK so I finally got around testing this along with your bank
>> removal set. Looks like this patch causes a regression at least
>> with n900 keyboard LEDs with off-idle. The LED won't come back
>> on after restore from off-idle. Anyways, now we have something
>> reproducable :) So I'll try to debug it further at some point,
>> might be few days before I get to it.
> 
> Sorry for the delay, finally got around to this one :)
> 
> Here's what I came up with, only lightly tested so far. Note that
> we need to keep the PM runtime per bank, not per GPIO. Will repost
> a proper patch after some more testing.

I've had a opposite idea actually ;) - use Runtime PM on per-gpio basis as
it maintains all needed counters inside and we can be sure that
PM runtime callbacks will be called once per bank.
Also, I've thought about moving the code from omap_enable_gpio_module()
into Runtime PM callbacks.
So, final goal - get rid of BANK_USED & LINE_USED.

Were you able to identify broken calls sequence?

Also, Pay attention pls, that omap2_gpio_prepare_for/resume_after_idle()
will be most probably a NOP now.

> 
> This should not cause any functional changes, mostly just removal
> of code that can all be done in omap_enable/disable_gpio_module.


> 
> 8< -------------------------
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -86,6 +86,7 @@ struct gpio_bank {
>   #define BANK_USED(bank) (bank->mod_usage || bank->irq_usage)
>   #define LINE_USED(line, offset) (line & (BIT(offset)))
>   
> +static void omap_reset_gpio(struct gpio_bank *bank, unsigned offset);
>   static void omap_gpio_unmask_irq(struct irq_data *d);
>   
>   static inline struct gpio_bank *omap_irq_data_get_bank(struct irq_data *d)
> @@ -419,8 +420,16 @@ static int omap_set_gpio_triggering(struct gpio_bank *bank, int gpio,
>   	return 0;
>   }
>   
> -static void omap_enable_gpio_module(struct gpio_bank *bank, unsigned offset)
> +static void omap_enable_gpio_module(struct gpio_bank *bank, unsigned offset,
> +				    bool is_irq)
>   {
> +	unsigned long flags;
> +
> +	/* PM runtime is per bank, not per GPIO line */
> +	if (!BANK_USED(bank))
> +		pm_runtime_get_sync(bank->dev);
> +
> +	spin_lock_irqsave(&bank->lock, flags);
>   	if (bank->regs->pinctrl) {
>   		void __iomem *reg = bank->base + bank->regs->pinctrl;
>   
> @@ -438,11 +447,30 @@ static void omap_enable_gpio_module(struct gpio_bank *bank, unsigned offset)
>   		writel_relaxed(ctrl, reg);
>   		bank->context.ctrl = ctrl;
>   	}
> +
> +	if (is_irq) {
> +		omap_set_gpio_direction(bank, offset, 1);
> +		bank->irq_usage |= BIT(offset);
> +	} else {
> +		omap_set_gpio_triggering(bank, offset, IRQ_TYPE_NONE);
> +		bank->mod_usage |= BIT(offset);
> +	}
> +	spin_unlock_irqrestore(&bank->lock, flags);
>   }
>   
> -static void omap_disable_gpio_module(struct gpio_bank *bank, unsigned offset)
> +static void omap_disable_gpio_module(struct gpio_bank *bank, unsigned offset,
> +				     bool is_irq)
>   {
>   	void __iomem *base = bank->base;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&bank->lock, flags);
> +	if (is_irq)
> +		bank->irq_usage &= ~(BIT(offset));
> +	else
> +		bank->mod_usage &= ~(BIT(offset));
> +
> +	omap_reset_gpio(bank, offset);
>   
>   	if (bank->regs->wkup_en &&
>   	    !LINE_USED(bank->mod_usage, offset) &&
> @@ -463,6 +491,11 @@ static void omap_disable_gpio_module(struct gpio_bank *bank, unsigned offset)
>   		writel_relaxed(ctrl, reg);
>   		bank->context.ctrl = ctrl;
>   	}
> +	spin_unlock_irqrestore(&bank->lock, flags);
> +
> +	/* PM runtime is per bank, not per GPIO line */
> +	if (!BANK_USED(bank))
> +		pm_runtime_put(bank->dev);
>   }
>   
>   static int omap_gpio_is_input(struct gpio_bank *bank, unsigned offset)
> @@ -472,15 +505,6 @@ static int omap_gpio_is_input(struct gpio_bank *bank, unsigned offset)
>   	return readl_relaxed(reg) & BIT(offset);
>   }
>   
> -static void omap_gpio_init_irq(struct gpio_bank *bank, unsigned offset)
> -{
> -	if (!LINE_USED(bank->mod_usage, offset)) {
> -		omap_enable_gpio_module(bank, offset);
> -		omap_set_gpio_direction(bank, offset, 1);
> -	}
> -	bank->irq_usage |= BIT(offset);
> -}
> -
>   static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
>   {
>   	struct gpio_bank *bank = omap_irq_data_get_bank(d);
> @@ -488,9 +512,6 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
>   	unsigned long flags;
>   	unsigned offset = d->hwirq;
>   
> -	if (!BANK_USED(bank))
> -		pm_runtime_get_sync(bank->dev);
> -
>   	if (type & ~IRQ_TYPE_SENSE_MASK)
>   		return -EINVAL;
>   
> @@ -498,13 +519,9 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
>   		(type & (IRQ_TYPE_LEVEL_LOW|IRQ_TYPE_LEVEL_HIGH)))
>   		return -EINVAL;
>   
> +	omap_enable_gpio_module(bank, offset, true);
>   	spin_lock_irqsave(&bank->lock, flags);
>   	retval = omap_set_gpio_triggering(bank, offset, type);
> -	omap_gpio_init_irq(bank, offset);
> -	if (!omap_gpio_is_input(bank, offset)) {
> -		spin_unlock_irqrestore(&bank->lock, flags);
> -		return -EINVAL;
> -	}
>   	spin_unlock_irqrestore(&bank->lock, flags);
>   
>   	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
> @@ -659,26 +676,8 @@ static int omap_gpio_wake_enable(struct irq_data *d, unsigned int enable)
>   static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
>   {
>   	struct gpio_bank *bank = container_of(chip, struct gpio_bank, chip);
> -	unsigned long flags;
>   
> -	/*
> -	 * If this is the first gpio_request for the bank,
> -	 * enable the bank module.
> -	 */
> -	if (!BANK_USED(bank))
> -		pm_runtime_get_sync(bank->dev);
> -
> -	spin_lock_irqsave(&bank->lock, flags);
> -	/* Set trigger to none. You need to enable the desired trigger with
> -	 * request_irq() or set_irq_type(). Only do this if the IRQ line has
> -	 * not already been requested.
> -	 */
> -	if (!LINE_USED(bank->irq_usage, offset)) {
> -		omap_set_gpio_triggering(bank, offset, IRQ_TYPE_NONE);
> -		omap_enable_gpio_module(bank, offset);
> -	}
> -	bank->mod_usage |= BIT(offset);
> -	spin_unlock_irqrestore(&bank->lock, flags);
> +	omap_enable_gpio_module(bank, offset, false);
>   
>   	return 0;
>   }
> @@ -686,20 +685,8 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
>   static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
>   {
>   	struct gpio_bank *bank = container_of(chip, struct gpio_bank, chip);
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&bank->lock, flags);
> -	bank->mod_usage &= ~(BIT(offset));
> -	omap_disable_gpio_module(bank, offset);
> -	omap_reset_gpio(bank, offset);
> -	spin_unlock_irqrestore(&bank->lock, flags);
>   
> -	/*
> -	 * If this is the last gpio to be freed in the bank,
> -	 * disable the bank module.
> -	 */
> -	if (!BANK_USED(bank))
> -		pm_runtime_put(bank->dev);
> +	omap_disable_gpio_module(bank, offset, false);
>   }
>   
>   /*
> @@ -788,15 +775,9 @@ exit:
>   static unsigned int omap_gpio_irq_startup(struct irq_data *d)
>   {
>   	struct gpio_bank *bank = omap_irq_data_get_bank(d);
> -	unsigned long flags;
>   	unsigned offset = d->hwirq;
>   
> -	if (!BANK_USED(bank))
> -		pm_runtime_get_sync(bank->dev);
> -
> -	spin_lock_irqsave(&bank->lock, flags);
> -	omap_gpio_init_irq(bank, offset);
> -	spin_unlock_irqrestore(&bank->lock, flags);
> +	omap_enable_gpio_module(bank, offset, true);
>   	omap_gpio_unmask_irq(d);
>   
>   	return 0;
> @@ -805,21 +786,9 @@ static unsigned int omap_gpio_irq_startup(struct irq_data *d)
>   static void omap_gpio_irq_shutdown(struct irq_data *d)
>   {
>   	struct gpio_bank *bank = omap_irq_data_get_bank(d);
> -	unsigned long flags;
>   	unsigned offset = d->hwirq;
>   
> -	spin_lock_irqsave(&bank->lock, flags);
> -	bank->irq_usage &= ~(BIT(offset));
> -	omap_disable_gpio_module(bank, offset);
> -	omap_reset_gpio(bank, offset);
> -	spin_unlock_irqrestore(&bank->lock, flags);
> -
> -	/*
> -	 * If this is the last IRQ to be freed in the bank,
> -	 * disable the bank module.
> -	 */
> -	if (!BANK_USED(bank))
> -		pm_runtime_put(bank->dev);
> +	omap_disable_gpio_module(bank, offset, true);
>   }
>   
>   static void omap_gpio_ack_irq(struct irq_data *d)
> 


-- 
regards,
-grygorii
