From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP2/3 Avoid GPIO pending irq status been set after irq_disable
Date: Tue, 02 Jun 2009 08:11:04 -0700
Message-ID: <87y6sak6wn.fsf@deeprootsystems.com>
References: <B00E06E2766C2744B022DE9BAF3C59D532D19D@zmy16exm69.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:23392 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753458AbZFBPLF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jun 2009 11:11:05 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1716903wah.21
        for <linux-omap@vger.kernel.org>; Tue, 02 Jun 2009 08:11:07 -0700 (PDT)
In-Reply-To: <B00E06E2766C2744B022DE9BAF3C59D532D19D@zmy16exm69.ds.mot.com> (Wang Sawsd-A's message of "Tue\, 2 Jun 2009 07\:49\:45 +0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wang Sawsd-A24013 <cqwang@motorola.com>
Cc: linux-omap@vger.kernel.org

"Wang Sawsd-A24013" <cqwang@motorola.com> writes:

> Resend because of the content format issues in last mail---sorry for
> inconvenience.

This version is line-wrapped and otherwise confusing as well so does
not apply cleanly.  Could you try using 'git format-patch' to generate
your patch?  It looks like you may have used 'git diff' and then
appended them together?

In addition, the many uses of "also" in this description suggest that
that it could be broken up in to several patches with more clear
descriptions/justifications..  Some are fixes, some are new
functionality.

> This patch adds irq_enable and irq_disable for OMAP GPIO IRQ chip, 

Please elaborate on why you chose to implement the enable/disable
hooks instead of using the mask/unmask hooks.

> and also only enable WAKEUPEN When GPIO edge detection is enabled,

Can you send this fixa separate patch.  It is a bug fix that is
separate from the new stuff you're adding here.

> also clear the gpio event triggering configurations to avoid Pending
> interrupt status which is generated regardless of the IRQEN and
> WKUPEN bit, the pending IRQ status may prevent GPIO module
> acknowledge IDLE request and prevent PER and thus CORE RETENTION.

Have you tested the PM branch code?

I'm not sure I quite follow your description here, but IIUC, we are
already doing this in the [prepare|resume]_idle() hooks.

Kevin

> This is only applied for OMAP2/3 GPIO IRQs.
>
> Signed-off-by: Chunqiu Wang <cqwang@motorola.com>
>
> ---
>  arch/arm/plat-omap/gpio.c |   44
> ++++++++++++++++++++++++++++++++++++++++++--
>  1 files changed, 42 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index bd04b40..19e0461 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -581,7 +581,7 @@ void omap_set_gpio_debounce_time(int gpio, int
> enc_time)
>  EXPORT_SYMBOL(omap_set_gpio_debounce_time);
>  
>  #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
> -static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int
> gpio,
> +static void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
>  						int trigger)
>  {
>  	void __iomem *base = bank->base;
> @@ -597,7 +597,12 @@ static inline void set_24xx_gpio_triggering(struct
> gpio_bank *bank, int gpio,
>  		trigger & IRQ_TYPE_EDGE_FALLING);
>  
>  	if (likely(!(bank->non_wakeup_gpios & gpio_bit))) {
> -		if (trigger != 0)
> +		/*
> +		 * GPIO wakeup request can only be generated on edge
> +		 * transitions, see OMAP34xx_ES3.1_TRM_V_Q G25.5.3.1
> +		 * wake-up request note for detail
> +		 */
> +		if ((trigger & IRQ_TYPE_EDGE_BOTH) != 0)
>  			__raw_writel(1 << gpio, bank->base
>  					+ OMAP24XX_GPIO_SETWKUENA);
>  		else
> @@ -1133,6 +1138,39 @@ static void gpio_ack_irq(unsigned int irq)
>  	_clear_gpio_irqstatus(bank, gpio);
>  }
>  
> +static void gpio_enable_irq(unsigned int irq)
> +{
> +	unsigned int gpio = irq - IH_GPIO_BASE;
> +	struct gpio_bank *bank = get_irq_chip_data(irq);
> +	int trigger = irq_desc[irq].status & IRQ_TYPE_SENSE_MASK;
> +
> +#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
> +	set_24xx_gpio_triggering(bank, get_gpio_index(gpio), trigger);
> +#endif
> +	_set_gpio_irqenable(bank, gpio, 1);
> +}
> +
> +static void gpio_disable_irq(unsigned int irq)
> +{
> +	unsigned int gpio = irq - IH_GPIO_BASE;
> +	struct gpio_bank *bank = get_irq_chip_data(irq);
> +
> +	_set_gpio_irqenable(bank, gpio, 0);
> +#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
> +	/*
> +	 * Clear the event detect setting and IRQ status to prevent
> +	 * IRQ staus been set or pending there While IRQ is disabled,
> +	 * otherwise GPIO module will not acknowledge the IDLE request
> +	 * from PER power domain, this may prevent System wide retention
> +	 * See OMAP34xx_ES3.1_TRM_V_Q G25.5.3.1 GPIO interrupt and
> wakeup
> +	 * enable note for detail
> +	 */
> +	set_24xx_gpio_triggering(bank, get_gpio_index(gpio),
> IRQ_TYPE_NONE);
> +	_clear_gpio_irqstatus(bank, gpio);
> +#endif
> +
> +}
> +
>  static void gpio_mask_irq(unsigned int irq)
>  {
>  	unsigned int gpio = irq - IH_GPIO_BASE;
> @@ -1160,6 +1198,8 @@ static void gpio_unmask_irq(unsigned int irq)
>  static struct irq_chip gpio_irq_chip = {
>  	.name		= "GPIO",
>  	.shutdown	= gpio_irq_shutdown,
> +	.enable		= gpio_enable_irq,
> +	.disable	= gpio_disable_irq,
>  	.ack		= gpio_ack_irq,
>  	.mask		= gpio_mask_irq,
>  	.unmask		= gpio_unmask_irq,
> -- 
> 1.5.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org More majordomo info
> at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
