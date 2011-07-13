From: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Subject: RE: [PATCH v3 12/20] GPIO: OMAP: Use wkup_status for all SoCs
Date: Wed, 13 Jul 2011 09:25:00 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037BE784D9@dbde02.ent.ti.com>
References: <1309513634-20971-1-git-send-email-tarun.kanti@ti.com>
	<1309513634-20971-13-git-send-email-tarun.kanti@ti.com>
	<87k4bwkz9y.fsf@ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB037BE78072@dbde02.ent.ti.com>
 <87hb6rtt2f.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34178 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756027Ab1GMDzI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jul 2011 23:55:08 -0400
In-Reply-To: <87hb6rtt2f.fsf@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hilman, Kevin" <khilman@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "tony@atomide.com" <tony@atomide.com>

[...] 
> A better solution is to just get rid of this macro and use a static
> inline.
> 
> The patch below does just this, and I'm including it into my
> gpio-cleanup series (branch: for_3.1/gpio-cleanup-2.)  Please rebase
> your updated series on that branch.
Alright! Thanks.
--
Tarun

> 
> Kevin
> 
> From 0c3da6533061f51236743ebaf4bae23561e315fe Mon Sep 17 00:00:00 2001
> From: Kevin Hilman <khilman@ti.com>
> Date: Tue, 12 Jul 2011 08:18:15 -0700
> Subject: [PATCH] gpio/omap: replace MOD_REG_BIT macro with static inline
> 
> This macro is ugly and confusing, especially since it passes in most
> arguments, but uses an implied 'base' from the caller.
> 
> Replace it with an equivalent static inline.
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
>  drivers/gpio/gpio-omap.c |   54 ++++++++++++++++++++++++-----------------
> ----
>  1 files changed, 29 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 501ca3d..6d616ee 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -148,13 +148,17 @@ static int _get_gpio_dataout(struct gpio_bank *bank,
> int gpio)
>  	return (__raw_readl(reg) & GPIO_BIT(bank, gpio)) != 0;
>  }
> 
> -#define MOD_REG_BIT(reg, bit_mask, set)	\
> -do {	\
> -	int l = __raw_readl(base + reg); \
> -	if (set) l |= bit_mask; \
> -	else l &= ~bit_mask; \
> -	__raw_writel(l, base + reg); \
> -} while(0)
> +static inline void _gpio_rmw(void __iomem *base, u32 reg, u32 mask, bool
> set)
> +{
> +	int l = __raw_readl(base + reg);
> +
> +	if (set)
> +		l |= mask;
> +	else
> +		l &= ~mask;
> +
> +	__raw_writel(l, base + reg);
> +}
> 
>  /**
>   * _set_gpio_debounce - low level gpio debounce time
> @@ -210,28 +214,28 @@ static inline void set_24xx_gpio_triggering(struct
> gpio_bank *bank, int gpio,
>  	u32 gpio_bit = 1 << gpio;
> 
>  	if (cpu_is_omap44xx()) {
> -		MOD_REG_BIT(OMAP4_GPIO_LEVELDETECT0, gpio_bit,
> -			trigger & IRQ_TYPE_LEVEL_LOW);
> -		MOD_REG_BIT(OMAP4_GPIO_LEVELDETECT1, gpio_bit,
> -			trigger & IRQ_TYPE_LEVEL_HIGH);
> -		MOD_REG_BIT(OMAP4_GPIO_RISINGDETECT, gpio_bit,
> -			trigger & IRQ_TYPE_EDGE_RISING);
> -		MOD_REG_BIT(OMAP4_GPIO_FALLINGDETECT, gpio_bit,
> -			trigger & IRQ_TYPE_EDGE_FALLING);
> +		_gpio_rmw(base, OMAP4_GPIO_LEVELDETECT0, gpio_bit,
> +			  trigger & IRQ_TYPE_LEVEL_LOW);
> +		_gpio_rmw(base, OMAP4_GPIO_LEVELDETECT1, gpio_bit,
> +			  trigger & IRQ_TYPE_LEVEL_HIGH);
> +		_gpio_rmw(base, OMAP4_GPIO_RISINGDETECT, gpio_bit,
> +			  trigger & IRQ_TYPE_EDGE_RISING);
> +		_gpio_rmw(base, OMAP4_GPIO_FALLINGDETECT, gpio_bit,
> +			  trigger & IRQ_TYPE_EDGE_FALLING);
>  	} else {
> -		MOD_REG_BIT(OMAP24XX_GPIO_LEVELDETECT0, gpio_bit,
> -			trigger & IRQ_TYPE_LEVEL_LOW);
> -		MOD_REG_BIT(OMAP24XX_GPIO_LEVELDETECT1, gpio_bit,
> -			trigger & IRQ_TYPE_LEVEL_HIGH);
> -		MOD_REG_BIT(OMAP24XX_GPIO_RISINGDETECT, gpio_bit,
> -			trigger & IRQ_TYPE_EDGE_RISING);
> -		MOD_REG_BIT(OMAP24XX_GPIO_FALLINGDETECT, gpio_bit,
> -			trigger & IRQ_TYPE_EDGE_FALLING);
> +		_gpio_rmw(base, OMAP24XX_GPIO_LEVELDETECT0, gpio_bit,
> +			  trigger & IRQ_TYPE_LEVEL_LOW);
> +		_gpio_rmw(base, OMAP24XX_GPIO_LEVELDETECT1, gpio_bit,
> +			  trigger & IRQ_TYPE_LEVEL_HIGH);
> +		_gpio_rmw(base, OMAP24XX_GPIO_RISINGDETECT, gpio_bit,
> +			  trigger & IRQ_TYPE_EDGE_RISING);
> +		_gpio_rmw(base, OMAP24XX_GPIO_FALLINGDETECT, gpio_bit,
> +			  trigger & IRQ_TYPE_EDGE_FALLING);
>  	}
>  	if (likely(!(bank->non_wakeup_gpios & gpio_bit))) {
>  		if (cpu_is_omap44xx()) {
> -			MOD_REG_BIT(OMAP4_GPIO_IRQWAKEN0, gpio_bit,
> -				trigger != 0);
> +			_gpio_rmw(base, OMAP4_GPIO_IRQWAKEN0, gpio_bit,
> +				  trigger != 0);
>  		} else {
>  			/*
>  			 * GPIO wakeup request can only be generated on edge
> --
> 1.7.6

