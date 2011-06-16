From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v2 08/18] GPIO: OMAP: Use wkup regs off/suspend support flag
Date: Thu, 16 Jun 2011 09:54:29 -0700
Message-ID: <87boxxpvi2.fsf@ti.com>
References: <1308111776-29130-1-git-send-email-tarun.kanti@ti.com>
	<1308111776-29130-7-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:48825 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932090Ab1FPQyd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Jun 2011 12:54:33 -0400
Received: by mail-pv0-f179.google.com with SMTP id 18so367827pvg.10
        for <linux-omap@vger.kernel.org>; Thu, 16 Jun 2011 09:54:32 -0700 (PDT)
In-Reply-To: <1308111776-29130-7-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Wed, 15 Jun 2011 09:52:55 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, tony@atomide.com

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> Wakeup register offsets are initialized according to OMAP versions
> during device registration. These explicit checks are no longer needed.
>
> mpuio_init() function is defined under #ifdefs. It is required only in case
> of MPUIO bank type and only when PM operations are supported by it.
> This is applicable only in case of OMAP16xx SoC's MPUIO GPIO bank type.
> For all the other cases it is a dummy function. Hence clean up the same
> and remove all the OMAP SoC specific #ifdefs.
>
> bank_is_mpuio() is defined as a check to identify if the bank type is MPUIO.
> It is not required to define it separately as zero for OMAP2plus. Remove this.

Also adds a new suspend_support flag to pdata which is not described
here.  This flag is wrongly named and wrongly used throughout.  More on
this below...

> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Signed-off-by: Charulatha V <charu@ti.com>
> ---
>  arch/arm/mach-omap1/gpio16xx.c         |    8 ++
>  arch/arm/mach-omap2/gpio.c             |    7 ++
>  arch/arm/plat-omap/include/plat/gpio.h |    4 +
>  drivers/gpio/gpio-omap.c               |  124 ++++++--------------------------
>  4 files changed, 41 insertions(+), 102 deletions(-)
>
> diff --git a/arch/arm/mach-omap1/gpio16xx.c b/arch/arm/mach-omap1/gpio16xx.c
> index 9a97e60..d1da7c8 100644
> --- a/arch/arm/mach-omap1/gpio16xx.c
> +++ b/arch/arm/mach-omap1/gpio16xx.c
> @@ -52,6 +52,7 @@ static struct __initdata omap_gpio_platform_data omap16xx_mpu_gpio_config = {
>  	.bank_type		= METHOD_MPUIO,
>  	.bank_width		= 16,
>  	.bank_stride		= 1,
> +	.suspend_support	= true,
>  	.regs                   = &omap16xx_mpuio_regs,
>  };
>  
> @@ -89,12 +90,16 @@ static struct omap_gpio_reg_offs omap16xx_gpio_regs = {
>  	.irqenable	= OMAP1610_GPIO_IRQENABLE1,
>  	.set_irqenable	= OMAP1610_GPIO_SET_IRQENABLE1,
>  	.clr_irqenable	= OMAP1610_GPIO_CLEAR_IRQENABLE1,
> +	.wkup_status	= OMAP1610_GPIO_WAKEUPENABLE,
> +	.wkup_clear	= OMAP1610_GPIO_CLEAR_WAKEUPENA,
> +	.wkup_set	= OMAP1610_GPIO_SET_WAKEUPENA,
>  };
>  
>  static struct __initdata omap_gpio_platform_data omap16xx_gpio1_config = {
>  	.virtual_irq_start	= IH_GPIO_BASE,
>  	.bank_type		= METHOD_GPIO_1610,
>  	.bank_width		= 16,
> +	.suspend_support	= true,
>  	.regs                   = &omap16xx_gpio_regs,
>  };
>  
> @@ -125,6 +130,7 @@ static struct __initdata omap_gpio_platform_data omap16xx_gpio2_config = {
>  	.virtual_irq_start	= IH_GPIO_BASE + 16,
>  	.bank_type		= METHOD_GPIO_1610,
>  	.bank_width		= 16,
> +	.suspend_support	= true,
>  	.regs                   = &omap16xx_gpio_regs,
>  };
>  
> @@ -155,6 +161,7 @@ static struct __initdata omap_gpio_platform_data omap16xx_gpio3_config = {
>  	.virtual_irq_start	= IH_GPIO_BASE + 32,
>  	.bank_type		= METHOD_GPIO_1610,
>  	.bank_width		= 16,
> +	.suspend_support	= true,
>  	.regs                   = &omap16xx_gpio_regs,
>  };
>  
> @@ -185,6 +192,7 @@ static struct __initdata omap_gpio_platform_data omap16xx_gpio4_config = {
>  	.virtual_irq_start	= IH_GPIO_BASE + 48,
>  	.bank_type		= METHOD_GPIO_1610,
>  	.bank_width		= 16,
> +	.suspend_support	= true,
>  	.regs                   = &omap16xx_gpio_regs,
>  };

Notice that you add a 'suspend_support = true' everywhere you add a the
wkup_* registers.  This suggests to me that checking for the presence of
one of those registers would tell you the same thing.

> diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
> index cdbc728..ea1556b 100644
> --- a/arch/arm/mach-omap2/gpio.c
> +++ b/arch/arm/mach-omap2/gpio.c
> @@ -72,6 +72,7 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
>  
>  	dev_attr = (struct omap_gpio_dev_attr *)oh->dev_attr;
>  	pdata->bank_width = dev_attr->bank_width;
> +	pdata->suspend_support = true;
>  	pdata->dbck_flag = dev_attr->dbck_flag;
>  	pdata->virtual_irq_start = IH_GPIO_BASE + 32 * (id - 1);
>  	pdata->get_context_loss_count = omap_gpio_get_context_loss;
> @@ -108,6 +109,9 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
>  		pdata->regs->debounce = OMAP24XX_GPIO_DEBOUNCE_VAL;
>  		pdata->regs->debounce_en = OMAP24XX_GPIO_DEBOUNCE_EN;
>  		pdata->regs->ctrl = OMAP24XX_GPIO_CTRL;
> +		pdata->regs->wkup_status = OMAP24XX_GPIO_WAKE_EN;
> +		pdata->regs->wkup_clear = OMAP24XX_GPIO_CLEARWKUENA;
> +		pdata->regs->wkup_set = OMAP24XX_GPIO_SETWKUENA;
>  		break;
>  	case 2:
>  		pdata->bank_type = METHOD_GPIO_44XX;
> @@ -125,6 +129,9 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
>  		pdata->regs->debounce = OMAP4_GPIO_DEBOUNCINGTIME;
>  		pdata->regs->debounce_en = OMAP4_GPIO_DEBOUNCENABLE;
>  		pdata->regs->ctrl = OMAP4_GPIO_CTRL;
> +		pdata->regs->wkup_status = OMAP4_GPIO_IRQWAKEN0;
> +		pdata->regs->wkup_clear = OMAP4_GPIO_IRQWAKEN0;
> +		pdata->regs->wkup_set = OMAP4_GPIO_IRQWAKEN0;
>  		break;
>  	default:
>  		WARN(1, "Invalid gpio bank_type\n");
> diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
> index cf41743..8ab72ed 100644
> --- a/arch/arm/plat-omap/include/plat/gpio.h
> +++ b/arch/arm/plat-omap/include/plat/gpio.h
> @@ -189,6 +189,9 @@ struct omap_gpio_reg_offs {
>  	u16 debounce;
>  	u16 debounce_en;
>  	u16 ctrl;
> +	u16 wkup_status;
> +	u16 wkup_clear;
> +	u16 wkup_set;
>  
>  	bool irqenable_inv;
>  };
> @@ -198,6 +201,7 @@ struct omap_gpio_platform_data {
>  	int bank_type;
>  	int bank_width;		/* GPIO bank width */
>  	int bank_stride;	/* Only needed for omap1 MPUIO */
> +	bool suspend_support;	/* Bank supports suspend/resume operations or not */
>  	bool dbck_flag;		/* dbck required or not - True for OMAP3&4 */
>  	bool loses_context;	/* whether the bank would ever lose context */
>  	u32 non_wakeup_gpios;
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 5555c5a..0c00ccf 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -50,10 +50,8 @@ struct gpio_bank {
>  	u16 irq;
>  	u16 virtual_irq_start;
>  	int method;
> -#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2PLUS)
>  	u32 suspend_wakeup;
>  	u32 saved_wakeup;
> -#endif
>  	u32 non_wakeup_gpios;
>  	u32 enabled_non_wakeup_gpios;
>  	struct gpio_regs context;
> @@ -70,6 +68,7 @@ struct gpio_bank {
>  	struct device *dev;
>  	bool dbck_flag;
>  	bool loses_context;
> +	bool suspend_support;
>  	int stride;
>  	u32 width;
>  	u32 ctx_loss_count;
> @@ -604,27 +603,11 @@ static void omap_gpio_free(struct gpio_chip *chip, unsigned offset)
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&bank->lock, flags);
> -#ifdef CONFIG_ARCH_OMAP16XX
> -	if (bank->method == METHOD_GPIO_1610) {
> -		/* Disable wake-up during idle for dynamic tick */
> -		void __iomem *reg = bank->base + OMAP1610_GPIO_CLEAR_WAKEUPENA;
> -		__raw_writel(1 << offset, reg);
> -	}
> -#endif
> -#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
> -	if (bank->method == METHOD_GPIO_24XX) {
> -		/* Disable wake-up during idle for dynamic tick */
> -		void __iomem *reg = bank->base + OMAP24XX_GPIO_CLEARWKUENA;
> -		__raw_writel(1 << offset, reg);
> -	}
> -#endif
> -#ifdef CONFIG_ARCH_OMAP4
> -	if (bank->method == METHOD_GPIO_44XX) {
> +
> +	if (bank->regs->wkup_clear)
>  		/* Disable wake-up during idle for dynamic tick */
> -		void __iomem *reg = bank->base + OMAP4_GPIO_IRQWAKEN0;
> -		__raw_writel(1 << offset, reg);
> -	}
> -#endif
> +		__raw_writel(1 << offset, bank->base + bank->regs->wkup_clear);
> +
>  	bank->mod_usage &= ~(1 << offset);
>  
>  	if (bank->regs->ctrl && !bank->mod_usage) {
> @@ -788,15 +771,8 @@ static struct irq_chip gpio_irq_chip = {
>  };
>  
>  /*---------------------------------------------------------------------*/
> -
> -#ifdef CONFIG_ARCH_OMAP1
> -
>  #define bank_is_mpuio(bank)	((bank)->method == METHOD_MPUIO)
>  
> -#ifdef CONFIG_ARCH_OMAP16XX
> -
> -#include <linux/platform_device.h>
> -
>  static int omap_mpuio_suspend_noirq(struct device *dev)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
> @@ -858,17 +834,6 @@ static inline void mpuio_init(struct gpio_bank *bank)
>  		(void) platform_device_register(&omap_mpuio_device);
>  }
>  
> -#else
> -static inline void mpuio_init(struct gpio_bank *bank) {}
> -#endif	/* 16xx */
> -
> -#else
> -
> -#define bank_is_mpuio(bank)	0
> -static inline void mpuio_init(struct gpio_bank *bank) {}
> -
> -#endif
> -
>  /*---------------------------------------------------------------------*/
>  
>  /* REVISIT these are stupid implementations!  replace by ones that
> @@ -1010,7 +975,7 @@ static void omap_gpio_mod_init(struct gpio_bank *bank)
>  			__raw_writel(0, bank->base + OMAP24XX_GPIO_CTRL);
>  		}
>  	} else if (cpu_class_is_omap1()) {
> -		if (bank_is_mpuio(bank)) {
> +		if (bank_is_mpuio(bank) && bank->suspend_support) {

What does ->suspend_support have to do with MPUIO init?

>  			__raw_writew(0xffff, bank->base +
>  				OMAP_MPUIO_GPIO_MASKIT / bank->stride);
>  			mpuio_init(bank);
> @@ -1060,8 +1025,8 @@ omap_mpuio_alloc_gc(struct gpio_bank *bank, unsigned int irq_start,
>  	ct->chip.irq_mask = irq_gc_mask_set_bit;
>  	ct->chip.irq_unmask = irq_gc_mask_clr_bit;
>  	ct->chip.irq_set_type = gpio_irq_type;
> -	/* REVISIT: assuming only 16xx supports MPUIO wake events */
> -	if (cpu_is_omap16xx())
> +
> +	if (bank->suspend_support)
>  		ct->chip.irq_set_wake = gpio_wake_enable,
>  
>  	ct->regs.mask = OMAP_MPUIO_GPIO_INT / bank->stride;
> @@ -1089,9 +1054,8 @@ static void __devinit omap_gpio_chip_init(struct gpio_bank *bank)
>  	bank->chip.to_irq = gpio_2irq;
>  	if (bank_is_mpuio(bank)) {
>  		bank->chip.label = "mpuio";
> -#ifdef CONFIG_ARCH_OMAP16XX
> -		bank->chip.dev = &omap_mpuio_device.dev;
> -#endif
> +		if (bank->suspend_support)
> +			bank->chip.dev = &omap_mpuio_device.dev;

ditto

>  		bank->chip.base = OMAP_MPUIO(0);
>  	} else {
>  		bank->chip.label = "gpio";
> @@ -1155,6 +1119,7 @@ static int __devinit omap_gpio_probe(struct platform_device *pdev)
>  	bank->dbck_flag = pdata->dbck_flag;
>  	bank->stride = pdata->bank_stride;
>  	bank->width = pdata->bank_width;
> +	bank->suspend_support = pdata->suspend_support;
>  	bank->non_wakeup_gpios = pdata->non_wakeup_gpios;
>  	bank->loses_context = pdata->loses_context;
>  	bank->regs = pdata->regs;
> @@ -1200,45 +1165,22 @@ err_exit:
>  	return ret;
>  }
>  
> -#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2PLUS)
>  static int omap_gpio_suspend(void)
>  {
>  	struct gpio_bank *bank;
>  
> -	if (!cpu_class_is_omap2() && !cpu_is_omap16xx())
> -		return 0;
> -
>  	list_for_each_entry(bank, &omap_gpio_list, node) {
>  		void __iomem *wake_status;
>  		void __iomem *wake_clear;
>  		void __iomem *wake_set;
>  		unsigned long flags;
>  
> -		switch (bank->method) {
> -#ifdef CONFIG_ARCH_OMAP16XX
> -		case METHOD_GPIO_1610:
> -			wake_status = bank->base + OMAP1610_GPIO_WAKEUPENABLE;
> -			wake_clear = bank->base + OMAP1610_GPIO_CLEAR_WAKEUPENA;
> -			wake_set = bank->base + OMAP1610_GPIO_SET_WAKEUPENA;
> -			break;
> -#endif
> -#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
> -		case METHOD_GPIO_24XX:
> -			wake_status = bank->base + OMAP24XX_GPIO_WAKE_EN;
> -			wake_clear = bank->base + OMAP24XX_GPIO_CLEARWKUENA;
> -			wake_set = bank->base + OMAP24XX_GPIO_SETWKUENA;
> -			break;
> -#endif
> -#ifdef CONFIG_ARCH_OMAP4
> -		case METHOD_GPIO_44XX:
> -			wake_status = bank->base + OMAP4_GPIO_IRQWAKEN0;
> -			wake_clear = bank->base + OMAP4_GPIO_IRQWAKEN0;
> -			wake_set = bank->base + OMAP4_GPIO_IRQWAKEN0;
> -			break;
> -#endif
> -		default:
> -			continue;
> -		}
> +		if (!bank->suspend_support)
> +			return 0;

Rather than check the flag here in every suspend, don't add a suspend
method in dev_pm_ops for banks that don't have the wkup_* registers.

> +		wake_status = bank->base + bank->regs->wkup_status;
> +		wake_clear = bank->base + bank->regs->wkup_clear;
> +		wake_set = bank->base + bank->regs->wkup_set;
>  
>  		spin_lock_irqsave(&bank->lock, flags);
>  		bank->saved_wakeup = __raw_readl(wake_status);
> @@ -1254,36 +1196,16 @@ static void omap_gpio_resume(void)
>  {
>  	struct gpio_bank *bank;
>  
> -	if (!cpu_class_is_omap2() && !cpu_is_omap16xx())
> -		return;
> -
>  	list_for_each_entry(bank, &omap_gpio_list, node) {
>  		void __iomem *wake_clear;
>  		void __iomem *wake_set;
>  		unsigned long flags;
>  
> -		switch (bank->method) {
> -#ifdef CONFIG_ARCH_OMAP16XX
> -		case METHOD_GPIO_1610:
> -			wake_clear = bank->base + OMAP1610_GPIO_CLEAR_WAKEUPENA;
> -			wake_set = bank->base + OMAP1610_GPIO_SET_WAKEUPENA;
> -			break;
> -#endif
> -#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
> -		case METHOD_GPIO_24XX:
> -			wake_clear = bank->base + OMAP24XX_GPIO_CLEARWKUENA;
> -			wake_set = bank->base + OMAP24XX_GPIO_SETWKUENA;
> -			break;
> -#endif
> -#ifdef CONFIG_ARCH_OMAP4
> -		case METHOD_GPIO_44XX:
> -			wake_clear = bank->base + OMAP4_GPIO_IRQWAKEN0;
> -			wake_set = bank->base + OMAP4_GPIO_IRQWAKEN0;
> -			break;
> -#endif
> -		default:
> -			continue;
> -		}
> +		if (!bank->suspend_support)
> +			return;

Same here.   Rather than check this flag every time, just don't add a
.resume method to dev_pm_ops for banks that don't have wkup_* registers.

> +		wake_clear = bank->base + bank->regs->wkup_clear;
> +		wake_set = bank->base + bank->regs->wkup_set;
>  
>  		spin_lock_irqsave(&bank->lock, flags);
>  		__raw_writel(0xffffffff, wake_clear);
> @@ -1297,8 +1219,6 @@ static struct syscore_ops omap_gpio_syscore_ops = {
>  	.resume		= omap_gpio_resume,
>  };
>  
> -#endif
> -
>  #ifdef CONFIG_ARCH_OMAP2PLUS
>  
>  static void omap_gpio_save_context(struct gpio_bank *bank);

Kevin
