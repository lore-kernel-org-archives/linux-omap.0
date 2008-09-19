From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH PM-0 v2] ARM: OMAP3: HSMMC: Ensure HSMMC is fully reset on boot
Date: Fri, 19 Sep 2008 14:33:44 +0300
Message-ID: <87hc8c1iav.fsf@deeprootsystems.com>
References: <1221753282-18594-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:24343 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752129AbYISLdt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Sep 2008 07:33:49 -0400
Received: by ey-out-2122.google.com with SMTP id 6so112976eyi.37
        for <linux-omap@vger.kernel.org>; Fri, 19 Sep 2008 04:33:48 -0700 (PDT)
In-Reply-To: <1221753282-18594-1-git-send-email-khilman@deeprootsystems.com> (Kevin Hilman's message of "Thu\, 18 Sep 2008 18\:54\:42 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Kevin Hilman <khilman@deeprootsystems.com> writes:

> This ensures that each HSMMC block is reset so it will not interfere
> with retention or OFF-mode.
>

Sigh... I still didn't get this right for all the cases of MMC
built-in, module or disabled.  Stay tuned for v3.

Kevin

> ---
>  arch/arm/mach-omap2/hsmmc.c |   73 ++++++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 72 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
> index 7334d86..00fe354 100644
> --- a/arch/arm/mach-omap2/hsmmc.c
> +++ b/arch/arm/mach-omap2/hsmmc.c
> @@ -15,7 +15,9 @@
>  #include <linux/platform_device.h>
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
> +#include <linux/clk.h>
>  #include <linux/i2c/twl4030.h>
> +
>  #include <mach/hardware.h>
>  #include <mach/mmc.h>
>  #include <mach/board.h>
> @@ -46,6 +48,74 @@
>  #define OMAP2_CONTROL_PBIAS_PWRDNZ	(1 << 1)
>  #define OMAP2_CONTROL_PBIAS_SCTRL	(1 << 2)
>  
> +#define MMCHS1				(L4_34XX_BASE + 0x9C000)
> +#define MMCHS2				(L4_34XX_BASE + 0xB4000)
> +#define MMCHS3				(L4_34XX_BASE + 0xAD000)
> +#define MAX_MMC				3
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
> + * hsmmc_reset() - Full reset of each HS-MMC controller
> + *
> + * Ensure that each MMC controller is fully reset.  Controllers
> + * left in an unknown state (by bootloaer) may prevent retention
> + * or OFF-mode.
> + *
> + * In order for reset to work, interface, functional and debounce
> + * clocks must be enabled.  The debounce clock comes from func_32k_clk
> + * and is not under SW controle, so we only enable i- and f-clocks.
> + **/
> +static void __init hsmmc_reset(void)
> +{
> +	u32 i, base[MAX_MMC] = {MMCHS1, MMCHS2, MMCHS3};
> +
> +	for (i = 0; i < MAX_MMC; i++) {
> +		u32 v;
> +		struct clk *iclk, *fclk;
> +		struct device *dev = &dummy_pdev.dev;
> +
> +		dummy_pdev.id = i + 1;
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
> +
>  static int hsmmc_card_detect(int irq)
>  {
>  	return twl4030_get_gpio_datain(irq - TWL4030_GPIO_IRQ_BASE);
> @@ -282,6 +352,7 @@ static struct omap_mmc_platform_data hsmmc_data = {
>  
>  void __init hsmmc_init(void)
>  {
> +	hsmmc_reset();
>  	omap2_init_mmc(&hsmmc_data);
>  }
>  
> @@ -289,7 +360,7 @@ void __init hsmmc_init(void)
>  
>  void __init hsmmc_init(void)
>  {
> -
> +	hsmmc_reset();
>  }
>  
>  #endif
> -- 
> 1.6.0
