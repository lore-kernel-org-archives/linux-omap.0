From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH PM-0 v2] ARM: OMAP3: HSMMC: Ensure HSMMC is fully reset on boot
Date: Thu, 18 Sep 2008 18:54:42 +0300
Message-ID: <1221753282-18594-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:20282 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753534AbYIRPyu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 11:54:50 -0400
Received: by fg-out-1718.google.com with SMTP id 19so259239fgg.17
        for <linux-omap@vger.kernel.org>; Thu, 18 Sep 2008 08:54:48 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

This ensures that each HSMMC block is reset so it will not interfere
with retention or OFF-mode.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/hsmmc.c |   73 ++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 72 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
index 7334d86..00fe354 100644
--- a/arch/arm/mach-omap2/hsmmc.c
+++ b/arch/arm/mach-omap2/hsmmc.c
@@ -15,7 +15,9 @@
 #include <linux/platform_device.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
+#include <linux/clk.h>
 #include <linux/i2c/twl4030.h>
+
 #include <mach/hardware.h>
 #include <mach/mmc.h>
 #include <mach/board.h>
@@ -46,6 +48,74 @@
 #define OMAP2_CONTROL_PBIAS_PWRDNZ	(1 << 1)
 #define OMAP2_CONTROL_PBIAS_SCTRL	(1 << 2)
 
+#define MMCHS1				(L4_34XX_BASE + 0x9C000)
+#define MMCHS2				(L4_34XX_BASE + 0xB4000)
+#define MMCHS3				(L4_34XX_BASE + 0xAD000)
+#define MAX_MMC				3
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
+ * hsmmc_reset() - Full reset of each HS-MMC controller
+ *
+ * Ensure that each MMC controller is fully reset.  Controllers
+ * left in an unknown state (by bootloaer) may prevent retention
+ * or OFF-mode.
+ *
+ * In order for reset to work, interface, functional and debounce
+ * clocks must be enabled.  The debounce clock comes from func_32k_clk
+ * and is not under SW controle, so we only enable i- and f-clocks.
+ **/
+static void __init hsmmc_reset(void)
+{
+	u32 i, base[MAX_MMC] = {MMCHS1, MMCHS2, MMCHS3};
+
+	for (i = 0; i < MAX_MMC; i++) {
+		u32 v;
+		struct clk *iclk, *fclk;
+		struct device *dev = &dummy_pdev.dev;
+
+		dummy_pdev.id = i + 1;
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
+		omap_writel(MMCHS_SYSCONFIG_SWRESET, base[i] + MMCHS_SYSCONFIG);
+		v = omap_readl(base[i] + MMCHS_SYSSTATUS);
+		while (!(omap_readl(base[i] + MMCHS_SYSSTATUS) &
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
+
 static int hsmmc_card_detect(int irq)
 {
 	return twl4030_get_gpio_datain(irq - TWL4030_GPIO_IRQ_BASE);
@@ -282,6 +352,7 @@ static struct omap_mmc_platform_data hsmmc_data = {
 
 void __init hsmmc_init(void)
 {
+	hsmmc_reset();
 	omap2_init_mmc(&hsmmc_data);
 }
 
@@ -289,7 +360,7 @@ void __init hsmmc_init(void)
 
 void __init hsmmc_init(void)
 {
-
+	hsmmc_reset();
 }
 
 #endif
-- 
1.6.0

