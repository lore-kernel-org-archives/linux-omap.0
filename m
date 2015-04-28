From: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
Subject: Re: [PATCH 1/1] gpio: omap: Fix PM runtime issue and remove most
 BANK_USED macros
Date: Wed, 29 Apr 2015 00:57:23 +0300
Message-ID: <55400243.4040504@linaro.org>
References: <1429632533-23285-1-git-send-email-tony@atomide.com> <5538D3B6.7060305@linaro.org> <20150423143952.GR18048@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:33827 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030715AbbD1V51 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Apr 2015 17:57:27 -0400
Received: by wicmx19 with SMTP id mx19so117868901wic.1
        for <linux-omap@vger.kernel.org>; Tue, 28 Apr 2015 14:57:26 -0700 (PDT)
In-Reply-To: <20150423143952.GR18048@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Javier Martinez Canillas <jmartinez@softcrates.net>, Nishanth Menon <nm@ti.com>

Hi Tony,

Sorry for delayed reply.

On 04/23/2015 05:39 PM, Tony Lindgren wrote:
> * Grygorii.Strashko@linaro.org <grygorii.strashko@linaro.org> [150423 04:13]:
>> On 04/21/2015 07:08 PM, Tony Lindgren wrote:
>>> @@ -438,11 +447,30 @@ static void omap_enable_gpio_module(struct gpio_bank *bank, unsigned offset)
>>>    		writel_relaxed(ctrl, reg);
>>>    		bank->context.ctrl = ctrl;
>>>    	}
>>> +
>>> +	if (is_irq) {
>>> +		omap_set_gpio_direction(bank, offset, 1);
>>> +		bank->irq_usage |= BIT(offset);
>>> +	} else {
>>> +		omap_set_gpio_triggering(bank, offset, IRQ_TYPE_NONE);
>>> +		bank->mod_usage |= BIT(offset);
>>> +	}
>>
>> The OMAP GPIO driver implements two Core interfaces IRQ-chip and GPIO-chip which, in general,
>> more or less independent.
>>
>> So, I don't think, that it's good to mix GPIO-IRQ-chip specific code with GPIO-chip code.
>> And this even don't really correspond the purpose of omap_enable_gpio_module() :( and might
>> introduce misunderstanding of code. The worst thing is that future fixes in IRQ-chip may
>> affect on on GPIO-chip and vise versa :(
> 
> Hmm I'm thinking omap_enable/disable_gpio_module() eventually becomes
> our runtime_resume/suspend(). Currently the enabling and disabling is
> buggy for GPIO for some corner cases.. AFAIK the only difference between

It might be very helpful if you'd able to share additional info about
any "corner cases" you know.

> enabling GPIO vs GPIO-IRQ is the calling of omap_set_gpio_direction
> vs omap_set_gpio_triggering. Or at least that's the way it should be
> unless I'm missing something?

I think yes. what i'd like to say, first of all, is that it might be not good idea to mix 
too much functionality in  omap_enable/disable_gpio_module() - especially GPIO-IRQ vs
GPIO-chip ( Very easy to get lost ;)

For example (1) - your change of omap_gpio_request() looks like invalid:

  static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
  {
  	struct gpio_bank *bank = container_of(chip, struct gpio_bank, chip);
-	unsigned long flags;
  
-	/*
-	 * If this is the first gpio_request for the bank,
-	 * enable the bank module.
-	 */
-	if (!BANK_USED(bank))
-		pm_runtime_get_sync(bank->dev);
-
-	spin_lock_irqsave(&bank->lock, flags);
-	/* Set trigger to none. You need to enable the desired trigger with
-	 * request_irq() or set_irq_type(). Only do this if the IRQ line has
-	 * not already been requested.
-	 */
-	if (!LINE_USED(bank->irq_usage, offset)) {
-		omap_set_gpio_triggering(bank, offset, IRQ_TYPE_NONE);
-		omap_enable_gpio_module(bank, offset);

	^^ above two line should be executed only if GPIO line was not requested as IRQ before

-	}


-	bank->mod_usage |= BIT(offset);
-	spin_unlock_irqrestore(&bank->lock, flags);
+	omap_enable_gpio_module(bank, offset, false);

^^ after your change, it looks like omap_set_gpio_triggering(bank, offset, IRQ_TYPE_NONE)
   will be called always and GPIO triggering configuration might be lost
  
  	return 0;
  }

Example (2)
 I've found commit 55b6019ae294 "OMAP: GPIO: clear/restore level/edge detect settings on mask/unmask"
 which does the following
  gpio_mask_irq()
   |-  _set_gpio_triggering(bank, get_gpio_index(gpio), IRQ_TYPE_NONE);
  
  gpio_unmask_irq()
   |- u32 trigger = irqd_get_trigger_type(d);
      if (trigger)
             omap_set_gpio_triggering(bank, offset, trigger);

  As result, it seems unreasonable to physically configure IRQ triggering type in GPIO bank registers 
  inside omap_gpio_irq_type(). Of course, such assumption should be double checked taking into account that 
  __irq_set_trigger() can be called any time even before request_irq().
  Also, seems the same could be applied to omap_enable_gpio_module and omap_set_gpio_direction and they
  could be removed from omap_gpio_irq_type().
  
>   
>> Could we keep omap_xxx_gpio_module() functions responsible only for GPIO bank PM and
>> enabling/disabling?
> 
> If you're thinking about just thinking about having separate wrappers around
> it like this::
> 
> static void omap_enable_gpio_module(struct gpio_bank *bank, unsigned offset,
> 					bool is_irq)
> {
> 	...
> }
> 
> static void omap_enable_gpio((struct gpio_bank *bank, unsigned offset)
> {
> 	omap_enable_gpio_module(bpio_bank, offset, 0);
> }
> 
> static void omap_enable_gpio_irq((struct gpio_bank *bank, unsigned offset)
> {
> 	omap_enable_gpio_module(bpio_bank, offset, 1);
> }
> 
> Then yes makes sense to me. Or do you have something else in mind?

Yep. Commented above.

Also, it probably could work if we will set GPIO_CTRL.DISABLEMODULE=1
in omap_gpio_runtime_resume and GPIO_CTRL.DISABLEMODULE=0 in _runtime_suspend,
but it may require from us to split CPUIdle and suspend code path (


-- 
regards,
-grygorii
