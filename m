From: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
Subject: [PATCH 1/2] Revert "OMAP: WDT: Use PM runtime APIs instead of clk FW APIs"
Date: Tue,  8 Mar 2011 15:06:22 +0200
Message-ID: <1299589583-22632-2-git-send-email-kalle.jokiniemi@nokia.com>
References: <1299589583-22632-1-git-send-email-kalle.jokiniemi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:50909 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754746Ab1CHNI2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Mar 2011 08:08:28 -0500
In-Reply-To: <1299589583-22632-1-git-send-email-kalle.jokiniemi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com
Cc: ilkka.koskinen@nokia.com, wim@iguana.be, Kalle Jokiniemi <kalle.jokiniemi@nokia.com>

This reverts commit 7ec5ad0f3c1e28b693185c35f768953c5db32291.

The runtime PM APIs do not allow separate switching of watchdog
interface clock. Both functional clock and interface clock are
switched at the same time. This results in the CORE power domain
being unable to sleep due to the watchdog interface clock always
remaining on when the watchdog is active.

Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
---
 drivers/watchdog/omap_wdt.c |   42 +++++++++++++++++++++++++++++++++++-------
 1 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 3dd4971..81e3d61 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -38,11 +38,11 @@
 #include <linux/err.h>
 #include <linux/platform_device.h>
 #include <linux/moduleparam.h>
+#include <linux/clk.h>
 #include <linux/bitops.h>
 #include <linux/io.h>
 #include <linux/uaccess.h>
 #include <linux/slab.h>
-#include <linux/pm_runtime.h>
 #include <mach/hardware.h>
 #include <plat/prcm.h>
 
@@ -61,6 +61,8 @@ struct omap_wdt_dev {
 	void __iomem    *base;          /* physical */
 	struct device   *dev;
 	int             omap_wdt_users;
+	struct clk      *ick;
+	struct clk      *fck;
 	struct resource *mem;
 	struct miscdevice omap_wdt_miscdev;
 };
@@ -144,7 +146,8 @@ static int omap_wdt_open(struct inode *inode, struct file *file)
 	if (test_and_set_bit(1, (unsigned long *)&(wdev->omap_wdt_users)))
 		return -EBUSY;
 
-	pm_runtime_get_sync(wdev->dev);
+	clk_enable(wdev->ick);    /* Enable the interface clock */
+	clk_enable(wdev->fck);    /* Enable the functional clock */
 
 	/* initialize prescaler */
 	while (__raw_readl(base + OMAP_WATCHDOG_WPS) & 0x01)
@@ -174,7 +177,8 @@ static int omap_wdt_release(struct inode *inode, struct file *file)
 
 	omap_wdt_disable(wdev);
 
-	pm_runtime_put_sync(wdev->dev);
+	clk_disable(wdev->ick);
+	clk_disable(wdev->fck);
 #else
 	printk(KERN_CRIT "omap_wdt: Unexpected close, not stopping!\n");
 #endif
@@ -289,7 +293,19 @@ static int __devinit omap_wdt_probe(struct platform_device *pdev)
 
 	wdev->omap_wdt_users = 0;
 	wdev->mem = mem;
-	wdev->dev = &pdev->dev;
+
+	wdev->ick = clk_get(&pdev->dev, "ick");
+	if (IS_ERR(wdev->ick)) {
+		ret = PTR_ERR(wdev->ick);
+		wdev->ick = NULL;
+		goto err_clk;
+	}
+	wdev->fck = clk_get(&pdev->dev, "fck");
+	if (IS_ERR(wdev->fck)) {
+		ret = PTR_ERR(wdev->fck);
+		wdev->fck = NULL;
+		goto err_clk;
+	}
 
 	wdev->base = ioremap(res->start, resource_size(res));
 	if (!wdev->base) {
@@ -299,8 +315,8 @@ static int __devinit omap_wdt_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, wdev);
 
-	pm_runtime_enable(wdev->dev);
-	pm_runtime_get_sync(wdev->dev);
+	clk_enable(wdev->ick);
+	clk_enable(wdev->fck);
 
 	omap_wdt_disable(wdev);
 	omap_wdt_adjust_timeout(timer_margin);
@@ -318,7 +334,11 @@ static int __devinit omap_wdt_probe(struct platform_device *pdev)
 		__raw_readl(wdev->base + OMAP_WATCHDOG_REV) & 0xFF,
 		timer_margin);
 
-	pm_runtime_put_sync(wdev->dev);
+	/* autogate OCP interface clock */
+	__raw_writel(0x01, wdev->base + OMAP_WATCHDOG_SYS_CONFIG);
+
+	clk_disable(wdev->ick);
+	clk_disable(wdev->fck);
 
 	omap_wdt_dev = pdev;
 
@@ -330,6 +350,12 @@ err_misc:
 
 err_ioremap:
 	wdev->base = NULL;
+
+err_clk:
+	if (wdev->ick)
+		clk_put(wdev->ick);
+	if (wdev->fck)
+		clk_put(wdev->fck);
 	kfree(wdev);
 
 err_kzalloc:
@@ -361,6 +387,8 @@ static int __devexit omap_wdt_remove(struct platform_device *pdev)
 	release_mem_region(res->start, resource_size(res));
 	platform_set_drvdata(pdev, NULL);
 
+	clk_put(wdev->ick);
+	clk_put(wdev->fck);
 	iounmap(wdev->base);
 
 	kfree(wdev);
-- 
1.7.1

