From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] gpio: omap: Fix PM runtime issue and remove most
 BANK_USED macros
Date: Thu, 30 Apr 2015 14:12:55 -0700
Message-ID: <20150430211254.GC24469@atomide.com>
References: <1429632533-23285-1-git-send-email-tony@atomide.com>
 <5538D3B6.7060305@linaro.org>
 <20150423143952.GR18048@atomide.com>
 <55400243.4040504@linaro.org>
 <20150429142626.GA10572@atomide.com>
 <55427E3B.2090408@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55427E3B.2090408@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Javier Martinez Canillas <jmartinez@softcrates.net>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

* Grygorii.Strashko@linaro.org <grygorii.strashko@linaro.org> [150430 12:12]:
> On 04/29/2015 05:26 PM, Tony Lindgren wrote:
> > 
> > In general removing 30 lines of duplicate code to fix freeing
> > of resources makes sense :) I'd rather do that than add more similar
> > code to fix it for sure. That will make further changes easier too.
> 
> Unfortunately I'm not sure ( at least not for this driver.
> Future fixes most probably will eat all these removed lines and
> will just add anther "if else" but in different places (see description or corner case below).
> 
> In my opinion, It might be better to review each interface function first as for GPIO chip
> as for GPIOIRQ chip and ensure that they are doing exactly what need to be done
> (as part this job - get rid of over-optimized functions like omap_reset_gpio or
> omap_gpio_init_irq). And after that do further optimization. 

In general I agree that a minimal fix is preferred. Unfortunately in
this case "fixing" it gets us deeper into the mess with BANK_USED :)
 
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -488,9 +488,6 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
>         unsigned long flags;
>         unsigned offset = d->hwirq;
>  
> -       if (!BANK_USED(bank))
> -               pm_runtime_get_sync(bank->dev);
> -
>         if (type & ~IRQ_TYPE_SENSE_MASK)
>                 return -EINVAL;
>  
> @@ -498,13 +495,11 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
>                 (type & (IRQ_TYPE_LEVEL_LOW|IRQ_TYPE_LEVEL_HIGH)))
>                 return -EINVAL;
>  
> +       if (!BANK_USED(bank))
> +               pm_runtime_get_sync(bank->dev);
> +
>         spin_lock_irqsave(&bank->lock, flags);
>         retval = omap_set_gpio_triggering(bank, offset, type);
> -       omap_gpio_init_irq(bank, offset);
> -       if (!omap_gpio_is_input(bank, offset)) {
> -               spin_unlock_irqrestore(&bank->lock, flags);
> -               return -EINVAL;
> -       }
>         spin_unlock_irqrestore(&bank->lock, flags);
>  
>         if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
> @@ -512,6 +507,9 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
>         else if (type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
>                 __irq_set_handler_locked(d->irq, handle_edge_irq);
>  
> +       if (!BANK_USED(bank))
> +               pm_runtime_put(bank->dev);
> +
>         return retval;
>  }

Hmm I don't think we can remove the call to omap_gpio_init_irq as with
request_irq there's nothing ensuring the GPIO line is configured in
the device tree case for example?

And then removing the check for omap_gpio_is_input is not good.. We
should just call omap_set_gpio_direction to set it to input instead
like I'm doing.

And looking at it more, omap_set_gpio_triggering can fail so we should
check the return value (also with my patch). And if that fails, then we
currently need a flag to keep track if we enabled the bank in
omap_gpio_irq_type or not.. So piling up yet more BANK_USED tinkering.

I still think we're better of just removing it all. Below is my patch
updated with the omap_set_gpio_triggering error handling. We can just
make omap_enable_gpio_module return a value, it might provide us with
more info where things go wrong :)

> There is another corner case :) - easy to reproduce
> and it's present in old code.
> 
> GPIOn is used as IRQ by some dev:
> - in my case PCF8575.INT ->  gpio6.11
> - PCFx driver knows nothing about type of IRQ line (GPIO or not)
>   so it doesn't request gpio and just do request_irq()
> 
> If I'll export gpio6.11 through sysfs and then unxeport it
> then IRQs from PCFx will not be received any more.
> 
> Seems omap_reset_gpio has to be split for GPIO and GPIO-IRQ cases.

OK, that sounds like a separate fix though if I understand your
right. We should not allow exporting GPIOs to sysfs if they are
being used.

Regards,

Tony

8< -------------------------
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 27 Apr 2015 10:18:17 -0700
Subject: [PATCH] gpio: omap: Fix PM runtime issue and remove most BANK_USED
 macros

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
@@ -419,8 +420,17 @@ static int omap_set_gpio_triggering(struct gpio_bank *bank, int gpio,
 	return 0;
 }
 
-static void omap_enable_gpio_module(struct gpio_bank *bank, unsigned offset)
+static int omap_enable_gpio_module(struct gpio_bank *bank, unsigned offset,
+				   bool is_irq)
 {
+	unsigned long flags;
+	int error;
+
+	/* PM runtime is per bank, not per GPIO line */
+	if (!BANK_USED(bank))
+		pm_runtime_get_sync(bank->dev);
+
+	spin_lock_irqsave(&bank->lock, flags);
 	if (bank->regs->pinctrl) {
 		void __iomem *reg = bank->base + bank->regs->pinctrl;
 
@@ -438,11 +448,50 @@ static void omap_enable_gpio_module(struct gpio_bank *bank, unsigned offset)
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
+		if (!LINE_USED(bank->irq_usage, offset)) {
+			error = omap_set_gpio_triggering(bank, offset,
+							 IRQ_TYPE_NONE);
+			if (error)
+				goto out_err;
+		}
+		bank->mod_usage |= BIT(offset);
+	}
+	spin_unlock_irqrestore(&bank->lock, flags);
+
+	return 0;
+
+out_err:
+	dev_err(bank->dev, "enable failed with %i\n", error);
+	if (!BANK_USED(bank))
+		pm_runtime_put(bank->dev);
+	spin_unlock_irqrestore(&bank->lock, flags);
+
+	return error;
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
@@ -463,6 +512,11 @@ static void omap_disable_gpio_module(struct gpio_bank *bank, unsigned offset)
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
@@ -472,15 +526,6 @@ static int omap_gpio_is_input(struct gpio_bank *bank, unsigned offset)
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
@@ -488,9 +533,6 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
 	unsigned long flags;
 	unsigned offset = d->hwirq;
 
-	if (!BANK_USED(bank))
-		pm_runtime_get_sync(bank->dev);
-
 	if (type & ~IRQ_TYPE_SENSE_MASK)
 		return -EINVAL;
 
@@ -498,13 +540,11 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
 		(type & (IRQ_TYPE_LEVEL_LOW|IRQ_TYPE_LEVEL_HIGH)))
 		return -EINVAL;
 
+	retval = omap_enable_gpio_module(bank, offset, true);
+	if (retval)
+		return retval;
 	spin_lock_irqsave(&bank->lock, flags);
 	retval = omap_set_gpio_triggering(bank, offset, type);
-	omap_gpio_init_irq(bank, offset);
-	if (!omap_gpio_is_input(bank, offset)) {
-		spin_unlock_irqrestore(&bank->lock, flags);
-		return -EINVAL;
-	}
 	spin_unlock_irqrestore(&bank->lock, flags);
 
 	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
@@ -659,26 +699,11 @@ static int omap_gpio_wake_enable(struct irq_data *d, unsigned int enable)
 static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
 {
 	struct gpio_bank *bank = container_of(chip, struct gpio_bank, chip);
-	unsigned long flags;
+	int error;
 
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
+	error = omap_enable_gpio_module(bank, offset, false);
+	if (error)
+		return error;
 
 	return 0;
 }
@@ -686,20 +711,8 @@ static int omap_gpio_request(struct gpio_chip *chip, unsigned offset)
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
@@ -788,15 +801,12 @@ exit:
 static unsigned int omap_gpio_irq_startup(struct irq_data *d)
 {
 	struct gpio_bank *bank = omap_irq_data_get_bank(d);
-	unsigned long flags;
 	unsigned offset = d->hwirq;
+	int error;
 
-	if (!BANK_USED(bank))
-		pm_runtime_get_sync(bank->dev);
-
-	spin_lock_irqsave(&bank->lock, flags);
-	omap_gpio_init_irq(bank, offset);
-	spin_unlock_irqrestore(&bank->lock, flags);
+	error = omap_enable_gpio_module(bank, offset, true);
+	if (error)
+		return error;
 	omap_gpio_unmask_irq(d);
 
 	return 0;
@@ -805,21 +815,9 @@ static unsigned int omap_gpio_irq_startup(struct irq_data *d)
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
