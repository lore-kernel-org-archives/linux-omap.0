From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 15/15] OMAP: GPIO: clean omap_gpio_mod_init function
Date: Wed, 25 May 2011 16:48:30 -0700
Message-ID: <87r57mjq9d.fsf@ti.com>
References: <1306247094-25372-1-git-send-email-tarun.kanti@ti.com>
	<1306247094-25372-16-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:59692 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753571Ab1EYXsd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 May 2011 19:48:33 -0400
Received: by mail-px0-f173.google.com with SMTP id 16so106046pxi.18
        for <linux-omap@vger.kernel.org>; Wed, 25 May 2011 16:48:32 -0700 (PDT)
In-Reply-To: <1306247094-25372-16-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Tue, 24 May 2011 19:54:54 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Charulatha V <charu@ti.com>

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> From: Charulatha V <charu@ti.com>
>
> With register offsets now defined for respective OMAP versions
> we can get rid of cpu_class_* checks. In addition, organized
> common initialization for the different OMAP silicon versions.
>
> Signed-off-by: Charulatha V <charu@ti.com>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>

The sysconfig stuff in this patch should be removed.  In fact, now that
hwmod is used to manage all the GPIO IP blocks, the driver should not be
touching sysconfig at all.

The hwmod defaults should be enough, and for enabling wake-ups, the
device-specific code should be calling omap_hwmod_enable_wakeup() (which
will also enable smart-idle if the IP supports it.)


> ---
>  arch/arm/mach-omap1/gpio16xx.c         |    1 +
>  arch/arm/plat-omap/include/plat/gpio.h |    1 +
>  drivers/gpio/gpio_omap.c               |   74 +++++++++++++-------------------
>  3 files changed, 32 insertions(+), 44 deletions(-)
>
> diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
> index 24f6cfa..e9f8abd 100644
> --- a/arch/arm/mach-omap1/gpio16xx.c
> +++ b/arch/arm/mach-omap1/gpio16xx.c
> @@ -227,6 +227,7 @@ static int __init omap16xx_gpio_init(void)
>  	omap16xx_gpio_regs.wkupset = OMAP1610_GPIO_SET_WAKEUPENA;
>  	omap16xx_gpio_regs.edgectrl1 = OMAP1610_GPIO_EDGE_CTRL1;
>  	omap16xx_gpio_regs.edgectrl2 = OMAP1610_GPIO_EDGE_CTRL2;
> +	omap16xx_gpio_regs.sysconfig = OMAP1610_GPIO_SYSCONFIG;
>  
>  	for (i = 0; i < ARRAY_SIZE(omap16xx_gpio_dev); i++)
>  		platform_device_register(omap16xx_gpio_dev[i]);
> diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
> index f82881c..ac45191 100644
> --- a/arch/arm/plat-omap/include/plat/gpio.h
> +++ b/arch/arm/plat-omap/include/plat/gpio.h
> @@ -176,6 +176,7 @@ struct omap_gpio_dev_attr {
>  
>  struct omap_gpio_reg_offs {
>  	u16 revision;
> +	u16 sysconfig;
>  	u16 direction;
>  	u16 datain;
>  	u16 dataout;
> diff --git a/drivers/gpio/gpio_omap.c b/drivers/gpio/gpio_omap.c
> index ebeb16e..3649c74 100644
> --- a/drivers/gpio/gpio_omap.c
> +++ b/drivers/gpio/gpio_omap.c
> @@ -885,65 +885,51 @@ static void __init omap_gpio_show_rev(struct gpio_bank *bank)
>  	called = true;
>  }
>  
> -/* This lock class tells lockdep that GPIO irqs are in a different
> +/*
> + * This lock class tells lockdep that GPIO irqs are in a different
>   * category than their parents, so it won't report false recursion.
>   */
>  static struct lock_class_key gpio_lock_class;
>  
> -/* TODO: Cleanup cpu_is_* checks */
>  static void omap_gpio_mod_init(struct gpio_bank *bank)
>  {
> -	if (cpu_class_is_omap2()) {
> -		if (cpu_is_omap44xx()) {
> -			__raw_writel(0xffffffff, bank->base +
> -					OMAP4_GPIO_IRQSTATUSCLR0);
> -			__raw_writel(0x00000000, bank->base +
> -					 OMAP4_GPIO_DEBOUNCENABLE);
> -			/* Initialize interface clk ungated, module enabled */
> -			__raw_writel(0, bank->base + OMAP4_GPIO_CTRL);
> -		} else if (cpu_is_omap34xx()) {
> -			__raw_writel(0x00000000, bank->base +
> -					OMAP24XX_GPIO_IRQENABLE1);
> -			__raw_writel(0xffffffff, bank->base +
> -					OMAP24XX_GPIO_IRQSTATUS1);
> -			__raw_writel(0x00000000, bank->base +
> -					OMAP24XX_GPIO_DEBOUNCE_EN);
> +	if (bank->width == 32) {
> +		u32 l = 0;
> +
> +		if (bank->regs->irqenable_inv)
> +			l = ~l;
>  
> +		__raw_writel(l, bank->base + bank->regs->irqstatus);

The ->irqenable_inv flag doesn't affect ->irqstatus.

> +		__raw_writel(l, bank->base + bank->regs->irqenable);
> +
> +		if (bank->regs->debounce_en != USHRT_MAX)
> +			__raw_writel(l, bank->base + bank->regs->debounce_en);

If ->irqenable_inv = true, debounce was just enabled for all GPIOs in
the bank.

> +		if (bank->regs->ctrl != USHRT_MAX)
>  			/* Initialize interface clk ungated, module enabled */
> -			__raw_writel(0, bank->base + OMAP24XX_GPIO_CTRL);
> -		}
> -	} else if (cpu_class_is_omap1()) {
> -		if (bank_is_mpuio(bank)) {
> -			__raw_writew(0xffff, bank->base +
> -				OMAP_MPUIO_GPIO_MASKIT / bank->stride);
> +			 __raw_writel(l, bank->base + bank->regs->ctrl);

If ->irqenable_env = true, all the clocks were just gated.

Similar problems below.

Kevin
> +
> +	} else if (bank->width == 16) {
> +		u16 l = 0;
> +
> +		if (bank_is_mpuio(bank))
>  			mpuio_init(bank);
> -		}
> -		if (cpu_is_omap15xx() && bank->method == METHOD_GPIO_1510) {
> -			__raw_writew(0xffff, bank->base
> -						+ OMAP1510_GPIO_INT_MASK);
> -			__raw_writew(0x0000, bank->base
> -						+ OMAP1510_GPIO_INT_STATUS);
> -		}
> -		if (cpu_is_omap16xx() && bank->method == METHOD_GPIO_1610) {
> -			__raw_writew(0x0000, bank->base
> -						+ OMAP1610_GPIO_IRQENABLE1);
> -			__raw_writew(0xffff, bank->base
> -						+ OMAP1610_GPIO_IRQSTATUS1);
> -			__raw_writew(0x0014, bank->base
> -						+ OMAP1610_GPIO_SYSCONFIG);
>  
> +		if (bank->regs->irqenable_inv)
> +			l = ~l;
> +
> +		__raw_writew(l, bank->base + bank->regs->irqstatus);
> +		__raw_writew(l, bank->base + bank->regs->irqenable);
> +
> +		if (bank->regs->sysconfig != USHRT_MAX) {
> +			/* set wakeup-enable and smart-idle */
> +			__raw_writew(0x14, bank->base + bank->regs->sysconfig);
>  			/*
>  			 * Enable system clock for GPIO module.
>  			 * The CAM_CLK_CTRL *is* really the right place.
>  			 */
>  			omap_writel(omap_readl(ULPD_CAM_CLK_CTRL) | 0x04,
> -						ULPD_CAM_CLK_CTRL);
> -		}
> -		if (cpu_is_omap7xx() && bank->method == METHOD_GPIO_7XX) {
> -			__raw_writel(0xffffffff, bank->base
> -						+ OMAP7XX_GPIO_INT_MASK);
> -			__raw_writel(0x00000000, bank->base
> -						+ OMAP7XX_GPIO_INT_STATUS);
> +					ULPD_CAM_CLK_CTRL);
>  		}
>  	}
>  }
