From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 02/10] omap mailbox: add initial omap3 support
Date: Tue, 25 Nov 2008 13:54:14 -0800
Message-ID: <20081125215413.GS11997@atomide.com>
References: <1227605998-13531-1-git-send-email-Hiroshi.DOYU@nokia.com> <1227605998-13531-2-git-send-email-Hiroshi.DOYU@nokia.com> <1227605998-13531-3-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:51374 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752376AbYKYVyO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Nov 2008 16:54:14 -0500
Content-Disposition: inline
In-Reply-To: <1227605998-13531-3-git-send-email-Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap@vger.kernel.org

* Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [081125 01:40]:
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> ---
>  arch/arm/mach-omap2/devices.c              |   24 +++++++++++---
>  arch/arm/mach-omap2/mailbox.c              |   46 ++++++++++++++++++----------
>  arch/arm/plat-omap/Kconfig                 |    2 +-
>  arch/arm/plat-omap/include/mach/irqs.h     |    1 +
>  arch/arm/plat-omap/include/mach/omap34xx.h |    2 +-
>  5 files changed, 52 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index 241e418..d385f0f 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -84,13 +84,15 @@ static inline void omap_init_camera(void)
>  }
>  #endif
>  
> -#if defined(CONFIG_OMAP_DSP) || defined(CONFIG_OMAP_DSP_MODULE)
> -#define OMAP2_MBOX_BASE		IO_ADDRESS(OMAP24XX_MAILBOX_BASE)
> +#if defined(CONFIG_OMAP_MBOX_FWK) || defined(CONFIG_OMAP_MBOX_FWK_MODULE)
> +
> +#define MBOX_REG_SIZE	0x120
>  
>  static struct resource mbox_resources[] = {
> +#if defined(CONFIG_ARCH_OMAP2420)
>  	{
> -		.start		= OMAP2_MBOX_BASE,
> -		.end		= OMAP2_MBOX_BASE + 0x11f,
> +		.start		= OMAP24XX_MAILBOX_BASE,
> +		.end		= OMAP24XX_MAILBOX_BASE + MBOX_REG_SIZE - 1,
>  		.flags		= IORESOURCE_MEM,
>  	},
>  	{> @@ -101,6 +103,18 @@ static struct resource mbox_resources[] = {
>  		.start		= INT_24XX_MAIL_U3_MPU,
>  		.flags		= IORESOURCE_IRQ,
>  	},
> +/* FIXME: if multiple architecture support is necessary */
> +#elif  defined(CONFIG_ARCH_OMAP3)
> +	{
> +		.start		= OMAP34XX_MAILBOX_BASE,
> +		.end		= OMAP34XX_MAILBOX_BASE + MBOX_REG_SIZE - 1,
> +		.flags		= IORESOURCE_MEM,
> +	},
> +	{
> +		.start		= INT_34XX_MAIL_U0_MPU,
> +		.flags		= IORESOURCE_IRQ,
> +	},
> +#endif
>  };
>  
>  static struct platform_device mbox_device = {

How about setting up omap2_mbox_resources[] and omap3_mbox_resources[]
above instead? Then just select the right one to use during init.

We should not need to use ifdefs in any of the code for detecting the
omap cpu type, please use cpu_is_omap24xx() and cpu_is_omap34xx()
instead.

Regards,

Tony




> @@ -116,7 +130,7 @@ static inline void omap_init_mbox(void)
>  }
>  #else
>  static inline void omap_init_mbox(void) { }
> -#endif
> +#endif /* CONFIG_OMAP_MBOX_FWK */
>  
>  #if defined(CONFIG_OMAP_STI)
>  
> diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
> index 5ff2ed8..261cd79 100644
> --- a/arch/arm/mach-omap2/mailbox.c
> +++ b/arch/arm/mach-omap2/mailbox.c
> @@ -30,7 +30,7 @@
>  #define MAILBOX_IRQ_NEWMSG(u)		(1 << (2 * (u)))
>  #define MAILBOX_IRQ_NOTFULL(u)		(1 << (2 * (u) + 1))
>  
> -static unsigned long mbox_base;
> +static void __iomem *mbox_base;
>  
>  struct omap_mbox2_fifo {
>  	unsigned long msg;
> @@ -52,14 +52,14 @@ static struct clk *mbox_ick_handle;
>  static void omap2_mbox_enable_irq(struct omap_mbox *mbox,
>  				  omap_mbox_type_t irq);
>  
> -static inline unsigned int mbox_read_reg(unsigned int reg)
> +static inline unsigned int mbox_read_reg(size_t ofs)
>  {
> -	return __raw_readl((void __iomem *)(mbox_base + reg));
> +	return __raw_readl(mbox_base + ofs);
>  }
>  
> -static inline void mbox_write_reg(unsigned int val, unsigned int reg)
> +static inline void mbox_write_reg(u32 val, size_t ofs)
>  {
> -	__raw_writel(val, (void __iomem *)(mbox_base + reg));
> +	__raw_writel(val, mbox_base + ofs);
>  }
>  
>  /* Mailbox H/W preparations */
> @@ -208,7 +208,7 @@ struct omap_mbox mbox_dsp_info = {
>  };
>  EXPORT_SYMBOL(mbox_dsp_info);
>  
> -/* IVA */
> +#if defined(CONFIG_ARCH_OMAP2420) /* IVA */
>  static struct omap_mbox2_priv omap2_mbox_iva_priv = {
>  	.tx_fifo = {
>  		.msg		= MAILBOX_MESSAGE(2),
> @@ -229,52 +229,66 @@ static struct omap_mbox mbox_iva_info = {
>  	.ops	= &omap2_mbox_ops,
>  	.priv	= &omap2_mbox_iva_priv,
>  };
> +#endif
>  
>  static int __init omap2_mbox_probe(struct platform_device *pdev)
>  {
>  	struct resource *res;
>  	int ret = 0;
>  
> -	if (pdev->num_resources != 3) {
> -		dev_err(&pdev->dev, "invalid number of resources: %d\n",
> -			pdev->num_resources);
> -		return -ENODEV;
> -	}
> -
>  	/* MBOX base */
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	if (unlikely(!res)) {
>  		dev_err(&pdev->dev, "invalid mem resource\n");
>  		return -ENODEV;
>  	}
> -	mbox_base = res->start;
> +	mbox_base = ioremap(res->start, res->end - res->start);
> +	if (!mbox_base)
> +		return -ENOMEM;
>  
> -	/* DSP IRQ */
> +	/* DSP or IVA2 IRQ */
>  	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
>  	if (unlikely(!res)) {
>  		dev_err(&pdev->dev, "invalid irq resource\n");
> -		return -ENODEV;
> +		ret = -ENODEV;
> +		goto err_dsp;
>  	}
>  	mbox_dsp_info.irq = res->start;
>  
>  	ret = omap_mbox_register(&mbox_dsp_info);
> +	if (!ret)
> +		goto err_dsp;
>  
> +#if defined(CONFIG_ARCH_OMAP2420)
>  	/* IVA IRQ */
>  	res = platform_get_resource(pdev, IORESOURCE_IRQ, 1);
>  	if (unlikely(!res)) {
>  		dev_err(&pdev->dev, "invalid irq resource\n");
> -		return -ENODEV;
> +		ret = -ENODEV;
> +		goto err_iva1;
>  	}
>  	mbox_iva_info.irq = res->start;
>  
>  	ret = omap_mbox_register(&mbox_iva_info);
> +	if (!ret)
> +		goto err_iva1;
> +#endif
> +	return ret;
>  
> +err_iva1:
> +	omap_mbox_unregister(&mbox_dsp_info);
> +err_dsp:
> +	iounmap(mbox_base);
>  	return ret;
>  }
>  
>  static int omap2_mbox_remove(struct platform_device *pdev)
>  {
> +#if defined(CONFIG_ARCH_OMAP2420)
> +	omap_mbox_unregister(&mbox_iva_info);
> +#endif
>  	omap_mbox_unregister(&mbox_dsp_info);
> +	iounmap(mbox_base);
>  	return 0;
>  }
>  
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index 960c13f..2465aea 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -180,7 +180,7 @@ config OMAP_MBOX_FWK
>  	default n
>  	help
>  	  Say Y here if you want to use OMAP Mailbox framework support for
> -	  DSP and IVA1.0 in OMAP1/2.
> +	  DSP, IVA1.0 and IVA2 in OMAP1/2/3.
>  
>  choice
>          prompt "System timer"
> diff --git a/arch/arm/plat-omap/include/mach/irqs.h b/arch/arm/plat-omap/include/mach/irqs.h
> index d12c39f..74f58c6 100644
> --- a/arch/arm/plat-omap/include/mach/irqs.h
> +++ b/arch/arm/plat-omap/include/mach/irqs.h
> @@ -315,6 +315,7 @@
>  #define INT_34XX_MCBSP3_IRQ	22
>  #define INT_34XX_MCBSP4_IRQ	23
>  #define INT_34XX_CAM_IRQ	24
> +#define INT_34XX_MAIL_U0_MPU	26
>  #define INT_34XX_MCBSP5_IRQ	27
>  #define INT_34XX_GPIO_BANK1	29
>  #define INT_34XX_GPIO_BANK2	30
> diff --git a/arch/arm/plat-omap/include/mach/omap34xx.h b/arch/arm/plat-omap/include/mach/omap34xx.h
> index 0a137c1..afd0f6c 100644
> --- a/arch/arm/plat-omap/include/mach/omap34xx.h
> +++ b/arch/arm/plat-omap/include/mach/omap34xx.h
> @@ -63,8 +63,8 @@
>  #define OMAP2_CM_BASE			OMAP3430_CM_BASE
>  #define OMAP2_PRM_BASE			OMAP3430_PRM_BASE
>  #define OMAP2_VA_IC_BASE		IO_ADDRESS(OMAP34XX_IC_BASE)
> +#define OMAP34XX_MAILBOX_BASE		(L4_34XX_BASE + 0x94000)
>  #define OMAP34XX_CAMERA_BASE		(L4_34XX_BASE + 0xBC000)
> -
>  #endif
>  
>  #define OMAP34XX_DSP_BASE	0x58000000
> -- 
> 1.6.0.3.613.g9f8f13
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
