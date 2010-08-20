From: "kishore kadiyala" <kishore.kadiyala@ti.com>
Subject: [PATCH 07/10] [PM-WIP-MMC] OMAP MMC: Remove MMC controller reset
Date: Sat, 21 Aug 2010 01:41:03 +0530 (IST)
Message-ID: <16154.10.24.255.18.1282335063.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46766 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753097Ab0HTULI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Aug 2010 16:11:08 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, tony@atomide.com, b-cousson@ti.com

MMC controller Reset is handled in hwmod framework and thus
remove MMC controller reset which is done seperately.

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
---
 arch/arm/mach-omap2/devices.c |  104 +----------------------------------------
 1 files changed, 1 insertions(+), 103 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 5b0e171..77b979b 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/err.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/clk.h>
@@ -503,108 +504,6 @@ static inline void omap_init_sham(void) { }

 /*-------------------------------------------------------------------------*/

-#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
-
-#define MMCHS_SYSCONFIG			0x0010
-#define MMCHS_SYSCONFIG_SWRESET		(1 << 1)
-#define MMCHS_SYSSTATUS			0x0014
-#define MMCHS_SYSSTATUS_RESETDONE	(1 << 0)
-
-static struct platform_device dummy_pdev = {
-	.dev = {
-		.bus = &platform_bus_type,
-	},
-};
-
-/**
- * omap_hsmmc_reset() - Full reset of each HS-MMC controller
- *
- * Ensure that each MMC controller is fully reset.  Controllers
- * left in an unknown state (by bootloader) may prevent retention
- * or OFF-mode.  This is especially important in cases where the
- * MMC driver is not enabled, _or_ built as a module.
- *
- * In order for reset to work, interface, functional and debounce
- * clocks must be enabled.  The debounce clock comes from func_32k_clk
- * and is not under SW control, so we only enable i- and f-clocks.
- **/
-static void __init omap_hsmmc_reset(void)
-{
-	u32 i, nr_controllers;
-
-	if (cpu_is_omap242x())
-		return;
-
-	nr_controllers = cpu_is_omap44xx() ? OMAP44XX_NR_MMC :
-		(cpu_is_omap34xx() ? OMAP34XX_NR_MMC : OMAP24XX_NR_MMC);
-
-	for (i = 0; i < nr_controllers; i++) {
-		u32 v, base = 0;
-		struct clk *iclk, *fclk;
-		struct device *dev = &dummy_pdev.dev;
-
-		switch (i) {
-		case 0:
-			base = OMAP2_MMC1_BASE;
-			break;
-		case 1:
-			base = OMAP2_MMC2_BASE;
-			break;
-		case 2:
-			base = OMAP3_MMC3_BASE;
-			break;
-		case 3:
-			if (!cpu_is_omap44xx())
-				return;
-			base = OMAP4_MMC4_BASE;
-			break;
-		case 4:
-			if (!cpu_is_omap44xx())
-				return;
-			base = OMAP4_MMC5_BASE;
-			break;
-		}
-
-		if (cpu_is_omap44xx())
-			base += OMAP4_MMC_REG_OFFSET;
-
-		dummy_pdev.id = i;
-		dev_set_name(&dummy_pdev.dev, "mmci-omap-hs.%d", i);
-		iclk = clk_get(dev, "ick");
-		if (iclk && clk_enable(iclk))
-			iclk = NULL;
-
-		fclk = clk_get(dev, "fck");
-		if (fclk && clk_enable(fclk))
-			fclk = NULL;
-
-		if (!iclk || !fclk) {
-			printk(KERN_WARNING
-			       "%s: Unable to enable clocks for MMC%d, "
-			       "cannot reset.\n",  __func__, i);
-			break;
-		}
-
-		omap_writel(MMCHS_SYSCONFIG_SWRESET, base + MMCHS_SYSCONFIG);
-		v = omap_readl(base + MMCHS_SYSSTATUS);
-		while (!(omap_readl(base + MMCHS_SYSSTATUS) &
-			 MMCHS_SYSSTATUS_RESETDONE))
-			cpu_relax();
-
-		if (fclk) {
-			clk_disable(fclk);
-			clk_put(fclk);
-		}
-		if (iclk) {
-			clk_disable(iclk);
-			clk_put(iclk);
-		}
-	}
-}
-#else
-static inline void omap_hsmmc_reset(void) {}
-#endif
-
 #if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE) || \
 	defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)

@@ -852,7 +751,6 @@ static int __init omap2_init_devices(void)
 	/* please keep these calls, and their implementations above,
 	 * in alphabetical order so they're easier to sort through.
 	 */
-	omap_hsmmc_reset();
 	omap_init_camera();
 	omap_init_mbox();
 	omap_init_mcspi();
-- 
1.7.0.4


