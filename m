From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 03/12] GPIO context save/restore
Date: Thu, 04 Sep 2008 11:58:00 +0300
Message-ID: <87tzcw1e5j.fsf@deeprootsystems.com>
References: <59641.192.168.10.89.1220276278.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qb-out-0506.google.com ([72.14.204.230]:16882 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756988AbYIDI6I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Sep 2008 04:58:08 -0400
Received: by qb-out-0506.google.com with SMTP id f11so5001869qba.17
        for <linux-omap@vger.kernel.org>; Thu, 04 Sep 2008 01:58:06 -0700 (PDT)
In-Reply-To: <59641.192.168.10.89.1220276278.squirrel@dbdmail.itg.ti.com> (Rajendra Nayak's message of "Mon\, 1 Sep 2008 19\:07\:58 +0530 \(IST\)")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

"Rajendra Nayak" <rnayak@ti.com> writes:

> This patch adds the context save restore functions for GPIO
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/plat-omap/gpio.c              |   77 +++++++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/mach/gpio.h |   19 +++++++-
>  2 files changed, 95 insertions(+), 1 deletion(-)
>
> Index: linux-omap-2.6/arch/arm/plat-omap/gpio.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/plat-omap/gpio.c	2008-09-01 18:11:28.000000000
> +0530
> +++ linux-omap-2.6/arch/arm/plat-omap/gpio.c	2008-09-01 18:11:51.000000000 +0530
> @@ -102,6 +102,7 @@
>  #define OMAP24XX_GPIO_IRQSTATUS2	0x0028
>  #define OMAP24XX_GPIO_IRQENABLE2	0x002c
>  #define OMAP24XX_GPIO_IRQENABLE1	0x001c
> +#define OMAP24XX_GPIO_WAKE_EN		0x0020
>  #define OMAP24XX_GPIO_CTRL		0x0030
>  #define OMAP24XX_GPIO_OE		0x0034
>  #define OMAP24XX_GPIO_DATAIN		0x0038
> @@ -1708,6 +1709,82 @@ void omap2_gpio_resume_after_retention(v
>
>  #endif
>
> +#ifdef CONFIG_ARCH_OMAP34XX
> +static struct omap3_gpio_regs gpio_restore_banks[6];

Maybe we should have some consistency in naming the structures 
which are used for context save/restore.

Here it's called 'restore bank', in other places 'ctx' etc.
Personally, I think context is more appropriate.

> +/* save the registers of bank 2-6 */
> +void omap3_gpio_save(void)
> +{
> +	int i;
> +	/* saving banks from 2-6 only */
> +	for (i = 1; i < gpio_bank_count; i++) {
> +		struct gpio_bank *bank = &gpio_bank[i];
> +		gpio_restore_banks[i].gpio_sysconfig =
> +			__raw_readl(bank->base + OMAP24XX_GPIO_SYSCONFIG);
> +		gpio_restore_banks[i].gpio_irqenable1 =
> +			__raw_readl(bank->base + OMAP24XX_GPIO_IRQENABLE1);
> +		gpio_restore_banks[i].gpio_irqenable2 =
> +			__raw_readl(bank->base + OMAP24XX_GPIO_IRQENABLE2);
> +		gpio_restore_banks[i].gpio_wake_en =
> +			__raw_readl(bank->base + OMAP24XX_GPIO_WAKE_EN);
> +		gpio_restore_banks[i].gpio_ctrl =
> +			__raw_readl(bank->base + OMAP24XX_GPIO_CTRL);
> +		gpio_restore_banks[i].gpio_oe =
> +			__raw_readl(bank->base + OMAP24XX_GPIO_OE);
> +		gpio_restore_banks[i].gpio_leveldetect0 =
> +			__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT0);
> +		gpio_restore_banks[i].gpio_leveldetect1 =
> +			__raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT1);
> +		gpio_restore_banks[i].gpio_risingdetect =
> +			__raw_readl(bank->base + OMAP24XX_GPIO_RISINGDETECT);
> +		gpio_restore_banks[i].gpio_fallingdetect =
> +			__raw_readl(bank->base + OMAP24XX_GPIO_FALLINGDETECT);
> +		gpio_restore_banks[i].gpio_dataout =
> +			__raw_readl(bank->base + OMAP24XX_GPIO_DATAOUT);
> +		gpio_restore_banks[i].gpio_setwkuena =
> +			__raw_readl(bank->base + OMAP24XX_GPIO_SETWKUENA);
> +		gpio_restore_banks[i].gpio_setdataout =
> +			__raw_readl(bank->base + OMAP24XX_GPIO_SETDATAOUT);
> +	}
> +}
> +EXPORT_SYMBOL(omap3_gpio_save);
> +
> +/* restore the required registers of bank 2-6 */
> +void omap3_gpio_restore(void)
> +{
> +	int i;
> +	for (i = 1; i < gpio_bank_count; i++) {
> +		struct gpio_bank *bank = &gpio_bank[i];
> +		__raw_writel(gpio_restore_banks[i].gpio_sysconfig,
> +				bank->base + OMAP24XX_GPIO_SYSCONFIG);
> +		__raw_writel(gpio_restore_banks[i].gpio_irqenable1,
> +				bank->base + OMAP24XX_GPIO_IRQENABLE1);
> +		__raw_writel(gpio_restore_banks[i].gpio_irqenable2,
> +				bank->base + OMAP24XX_GPIO_IRQENABLE2);
> +		__raw_writel(gpio_restore_banks[i].gpio_wake_en,
> +				bank->base + OMAP24XX_GPIO_WAKE_EN);
> +		__raw_writel(gpio_restore_banks[i].gpio_ctrl,
> +				bank->base + OMAP24XX_GPIO_CTRL);
> +		__raw_writel(gpio_restore_banks[i].gpio_oe,
> +				bank->base + OMAP24XX_GPIO_OE);
> +		__raw_writel(gpio_restore_banks[i].gpio_leveldetect0,
> +				bank->base + OMAP24XX_GPIO_LEVELDETECT0);
> +		__raw_writel(gpio_restore_banks[i].gpio_leveldetect1,
> +				bank->base + OMAP24XX_GPIO_LEVELDETECT1);
> +		__raw_writel(gpio_restore_banks[i].gpio_risingdetect,
> +				bank->base + OMAP24XX_GPIO_RISINGDETECT);
> +		__raw_writel(gpio_restore_banks[i].gpio_fallingdetect,
> +				bank->base + OMAP24XX_GPIO_FALLINGDETECT);
> +		__raw_writel(gpio_restore_banks[i].gpio_dataout,
> +				bank->base + OMAP24XX_GPIO_DATAOUT);
> +		__raw_writel(gpio_restore_banks[i].gpio_setwkuena,
> +				bank->base + OMAP24XX_GPIO_SETWKUENA);
> +		__raw_writel(gpio_restore_banks[i].gpio_setdataout,
> +				bank->base + OMAP24XX_GPIO_SETDATAOUT);
> +	}
> +}
> +EXPORT_SYMBOL(omap3_gpio_restore);
> +#endif
> +
>  /*
>   * This may get called early from board specific init
>   * for boards that have interrupts routed via FPGA.
> Index: linux-omap-2.6/arch/arm/plat-omap/include/mach/gpio.h
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/plat-omap/include/mach/gpio.h	2008-09-01
> 18:11:28.000000000 +0530
> +++ linux-omap-2.6/arch/arm/plat-omap/include/mach/gpio.h	2008-09-01
> 18:11:51.000000000 +0530
> @@ -70,6 +70,22 @@
>  				 IH_MPUIO_BASE + ((nr) & 0x0f) : \
>  				 IH_GPIO_BASE + (nr))
>
> +struct omap3_gpio_regs {
> +	u32 gpio_sysconfig;
> +	u32 gpio_irqenable1;
> +	u32 gpio_irqenable2;
> +	u32 gpio_wake_en;
> +	u32 gpio_ctrl;
> +	u32 gpio_oe;
> +	u32 gpio_leveldetect0;
> +	u32 gpio_leveldetect1;
> +	u32 gpio_risingdetect;
> +	u32 gpio_fallingdetect;
> +	u32 gpio_dataout;
> +	u32 gpio_setwkuena;
> +	u32 gpio_setdataout;
> +};
> +

Just a minor detail, but do we need the gpio_ prefix on all these names?
Since they are part of a struct named gpio_restore_banks, it leads to
lots of redundant 'gpio' names in the code.

>  extern int omap_gpio_init(void);	/* Call from board init only */
>  extern int omap_request_gpio(int gpio);
>  extern void omap_free_gpio(int gpio);
> @@ -80,7 +96,8 @@ extern void omap2_gpio_prepare_for_reten
>  extern void omap2_gpio_resume_after_retention(void);
>  extern void omap_set_gpio_debounce(int gpio, int enable);
>  extern void omap_set_gpio_debounce_time(int gpio, int enable);
> -
> +extern void omap3_gpio_save(void);
> +extern void omap3_gpio_restore(void);
>  /*-------------------------------------------------------------------------*/
>
>  /* Wrappers for "new style" GPIO calls, using the new infrastructure
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
