From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 13/15] OMAP: GPIO: clean set_gpio_triggering function
Date: Wed, 25 May 2011 16:27:58 -0700
Message-ID: <87fwo2l5s1.fsf@ti.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
	<1306247094-25372-14-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:48480 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753745Ab1EYX2C (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 19:28:02 -0400
Received: by mail-pv0-f181.google.com with SMTP id 13so69358pvg.26
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 16:28:01 -0700 (PDT)
In-Reply-To: <1306247094-25372-14-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Tue, 24 May 2011 19:54:52 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> From: Charulatha V <charu@ti.com>
>
> Getting rid of ifdefs within the function by adding register offset intctrl
> and associating OMAPXXXX_GPIO_INT_CONTROL in respective SoC specific files.
>
> Signed-off-by: Charulatha V <charu@ti.com>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> ---
>  arch/arm/mach-omap1/gpio15xx.c         |   14 ++++
>  arch/arm/mach-omap1/gpio16xx.c         |   14 ++++
>  arch/arm/mach-omap1/gpio7xx.c          |   14 ++++
>  arch/arm/mach-omap2/gpio.c             |    4 +
>  arch/arm/plat-omap/include/plat/gpio.h |    3 +
>  drivers/gpio/gpio_omap.c               |  125 +++++++-------------------------
>  6 files changed, 77 insertions(+), 97 deletions(-)
>
> diff --git a/arch/arm/mach-omap1/gpio15xx.c b/arch/arm/mach-omap1/gpio15xx.c
> index b0bd21e..ceee046 100644
> --- a/arch/arm/mach-omap1/gpio15xx.c
> +++ b/arch/arm/mach-omap1/gpio15xx.c
> @@ -46,6 +46,13 @@ static struct omap_gpio_reg_offs omap15xx_mpuio_regs = {
>  	.wkupstatus	= USHRT_MAX,
>  	.wkupclear	= USHRT_MAX,
>  	.wkupset	= USHRT_MAX,
> +	.irqctrl	= OMAP_MPUIO_GPIO_INT_EDGE,
> +	.edgectrl1	= USHRT_MAX,
> +	.edgectrl2	= USHRT_MAX,
> +	.leveldetect0	= USHRT_MAX,
> +	.leveldetect1	= USHRT_MAX,
> +	.risingdetect	= USHRT_MAX,
> +	.fallingdetect	= USHRT_MAX,
>  };

As before, drop the USHRT_MAX and just use non-zer value to determine if
register exists.

>  static struct __initdata omap_gpio_platform_data omap15xx_mpu_gpio_config = {
> @@ -91,6 +98,13 @@ static struct omap_gpio_reg_offs omap15xx_gpio_regs = {
>  	.wkupstatus	= USHRT_MAX,
>  	.wkupclear	= USHRT_MAX,
>  	.wkupset	= USHRT_MAX,
> +	.irqctrl	= OMAP1510_GPIO_INT_CONTROL,
> +	.edgectrl1	= USHRT_MAX,
> +	.edgectrl2	= USHRT_MAX,
> +	.leveldetect0	= USHRT_MAX,
> +	.leveldetect1	= USHRT_MAX,
> +	.risingdetect	= USHRT_MAX,
> +	.fallingdetect	= USHRT_MAX,
>  };
>  
>  static struct __initdata omap_gpio_platform_data omap15xx_gpio_config = {
> diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
> index 403437b..b2479c5 100644
> --- a/arch/arm/mach-omap1/gpio16xx.c
> +++ b/arch/arm/mach-omap1/gpio16xx.c
> @@ -49,6 +49,13 @@ static struct omap_gpio_reg_offs omap16xx_mpuio_regs = {
>  	.wkupstatus	= USHRT_MAX,
>  	.wkupclear	= USHRT_MAX,
>  	.wkupset	= USHRT_MAX,
> +	.irqctrl	= OMAP_MPUIO_GPIO_INT_EDGE,
> +	.edgectrl1	= USHRT_MAX,
> +	.edgectrl2	= USHRT_MAX,
> +	.leveldetect0	= USHRT_MAX,
> +	.leveldetect1	= USHRT_MAX,
> +	.risingdetect	= USHRT_MAX,
> +	.fallingdetect	= USHRT_MAX,
>  };
>  
>  static struct __initdata omap_gpio_platform_data omap16xx_mpu_gpio_config = {
> @@ -97,6 +104,13 @@ static struct omap_gpio_reg_offs omap16xx_gpio_regs = {
>  	.wkupstatus	= OMAP1610_GPIO_WAKEUPENABLE,
>  	.wkupclear	= OMAP1610_GPIO_CLEAR_WAKEUPENA,
>  	.wkupset	= OMAP1610_GPIO_SET_WAKEUPENA,
> +	.irqctrl	= USHRT_MAX,
> +	.edgectrl1	= OMAP1610_GPIO_EDGE_CTRL1,
> +	.edgectrl2	= OMAP1610_GPIO_EDGE_CTRL2,
> +	.leveldetect0	= USHRT_MAX,
> +	.leveldetect1	= USHRT_MAX,
> +	.risingdetect	= USHRT_MAX,
> +	.fallingdetect	= USHRT_MAX,
>  };
>  
>  static struct __initdata omap_gpio_platform_data omap16xx_gpio1_config = {
> diff --git a/arch/arm/mach-omap1/gpio7xx.c b/arch/arm/mach-omap1/gpio7xx.c
> index d5a4aaf..ceac936 100644
> --- a/arch/arm/mach-omap1/gpio7xx.c
> +++ b/arch/arm/mach-omap1/gpio7xx.c
> @@ -51,6 +51,13 @@ static struct omap_gpio_reg_offs omap7xx_mpuio_regs = {
>  	.wkupstatus	= USHRT_MAX,
>  	.wkupclear	= USHRT_MAX,
>  	.wkupset	= USHRT_MAX,
> +	.irqctrl	= OMAP_MPUIO_GPIO_INT_EDGE / 2,
> +	.edgectrl1	= USHRT_MAX,
> +	.edgectrl2	= USHRT_MAX,
> +	.leveldetect0	= USHRT_MAX,
> +	.leveldetect1	= USHRT_MAX,
> +	.risingdetect	= USHRT_MAX,
> +	.fallingdetect	= USHRT_MAX,
>  };
>  
>  static struct __initdata omap_gpio_platform_data omap7xx_mpu_gpio_config = {
> @@ -96,6 +103,13 @@ static struct omap_gpio_reg_offs omap7xx_gpio_regs = {
>  	.wkupstatus	= USHRT_MAX,
>  	.wkupclear	= USHRT_MAX,
>  	.wkupset	= USHRT_MAX,
> +	.irqctrl	= OMAP7XX_GPIO_INT_CONTROL,
> +	.edgectrl1	= USHRT_MAX,
> +	.edgectrl2	= USHRT_MAX,
> +	.leveldetect0	= USHRT_MAX,
> +	.leveldetect1	= USHRT_MAX,
> +	.risingdetect	= USHRT_MAX,
> +	.fallingdetect	= USHRT_MAX,
>  };
>  
>  static struct __initdata omap_gpio_platform_data omap7xx_gpio1_config = {
> diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
> index fbedbbb..eda1846 100644
> --- a/arch/arm/mach-omap2/gpio.c
> +++ b/arch/arm/mach-omap2/gpio.c
> @@ -92,6 +92,10 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
>  		return -ENOMEM;
>  	}
>  
> +	pdata->regs->irqctrl = USHRT_MAX;
> +	pdata->regs->edgectrl1 = USHRT_MAX;
> +	pdata->regs->edgectrl2 = USHRT_MAX;
> +
>  	switch (oh->class->rev) {
>  	case 0:
>  	case 1:
> diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
> index a341790..f82881c 100644
> --- a/arch/arm/plat-omap/include/plat/gpio.h
> +++ b/arch/arm/plat-omap/include/plat/gpio.h
> @@ -197,6 +197,9 @@ struct omap_gpio_reg_offs {
>  	u16 wkupstatus;
>  	u16 wkupclear;
>  	u16 wkupset;
> +	u16 irqctrl;
> +	u16 edgectrl1;
> +	u16 edgectrl2;
>  
>  	bool irqenable_inv;
>  };
> diff --git a/drivers/gpio/gpio_omap.c b/drivers/gpio/gpio_omap.c
> index 762d73c..ebeb16e 100644
> --- a/drivers/gpio/gpio_omap.c
> +++ b/drivers/gpio/gpio_omap.c
> @@ -202,33 +202,20 @@ static void _set_gpio_debounce(struct gpio_bank *bank, unsigned gpio,
>  	__raw_writel(val, reg);
>  }
>  
> -#ifdef CONFIG_ARCH_OMAP2PLUS
> -static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
> +static inline void set_gpio_trigger(struct gpio_bank *bank, int gpio,
>  						int trigger)
>  {
>  	void __iomem *base = bank->base;
>  	u32 gpio_bit = 1 << gpio;
> -	u32 val;
>  
> -	if (cpu_is_omap44xx()) {
> -		MOD_REG_BIT(OMAP4_GPIO_LEVELDETECT0, gpio_bit,
> +	MOD_REG_BIT(bank->regs->leveldetect0, gpio_bit,
>  			trigger & IRQ_TYPE_LEVEL_LOW);
> -		MOD_REG_BIT(OMAP4_GPIO_LEVELDETECT1, gpio_bit,
> +	MOD_REG_BIT(bank->regs->leveldetect1, gpio_bit,
>  			trigger & IRQ_TYPE_LEVEL_HIGH);
> -		MOD_REG_BIT(OMAP4_GPIO_RISINGDETECT, gpio_bit,
> +	MOD_REG_BIT(bank->regs->risingdetect, gpio_bit,
>  			trigger & IRQ_TYPE_EDGE_RISING);
> -		MOD_REG_BIT(OMAP4_GPIO_FALLINGDETECT, gpio_bit,
> +	MOD_REG_BIT(bank->regs->fallingdetect, gpio_bit,
>  			trigger & IRQ_TYPE_EDGE_FALLING);
> -	} else {
> -		MOD_REG_BIT(OMAP24XX_GPIO_LEVELDETECT0, gpio_bit,
> -			trigger & IRQ_TYPE_LEVEL_LOW);
> -		MOD_REG_BIT(OMAP24XX_GPIO_LEVELDETECT1, gpio_bit,
> -			trigger & IRQ_TYPE_LEVEL_HIGH);
> -		MOD_REG_BIT(OMAP24XX_GPIO_RISINGDETECT, gpio_bit,
> -			trigger & IRQ_TYPE_EDGE_RISING);
> -		MOD_REG_BIT(OMAP24XX_GPIO_FALLINGDETECT, gpio_bit,
> -			trigger & IRQ_TYPE_EDGE_FALLING);
> -	}
>  
>  	if (likely(!(bank->non_wakeup_gpios & gpio_bit))) {
>  		/*
> @@ -259,36 +246,16 @@ static inline void set_24xx_gpio_triggering(struct gpio_bank *bank, int gpio,
>  		__raw_readl(bank->base + bank->regs->leveldetect0) |
>  		__raw_readl(bank->base + bank->regs->leveldetect1);
>  }
> -#endif
>  
> -#ifdef CONFIG_ARCH_OMAP1
>  /*
>   * This only applies to chips that can't do both rising and falling edge
>   * detection at once.  For all other chips, this function is a noop.
>   */
>  static void _toggle_gpio_edge_triggering(struct gpio_bank *bank, int gpio)
>  {
> -	void __iomem *reg = bank->base;
> +	void __iomem *reg = bank->base + bank->regs->irqctrl;
>  	u32 l = 0;

Need to check for valid regs->irqctrl here.

> -	switch (bank->method) {
> -	case METHOD_MPUIO:
> -		reg += OMAP_MPUIO_GPIO_INT_EDGE / bank->stride;
> -		break;
> -#ifdef CONFIG_ARCH_OMAP15XX
> -	case METHOD_GPIO_1510:
> -		reg += OMAP1510_GPIO_INT_CONTROL;
> -		break;
> -#endif
> -#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
> -	case METHOD_GPIO_7XX:
> -		reg += OMAP7XX_GPIO_INT_CONTROL;
> -		break;
> -#endif
> -	default:
> -		return;
> -	}
> -
>  	l = __raw_readl(reg);
>  	if ((l >> gpio) & 1)
>  		l &= ~(1 << gpio);
> @@ -297,31 +264,18 @@ static void _toggle_gpio_edge_triggering(struct gpio_bank *bank, int gpio)
>  
>  	__raw_writel(l, reg);
>  }
> -#endif
>  
>  static int _set_gpio_triggering(struct gpio_bank *bank, int gpio, int trigger)
>  {
>  	void __iomem *reg = bank->base;
>  	u32 l = 0;
>  
> -	switch (bank->method) {
> -#ifdef CONFIG_ARCH_OMAP1
> -	case METHOD_MPUIO:
> -		reg += OMAP_MPUIO_GPIO_INT_EDGE / bank->stride;
> -		l = __raw_readl(reg);
> -		if ((trigger & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH)
> -			bank->toggle_mask |= 1 << gpio;
> -		if (trigger & IRQ_TYPE_EDGE_RISING)
> -			l |= 1 << gpio;
> -		else if (trigger & IRQ_TYPE_EDGE_FALLING)
> -			l &= ~(1 << gpio);
> -		else
> -			goto bad;
> -		break;
> -#endif
> -#ifdef CONFIG_ARCH_OMAP15XX
> -	case METHOD_GPIO_1510:
> -		reg += OMAP1510_GPIO_INT_CONTROL;
> +	if ((bank->regs->leveldetect0 != USHRT_MAX) &&
> +			(bank->regs->wkupstatus != USHRT_MAX)) {
> +		set_gpio_trigger(bank, gpio, trigger);
> +	} else if (bank->regs->irqctrl != USHRT_MAX) {
> +		reg += bank->regs->irqctrl;
> +
>  		l = __raw_readl(reg);
>  		if ((trigger & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH)
>  			bank->toggle_mask |= 1 << gpio;
> @@ -330,15 +284,16 @@ static int _set_gpio_triggering(struct gpio_bank *bank, int gpio, int trigger)
>  		else if (trigger & IRQ_TYPE_EDGE_FALLING)
>  			l &= ~(1 << gpio);
>  		else
> -			goto bad;
> -		break;
> -#endif
> -#ifdef CONFIG_ARCH_OMAP16XX
> -	case METHOD_GPIO_1610:
> +			return -EINVAL;
> +
> +		__raw_writel(l, reg);
> +
> +	} else if (bank->regs->edgectrl1 != USHRT_MAX) {
>  		if (gpio & 0x08)
> -			reg += OMAP1610_GPIO_EDGE_CTRL2;
> +			reg += bank->regs->edgectrl2;
>  		else
> -			reg += OMAP1610_GPIO_EDGE_CTRL1;
> +			reg += bank->regs->edgectrl1;
> +
>  		gpio &= 0x07;
>  		l = __raw_readl(reg);
>  		l &= ~(3 << (gpio << 1));
> @@ -346,40 +301,17 @@ static int _set_gpio_triggering(struct gpio_bank *bank, int gpio, int trigger)
>  			l |= 2 << (gpio << 1);
>  		if (trigger & IRQ_TYPE_EDGE_FALLING)
>  			l |= 1 << (gpio << 1);
> +
>  		if (trigger)
>  			/* Enable wake-up during idle for dynamic tick */
> -			__raw_writel(1 << gpio, bank->base + OMAP1610_GPIO_SET_WAKEUPENA);
> -		else
> -			__raw_writel(1 << gpio, bank->base + OMAP1610_GPIO_CLEAR_WAKEUPENA);
> -		break;
> -#endif
> -#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
> -	case METHOD_GPIO_7XX:
> -		reg += OMAP7XX_GPIO_INT_CONTROL;
> -		l = __raw_readl(reg);
> -		if ((trigger & IRQ_TYPE_SENSE_MASK) == IRQ_TYPE_EDGE_BOTH)
> -			bank->toggle_mask |= 1 << gpio;
> -		if (trigger & IRQ_TYPE_EDGE_RISING)
> -			l |= 1 << gpio;
> -		else if (trigger & IRQ_TYPE_EDGE_FALLING)
> -			l &= ~(1 << gpio);
> +			__raw_writel(1 << gpio, bank->wake_set);
>  		else
> -			goto bad;
> -		break;
> -#endif
> -#ifdef CONFIG_ARCH_OMAP2PLUS
> -	case METHOD_GPIO_24XX:
> -	case METHOD_GPIO_44XX:
> -		set_24xx_gpio_triggering(bank, gpio, trigger);
> -		return 0;
> -#endif
> -	default:
> -		goto bad;
> +			__raw_writel(1 << gpio, bank->wake_clear);
> +
> +		__raw_writel(l, reg);
>  	}
> -	__raw_writel(l, reg);
> +
>  	return 0;
> -bad:
> -	return -EINVAL;
>  }
>  
>  static int gpio_irq_type(struct irq_data *d, unsigned type)
> @@ -678,7 +610,6 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
>  			if (!(isr & 1))
>  				continue;
>  
> -#ifdef CONFIG_ARCH_OMAP1
>  			/*
>  			 * Some chips can't respond to both rising and falling
>  			 * at the same time.  If this irq was requested with
> @@ -686,9 +617,9 @@ static void gpio_irq_handler(unsigned int irq, struct irq_desc *desc)
>  			 * to respond to the IRQ for the opposite direction.
>  			 * This will be indicated in the bank toggle_mask.
>  			 */
> -			if (bank->toggle_mask & (1 << gpio_index))
> +			if ((bank->regs->irqctrl != USHRT_MAX) &&

The valid register check belongs in function, not here.

> +					(bank->toggle_mask & (1 << gpio_index)))
>  				_toggle_gpio_edge_triggering(bank, gpio_index);
> -#endif

This change isn't quite right, as we don't want (or need) do do this on
OMAP2+.  This really is an OMAP1-specific hack.

For the purposes of this patch, leave the OMAP1 #ifdef.  Then, in a
subsequent patch, add another per-bank flag (passed in from pdata) that
indicates whether we want to use this hack, and enable it for
OMAP1-based platforms.

Kevin
