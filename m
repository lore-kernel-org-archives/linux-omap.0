From: Tony Lindgren <tony@atomide.com>
Subject: Re: Remaining kautobuild errors with mainline
Date: Tue, 9 Sep 2008 08:22:54 -0700
Message-ID: <20080909152251.GM29054@atomide.com>
References: <20080909075929.GC9104@flint.arm.linux.org.uk> <20080909093329.GE9104@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62807 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753478AbYIIPXE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Sep 2008 11:23:04 -0400
Content-Disposition: inline
In-Reply-To: <20080909093329.GE9104@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [080909 02:34]:
> On Tue, Sep 09, 2008 at 08:59:29AM +0100, Russell King - ARM Linux wrote:
> > As of last nights merge of the ARM tree, the only remaining build error
> > is:
> > 
> > arch/arm/mach-omap1/built-in.o: In function `sx1_mmc_init':
> > board-sx1-mmc.c:(.init.text+0xd64): undefined reference to `omap_set_mmc_info'
> > arch/arm/mach-omap1/built-in.o: In function `h2_mmc_init':
> > arch/arm/mach-omap1/board-h2-mmc.c:98: undefined reference to `omap_set_mmc_info'
> > 
> > This seems to be because of arch/arm/plat-omap/devices.c not being up to
> > date; it seems to pass a struct omap_mmc_conf to the OMAP MMC driver,
> > but the MMC driver expects a struct omap_mmc_platform_data instead.
> > 
> > Can I lift just the MMC changes for arch/arm/plat-omap/devices.c from
> > the OMAP tree to fix this, or is there something more required for this?

Sure, go for it!

> I couldn't pull the commits from the omapzoom tree because there seem to
> be differences between mainline and omapzoom which aren't identifyable in
> the omapzoom history.

Yeah some patches just do not apply directly because of layers of fixes,
so redoing and splitting is needed.

> So... what I have is:
> 
> From c37e0062150668dd260a6ce0664697f0fbcf2239 Mon Sep 17 00:00:00 2001
> From: Russell King <rmk@dyn-67.arm.linux.org.uk>
> Date: Tue, 9 Sep 2008 10:16:22 +0100
> Subject: [PATCH] [ARM] OMAP: Fix MMC device data
> 
> OMAPs MMC device data was passing the wrong structure via the platform
> device.  Moreover, a missing function means that both sx1_defconfig
> and omap_h2_1610_defconfig builds failed with
> 
> 	undefined reference to `omap_set_mmc_info'
> 
> errors.  Fix this by updating the MMC support from the omapzoom tree.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/plat-omap/devices.c |   88 +++++++++++++++++++++++++++++++++++-------
>  1 files changed, 74 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
> index 187e3d8..370c2cf 100644
> --- a/arch/arm/plat-omap/devices.c
> +++ b/arch/arm/plat-omap/devices.c
> @@ -21,6 +21,7 @@
>  
>  #include <mach/tc.h>
>  #include <mach/board.h>
> +#include <mach/mmc.h>
>  #include <mach/mux.h>
>  #include <mach/gpio.h>
>  #include <mach/menelaus.h>
> @@ -194,25 +195,38 @@ void omap_mcbsp_register_board_cfg(struct omap_mcbsp_platform_data *config,
>  
>  /*-------------------------------------------------------------------------*/
>  
> -#if	defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
> +#if	defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE) || \
> +	defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
>  
> -#ifdef CONFIG_ARCH_OMAP24XX
> +#if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
>  #define	OMAP_MMC1_BASE		0x4809c000
> -#define OMAP_MMC1_INT		INT_24XX_MMC_IRQ
> +#define	OMAP_MMC1_END		(OMAP_MMC1_BASE + 0x1fc)
> +#define	OMAP_MMC1_INT		INT_24XX_MMC_IRQ
> +
> +#define	OMAP_MMC2_BASE		0x480b4000
> +#define	OMAP_MMC2_END		(OMAP_MMC2_BASE + 0x1fc)
> +#define	OMAP_MMC2_INT		INT_24XX_MMC2_IRQ
> +
>  #else
> +
>  #define	OMAP_MMC1_BASE		0xfffb7800
> +#define	OMAP_MMC1_END		(OMAP_MMC1_BASE + 0x7f)
>  #define OMAP_MMC1_INT		INT_MMC
> -#endif
> +
>  #define	OMAP_MMC2_BASE		0xfffb7c00	/* omap16xx only */
> +#define	OMAP_MMC2_END		(OMAP_MMC2_BASE + 0x7f)
> +#define	OMAP_MMC2_INT		INT_1610_MMC2
>  
> -static struct omap_mmc_conf mmc1_conf;
> +#endif
> +
> +static struct omap_mmc_platform_data mmc1_data;
>  
>  static u64 mmc1_dmamask = 0xffffffff;
>  
>  static struct resource mmc1_resources[] = {
>  	{
>  		.start		= OMAP_MMC1_BASE,
> -		.end		= OMAP_MMC1_BASE + 0x7f,
> +		.end		= OMAP_MMC1_END,
>  		.flags		= IORESOURCE_MEM,
>  	},
>  	{
> @@ -226,26 +240,27 @@ static struct platform_device mmc_omap_device1 = {
>  	.id		= 1,
>  	.dev = {
>  		.dma_mask	= &mmc1_dmamask,
> -		.platform_data	= &mmc1_conf,
> +		.platform_data	= &mmc1_data,
>  	},
>  	.num_resources	= ARRAY_SIZE(mmc1_resources),
>  	.resource	= mmc1_resources,
>  };
>  
> -#ifdef	CONFIG_ARCH_OMAP16XX
> +#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2430) || \
> +	defined(CONFIG_ARCH_OMAP34XX)
>  
> -static struct omap_mmc_conf mmc2_conf;
> +static struct omap_mmc_platform_data mmc2_data;
>  
>  static u64 mmc2_dmamask = 0xffffffff;
>  
>  static struct resource mmc2_resources[] = {
>  	{
>  		.start		= OMAP_MMC2_BASE,
> -		.end		= OMAP_MMC2_BASE + 0x7f,
> +		.end		= OMAP_MMC2_END,
>  		.flags		= IORESOURCE_MEM,
>  	},
>  	{
> -		.start		= INT_1610_MMC2,
> +		.start		= OMAP_MMC2_INT,
>  		.flags		= IORESOURCE_IRQ,
>  	},
>  };
> @@ -255,7 +270,7 @@ static struct platform_device mmc_omap_device2 = {
>  	.id		= 2,
>  	.dev = {
>  		.dma_mask	= &mmc2_dmamask,
> -		.platform_data	= &mmc2_conf,
> +		.platform_data	= &mmc2_data,
>  	},
>  	.num_resources	= ARRAY_SIZE(mmc2_resources),
>  	.resource	= mmc2_resources,
> @@ -274,6 +289,19 @@ static void __init omap_init_mmc(void)
>  
>  	/* block 1 is always available and has just one pinout option */
>  	mmc = &mmc_conf->mmc[0];
> +
> +	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
> +		if (mmc->enabled)
> +			(void) platform_device_register(&mmc_omap_device1);
> +
> +#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
> +		mmc = &mmc_conf->mmc[1];
> +		if (mmc->enabled)
> +			(void) platform_device_register(&mmc_omap_device2);
> +#endif
> +		return;
> +	}
> +
>  	if (mmc->enabled) {
>  		if (cpu_is_omap24xx()) {
>  			omap_cfg_reg(H18_24XX_MMC_CMD);
> @@ -308,7 +336,20 @@ static void __init omap_init_mmc(void)
>  				omap_cfg_reg(MMC_DAT3);
>  			}
>  		}
> -		mmc1_conf = *mmc;
> +#if defined(CONFIG_ARCH_OMAP2420)
> +		if (mmc->internal_clock) {
> +			/*
> +			 * Use internal loop-back in MMC/SDIO
> +			 * Module Input Clock selection
> +			 */
> +			if (cpu_is_omap24xx()) {
> +				u32 v = omap_ctrl_readl(OMAP2_CONTROL_DEVCONF0);
> +				v |= (1 << 24); /* not used in 243x */
> +				omap_ctrl_writel(v, OMAP2_CONTROL_DEVCONF0);
> +			}
> +		}
> +#endif
> +		mmc1_data.conf = *mmc;
>  		(void) platform_device_register(&mmc_omap_device1);
>  	}
>  
> @@ -337,14 +378,33 @@ static void __init omap_init_mmc(void)
>  		if (cpu_is_omap1710())
>  			omap_writel(omap_readl(MOD_CONF_CTRL_1) | (1 << 24),
>  				     MOD_CONF_CTRL_1);
> -		mmc2_conf = *mmc;
> +		mmc2_data.conf = *mmc;
>  		(void) platform_device_register(&mmc_omap_device2);
>  	}
>  #endif
>  	return;
>  }
> +
> +void omap_set_mmc_info(int host, const struct omap_mmc_platform_data *info)
> +{
> +	switch (host) {
> +	case 1:
> +		mmc1_data = *info;
> +		break;
> +#if defined(CONFIG_ARCH_OMAP16XX) || defined(CONFIG_ARCH_OMAP2430) || \
> +	defined(CONFIG_ARCH_OMAP34XX)
> +	case 2:
> +		mmc2_data = *info;
> +		break;
> +#endif
> +	default:
> +		BUG();
> +	}
> +}
> +
>  #else
>  static inline void omap_init_mmc(void) {}
> +void omap_set_mmc_info(int host, const struct omap_mmc_platform_data *info) {}
>  #endif
>  
>  /*-------------------------------------------------------------------------*/
> -- 
> 1.5.4.5
> 
