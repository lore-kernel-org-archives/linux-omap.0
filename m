From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 4/6] ARM: OMAP4: PMU: Add runtime PM support
Date: Wed, 9 May 2012 16:35:55 -0500
Message-ID: <1336599355-10983-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46663 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932213Ab2EIVgA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 May 2012 17:36:00 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Jon Hunter <jon-hunter@ti.com>, Ming Lei <ming.lei@canonical.com>, Will Deacon <will.deacon@arm.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>

From: Jon Hunter <jon-hunter@ti.com>

This patch is based upon Ming Lei's patch to add runtime PM support for OMAP4
[1]. In Ming's original patch the CTI interrupts were being enabled during
runtime when the PMU was used but they were only configured once during init.
Therefore move the configuration of the CTI interrupts to the runtime PM
functions.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/074153.html

Cc: Ming Lei <ming.lei@canonical.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/devices.c |   50 ++++++++++++++++++++++------------------
 1 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 636533d..b02aa81 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/platform_data/omap4-keypad.h>
+#include <linux/pm_runtime.h>
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
@@ -434,13 +435,22 @@ static struct omap_device_pm_latency omap_pmu_latency[] = {
 };
 
 static struct cti omap4_cti[2];
+static struct platform_device *pmu_dev;
 
 static void omap4_enable_cti(int irq)
 {
-	if (irq == OMAP44XX_IRQ_CTI0)
+	pm_runtime_get_sync(&pmu_dev->dev);
+	if (irq == OMAP44XX_IRQ_CTI0) {
+		/* configure CTI0 for pmu irq routing */
+		cti_unlock(&omap4_cti[0]);
+		cti_map_trigger(&omap4_cti[0], 1, 6, 2);
 		cti_enable(&omap4_cti[0]);
-	else if (irq == OMAP44XX_IRQ_CTI1)
+	} else if (irq == OMAP44XX_IRQ_CTI1) {
+		/* configure CTI1 for pmu irq routing */
+		cti_unlock(&omap4_cti[1]);
+		cti_map_trigger(&omap4_cti[1], 1, 6, 2);
 		cti_enable(&omap4_cti[1]);
+	}
 }
 
 static void omap4_disable_cti(int irq)
@@ -449,6 +459,7 @@ static void omap4_disable_cti(int irq)
 		cti_disable(&omap4_cti[0]);
 	else if (irq == OMAP44XX_IRQ_CTI1)
 		cti_disable(&omap4_cti[1]);
+	pm_runtime_put(&pmu_dev->dev);
 }
 
 static irqreturn_t omap4_pmu_handler(int irq, void *dev, irq_handler_t handler)
@@ -461,27 +472,20 @@ static irqreturn_t omap4_pmu_handler(int irq, void *dev, irq_handler_t handler)
 	return handler(irq, dev);
 }
 
-static void __init omap4_configure_pmu_irq(void)
+static int __init omap4_configure_pmu(void)
 {
-	void __iomem *base0;
-	void __iomem *base1;
+	omap4_cti[0].base = ioremap(OMAP44XX_CTI0_BASE, SZ_4K);
+	omap4_cti[1].base = ioremap(OMAP44XX_CTI1_BASE, SZ_4K);
 
-	base0 = ioremap(OMAP44XX_CTI0_BASE, SZ_4K);
-	base1 = ioremap(OMAP44XX_CTI1_BASE, SZ_4K);
-	if (!base0 && !base1) {
+	if (!omap4_cti[0].base || !omap4_cti[1].base) {
 		pr_err("ioremap for OMAP4 CTI failed\n");
-		return;
+		return -ENOMEM;
 	}
 
-	/*configure CTI0 for pmu irq routing*/
-	cti_init(&omap4_cti[0], base0, OMAP44XX_IRQ_CTI0, 6);
-	cti_unlock(&omap4_cti[0]);
-	cti_map_trigger(&omap4_cti[0], 1, 6, 2);
+	cti_init(&omap4_cti[0], omap4_cti[0].base, OMAP44XX_IRQ_CTI0, 6);
+	cti_init(&omap4_cti[1], omap4_cti[1].base, OMAP44XX_IRQ_CTI1, 6);
 
-	/*configure CTI1 for pmu irq routing*/
-	cti_init(&omap4_cti[1], base1, OMAP44XX_IRQ_CTI1, 6);
-	cti_unlock(&omap4_cti[1]);
-	cti_map_trigger(&omap4_cti[1], 1, 6, 2);
+	return 0;
 }
 
 static struct platform_device* __init omap4_init_pmu(void)
@@ -492,6 +496,9 @@ static struct platform_device* __init omap4_init_pmu(void)
 	struct omap_hwmod* oh[3];
 	char *dev_name = "arm-pmu";
 
+	if (omap4_configure_pmu())
+		return NULL;
+
 	hw = "l3_main_3";
 	oh[0] = omap_hwmod_lookup(hw);
 	if (!oh[0]) {
@@ -530,14 +537,11 @@ static void __init omap_init_pmu(void)
 	} else if (cpu_is_omap34xx()) {
 		omap_pmu_device.resource = &omap3_pmu_resource;
 	} else if (cpu_is_omap44xx()) {
-		struct platform_device *pd;
-
-		pd = omap4_init_pmu();
-		if (!pd)
+		pmu_dev = omap4_init_pmu();
+		if (!pmu_dev)
 			return;
 
-		omap_device_enable(&od->pdev);
-		omap4_configure_pmu_irq();
+		pm_runtime_enable(&pmu_dev->dev);
 		return;
 	} else {
 		return;
-- 
1.7.5.4

