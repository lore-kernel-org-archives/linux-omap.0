From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: [PATCH v5 6/6] OMAP: WDT: Use PM runtime APIs instead of clk FW APIs
Date: Wed, 15 Sep 2010 10:56:43 +0530
Message-ID: <1284528403-6494-7-git-send-email-charu@ti.com>
References: <1284528403-6494-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34263 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751948Ab0IOF1A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Sep 2010 01:27:00 -0400
In-Reply-To: <1284528403-6494-1-git-send-email-charu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, wim@iguana.be, linux-watchdog@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, p-basak2@ti.com, linux-omap@vger.kernel.org, "Varadarajan, Charulatha" <charu@ti.com>

Call runtime pm APIs pm_runtime_put_sync() and pm_runtime_get_sync()
for enabling/disabling the clocks, sysconfig settings instead of using
clock FW APIs.

Signed-off-by: Charulatha V <charu@ti.com>
---
 drivers/watchdog/omap_wdt.c |   42 +++++++-----------------------------------
 1 files changed, 7 insertions(+), 35 deletions(-)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 76b58ab..dbbc580 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -38,11 +38,11 @@
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
 
@@ -61,8 +61,6 @@ struct omap_wdt_dev {
 	void __iomem    *base;          /* physical */
 	struct device   *dev;
 	int             omap_wdt_users;
-	struct clk      *ick;
-	struct clk      *fck;
 	struct resource *mem;
 	struct miscdevice omap_wdt_miscdev;
 };
@@ -146,8 +144,7 @@ static int omap_wdt_open(struct inode *inode, struct file *file)
 	if (test_and_set_bit(1, (unsigned long *)&(wdev->omap_wdt_users)))
 		return -EBUSY;
 
-	clk_enable(wdev->ick);    /* Enable the interface clock */
-	clk_enable(wdev->fck);    /* Enable the functional clock */
+	pm_runtime_get_sync(wdev->dev);
 
 	/* initialize prescaler */
 	while (__raw_readl(base + OMAP_WATCHDOG_WPS) & 0x01)
@@ -177,8 +174,7 @@ static int omap_wdt_release(struct inode *inode, struct file *file)
 
 	omap_wdt_disable(wdev);
 
-	clk_disable(wdev->ick);
-	clk_disable(wdev->fck);
+	pm_runtime_put_sync(wdev->dev);
 #else
 	printk(KERN_CRIT "omap_wdt: Unexpected close, not stopping!\n");
 #endif
@@ -292,19 +288,7 @@ static int __devinit omap_wdt_probe(struct platform_device *pdev)
 
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
@@ -314,8 +298,8 @@ static int __devinit omap_wdt_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, wdev);
 
-	clk_enable(wdev->ick);
-	clk_enable(wdev->fck);
+	pm_runtime_enable(wdev->dev);
+	pm_runtime_get_sync(wdev->dev);
 
 	omap_wdt_disable(wdev);
 	omap_wdt_adjust_timeout(timer_margin);
@@ -333,11 +317,7 @@ static int __devinit omap_wdt_probe(struct platform_device *pdev)
 		__raw_readl(wdev->base + OMAP_WATCHDOG_REV) & 0xFF,
 		timer_margin);
 
-	/* autogate OCP interface clock */
-	__raw_writel(0x01, wdev->base + OMAP_WATCHDOG_SYS_CONFIG);
-
-	clk_disable(wdev->ick);
-	clk_disable(wdev->fck);
+	pm_runtime_put_sync(wdev->dev);
 
 	omap_wdt_dev = pdev;
 
@@ -349,12 +329,6 @@ err_misc:
 
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
@@ -386,8 +360,6 @@ static int __devexit omap_wdt_remove(struct platform_device *pdev)
 	release_mem_region(res->start, resource_size(res));
 	platform_set_drvdata(pdev, NULL);
 
-	clk_put(wdev->ick);
-	clk_put(wdev->fck);
 	iounmap(wdev->base);
 
 	kfree(wdev);
-- 
1.7.0.4

