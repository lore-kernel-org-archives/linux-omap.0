From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: Re: [PATCH PM-0 v2] ARM: OMAP3: HSMMC: Ensure HSMMC is fully reset on boot
Date: Fri, 19 Sep 2008 09:25:35 +0530
Message-ID: <023001c91a0b$936f09e0$LocalHost@wipultra1303>
References: <1221753282-18594-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42050 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756101AbYISDzs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 23:55:48 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>


----- Original Message ----- 
From: "Kevin Hilman" <khilman@deeprootsystems.com>
To: <linux-omap@vger.kernel.org>
Cc: "Kevin Hilman" <khilman@deeprootsystems.com>
Sent: Thursday, September 18, 2008 9:24 PM
Subject: [PATCH PM-0 v2] ARM: OMAP3: HSMMC: Ensure HSMMC is fully reset on boot


> This ensures that each HSMMC block is reset so it will not interfere
> with retention or OFF-mode.
> 
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
> ---
> arch/arm/mach-omap2/hsmmc.c |   73 ++++++++++++++++++++++++++++++++++++++++++-
> 1 files changed, 72 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
> index 7334d86..00fe354 100644
> --- a/arch/arm/mach-omap2/hsmmc.c
> +++ b/arch/arm/mach-omap2/hsmmc.c
> @@ -15,7 +15,9 @@
> #include <linux/platform_device.h>
> #include <linux/interrupt.h>
> #include <linux/delay.h>
> +#include <linux/clk.h>
> #include <linux/i2c/twl4030.h>
> +
> #include <mach/hardware.h>
> #include <mach/mmc.h>
> #include <mach/board.h>
> @@ -46,6 +48,74 @@
> #define OMAP2_CONTROL_PBIAS_PWRDNZ (1 << 1)
> #define OMAP2_CONTROL_PBIAS_SCTRL (1 << 2)
> 
> +#define MMCHS1 (L4_34XX_BASE + 0x9C000)
> +#define MMCHS2 (L4_34XX_BASE + 0xB4000)
> +#define MMCHS3 (L4_34XX_BASE + 0xAD000)
> +#define MAX_MMC 3
> +#define MMCHS_SYSCONFIG 0x0010
> +#define MMCHS_SYSCONFIG_SWRESET (1 << 1)
> +#define MMCHS_SYSSTATUS 0x0014
> +#define MMCHS_SYSSTATUS_RESETDONE (1 << 0)
> +
> +static struct platform_device dummy_pdev = {
> + .dev = {
> + .bus = &platform_bus_type,
> + },
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
> + u32 i, base[MAX_MMC] = {MMCHS1, MMCHS2, MMCHS3};
> +
> + for (i = 0; i < MAX_MMC; i++) {
> + u32 v;
> + struct clk *iclk, *fclk;
> + struct device *dev = &dummy_pdev.dev;
> +
> + dummy_pdev.id = i + 1;
> + iclk = clk_get(dev, "mmchs_ick");
> + if (iclk && clk_enable(iclk))
> + iclk = NULL;
> + 
> + fclk = clk_get(dev, "mmchs_fck");
> + if (fclk && clk_enable(fclk))
> + fclk = NULL;
> +
> + if (!iclk || !fclk) {
> + printk(KERN_WARNING 
> +        "%s: Unable to enable clocks for MMC%d, "
> +        "cannot reset.\n",  __func__, i);
> + break;
> + }
> +
> + omap_writel(MMCHS_SYSCONFIG_SWRESET, base[i] + MMCHS_SYSCONFIG);
> + v = omap_readl(base[i] + MMCHS_SYSSTATUS);
> + while (!(omap_readl(base[i] + MMCHS_SYSSTATUS) &
> + MMCHS_SYSSTATUS_RESETDONE))
> + cpu_relax();
> +
> + if (fclk) {
> + clk_disable(fclk);
> + clk_put(fclk);
> + }
> + if (iclk) {
> + clk_disable(iclk);
> + clk_put(iclk);
> + }
> + }
> +}
> +
> static int hsmmc_card_detect(int irq)
> {
>  return twl4030_get_gpio_datain(irq - TWL4030_GPIO_IRQ_BASE);
> @@ -282,6 +352,7 @@ static struct omap_mmc_platform_data hsmmc_data = {
> 
> void __init hsmmc_init(void)
> {
> + hsmmc_reset();
This might not be the right place to reset the controllers. You can avoid all the clk stuff if you do the reset in the driver probe function after the clocks are enabled.

BTW,
What is the issue you are facing if you dont reset the controllers? I have seen that on L-o that suspend/resume works with this driver enabled.

Regards,
Madhu

>  omap2_init_mmc(&hsmmc_data);
> }
> 
> @@ -289,7 +360,7 @@ void __init hsmmc_init(void)
> 
> void __init hsmmc_init(void)
> {
> -
> + hsmmc_reset();
> }
> 
> #endif
> -- 
> 1.6.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
>
