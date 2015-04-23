From: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
Subject: Re: [PATCH 1/1] gpio: omap: Fix PM runtime issue and remove most
 BANK_USED macros
Date: Thu, 23 Apr 2015 14:12:54 +0300
Message-ID: <5538D3B6.7060305@linaro.org>
References: <1429632533-23285-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1429632533-23285-1-git-send-email-tony@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <balbi@ti.com>, Javier Martinez Canillas <jmartinez@softcrates.net>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 04/21/2015 07:08 PM, Tony Lindgren wrote:
> Looks like omap_gpio_irq_type can return early at several places
> leaving a GPIO bank enabled without doing pm_runtime_put if wrong
> GPIO arguments are passed.
> 
> Instead of adding more complicated BANK_USED macros, let's fix the
> issue properly. We can pass is_irq flag to omap_enable_gpio_module
> and omap_disble_gpio_module. And with that we can remove all the
> similar code elsewhere to get rid of most BANK_USED macros.
> 
> Note that the reason for the BANK_USED macro is that we need to manage
> PM runtime on per GPIO bank basis. In the long run we want to move to
> using PM runtime counts for each GPIO line to determine if a GPIO
> bank is used. Once we have a solution for omap_enable_gpio_module
> and omap_disable_gpio_module, we can remove the remaining BANK_USED
> macros.

In general, this approach is ok for me - I've had not able to test this patch, but
I'm going to take a deeper look on it on Friday or at the beginning of next week.

But, honestly, there is one thing I really don't like :( see below pls.

> 
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Grygorii Strashko <grygorii.strashko@linaro.org>
> Cc: Javier Martinez Canillas <jmartinez@softcrates.net>
> Cc: Nishanth Menon <nm@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>   drivers/gpio/gpio-omap.c | 111 +++++++++++++++++------------------------------
>   1 file changed, 40 insertions(+), 71 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index d44e617..39a6312 100644
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

The OMAP GPIO driver implements two Core interfaces IRQ-chip and GPIO-chip which, in general,
more or less independent. 

So, I don't think, that it's good to mix GPIO-IRQ-chip specific code with GPIO-chip code.
And this even don't really correspond the purpose of omap_enable_gpio_module() :( and might
introduce misunderstanding of code. The worst thing is that future fixes in IRQ-chip may 
affect on on GPIO-chip and vise versa :(

Could we keep omap_xxx_gpio_module() functions responsible only for GPIO bank PM and
enabling/disabling?

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
