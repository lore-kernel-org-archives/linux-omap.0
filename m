From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 4/5] mfd: tps65217: Make an interrupt handler simpler
Date: Tue, 22 Nov 2016 15:48:52 +0000
Message-ID: <20161122154852.GD10134@dell.home>
References: <20161115130215.3301-1-woogyom.kim@gmail.com>
 <20161115130215.3301-5-woogyom.kim@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161115130215.3301-5-woogyom.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Milo Kim <woogyom.kim@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, 15 Nov 2016, Milo Kim wrote:

> Rework the IRQ handler by using HW IRQ number and status bit.
> 
> Each HW IRQ number is matched with TPS65217 register layout[*].
> (USB IRQ number is 0, AC is 1, Push button is 2)
> 
> When an interrupt is enabled, mask bit should be cleared (unmasked).
> If an interrupt is disabled, then mask bit should be set (masked).
> This mask value is updated into the TPS65217 register in irq_sync_unlock().
> 
> Mask bit and interrupt status bit can be handled with HW IRQ number.
> Eventually, additional IRQ data, 'tps65217_irqs[]' and the function,
> 'irq_to_tps65217_irq()' are not necessary.
> 
> [*] TPS65217 interrupt register layout
> 
>  Bit7  6     5     4     3    2     1     0
> ----------------------------------------------
> | x | PBM | ACM | USBM | x | PBI | ACI | USBI
> 
> PBM:  Push button status change interrupt mask
> ACM:  AC interrupt mask
> USBM: USB power status change interrupt mask
> PBI:  Push button status change interrupt
> ACI:  AC power status change interrupt
> USBI: USB power status change interrupt
> x:    Not used
> 
> Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
> ---
>  drivers/mfd/tps65217.c       | 44 +++++++++-----------------------------------
>  include/linux/mfd/tps65217.h |  1 +
>  2 files changed, 10 insertions(+), 35 deletions(-)

Applied, thanks.

> diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
> index 9d76de9..7376090 100644
> --- a/drivers/mfd/tps65217.c
> +++ b/drivers/mfd/tps65217.c
> @@ -42,26 +42,6 @@ static struct resource pb_resources[] = {
>  	DEFINE_RES_IRQ_NAMED(TPS65217_IRQ_PB, "PB"),
>  };
>  
> -struct tps65217_irq {
> -	int mask;
> -	int interrupt;
> -};
> -
> -static const struct tps65217_irq tps65217_irqs[] = {
> -	[TPS65217_IRQ_PB] = {
> -		.mask = TPS65217_INT_PBM,
> -		.interrupt = TPS65217_INT_PBI,
> -	},
> -	[TPS65217_IRQ_AC] = {
> -		.mask = TPS65217_INT_ACM,
> -		.interrupt = TPS65217_INT_ACI,
> -	},
> -	[TPS65217_IRQ_USB] = {
> -		.mask = TPS65217_INT_USBM,
> -		.interrupt = TPS65217_INT_USBI,
> -	},
> -};
> -
>  static void tps65217_irq_lock(struct irq_data *data)
>  {
>  	struct tps65217 *tps = irq_data_get_irq_chip_data(data);
> @@ -74,34 +54,28 @@ static void tps65217_irq_sync_unlock(struct irq_data *data)
>  	struct tps65217 *tps = irq_data_get_irq_chip_data(data);
>  	int ret;
>  
> -	ret = tps65217_reg_write(tps, TPS65217_REG_INT, tps->irq_mask,
> -				TPS65217_PROTECT_NONE);
> +	ret = tps65217_set_bits(tps, TPS65217_REG_INT, TPS65217_INT_MASK,
> +				tps->irq_mask, TPS65217_PROTECT_NONE);
>  	if (ret != 0)
>  		dev_err(tps->dev, "Failed to sync IRQ masks\n");
>  
>  	mutex_unlock(&tps->irq_lock);
>  }
>  
> -static inline const struct tps65217_irq *
> -irq_to_tps65217_irq(struct tps65217 *tps, struct irq_data *data)
> -{
> -	return &tps65217_irqs[data->hwirq];
> -}
> -
>  static void tps65217_irq_enable(struct irq_data *data)
>  {
>  	struct tps65217 *tps = irq_data_get_irq_chip_data(data);
> -	const struct tps65217_irq *irq_data = irq_to_tps65217_irq(tps, data);
> +	u8 mask = BIT(data->hwirq) << TPS65217_INT_SHIFT;
>  
> -	tps->irq_mask &= ~irq_data->mask;
> +	tps->irq_mask &= ~mask;
>  }
>  
>  static void tps65217_irq_disable(struct irq_data *data)
>  {
>  	struct tps65217 *tps = irq_data_get_irq_chip_data(data);
> -	const struct tps65217_irq *irq_data = irq_to_tps65217_irq(tps, data);
> +	u8 mask = BIT(data->hwirq) << TPS65217_INT_SHIFT;
>  
> -	tps->irq_mask |= irq_data->mask;
> +	tps->irq_mask |= mask;
>  }
>  
>  static struct irq_chip tps65217_irq_chip = {
> @@ -150,8 +124,8 @@ static irqreturn_t tps65217_irq_thread(int irq, void *data)
>  		return IRQ_NONE;
>  	}
>  
> -	for (i = 0; i < ARRAY_SIZE(tps65217_irqs); i++) {
> -		if (status & tps65217_irqs[i].interrupt) {
> +	for (i = 0; i < TPS65217_NUM_IRQ; i++) {
> +		if (status & BIT(i)) {
>  			handle_nested_irq(irq_find_mapping(tps->irq_domain, i));
>  			handled = true;
>  		}
> @@ -430,7 +404,7 @@ static int tps65217_remove(struct i2c_client *client)
>  	unsigned int virq;
>  	int i;
>  
> -	for (i = 0; i < ARRAY_SIZE(tps65217_irqs); i++) {
> +	for (i = 0; i < TPS65217_NUM_IRQ; i++) {
>  		virq = irq_find_mapping(tps->irq_domain, i);
>  		if (virq)
>  			irq_dispose_mapping(virq);
> diff --git a/include/linux/mfd/tps65217.h b/include/linux/mfd/tps65217.h
> index 35d8d64..eac2857 100644
> --- a/include/linux/mfd/tps65217.h
> +++ b/include/linux/mfd/tps65217.h
> @@ -79,6 +79,7 @@
>  #define TPS65217_INT_PBI		BIT(2)
>  #define TPS65217_INT_ACI		BIT(1)
>  #define TPS65217_INT_USBI		BIT(0)
> +#define TPS65217_INT_SHIFT		4
>  #define TPS65217_INT_MASK		(TPS65217_INT_PBM | TPS65217_INT_ACM | \
>  					TPS65217_INT_USBM)
>  

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
