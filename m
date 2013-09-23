From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [RFC] gpio/omap: auto-setup a GPIO when used as an IRQ
Date: Mon, 23 Sep 2013 19:00:44 +0200
Message-ID: <524073BC.9080907@collabora.co.uk>
References: <1379860848-29020-1-git-send-email-javier.martinez@collabora.co.uk> <20130923164519.GF2684@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20130923164519.GF2684@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Lars Poeschel <larsi@wh2.tu-dresden.de>, Grant Likely <grant.likely@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ian.campbell@citrix.com>, Kumar Gala <galak@codeaurora.org>, Pawel Moll <pawel.moll@arm.com>, Tomasz Figa <tomasz.figa@gmail.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Balaji T K <balajitk@ti.com>, Jon Hunter <jgchunter@gmail.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 09/23/2013 06:45 PM, Tony Lindgren wrote:
> * Javier Martinez Canillas <javier.martinez@collabora.co.uk> [130922 07:49]:
>> --- a/drivers/gpio/gpio-omap.c
>> +++ b/drivers/gpio/gpio-omap.c
>> @@ -420,6 +420,29 @@ static int _set_gpio_triggering(struct gpio_bank *bank, int gpio,
>>  	return 0;
>>  }
>>  
>> +static void _set_gpio_mode(struct gpio_bank *bank, unsigned offset)
>> +{
>> +	if (bank->regs->pinctrl) {
>> +		void __iomem *reg = bank->base + bank->regs->pinctrl;
>> +
>> +		/* Claim the pin for MPU */
>> +		__raw_writel(__raw_readl(reg) | (1 << offset), reg);
>> +	}
>> +
>> +	if (bank->regs->ctrl && !bank->mod_usage) {
>> +		void __iomem *reg = bank->base + bank->regs->ctrl;
>> +		u32 ctrl;
>> +
>> +		ctrl = __raw_readl(reg);
>> +		/* Module is enabled, clocks are not gated */
>> +		ctrl &= ~GPIO_MOD_CTRL_BIT;
>> +		__raw_writel(ctrl, reg);
>> +		bank->context.ctrl = ctrl;
>> +	}
>> +
>> +	bank->mod_usage |= 1 << offset;
>> +}
>> +
>>  static int gpio_irq_type(struct irq_data *d, unsigned type)
>>  {
>>  	struct gpio_bank *bank = irq_data_get_irq_chip_data(d);
>> @@ -427,8 +450,8 @@ static int gpio_irq_type(struct irq_data *d, unsigned type)
>>  	int retval;
>>  	unsigned long flags;
>>  
>> -	if (WARN_ON(!bank->mod_usage))
>> -		return -EINVAL;
>> +	if (!bank->mod_usage)
>> +		pm_runtime_get_sync(bank->dev);
>>  
>>  #ifdef CONFIG_ARCH_OMAP1
>>  	if (d->irq > IH_MPUIO_BASE)
>> @@ -438,6 +461,11 @@ static int gpio_irq_type(struct irq_data *d, unsigned type)
>>  	if (!gpio)
>>  		gpio = irq_to_gpio(bank, d->hwirq);
>>  
>> +	spin_lock_irqsave(&bank->lock, flags);
>> +	_set_gpio_mode(bank, GPIO_INDEX(bank, gpio));
>> +	_set_gpio_direction(bank, GPIO_INDEX(bank, gpio), 1);
>> +	spin_unlock_irqrestore(&bank->lock, flags);
>> +
>>  	if (type & ~IRQ_TYPE_SENSE_MASK)
>>  		return -EINVAL;
>>

Hi Tony, thanks a lot for your feedback.

> 
> Hmm does this still work for legacy platform data based
> drivers that are doing gpio_request() first?
> 

Yes it still work when booting using board files. I tested on my OMAP3 board and
it worked in both DT and legacy booting mode.

> And what's the path for clearing things for PM when free_irq()
> gets called? It seems that this would leave the GPIO bank
> enabled causing a PM regression?
> 

Indeed, I did set bank->mod_usage |= 1 << offset so the bank is enabled if the
device goes to suspended and then resumed but I completely forget about the
clearing path when the IRQ is freed.

Which makes me think that we should probably maintain two usage variables, one
for GPIO and another one for IRQ and check both of them on the suspend/resume pm
functions.

> Other than the two concerns above it seems that this might
> be the way to go to fix the regression for the -rc cycle.
> 
> Regards,
> 
> Tony
> 

Great, I'll do these changes when posting as a proper PATCH.

Thanks a lot and best regards,
Javier
