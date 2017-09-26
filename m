From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v2] gpio: omap: Fix lost edge interrupts
Date: Tue, 26 Sep 2017 10:54:26 -0500
Message-ID: <01f236f2-b1f2-87af-a9f3-047ae0f02443@ti.com>
References: <20170926113203.2bhqq6ini7dtk4l2@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20170926113203.2bhqq6ini7dtk4l2@lenoch>
Content-Language: en-US
Sender: linux-gpio-owner@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>, linux-omap@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

cc: Linus, linux-gpio

On 09/26/2017 06:32 AM, Ladislav Michl wrote:
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> Use handle_simple_irq and clear edge interrupts early in
> omap_gpio_irq_handler to avoid loosing interrupts.

Acked-by: Grygorii Strashko <grygorii.strashko@ti.com>

not sure, but you might need to re-send it with proper cc list.

> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> ---
>   drivers/gpio/gpio-omap.c |   22 +++++++++++++---------
>   1 file changed, 13 insertions(+), 9 deletions(-)
> 
>   Changes:
>   -v2: use handle_simple_irq to handle edge interrupts
> 
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index dbf869fb63ce..0c8005285124 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -518,7 +518,13 @@ static int omap_gpio_irq_type(struct irq_data *d, unsigned type)
>   	if (type & (IRQ_TYPE_LEVEL_LOW | IRQ_TYPE_LEVEL_HIGH))
>   		irq_set_handler_locked(d, handle_level_irq);
>   	else if (type & (IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
> -		irq_set_handler_locked(d, handle_edge_irq);
> +		/*
> +		 * Edge IRQs are already cleared/acked in irq_handler and
> +		 * not need to be masked, as result handle_edge_irq()
> +		 * logic is excessed here and may cause lose of interrupts.
> +		 * So just use handle_simple_irq.
> +		 */
> +		irq_set_handler_locked(d, handle_simple_irq);
>   
>   	return 0;
>   
> @@ -678,7 +684,7 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
>   static irqreturn_t omap_gpio_irq_handler(int irq, void *gpiobank)
>   {
>   	void __iomem *isr_reg = NULL;
> -	u32 isr;
> +	u32 enabled, isr, level_mask;
>   	unsigned int bit;
>   	struct gpio_bank *bank = gpiobank;
>   	unsigned long wa_lock_flags;
> @@ -691,23 +697,21 @@ static irqreturn_t omap_gpio_irq_handler(int irq, void *gpiobank)
>   	pm_runtime_get_sync(bank->chip.parent);
>   
>   	while (1) {
> -		u32 isr_saved, level_mask = 0;
> -		u32 enabled;
> -
>   		raw_spin_lock_irqsave(&bank->lock, lock_flags);
>   
>   		enabled = omap_get_gpio_irqbank_mask(bank);
> -		isr_saved = isr = readl_relaxed(isr_reg) & enabled;
> +		isr = readl_relaxed(isr_reg) & enabled;
>   
>   		if (bank->level_mask)
>   			level_mask = bank->level_mask & enabled;
> +		else
> +			level_mask = 0;
>   
>   		/* clear edge sensitive interrupts before handler(s) are
>   		called so that we don't miss any interrupt occurred while
>   		executing them */
> -		omap_disable_gpio_irqbank(bank, isr_saved & ~level_mask);
> -		omap_clear_gpio_irqbank(bank, isr_saved & ~level_mask);
> -		omap_enable_gpio_irqbank(bank, isr_saved & ~level_mask);
> +		if (isr & ~level_mask)
> +			omap_clear_gpio_irqbank(bank, isr & ~level_mask);
>   
>   		raw_spin_unlock_irqrestore(&bank->lock, lock_flags);
>   
> 

-- 
regards,
-grygorii
