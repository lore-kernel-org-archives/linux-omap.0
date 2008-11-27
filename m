From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/5] OMAP3: PM: HSMMC: force MMC module reset on boot
Date: Wed, 26 Nov 2008 16:25:34 -0800
Message-ID: <20081127002533.GA6640@atomide.com>
References: <1227744349-12118-1-git-send-email-khilman@deeprootsystems.com> <1227744349-12118-2-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61271 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269AbYK0AZe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2008 19:25:34 -0500
Content-Disposition: inline
In-Reply-To: <1227744349-12118-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@deeprootsystems.com> [081126 16:07]:
> The bootloader may leave the MMC in a state which prevents hitting
> retention.  Even when MMC is not compiled in, each MMC module needs to
> be forced into reset.
> 
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
>  arch/arm/mach-omap2/devices.c |   76 +++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 76 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index 241e418..196de4e 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -14,6 +14,7 @@
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
> +#include <linux/clk.h>
>  
>  #include <mach/hardware.h>
>  #include <asm/mach-types.h>
> @@ -358,6 +359,80 @@ static inline void omap_init_sha1_md5(void) { }
>  
>  /*-------------------------------------------------------------------------*/
>  
> +#ifdef CONFIG_ARCH_OMAP3
> +
> +#define MMCHS1				(L4_34XX_BASE + 0x9C000)
> +#define MMCHS2				(L4_34XX_BASE + 0xB4000)
> +#define MMCHS3				(L4_34XX_BASE + 0xAD000)

These are already in plat-omap/include/mach/mmc.h, how about just
include it? Then you can have a switch statement like we already have
for omap2_init_mmc?

> +#define MAX_MMC				3

This too

> +#define MMCHS_SYSCONFIG			0x0010
> +#define MMCHS_SYSCONFIG_SWRESET		(1 << 1)
> +#define MMCHS_SYSSTATUS			0x0014
> +#define MMCHS_SYSSTATUS_RESETDONE	(1 << 0)
> +
> +static struct platform_device dummy_pdev = {
> +	.dev = {
> +		.bus = &platform_bus_type,
> +	},
> +};
> +
> +/**
> + * omap_hsmmc_reset() - Full reset of each HS-MMC controller
> + *
> + * Ensure that each MMC controller is fully reset.  Controllers
> + * left in an unknown state (by bootloaer) may prevent retention
> + * or OFF-mode.  This is especially important in cases where the
> + * MMC driver is not enabled, _or_ built as a module.

Should say bootloader above :)

Regards,

Tony


> + * In order for reset to work, interface, functional and debounce
> + * clocks must be enabled.  The debounce clock comes from func_32k_clk
> + * and is not under SW control, so we only enable i- and f-clocks.
> + **/
> +static void __init omap_hsmmc_reset(void)
> +{
> +	u32 i, base[MAX_MMC] = {MMCHS1, MMCHS2, MMCHS3};
> +
> +	for (i = 0; i < MAX_MMC; i++) {
> +		u32 v;
> +		struct clk *iclk, *fclk;
> +		struct device *dev = &dummy_pdev.dev;
> +
> +		dummy_pdev.id = i;
> +		iclk = clk_get(dev, "mmchs_ick");
> +		if (iclk && clk_enable(iclk))
> +			iclk = NULL;
> +
> +		fclk = clk_get(dev, "mmchs_fck");
> +		if (fclk && clk_enable(fclk))
> +			fclk = NULL;
> +
> +		if (!iclk || !fclk) {
> +			printk(KERN_WARNING
> +			       "%s: Unable to enable clocks for MMC%d, "
> +			       "cannot reset.\n",  __func__, i);
> +			break;
> +		}
> +
> +		omap_writel(MMCHS_SYSCONFIG_SWRESET, base[i] + MMCHS_SYSCONFIG);
> +		v = omap_readl(base[i] + MMCHS_SYSSTATUS);
> +		while (!(omap_readl(base[i] + MMCHS_SYSSTATUS) &
> +			 MMCHS_SYSSTATUS_RESETDONE))
> +			cpu_relax();
> +
> +		if (fclk) {
> +			clk_disable(fclk);
> +			clk_put(fclk);
> +		}
> +		if (iclk) {
> +			clk_disable(iclk);
> +			clk_put(iclk);
> +		}
> +	}
> +}
> +#else
> +static inline void omap_hsmmc_reset(void) {}
> +#endif
> +
>  #if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE) || \
>  	defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
>  
> @@ -477,6 +552,7 @@ static int __init omap2_init_devices(void)
>  	/* please keep these calls, and their implementations above,
>  	 * in alphabetical order so they're easier to sort through.
>  	 */
> +	omap_hsmmc_reset();
>  	omap_init_camera();
>  	omap_init_mbox();
>  	omap_init_mcspi();
> -- 
> 1.6.0.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
