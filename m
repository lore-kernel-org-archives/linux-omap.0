From: Charulatha V <charu@ti.com>
Subject: [PATCH 6/6] OMAP2PLUS: WDT: Conversion to runtime PM
Date: Sat, 22 May 2010 18:26:06 +0530
Message-ID: <1274532966-19916-7-git-send-email-charu@ti.com>
References: <1274532966-19916-1-git-send-email-charu@ti.com>
 <1274532966-19916-2-git-send-email-charu@ti.com>
 <1274532966-19916-3-git-send-email-charu@ti.com>
 <1274532966-19916-4-git-send-email-charu@ti.com>
 <1274532966-19916-5-git-send-email-charu@ti.com>
 <1274532966-19916-6-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48446 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753685Ab0EVMyd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 22 May 2010 08:54:33 -0400
In-Reply-To: <1274532966-19916-6-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: wim@iguana.be, khilman@deeprootsystems.com, rnayak@ti.com, paul@pwsan.com, Charulatha V <charu@ti.com>

This patch converts the OMAP2/3 Watchdog timer driver to
get adapted to HWMOD FW and to use the runtime PM APIs.

This patch is tested on SDP3430, SDP3630 and SDP4430.

Signed-off-by: Charulatha V <charu@ti.com>
---
 arch/arm/plat-omap/devices.c |   52 ++++++++++++++++++++++++----------
 drivers/watchdog/omap_wdt.c  |   63 ++++++++++++++---------------------------
 2 files changed, 58 insertions(+), 57 deletions(-)

diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index 95677d1..28758e3 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -15,6 +15,7 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/slab.h>
+#include <linux/err.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -30,6 +31,8 @@
 #include <plat/mcbsp.h>
 #include <plat/dsp_common.h>
 #include <plat/omap44xx.h>
+#include <plat/omap_hwmod.h>
+#include <plat/omap_device.h>
 
 #if	defined(CONFIG_OMAP_DSP) || defined(CONFIG_OMAP_DSP_MODULE)
 
@@ -360,6 +363,8 @@ static inline void omap_init_uwire(void) {}
 
 static struct resource wdt_resources[] = {
 	{
+		.start		= 0xfffeb000,
+		.end		= 0xfffeb07F,
 		.flags		= IORESOURCE_MEM,
 	},
 };
@@ -371,24 +376,39 @@ static struct platform_device omap_wdt_device = {
 	.resource	= wdt_resources,
 };
 
-static void omap_init_wdt(void)
-{
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
-		return;
+struct omap_device_pm_latency omap_wdt_latency[] = {
+	[0] = {
+		.deactivate_func = omap_device_idle_hwmods,
+		.activate_func   = omap_device_enable_hwmods,
+		.flags		 = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	},
+};
 
-	wdt_resources[0].end = wdt_resources[0].start + 0x4f;
+static int omap2_init_wdt(struct omap_hwmod *oh, void *user)
+{
+	int id = -1;
+	struct omap_device *od;
+	char *name = "omap_wdt";
+
+	if (!oh)
+		pr_err("Could not look up wdtimer2_hwmod\n");
+
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
+		omap_hwmod_for_each_by_class("wd_timer", omap2_init_wdt,
+						NULL);
+	else if (cpu_is_omap16xx())
+		(void) platform_device_register(&omap_wdt_device);
+	return;
 }
 #else
 static inline void omap_init_wdt(void) {}
diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 76b58ab..0458829 100644
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
@@ -135,6 +134,8 @@ static void omap_wdt_set_timeout(struct omap_wdt_dev *wdev)
 		cpu_relax();
 }
 
+static int wdt_runtime_state;
+
 /*
  *	Allow only one task to hold it open
  */
@@ -142,12 +143,13 @@ static int omap_wdt_open(struct inode *inode, struct file *file)
 {
 	struct omap_wdt_dev *wdev = platform_get_drvdata(omap_wdt_dev);
 	void __iomem *base = wdev->base;
-
 	if (test_and_set_bit(1, (unsigned long *)&(wdev->omap_wdt_users)))
 		return -EBUSY;
 
-	clk_enable(wdev->ick);    /* Enable the interface clock */
-	clk_enable(wdev->fck);    /* Enable the functional clock */
+	if (!wdt_runtime_state) {
+		pm_runtime_get_sync(wdev->dev);
+		wdt_runtime_state = 1;
+	}
 
 	/* initialize prescaler */
 	while (__raw_readl(base + OMAP_WATCHDOG_WPS) & 0x01)
@@ -177,8 +179,8 @@ static int omap_wdt_release(struct inode *inode, struct file *file)
 
 	omap_wdt_disable(wdev);
 
-	clk_disable(wdev->ick);
-	clk_disable(wdev->fck);
+	pm_runtime_put_sync(wdev->dev);
+	wdt_runtime_state = 0;
 #else
 	printk(KERN_CRIT "omap_wdt: Unexpected close, not stopping!\n");
 #endif
@@ -290,32 +292,24 @@ static int __devinit omap_wdt_probe(struct platform_device *pdev)
 		goto err_kzalloc;
 	}
 
-	wdev->omap_wdt_users = 0;
-	wdev->mem = mem;
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
-
-	wdev->base = ioremap(res->start, resource_size(res));
+	wdev->base = ioremap(res->start, SZ_4K);
 	if (!wdev->base) {
 		ret = -ENOMEM;
 		goto err_ioremap;
 	}
 
+	wdev->omap_wdt_users = 0;
+	wdev->mem = mem;
+	wdev->dev = &pdev->dev;
+
 	platform_set_drvdata(pdev, wdev);
 
-	clk_enable(wdev->ick);
-	clk_enable(wdev->fck);
+	pm_runtime_enable(wdev->dev);
+	pm_runtime_get_sync(wdev->dev);
+#ifndef CONFIG_PM_RUNTIME
+	/* If runtime PM is not enabled, ensure clocks are always enabled */
+	omap_device_enable(pdev);
+#endif
 
 	omap_wdt_disable(wdev);
 	omap_wdt_adjust_timeout(timer_margin);
@@ -333,12 +327,7 @@ static int __devinit omap_wdt_probe(struct platform_device *pdev)
 		__raw_readl(wdev->base + OMAP_WATCHDOG_REV) & 0xFF,
 		timer_margin);
 
-	/* autogate OCP interface clock */
-	__raw_writel(0x01, wdev->base + OMAP_WATCHDOG_SYS_CONFIG);
-
-	clk_disable(wdev->ick);
-	clk_disable(wdev->fck);
-
+	pm_runtime_put_sync(wdev->dev);
 	omap_wdt_dev = pdev;
 
 	return 0;
@@ -349,12 +338,6 @@ err_misc:
 
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
@@ -386,8 +369,6 @@ static int __devexit omap_wdt_remove(struct platform_device *pdev)
 	release_mem_region(res->start, resource_size(res));
 	platform_set_drvdata(pdev, NULL);
 
-	clk_put(wdev->ick);
-	clk_put(wdev->fck);
 	iounmap(wdev->base);
 
 	kfree(wdev);
-- 
1.6.3.3

