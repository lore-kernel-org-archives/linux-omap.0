From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] gpio: omap: Fix PM runtime issue and remove most
 BANK_USED macros
Date: Wed, 29 Apr 2015 07:26:26 -0700
Message-ID: <20150429142626.GA10572@atomide.com>
References: <1429632533-23285-1-git-send-email-tony@atomide.com>
 <5538D3B6.7060305@linaro.org>
 <20150423143952.GR18048@atomide.com>
 <55400243.4040504@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:47928 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966232AbbD2O03 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Apr 2015 10:26:29 -0400
Content-Disposition: inline
In-Reply-To: <55400243.4040504@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Javier Martinez Canillas <jmartinez@softcrates.net>, Nishanth Menon <nm@ti.com>

* Grygorii.Strashko@linaro.org <grygorii.strashko@linaro.org> [150428 14:58]:
> Hi Tony,
> 
> Sorry for delayed reply.
> 
> On 04/23/2015 05:39 PM, Tony Lindgren wrote:
> > * Grygorii.Strashko@linaro.org <grygorii.strashko@linaro.org> [150423 04:13]:
> >> On 04/21/2015 07:08 PM, Tony Lindgren wrote:
> >>> @@ -438,11 +447,30 @@ static void omap_enable_gpio_module(struct gpio_bank *bank, unsigned offset)
> >>>    		writel_relaxed(ctrl, reg);
> >>>    		bank->context.ctrl = ctrl;
> >>>    	}
> >>> +
> >>> +	if (is_irq) {
> >>> +		omap_set_gpio_direction(bank, offset, 1);
> >>> +		bank->irq_usage |= BIT(offset);
> >>> +	} else {
> >>> +		omap_set_gpio_triggering(bank, offset, IRQ_TYPE_NONE);
> >>> +		bank->mod_usage |= BIT(offset);
> >>> +	}
> >>
> >> The OMAP GPIO driver implements two Core interfaces IRQ-chip and GPIO-chip which, in general,
> >> more or less independent.
> >>
> >> So, I don't think, that it's good to mix GPIO-IRQ-chip specific code with GPIO-chip code.
> >> And this even don't really correspond the purpose of omap_enable_gpio_module() :( and might
> >> introduce misunderstanding of code. The worst thing is that future fixes in IRQ-chip may
> >> affect on on GPIO-chip and vise versa :(
> > 
> > Hmm I'm thinking omap_enable/disable_gpio_module() eventually becomes
> > our runtime_resume/suspend(). Currently the enabling and disabling is
> > buggy for GPIO for some corner cases.. AFAIK the only difference between
> 
> It might be very helpful if you'd able to share additional info about
> any "corner cases" you know.

Well not much to share there. I started trying to figure out why your
earlier patch causes PM regressions trying reduce the GPIO_BANK usage,
but had not luck. Based on looking at the code, I then noticed that some
resources are not freed for omap_gpio_irq_type() with the early returns.
And then I noticed we have piles of duplicate code all over the place
pretty much trying to do the same thing.

> > enabling GPIO vs GPIO-IRQ is the calling of omap_set_gpio_direction
> > vs omap_set_gpio_triggering. Or at least that's the way it should be
> > unless I'm missing something?
> 
> I think yes. what i'd like to say, first of all, is that it might be not good idea to mix 
> too much functionality in  omap_enable/disable_gpio_module() - especially GPIO-IRQ vs
> GPIO-chip ( Very easy to get lost ;)

In general removing 30 lines of duplicate code to fix freeing
of resources makes sense :) I'd rather do that than add more similar
code to fix it for sure. That will make further changes easier too.
 
> For example (1) - your change of omap_gpio_request() looks like invalid:
> 
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
> 
> 	^^ above two line should be executed only if GPIO line was not requested as IRQ before
> 
> -	}
> 
> 
> -	bank->mod_usage |= BIT(offset);
> -	spin_unlock_irqrestore(&bank->lock, flags);
> +	omap_enable_gpio_module(bank, offset, false);
> 
> ^^ after your change, it looks like omap_set_gpio_triggering(bank, offset, IRQ_TYPE_NONE)
>    will be called always and GPIO triggering configuration might be lost

OK yeah that's a valid concern thanks. Let's keep that part to be sure
we're not introducing regressions.
   
>   	return 0;
>   }
> 
> Example (2)
>  I've found commit 55b6019ae294 "OMAP: GPIO: clear/restore level/edge detect settings on mask/unmask"
>  which does the following
>   gpio_mask_irq()
>    |-  _set_gpio_triggering(bank, get_gpio_index(gpio), IRQ_TYPE_NONE);
>   
>   gpio_unmask_irq()
>    |- u32 trigger = irqd_get_trigger_type(d);
>       if (trigger)
>              omap_set_gpio_triggering(bank, offset, trigger);
> 
>   As result, it seems unreasonable to physically configure IRQ triggering type in GPIO bank registers 
>   inside omap_gpio_irq_type(). Of course, such assumption should be double checked taking into account that 
>   __irq_set_trigger() can be called any time even before request_irq().
>   Also, seems the same could be applied to omap_enable_gpio_module and omap_set_gpio_direction and they
>   could be removed from omap_gpio_irq_type().

In omap_gpio_irq_type() we call omap_set_gpio_triggering() after we call
omap_enable_gpio_module(), so I don't think we need to change anything
there. Or am I missing something here?
  
> >> Could we keep omap_xxx_gpio_module() functions responsible only for GPIO bank PM and
> >> enabling/disabling?
> > 
> > If you're thinking about just thinking about having separate wrappers around
> > it like this::
> > 
> > static void omap_enable_gpio_module(struct gpio_bank *bank, unsigned offset,
> > 					bool is_irq)
> > {
> > 	...
> > }
> > 
> > static void omap_enable_gpio((struct gpio_bank *bank, unsigned offset)
> > {
> > 	omap_enable_gpio_module(bpio_bank, offset, 0);
> > }
> > 
> > static void omap_enable_gpio_irq((struct gpio_bank *bank, unsigned offset)
> > {
> > 	omap_enable_gpio_module(bpio_bank, offset, 1);
> > }
> > 
> > Then yes makes sense to me. Or do you have something else in mind?
> 
> Yep. Commented above.

Sounds like adding the wrappers is not needed as we're planning to replace
these with line specific pm runtime calls anyways.
 
> Also, it probably could work if we will set GPIO_CTRL.DISABLEMODULE=1
> in omap_gpio_runtime_resume and GPIO_CTRL.DISABLEMODULE=0 in _runtime_suspend,
> but it may require from us to split CPUIdle and suspend code path (

What Felipe suggested a while back to me was we implement runtime_idle()
that checks for GPIO lines used and then we can still suspend and resume
for idle.

Anyways, updated patch below with the line check added. Do you see
other issues?

Regards,

Tony

8< -------------------------
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 27 Apr 2015 10:18:17 -0700
Subject: [PATCH] gpio: omap: Fix PM runtime issue and remove most BANK_USED macros

Looks like omap_gpio_irq_type can return early at several places
leaving a GPIO bank enabled without doing pm_runtime_put if wrong
GPIO arguments are passed.

Instead of adding more complicated BANK_USED macros, let's fix the
issue properly. We can pass is_irq flag to omap_enable_gpio_module
and omap_disble_gpio_module. And with that we can remove all the
similar code elsewhere to get rid of most BANK_USED macros.

Note that the reason for the BANK_USED macro is that we need to manage
PM runtime on per GPIO bank basis. In the long run we want to move to
using PM runtime counts for each GPIO line to determine if a GPIO
bank is used. Once we have a solution for omap_enable_gpio_module
and omap_disable_gpio_module, we can remove the remaining BANK_USED
macros.

Cc: Felipe Balbi <balbi@ti.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Grygorii Strashko <grygorii.strashko@linaro.org>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -86,6 +86,7 @@ struct gpio_bank {
 #define BANK_USED(bank) (bank->mod_usage || bank->irq_usage)
 #define LINE_USED(line, offset) (line & (BIT(offset)))
 
+static void omap_reset_gpio(struct gpio_bank *bank, unsigned offset);
 static void omap_gpio_unmask_irq(struct irq_data *d);
 
 static inline struct gpio_bank *omap_irq_data_get_bank(struct irq_data *d)
@@ -419,8 +420,16 @@ static int omap_set_gpio_triggering(struct gpio_bank *bank, int gpio,
 	return 0;
 }
 
-static void omap_enable_gpio_module(struct gpio_bank *bank, unsigned offset)
+static void omap_enable_gpio_module(struct gpio_bank *bank, unsigned offset,
+				    bool is_irq)
 {
+	unsigned long flags;
+
+	/* PM runtime is per bank, not per GPIO line */
+	if (!BANK_USED(bank))
+		pm_runtime_get_sync(bank->dev);
+
+	spin_lock_irqsave(&bank->lock, flags);
 	if (bank->regs->pinctrl) {
 		void __iomem *reg = bank->base + bank->regs->pinctrl;
 
@@ -438,11 +447,36 @@ static void omap_enable_gpio_module(struct gpio_bank *bank, unsigned offset)
 		writel_relaxed(ctrl, reg);
 		bank->context.ctrl = ctrl;
 	}
+
+	if (is_irq) {
+		omap_set_gpio_direction(bank, offset, 1);
+		bank->irq_usage |= BIT(offset);
+	} else {
+		/*
+		 * Set trigger to none. You need to enable the desired trigger
+		 * with request_irq() or set_irq_type(). Only do this if the
+		 * IRQ line has not already been requested.
+		 */
+		if (!LINE_USED(bank->irq_usage, offset))
+			omap_set_gpio_triggering(bank, offset, IRQ_TYPE_NONE);
+		bank->mod_usage |= BIT(offset);
+	}
+	spin_unlock_irqrestore(&bank->lock, flags);
 }
 
-static void omap_disable_gpio_module(struct gpio_bank *bank, unsigned offset)
+static void omap_disable_gpio_module(struct gpio_bank *bank, unsigned offset,
+				     bool is_irq)
 {
 	void __iomem *base = bank->base;
+	unsigned long flags;
+
+	spin_lock_irqsave(&bank->lock, flags);
+	if (is_irq)
+		bank->irq_usage &= ~(BIT(offset));
+	else
+		bank->mod_usage &= ~(BIT(offset));
+
+	omap_reset_gpio(bank, offset);
 
 	if (bank->regs->wkup_en &&
 	    !LINE_USED(bank->mod_usage, offset) &&
@@ -463,6 +497,11 @@ static void omap_disable_gpio_module(struct gpio_bank *bank, unsigned offset)
 		writel_relaxed(ctrl, reg);
 		bank->context.ctrl = ctrl;
 	}
+	spin_unlock_irqrestore(&bank->lock, flags);
+
+	/* PM runtime is per bank, not per GPIO line */
+	if (!BANK_USED(bank))
+		pm_runtime_put(bank->dev);
 }
 
 static int omap_gpio_is_input(struct gpio_bank *bank, unsigned offset)
@@ -472,15 +511,6 @@ static int omap_gpio_is_input(struct gpio_bank *bank, unsigned offset)
 	return readl_relaxed(reg) & BIT(offset);
 }
 
-static void omap_gpio_init_irq(struct gpio_bank *bank, unsigned offset)
-{
-	if (!LINE_USED(bank->mod_usage, offset)) {
-		omap_enable_gpio_module(bank, offset);
-		omap_set_gpio_direction(bank, offset, 1);
-	}
-	bank->irq_usage |= BIT(offset);
-}
-
 static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
 {
 	struct gpio_bank *bank = omap_irq_data_get_bank(d);
@@ -488,9 +518,6 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
 	unsigned long flags;
 	unsigned offset = d->hwirq;
 
-	if (!BANK_USED(bank))
-		pm_runtime_get_sync(bank->dev);
-
 	if (type & ~IRQ_TYPE_SENSE_MASK)
 		return -EINVAL;
 
@@ -498,13 +525,9 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
 		(type & (IRQ_TYPE_LEVEL_LOW|IRQ_TYPE_LEVEL_HIGH)))
 		return -EINVAL;
 
+	omap_enable_gpio_module(bank, offset, true);
 	spin_lock_irqsave(&bank->lock, flags);
 	retval = omap_set_gpio_triggering(bank, offset, type);
-	omap_gpio_init_irq(bank, offset);
-	if (!omap_gpio_is_input(bank, offset)) {
-		spin_unlock_irqrestore(&bank->lock, flags);
-		return -EINVAL;
-	}
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
@@ -659,26 +682,8 @@ static int omap_gpio_wake_enable(struct irq_data *d, unsigned int enable)
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
-	}
-	bank->mod_usage |= BIT(offset);
-	spin_unlock_irqrestore(&bank->lock, flags);
+	omap_enable_gpio_module(bank, offset, false);
 
 	return 0;
 }
@@ -686,20 +691,8 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
 {
 	struct gpio_bank *bank = container_of(chip, struct gpio_bank, chip);
-	unsigned long flags;
-
-	spin_lock_irqsave(&bank->lock, flags);
-	bank->mod_usage &= ~(BIT(offset));
-	omap_disable_gpio_module(bank, offset);
-	omap_reset_gpio(bank, offset);
-	spin_unlock_irqrestore(&bank->lock, flags);
 
-	/*
-	 * If this is the last gpio to be freed in the bank,
-	 * disable the bank module.
-	 */
-	if (!BANK_USED(bank))
-		pm_runtime_put(bank->dev);
+	omap_disable_gpio_module(bank, offset, false);
 }
 
 /*
@@ -788,15 +781,9 @@ exit:
 static unsigned int omap_gpio_irq_startup(struct irq_data *d)
 {
 	struct gpio_bank *bank = omap_irq_data_get_bank(d);
-	unsigned long flags;
 	unsigned offset = d->hwirq;
 
-	if (!BANK_USED(bank))
-		pm_runtime_get_sync(bank->dev);
-
-	spin_lock_irqsave(&bank->lock, flags);
-	omap_gpio_init_irq(bank, offset);
-	spin_unlock_irqrestore(&bank->lock, flags);
+	omap_enable_gpio_module(bank, offset, true);
 	omap_gpio_unmask_irq(d);
 
 	return 0;
@@ -805,21 +792,9 @@ static unsigned int omap_gpio_irq_startup(struct irq_data *d)
 static void omap_gpio_irq_shutdown(struct irq_data *d)
 {
 	struct gpio_bank *bank = omap_irq_data_get_bank(d);
-	unsigned long flags;
 	unsigned offset = d->hwirq;
 
-	spin_lock_irqsave(&bank->lock, flags);
-	bank->irq_usage &= ~(BIT(offset));
-	omap_disable_gpio_module(bank, offset);
-	omap_reset_gpio(bank, offset);
-	spin_unlock_irqrestore(&bank->lock, flags);
-
-	/*
-	 * If this is the last IRQ to be freed in the bank,
-	 * disable the bank module.
-	 */
-	if (!BANK_USED(bank))
-		pm_runtime_put(bank->dev);
+	omap_disable_gpio_module(bank, offset, true);
 }
 
 static void omap_gpio_ack_irq(struct irq_data *d)
