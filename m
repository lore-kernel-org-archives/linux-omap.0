From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP2/3 Avoid GPIO pending irq status been set after
	irq_disable
Date: Wed, 5 Aug 2009 15:33:55 +0300
Message-ID: <20090805123354.GF7374@atomide.com>
References: <B00E06E2766C2744B022DE9BAF3C59D532D196@zmy16exm69.ds.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:60030 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933704AbZHEMd5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 08:33:57 -0400
Content-Disposition: inline
In-Reply-To: <B00E06E2766C2744B022DE9BAF3C59D532D196@zmy16exm69.ds.mot.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wang Sawsd-A24013 <cqwang@motorola.com>
Cc: linux-omap@vger.kernel.org

Hi,

Sorry for the long delay on replying to this one.

* Wang Sawsd-A24013 <cqwang@motorola.com> [090602 02:25]:
> This patch adds irq_enable and irq_disable for OMAP GPIO IRQ chip, and
> also only enable WAKEUPEN
> When GPIO edge detection is enabled, also clear the gpio event
> triggering configurations to avoid
> Pending interrupt status which is generated regardless of the IRQEN and
> WKUPEN bit, the pending
> IRQ status may prevent GPIO module acknowledge IDLE request and prevent
> PER and thus RETENTION.
> 
> This is only applied for OMAP2/3 GPIO IRQs.
> 
> Signed-off-by: Chunqiu Wang <cqwang@motorola.com>
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

To me it looks like the right way to deal with the level gpio
would be to change it temporarily to be edge for the duration of
idle, then change it back to be level after returning from idle.


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

Also, this irq_enable/disable should be a separate patch.

Regards,

Tony
