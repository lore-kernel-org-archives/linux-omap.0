From: Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: [PATCH] arm: mach-omap2: hsmmc_reset: fix clk_get() error handling
Date: Wed, 15 Dec 2010 14:45:33 +0200
Message-ID: <1292417133-18025-1-git-send-email-aaro.koskinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:50202 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752722Ab0LOMo6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Dec 2010 07:44:58 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>

clk_get() return value should be checked with IS_ERR(). Furthermore,
clocks should be put and disabled properly.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap2/devices.c |   44 ++++++++++++++++++++++------------------
 1 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 5a0c148..1bca147 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -638,6 +638,7 @@ static struct platform_device dummy_pdev = {
 static void __init omap_hsmmc_reset(void)
 {
 	u32 i, nr_controllers;
+	struct clk *iclk, *fclk;
 
 	if (cpu_is_omap242x())
 		return;
@@ -647,7 +648,6 @@ static void __init omap_hsmmc_reset(void)
 
 	for (i = 0; i < nr_controllers; i++) {
 		u32 v, base = 0;
-		struct clk *iclk, *fclk;
 		struct device *dev = &dummy_pdev.dev;
 
 		switch (i) {
@@ -678,19 +678,16 @@ static void __init omap_hsmmc_reset(void)
 		dummy_pdev.id = i;
 		dev_set_name(&dummy_pdev.dev, "mmci-omap-hs.%d", i);
 		iclk = clk_get(dev, "ick");
-		if (iclk && clk_enable(iclk))
-			iclk = NULL;
+		if (IS_ERR(iclk))
+			goto err1;
+		if (clk_enable(iclk))
+			goto err2;
 
 		fclk = clk_get(dev, "fck");
-		if (fclk && clk_enable(fclk))
-			fclk = NULL;
-
-		if (!iclk || !fclk) {
-			printk(KERN_WARNING
-			       "%s: Unable to enable clocks for MMC%d, "
-			       "cannot reset.\n",  __func__, i);
-			break;
-		}
+		if (IS_ERR(fclk))
+			goto err3;
+		if (clk_enable(fclk))
+			goto err4;
 
 		omap_writel(MMCHS_SYSCONFIG_SWRESET, base + MMCHS_SYSCONFIG);
 		v = omap_readl(base + MMCHS_SYSSTATUS);
@@ -698,15 +695,22 @@ static void __init omap_hsmmc_reset(void)
 			 MMCHS_SYSSTATUS_RESETDONE))
 			cpu_relax();
 
-		if (fclk) {
-			clk_disable(fclk);
-			clk_put(fclk);
-		}
-		if (iclk) {
-			clk_disable(iclk);
-			clk_put(iclk);
-		}
+		clk_disable(fclk);
+		clk_put(fclk);
+		clk_disable(iclk);
+		clk_put(iclk);
 	}
+	return;
+
+err4:
+	clk_put(fclk);
+err3:
+	clk_disable(iclk);
+err2:
+	clk_put(iclk);
+err1:
+	printk(KERN_WARNING "%s: Unable to enable clocks for MMC%d, "
+			    "cannot reset.\n",  __func__, i);
 }
 #else
 static inline void omap_hsmmc_reset(void) {}
-- 
1.5.6.5

