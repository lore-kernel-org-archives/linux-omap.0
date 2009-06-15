From: Ulrik Bech Hald <ubh@ti.com>
Subject: [PATCH 2/2] watchdog:OMAP3:Enable support for IVA2 and SECURE
Date: Mon, 15 Jun 2009 16:11:52 -0500
Message-ID: <1245100312-2312-3-git-send-email-ubh@ti.com>
References: <1245100312-2312-1-git-send-email-ubh@ti.com>
 <1245100312-2312-2-git-send-email-ubh@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44932 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934390AbZFOVHK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Jun 2009 17:07:10 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n5FL774N001149
	for <linux-omap@vger.kernel.org>; Mon, 15 Jun 2009 16:07:12 -0500
In-Reply-To: <1245100312-2312-2-git-send-email-ubh@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Ulrik Bech Hald <ubh@ti.com>

This patch enables the IVA2 and SECURE WDTs in the omap_wdt
driver for omap34xx family. SECURE will be available as
/dev/watchdog_secure on HS/EMU devices and IVA2 will be available
as /dev/watchdog_iva2. MPU will still be available as /dev/watchdog

Signed-off-by: Ulrik Bech Hald <ubh@ti.com>
---
This patch has a dependency on:
[PATCH 1/1] watchdog: OMAP fixes: enable clock in probe, trigger timer reload

 drivers/watchdog/omap_wdt.c |   51 ++++++++++++++++++++++++++++++++++++------
 1 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index f271385..85a92de 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -47,7 +47,15 @@
 
 #include "omap_wdt.h"
 
-static struct platform_device *omap_wdt_dev;
+#define NUM_WDTS	3
+
+enum {
+	SECURE_WDT = 1,
+	MPU_WDT,
+	IVA2_WDT,
+};
+
+static struct platform_device *omap_wdt_dev[NUM_WDTS];
 
 static unsigned timer_margin;
 module_param(timer_margin, uint, 0);
@@ -139,8 +147,23 @@ static void omap_wdt_set_timeout(struct omap_wdt_dev *wdev)
  */
 static int omap_wdt_open(struct inode *inode, struct file *file)
 {
-	struct omap_wdt_dev *wdev = platform_get_drvdata(omap_wdt_dev);
-	void __iomem *base = wdev->base;
+	struct omap_wdt_dev *wdev;
+	void __iomem *base;
+
+	/* by default MPU wdt is present across omap family */
+	wdev = platform_get_drvdata(omap_wdt_dev[1]);
+
+	/* Find match between device node and wdt device */
+	int i;
+	for (i = 0; i < NUM_WDTS; i++) {
+		if (omap_wdt_dev[i]) {
+			wdev = platform_get_drvdata(omap_wdt_dev[i]);
+			if (iminor(inode) == wdev->omap_wdt_miscdev.minor)
+				break;
+		}
+	}
+
+	base = wdev->base;
 
 	if (test_and_set_bit(1, (unsigned long *)&(wdev->omap_wdt_users)))
 		return -EBUSY;
@@ -271,7 +294,7 @@ static int __devinit omap_wdt_probe(struct platform_device *pdev)
 		goto err_get_resource;
 	}
 
-	if (omap_wdt_dev) {
+	if (omap_wdt_dev[pdev->id-1]) {
 		ret = -EBUSY;
 		goto err_busy;
 	}
@@ -317,10 +340,21 @@ static int __devinit omap_wdt_probe(struct platform_device *pdev)
 	omap_wdt_adjust_timeout(timer_margin);
 
 	wdev->omap_wdt_miscdev.parent = &pdev->dev;
-	wdev->omap_wdt_miscdev.minor = WATCHDOG_MINOR;
-	wdev->omap_wdt_miscdev.name = "watchdog";
+	wdev->omap_wdt_miscdev.minor = MISC_DYNAMIC_MINOR;
 	wdev->omap_wdt_miscdev.fops = &omap_wdt_fops;
 
+	switch (pdev->id) {
+	case SECURE_WDT:
+		wdev->omap_wdt_miscdev.name = "watchdog_secure";
+		break;
+	case IVA2_WDT:
+		wdev->omap_wdt_miscdev.name = "watchdog_iva2";
+		break;
+	case MPU_WDT:
+	default:
+		wdev->omap_wdt_miscdev.name = "watchdog";
+	}
+
 	ret = misc_register(&(wdev->omap_wdt_miscdev));
 	if (ret)
 		goto err_misc;
@@ -332,7 +366,8 @@ static int __devinit omap_wdt_probe(struct platform_device *pdev)
 	/* autogate OCP interface clock */
 	__raw_writel(0x01, wdev->base + OMAP_WATCHDOG_SYS_CONFIG);
 
-	omap_wdt_dev = pdev;
+	/* keep track of the wdt platform devices in local device array */
+	omap_wdt_dev[pdev->id - 1] = pdev;
 
 	return 0;
 
@@ -384,7 +419,7 @@ static int __devexit omap_wdt_remove(struct platform_device *pdev)
 	iounmap(wdev->base);
 
 	kfree(wdev);
-	omap_wdt_dev = NULL;
+	omap_wdt_dev[pdev->id-1] = NULL;
 
 	return 0;
 }
-- 
1.5.4.3

