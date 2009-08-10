From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v3] OMAP: GPIO: Fix incorrect gpio_get logic for output
	GPIOs
Date: Mon, 10 Aug 2009 15:27:12 +0300
Message-ID: <20090810122711.GD1938@atomide.com>
References: <1249904691-4810-1-git-send-email-ext-roger.quadros@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57703 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754067AbZHJM1O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Aug 2009 08:27:14 -0400
Content-Disposition: inline
In-Reply-To: <1249904691-4810-1-git-send-email-ext-roger.quadros@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <ext-roger.quadros@nokia.com>
Cc: linux-omap@vger.kernel.org

* Roger Quadros <ext-roger.quadros@nokia.com> [090810 14:45]:
> gpio_get() should return DATAIN register value when the GPIO
> is configured as input whereas it should return DATAOUT register
> value when the GPIO is configured as output.
> Now /sys/kernel/debug/gpio shows proper values for output GPIOs

Thanks, will update my omap-fixes queue with this.

Tony
 
> Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
> ---
>  arch/arm/plat-omap/gpio.c |  121 +++++++++++++++++++++++++++++++++------------
>  1 files changed, 89 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
> index 26b387c..9c16ca8 100644
> --- a/arch/arm/plat-omap/gpio.c
> +++ b/arch/arm/plat-omap/gpio.c
> @@ -476,14 +476,12 @@ static void _set_gpio_dataout(struct gpio_bank *bank, int gpio, int enable)
>  	__raw_writel(l, reg);
>  }
>  
> -static int __omap_get_gpio_datain(int gpio)
> +static int _get_gpio_datain(struct gpio_bank *bank, int gpio)
>  {
> -	struct gpio_bank *bank;
>  	void __iomem *reg;
>  
>  	if (check_gpio(gpio) < 0)
>  		return -EINVAL;
> -	bank = get_gpio_bank(gpio);
>  	reg = bank->base;
>  	switch (bank->method) {
>  #ifdef CONFIG_ARCH_OMAP1
> @@ -524,6 +522,53 @@ static int __omap_get_gpio_datain(int gpio)
>  			& (1 << get_gpio_index(gpio))) != 0;
>  }
>  
> +static int _get_gpio_dataout(struct gpio_bank *bank, int gpio)
> +{
> +	void __iomem *reg;
> +
> +	if (check_gpio(gpio) < 0)
> +		return -EINVAL;
> +	reg = bank->base;
> +
> +	switch (bank->method) {
> +#ifdef CONFIG_ARCH_OMAP1
> +	case METHOD_MPUIO:
> +		reg += OMAP_MPUIO_OUTPUT;
> +		break;
> +#endif
> +#ifdef CONFIG_ARCH_OMAP15XX
> +	case METHOD_GPIO_1510:
> +		reg += OMAP1510_GPIO_DATA_OUTPUT;
> +		break;
> +#endif
> +#ifdef CONFIG_ARCH_OMAP16XX
> +	case METHOD_GPIO_1610:
> +		reg += OMAP1610_GPIO_DATAOUT;
> +		break;
> +#endif
> +#ifdef CONFIG_ARCH_OMAP730
> +	case METHOD_GPIO_730:
> +		reg += OMAP730_GPIO_DATA_OUTPUT;
> +		break;
> +#endif
> +#ifdef CONFIG_ARCH_OMAP850
> +	case METHOD_GPIO_850:
> +		reg += OMAP850_GPIO_DATA_OUTPUT;
> +		break;
> +#endif
> +#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
> +		defined(CONFIG_ARCH_OMAP4)
> +	case METHOD_GPIO_24XX:
> +		reg += OMAP24XX_GPIO_DATAOUT;
> +		break;
> +#endif
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return (__raw_readl(reg) & (1 << get_gpio_index(gpio))) != 0;
> +}
> +
>  #define MOD_REG_BIT(reg, bit_mask, set)	\
>  do {	\
>  	int l = __raw_readl(base + reg); \
> @@ -1350,9 +1395,49 @@ static int gpio_input(struct gpio_chip *chip, unsigned offset)
>  	return 0;
>  }
>  
> +static int gpio_is_input(struct gpio_bank *bank, int mask)
> +{
> +	void __iomem *reg = bank->base;
> +
> +	switch (bank->method) {
> +	case METHOD_MPUIO:
> +		reg += OMAP_MPUIO_IO_CNTL;
> +		break;
> +	case METHOD_GPIO_1510:
> +		reg += OMAP1510_GPIO_DIR_CONTROL;
> +		break;
> +	case METHOD_GPIO_1610:
> +		reg += OMAP1610_GPIO_DIRECTION;
> +		break;
> +	case METHOD_GPIO_730:
> +		reg += OMAP730_GPIO_DIR_CONTROL;
> +		break;
> +	case METHOD_GPIO_850:
> +		reg += OMAP850_GPIO_DIR_CONTROL;
> +		break;
> +	case METHOD_GPIO_24XX:
> +		reg += OMAP24XX_GPIO_OE;
> +		break;
> +	}
> +	return __raw_readl(reg) & mask;
> +}
> +
>  static int gpio_get(struct gpio_chip *chip, unsigned offset)
>  {
> -	return __omap_get_gpio_datain(chip->base + offset);
> +	struct gpio_bank *bank;
> +	void __iomem *reg;
> +	int gpio;
> +	u32 mask;
> +
> +	gpio = chip->base + offset;
> +	bank = get_gpio_bank(gpio);
> +	reg = bank->base;
> +	mask = 1 << get_gpio_index(gpio);
> +
> +	if (gpio_is_input(bank, mask))
> +		return _get_gpio_datain(bank, gpio);
> +	else
> +		return _get_gpio_dataout(bank, gpio);
>  }
>  
>  static int gpio_output(struct gpio_chip *chip, unsigned offset, int value)
> @@ -1886,34 +1971,6 @@ arch_initcall(omap_gpio_sysinit);
>  #include <linux/debugfs.h>
>  #include <linux/seq_file.h>
>  
> -static int gpio_is_input(struct gpio_bank *bank, int mask)
> -{
> -	void __iomem *reg = bank->base;
> -
> -	switch (bank->method) {
> -	case METHOD_MPUIO:
> -		reg += OMAP_MPUIO_IO_CNTL;
> -		break;
> -	case METHOD_GPIO_1510:
> -		reg += OMAP1510_GPIO_DIR_CONTROL;
> -		break;
> -	case METHOD_GPIO_1610:
> -		reg += OMAP1610_GPIO_DIRECTION;
> -		break;
> -	case METHOD_GPIO_730:
> -		reg += OMAP730_GPIO_DIR_CONTROL;
> -		break;
> -	case METHOD_GPIO_850:
> -		reg += OMAP850_GPIO_DIR_CONTROL;
> -		break;
> -	case METHOD_GPIO_24XX:
> -		reg += OMAP24XX_GPIO_OE;
> -		break;
> -	}
> -	return __raw_readl(reg) & mask;
> -}
> -
> -
>  static int dbg_gpio_show(struct seq_file *s, void *unused)
>  {
>  	unsigned	i, j, gpio;
> -- 
> 1.6.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
