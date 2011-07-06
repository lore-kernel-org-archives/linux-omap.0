From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v3 13/20] GPIO: OMAP: Clean omap_gpio_mod_init function
Date: Wed, 06 Jul 2011 13:38:33 -0700
Message-ID: <87sjqjf8l2.fsf@ti.com>
References: <1309513634-20971-1-git-send-email-tarun.kanti@ti.com>
	<1309513634-20971-14-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:36415 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755529Ab1GFUij (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jul 2011 16:38:39 -0400
Received: by iwn37 with SMTP id 37so249209iwn.26
        for <linux-omap@vger.kernel.org>; Wed, 06 Jul 2011 13:38:37 -0700 (PDT)
In-Reply-To: <1309513634-20971-14-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Fri, 1 Jul 2011 15:17:07 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, tony@atomide.com, Charulatha V <charu@ti.com>

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> With register offsets now defined for respective OMAP versions we can get rid
> of cpu_class_* checks. This function now has common initialization code for
> all OMAP versions. Initialization specific to OMAP16xx has been moved within
> omap16xx_gpio_init().

This patch also adds the ->do_raw_write() stuff which is not described
here, and is an unrelated change that wants its own patch.  More on that
below.

> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Signed-off-by: Charulatha V <charu@ti.com>
> ---
>  arch/arm/mach-omap1/gpio16xx.c         |   19 ++++++-
>  arch/arm/plat-omap/include/plat/gpio.h |    2 +
>  drivers/gpio/gpio-omap.c               |   96 +++++++++++++++-----------------
>  3 files changed, 64 insertions(+), 53 deletions(-)
>
> diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
> index 08dda3c..cfd86b9 100644
> --- a/arch/arm/mach-omap1/gpio16xx.c
> +++ b/arch/arm/mach-omap1/gpio16xx.c
> @@ -93,6 +93,7 @@ static struct omap_gpio_reg_offs omap16xx_gpio_regs = {
>  	.wkup_status	= OMAP1610_GPIO_WAKEUPENABLE,
>  	.edgectrl1	= OMAP1610_GPIO_EDGE_CTRL1,
>  	.edgectrl2	= OMAP1610_GPIO_EDGE_CTRL2,
> +	.sysconfig	= OMAP1610_GPIO_SYSCONFIG,
>  };
>  
>  static struct __initdata omap_gpio_platform_data omap16xx_gpio1_config = {
> @@ -218,12 +219,28 @@ static struct __initdata platform_device * omap16xx_gpio_dev[] = {
>  static int __init omap16xx_gpio_init(void)
>  {
>  	int i;
> +	void __iomem *base;
> +	struct resource *res;
> +	struct platform_device *pdev;
> +	struct omap_gpio_platform_data *pdata;
>  
>  	if (!cpu_is_omap16xx())
>  		return -EINVAL;
>  
> -	for (i = 0; i < ARRAY_SIZE(omap16xx_gpio_dev); i++)
> +	for (i = 0; i < ARRAY_SIZE(omap16xx_gpio_dev); i++) {
> +		pdev = omap16xx_gpio_dev[i];
> +		pdata = pdev->dev.platform_data;
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +		base = ioremap(res->start, resource_size(res));
> +
> +		if (pdata->regs->sysconfig)

using field from regs-> here...

> +			__raw_writew(0x0014, base + OMAP1610_GPIO_SYSCONFIG);

but the #define here.

Since you don't really need this field in reg_offs (because it's not
used in SoC-independent code), just drop the if and always write
sysconfig.

> +		omap_writel(omap_readl(ULPD_CAM_CLK_CTRL) | 0x04,
> +					ULPD_CAM_CLK_CTRL);

Please preserve the comments from the original code, since the CAM
access does lok rather confusing.

>  		platform_device_register(omap16xx_gpio_dev[i]);
> +	}
>  
>  	return 0;
>  }
> diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
> index 4f584de..3f7b028 100644
> --- a/arch/arm/plat-omap/include/plat/gpio.h
> +++ b/arch/arm/plat-omap/include/plat/gpio.h
> @@ -198,6 +198,8 @@ struct omap_gpio_reg_offs {
>  	u16 irqctrl;
>  	u16 edgectrl1;
>  	u16 edgectrl2;
> +	/* Not applicable for OMAP2+ as hwmod layer takes care of sysconfig */
> +	u16 sysconfig;
>  
>  	bool irqenable_inv;
>  };
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 769fae7..3acbaa9 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -75,6 +75,7 @@ struct gpio_bank {
>  
>  	void (*set_dataout)(struct gpio_bank *bank, int gpio, int enable);
>  	int (*get_context_loss_count)(struct device *dev);
> +	void (*do_raw_write)(void __iomem *reg, int set);
>  
>  	struct omap_gpio_reg_offs *regs;
>  };
> @@ -864,67 +865,53 @@ static void __init omap_gpio_show_rev(struct gpio_bank *bank)
>  	called = true;
>  }
>  
> +static void __do_raw_writel(void __iomem *reg, int set)
> +{
> +	if (set)
> +		__raw_writel(0xffffffff, reg);
> +	else
> +		__raw_writel(0x00000000, reg);
> +
> +}
> +
> +static void __do_raw_writew(void __iomem *reg, int set)
> +{
> +	if (set)
> +		__raw_writew(0xffff, reg);
> +	else
> +		__raw_writew(0x0000, reg);
> +}
> +
>  /* This lock class tells lockdep that GPIO irqs are in a different
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
> -
> -			/* Initialize interface clk ungated, module enabled */
> -			__raw_writel(0, bank->base + OMAP24XX_GPIO_CTRL);
> -		}
> -	} else if (cpu_class_is_omap1()) {
> -		if (bank_is_mpuio(bank)) {
> -			__raw_writew(0xffff, bank->base +
> -				OMAP_MPUIO_GPIO_MASKIT / bank->stride);
> +	if (bank_is_mpuio(bank)) {
> +		bank->do_raw_write(bank->base + bank->regs->irqenable, 1);
> +		if (bank->regs->wkup_status)
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
> -
> -			/*
> -			 * Enable system clock for GPIO module.
> -			 * The CAM_CLK_CTRL *is* really the right place.
> -			 */
> -			omap_writel(omap_readl(ULPD_CAM_CLK_CTRL) | 0x04,
> -						ULPD_CAM_CLK_CTRL);
> -		}
> -		if (cpu_is_omap7xx() && bank->method == METHOD_GPIO_7XX) {
> -			__raw_writel(0xffffffff, bank->base
> -						+ OMAP7XX_GPIO_INT_MASK);
> -			__raw_writel(0x00000000, bank->base
> -						+ OMAP7XX_GPIO_INT_STATUS);
> -		}
> +		return;
>  	}
> +
> +	if (bank->regs->ctrl)
> +		/* Initialize interface clk ungated, module enabled */
> +		bank->do_raw_write(bank->base + bank->regs->ctrl, 0);
> +
> +	if (bank->regs->clr_irqenable && bank->width == 32)
> +		bank->do_raw_write(bank->base + bank->regs->clr_irqenable, 1);
> +	else if (bank->regs->irqenable)
> +		bank->do_raw_write(bank->base + bank->regs->irqenable,
> +				bank->regs->irqenable_inv);
> +
> +	if (bank->regs->irqstatus)
> +		bank->do_raw_write(bank->base + bank->regs->irqstatus,
> +				bank->regs->irqenable_inv == 0);
> +
> +	if (bank->regs->debounce_en)
> +		bank->do_raw_write(bank->base + bank->regs->debounce_en, 0);
>  }
>  
>  static __init void
> @@ -1041,6 +1028,11 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
>  	bank->get_context_loss_count = pdata->get_context_loss_count;
>  	bank->regs = pdata->regs;
>  
> +	if (bank->width == 32)
> +		bank->do_raw_write = __do_raw_writel;
> +	else
> +		bank->do_raw_write = __do_raw_writew;
> +
>  	if (bank->regs->set_dataout && bank->regs->clr_dataout)
>  		bank->set_dataout = _set_gpio_dataout_reg;
>  	else

Actually, I think this driver should just be converted so *all* access
are 4-byte accesses.

Current code already uses a mix of readw and readl for register access
OMAP1, so let's just drop all the readw and use readl throughout.  All
registers on OMAP1 are 4-byte aligned.

Kevin

