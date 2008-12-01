From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH v2 1/5] OMAP3: PM: HSMMC: force MMC module reset on boot
Date: Mon,  1 Dec 2008 08:22:42 -0800
Message-ID: <1228148566-9358-2-git-send-email-khilman@deeprootsystems.com>
References: <1228148566-9358-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.227]:21102 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106AbYLAQWv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Dec 2008 11:22:51 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2527683rvb.1
        for <linux-omap@vger.kernel.org>; Mon, 01 Dec 2008 08:22:51 -0800 (PST)
In-Reply-To: <1228148566-9358-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

The bootloader may leave the MMC in a state which prevents hitting
retention.  Even when MMC is not compiled in, each MMC module needs to
be forced into reset.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/devices.c |   85 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 85 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 241e418..423647e 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -14,6 +14,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/clk.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -358,6 +359,89 @@ static inline void omap_init_sha1_md5(void) { }
 
 /*-------------------------------------------------------------------------*/
 
+#ifdef CONFIG_ARCH_OMAP3
+
+#define MMCHS_SYSCONFIG			0x0010
+#define MMCHS_SYSCONFIG_SWRESET		(1 << 1)
+#define MMCHS_SYSSTATUS			0x0014
+#define MMCHS_SYSSTATUS_RESETDONE	(1 << 0)
+
+static struct platform_device dummy_pdev = {
+	.dev = {
+		.bus = &platform_bus_type,
+	},
+};
+
+/**
+ * omap_hsmmc_reset() - Full reset of each HS-MMC controller
+ *
+ * Ensure that each MMC controller is fully reset.  Controllers
+ * left in an unknown state (by bootloader) may prevent retention
+ * or OFF-mode.  This is especially important in cases where the
+ * MMC driver is not enabled, _or_ built as a module.
+ *
+ * In order for reset to work, interface, functional and debounce
+ * clocks must be enabled.  The debounce clock comes from func_32k_clk
+ * and is not under SW control, so we only enable i- and f-clocks.
+ **/
+static void __init omap_hsmmc_reset(void)
+{
+	u32 i, nr_controllers = cpu_is_omap34xx() ? OMAP34XX_NR_MMC :
+		OMAP24XX_NR_MMC;
+
+	for (i = 0; i < nr_controllers; i++) {
+		u32 v, base = 0;
+		struct clk *iclk, *fclk;
+		struct device *dev = &dummy_pdev.dev;
+
+		switch (i) {
+		case 0:
+			base = OMAP2_MMC1_BASE;
+			break;
+		case 1:
+			base = OMAP2_MMC2_BASE;
+			break;
+		case 2:
+			base = OMAP3_MMC3_BASE;
+			break;
+		}
+
+		dummy_pdev.id = i;
+		iclk = clk_get(dev, "mmchs_ick");
+		if (iclk && clk_enable(iclk))
+			iclk = NULL;
+
+		fclk = clk_get(dev, "mmchs_fck");
+		if (fclk && clk_enable(fclk))
+			fclk = NULL;
+
+		if (!iclk || !fclk) {
+			printk(KERN_WARNING
+			       "%s: Unable to enable clocks for MMC%d, "
+			       "cannot reset.\n",  __func__, i);
+			break;
+		}
+
+		omap_writel(MMCHS_SYSCONFIG_SWRESET, base + MMCHS_SYSCONFIG);
+		v = omap_readl(base + MMCHS_SYSSTATUS);
+		while (!(omap_readl(base + MMCHS_SYSSTATUS) &
+			 MMCHS_SYSSTATUS_RESETDONE))
+			cpu_relax();
+
+		if (fclk) {
+			clk_disable(fclk);
+			clk_put(fclk);
+		}
+		if (iclk) {
+			clk_disable(iclk);
+			clk_put(iclk);
+		}
+	}
+}
+#else
+static inline void omap_hsmmc_reset(void) {}
+#endif
+
 #if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE) || \
 	defined(CONFIG_MMC_OMAP_HS) || defined(CONFIG_MMC_OMAP_HS_MODULE)
 
@@ -477,6 +561,7 @@ static int __init omap2_init_devices(void)
 	/* please keep these calls, and their implementations above,
 	 * in alphabetical order so they're easier to sort through.
 	 */
+	omap_hsmmc_reset();
 	omap_init_camera();
 	omap_init_mbox();
 	omap_init_mcspi();
-- 
1.6.0.3

