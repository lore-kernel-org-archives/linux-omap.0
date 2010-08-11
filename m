From: Charulatha V <charu@ti.com>
Subject: [PATCH 6/6 v2] OMAP2PLUS: WDT: Conversion to runtime PM
Date: Wed, 11 Aug 2010 15:41:11 +0530
Message-ID: <1281521471-15802-7-git-send-email-charu@ti.com>
References: <1281521471-15802-1-git-send-email-charu@ti.com>
 <1281521471-15802-2-git-send-email-charu@ti.com>
 <1281521471-15802-3-git-send-email-charu@ti.com>
 <1281521471-15802-4-git-send-email-charu@ti.com>
 <1281521471-15802-5-git-send-email-charu@ti.com>
 <1281521471-15802-6-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49984 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932827Ab0HKKIm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Aug 2010 06:08:42 -0400
In-Reply-To: <1281521471-15802-6-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: wim@iguana.be, khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, p-basak2@ti.com, Charulatha V <charu@ti.com>

This patch converts the OMAP Watchdog timer driver to
get adapted to HWMOD FW and to use the runtime PM APIs.

Signed-off-by: Charulatha V <charu@ti.com>
Signed-off-by: Basak, Partha <p-basak2@ti.com>
---
 arch/arm/plat-omap/devices.c |   52 ++++++++++++++++++++++++++++++-----------
 drivers/watchdog/omap_wdt.c  |   43 ++++++----------------------------
 2 files changed, 46 insertions(+), 49 deletions(-)

diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index d1920be..efe2aff 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/slab.h>
+#include <linux/err.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -28,6 +29,8 @@
 #include <plat/menelaus.h>
 #include <plat/mcbsp.h>
 #include <plat/omap44xx.h>
+#include <plat/omap_hwmod.h>
+#include <plat/omap_device.h>
 
 /*-------------------------------------------------------------------------*/
 
@@ -238,6 +241,8 @@ static inline void omap_init_uwire(void) {}
 
 static struct resource wdt_resources[] = {
 	{
+		.start		= 0xfffeb000,
+		.end		= 0xfffeb07F,
 		.flags		= IORESOURCE_MEM,
 	},
 };
@@ -249,24 +254,43 @@ static struct platform_device omap_wdt_device = {
 	.resource	= wdt_resources,
 };
 
-static void omap_init_wdt(void)
+struct omap_device_pm_latency omap_wdt_latency[] = {
+	[0] = {
+		.deactivate_func = omap_device_idle_hwmods,
+		.activate_func   = omap_device_enable_hwmods,
+		.flags		 = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	},
+};
+
+static void omap2_init_wdt()
 {
-	if (cpu_is_omap16xx())
-		wdt_resources[0].start = 0xfffeb000;
-	else if (cpu_is_omap2420())
-		wdt_resources[0].start = 0x48022000; /* WDT2 */
-	else if (cpu_is_omap2430())
-		wdt_resources[0].start = 0x49016000; /* WDT2 */
-	else if (cpu_is_omap343x())
-		wdt_resources[0].start = 0x48314000; /* WDT2 */
-	else if (cpu_is_omap44xx())
-		wdt_resources[0].start = 0x4a314000;
-	else
+	int id = -1;
+	struct omap_device *od;
+	struct omap_hwmod *oh;
+	char *oh_name = "wd_timer2";
+	char *name = "omap_wdt";
+
+	oh = omap_hwmod_lookup(oh_name);
+	if (!oh) {
+		pr_err("Could not look up %s\n", oh_name);
 		return;
+	}
 
-	wdt_resources[0].end = wdt_resources[0].start + 0x4f;
+	od = omap_device_build(name, id, oh, NULL, 0,
+				omap_wdt_latency,
+				ARRAY_SIZE(omap_wdt_latency), 0);
+	WARN(IS_ERR(od), "Cant build omap_device for %s:%s.\n",
+				name, oh->name);
+	return 0;
+}
 
-	(void) platform_device_register(&omap_wdt_device);
+static void omap_init_wdt(void)
+{
+	if (cpu_class_is_omap2())
+		omap2_init_wdt();
+	else if (cpu_is_omap16xx())
+		(void) platform_device_register(&omap_wdt_device);
+	return;
 }
 #else
 static inline void omap_init_wdt(void) {}
diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 76b58ab..7645ca3 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -38,13 +38,14 @@
 #include <linux/err.h>
 #include <linux/platform_device.h>
 #include <linux/moduleparam.h>
-#include <linux/clk.h>
 #include <linux/bitops.h>
 #include <linux/io.h>
 #include <linux/uaccess.h>
 #include <linux/slab.h>
+#include <linux/pm_runtime.h>
 #include <mach/hardware.h>
 #include <plat/prcm.h>
+#include <plat/omap_device.h>
 
 #include "omap_wdt.h"
 
@@ -61,8 +62,6 @@ struct omap_wdt_dev {
 	void __iomem    *base;          /* physical */
 	struct device   *dev;
 	int             omap_wdt_users;
-	struct clk      *ick;
-	struct clk      *fck;
 	struct resource *mem;
 	struct miscdevice omap_wdt_miscdev;
 };
@@ -146,8 +145,7 @@ static int omap_wdt_open(struct inode *inode, struct file *file)
 	if (test_and_set_bit(1, (unsigned long *)&(wdev->omap_wdt_users)))
 		return -EBUSY;
 
-	clk_enable(wdev->ick);    /* Enable the interface clock */
-	clk_enable(wdev->fck);    /* Enable the functional clock */
+	pm_runtime_get_sync(wdev->dev);
 
 	/* initialize prescaler */
 	while (__raw_readl(base + OMAP_WATCHDOG_WPS) & 0x01)
@@ -177,8 +175,7 @@ static int omap_wdt_release(struct inode *inode, struct file *file)
 
 	omap_wdt_disable(wdev);
 
-	clk_disable(wdev->ick);
-	clk_disable(wdev->fck);
+	pm_runtime_put_sync(wdev->dev);
 #else
 	printk(KERN_CRIT "omap_wdt: Unexpected close, not stopping!\n");
 #endif
@@ -292,19 +289,7 @@ static int __devinit omap_wdt_probe(struct platform_device *pdev)
 
 	wdev->omap_wdt_users = 0;
 	wdev->mem = mem;
-
-	wdev->ick = clk_get(&pdev->dev, "ick");
-	if (IS_ERR(wdev->ick)) {
-		ret = PTR_ERR(wdev->ick);
-		wdev->ick = NULL;
-		goto err_clk;
-	}
-	wdev->fck = clk_get(&pdev->dev, "fck");
-	if (IS_ERR(wdev->fck)) {
-		ret = PTR_ERR(wdev->fck);
-		wdev->fck = NULL;
-		goto err_clk;
-	}
+	wdev->dev = &pdev->dev;
 
 	wdev->base = ioremap(res->start, resource_size(res));
 	if (!wdev->base) {
@@ -314,8 +299,8 @@ static int __devinit omap_wdt_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, wdev);
 
-	clk_enable(wdev->ick);
-	clk_enable(wdev->fck);
+	pm_runtime_enable(wdev->dev);
+	pm_runtime_get_sync(wdev->dev);
 
 	omap_wdt_disable(wdev);
 	omap_wdt_adjust_timeout(timer_margin);
@@ -333,11 +318,7 @@ static int __devinit omap_wdt_probe(struct platform_device *pdev)
 		__raw_readl(wdev->base + OMAP_WATCHDOG_REV) & 0xFF,
 		timer_margin);
 
-	/* autogate OCP interface clock */
-	__raw_writel(0x01, wdev->base + OMAP_WATCHDOG_SYS_CONFIG);
-
-	clk_disable(wdev->ick);
-	clk_disable(wdev->fck);
+	pm_runtime_put_sync(wdev->dev);
 
 	omap_wdt_dev = pdev;
 
@@ -349,12 +330,6 @@ err_misc:
 
 err_ioremap:
 	wdev->base = NULL;
-
-err_clk:
-	if (wdev->ick)
-		clk_put(wdev->ick);
-	if (wdev->fck)
-		clk_put(wdev->fck);
 	kfree(wdev);
 
 err_kzalloc:
@@ -386,8 +361,6 @@ static int __devexit omap_wdt_remove(struct platform_device *pdev)
 	release_mem_region(res->start, resource_size(res));
 	platform_set_drvdata(pdev, NULL);
 
-	clk_put(wdev->ick);
-	clk_put(wdev->fck);
 	iounmap(wdev->base);
 
 	kfree(wdev);
-- 
1.6.3.3

