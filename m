From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 12/18] GPIO: OMAP: Clean omap_gpio_mod_init function
Date: Thu, 16 Jun 2011 10:49:11 -0700
Message-ID: <87fwn9mzu0.fsf@ti.com>
References: <1308111806-29152-1-git-send-email-tarun.kanti@ti.com>
	<1308111806-29152-3-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:41442 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758514Ab1FPRtP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Jun 2011 13:49:15 -0400
Received: by mail-pw0-f45.google.com with SMTP id 6so921163pwi.32
        for <linux-omap@vger.kernel.org>; Thu, 16 Jun 2011 10:49:14 -0700 (PDT)
In-Reply-To: <1308111806-29152-3-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Wed, 15 Jun 2011 09:53:20 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, tony@atomide.com

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> From: Charulatha V <charu@ti.com>
>
> With register offsets now defined for respective OMAP versions we can get rid
> of cpu_class_* checks. In addition, organized common initialization for the
> different OMAP silicon versions.
>
> Signed-off-by: Charulatha V <charu@ti.com>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>

Since the SYSCONFIG register settings are OMAP1-only and init-time only,
they could be done in the OMAP1-specific init functions.

Also, this could be quite a bit more compact by not duplicating code for
both bank widths.  Instead, create some local function pointers for 16
or 32-bit register access, and assign them based on bank width.

Kevin

> ---
>  arch/arm/mach-omap1/gpio16xx.c         |    1 +
>  arch/arm/plat-omap/include/plat/gpio.h |    2 +
>  drivers/gpio/gpio-omap.c               |  121 +++++++++++++++++++++-----------
>  3 files changed, 84 insertions(+), 40 deletions(-)
>
> diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
> index 4677ea5..efd9275 100644
> --- a/arch/arm/mach-omap1/gpio16xx.c
> +++ b/arch/arm/mach-omap1/gpio16xx.c
> @@ -96,6 +96,7 @@ static struct omap_gpio_reg_offs omap16xx_gpio_regs = {
>  	.wkup_set	= OMAP1610_GPIO_SET_WAKEUPENA,
>  	.edgectrl1	= OMAP1610_GPIO_EDGE_CTRL1,
>  	.edgectrl2	= OMAP1610_GPIO_EDGE_CTRL2,
> +	.sysconfig	= OMAP1610_GPIO_SYSCONFIG,
>  };
>  
>  static struct __initdata omap_gpio_platform_data omap16xx_gpio1_config = {
> diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
> index c0a92ea..30db400 100644
> --- a/arch/arm/plat-omap/include/plat/gpio.h
> +++ b/arch/arm/plat-omap/include/plat/gpio.h
> @@ -200,6 +200,8 @@ struct omap_gpio_reg_offs {
>  	u16 irqctrl;
>  	u16 edgectrl1;
>  	u16 edgectrl2;
> +	/* Not applicable for OMAP2+ as hwmod layer takes care of sysconfig */
> +	u16 sysconfig;
>  
>  	bool irqenable_inv;
>  };
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 53f2ea6..89d1ea5 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -887,47 +887,94 @@ static void __init omap_gpio_show_rev(struct gpio_bank *bank)
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
> +		u32 clr_all = 0;		/* clear all the bits */
> +		u32 set_all = 0xFFFFFFFF;	/* set all the bits */
> +
> +		if (bank_is_mpuio(bank)) {
> +			__raw_writel(set_all, bank->base +
> +						bank->regs->irqenable);
> +
> +			if (bank->suspend_support)
> +				mpuio_init(bank);
>  
> +			return;
> +		}
> +
> +		if (bank->regs->ctrl)
>  			/* Initialize interface clk ungated, module enabled */
> -			__raw_writel(0, bank->base + OMAP24XX_GPIO_CTRL);
> +			 __raw_writel(clr_all, bank->base + bank->regs->ctrl);
> +
> +		if (bank->regs->clr_irqenable) {
> +			__raw_writel(set_all, bank->base +
> +						bank->regs->clr_irqenable);
> +		} else if (bank->regs->irqenable) {
> +			u32 i;
> +
> +			if (bank->regs->irqenable_inv)
> +				i = set_all;
> +			else
> +				i = clr_all;
> +
> +			__raw_writel(i, bank->base + bank->regs->irqenable);
>  		}
> -	} else if (cpu_class_is_omap1()) {
> -		if (bank_is_mpuio(bank) && bank->suspend_support) {
> -			__raw_writew(0xffff, bank->base +
> -				OMAP_MPUIO_GPIO_MASKIT / bank->stride);
> -			mpuio_init(bank);
> +
> +		if (bank->regs->irqstatus) {
> +			u32 i;
> +
> +			if (bank->regs->irqenable_inv)
> +				i = clr_all;
> +			else
> +				i = set_all;
> +
> +			__raw_writel(i, bank->base + bank->regs->irqstatus);
>  		}
> -		if (cpu_is_omap15xx() && bank->method == METHOD_GPIO_1510) {
> -			__raw_writew(0xffff, bank->base
> -						+ OMAP1510_GPIO_INT_MASK);
> -			__raw_writew(0x0000, bank->base
> -						+ OMAP1510_GPIO_INT_STATUS);
> +
> +		if (bank->regs->debounce_en)
> +			__raw_writel(clr_all, bank->base +
> +						bank->regs->debounce_en);
> +
> +	} else if (bank->width == 16) {
> +		u16 clr_all = 0;	/* clear all the bits */
> +		u16 set_all = 0xFFFF;	/* set all the bits */
> +
> +		if (bank_is_mpuio(bank)) {
> +			__raw_writew(set_all, bank->base +
> +						bank->regs->irqenable);
> +
> +			if (bank->suspend_support)
> +				mpuio_init(bank);
> +
> +			return;
>  		}
> -		if (cpu_is_omap16xx() && bank->method == METHOD_GPIO_1610) {
> -			__raw_writew(0x0000, bank->base
> -						+ OMAP1610_GPIO_IRQENABLE1);
> -			__raw_writew(0xffff, bank->base
> -						+ OMAP1610_GPIO_IRQSTATUS1);
> -			__raw_writew(0x0014, bank->base
> -						+ OMAP1610_GPIO_SYSCONFIG);
> +
> +		if (bank->regs->irqenable) {
> +			u16 i;
> +
> +			if (bank->regs->irqenable_inv)
> +				i = set_all;
> +			else
> +				i = clr_all;
> +
> +			__raw_writew(i, bank->base + bank->regs->irqenable);
> +		}
> +
> +		if (bank->regs->irqstatus) {
> +			u32 i;
> +
> +			if (bank->regs->irqenable_inv)
> +				i = clr_all;
> +			else
> +				i = set_all;
> +
> +			__raw_writew(i, bank->base + bank->regs->irqstatus);
> +		}
> +
> +		if (bank->regs->sysconfig) {
> +			/* set wakeup-enable and smart-idle */
> +			__raw_writew(0x14, bank->base + bank->regs->sysconfig);
>  
>  			/*
>  			 * Enable system clock for GPIO module.
> @@ -936,12 +983,6 @@ static void omap_gpio_mod_init(struct gpio_bank *bank)
>  			omap_writel(omap_readl(ULPD_CAM_CLK_CTRL) | 0x04,
>  						ULPD_CAM_CLK_CTRL);
>  		}
> -		if (cpu_is_omap7xx() && bank->method == METHOD_GPIO_7XX) {
> -			__raw_writel(0xffffffff, bank->base
> -						+ OMAP7XX_GPIO_INT_MASK);
> -			__raw_writel(0x00000000, bank->base
> -						+ OMAP7XX_GPIO_INT_STATUS);
> -		}
>  	}
>  }
