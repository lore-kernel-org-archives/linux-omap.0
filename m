From: Ulrik Bech Hald <ubh@ti.com>
Subject: [PATCH 2/2] watchdog:OMAP3:Enable support for IVA2 and SECURE
Date: Thu,  9 Jul 2009 13:04:23 -0500
Message-ID: <1247162663-27541-3-git-send-email-ubh@ti.com>
References: <1247162663-27541-1-git-send-email-ubh@ti.com>
 <1247162663-27541-2-git-send-email-ubh@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58843 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752573AbZGIR62 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Jul 2009 13:58:28 -0400
In-Reply-To: <1247162663-27541-2-git-send-email-ubh@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: wim@iguana.be
Cc: linux-omap@vger.kernel.org, Ulrik Bech Hald <ubh@ti.com>

This patch adds support for IVA2 and SECURE WDTs in the omap_wdt
driver for omap34xx family. SECURE will be available as
/dev/watchdog_secure on HS/EMU devices and IVA2 will be available
as /dev/watchdog_iva2. MPU will still be available as /dev/watchdog

Tested on Zoom1 OMAP3 platform

Signed-off-by: Ulrik Bech Hald <ubh@ti.com>
Reviewed-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 drivers/watchdog/omap_wdt.c |   34 ++++++++++++++++++++++++++--------
 1 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 3ed571a..12409fe 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -47,7 +47,9 @@
 
 #include "omap_wdt.h"
 
-static struct platform_device *omap_wdt_dev;
+#define NUM_WDTS	3
+
+static struct platform_device *omap_wdt_dev[NUM_WDTS];
 
 static unsigned timer_margin;
 module_param(timer_margin, uint, 0);
@@ -139,8 +141,23 @@ static void omap_wdt_set_timeout(struct omap_wdt_dev *wdev)
  */
 static int omap_wdt_open(struct inode *inode, struct file *file)
 {
-	struct omap_wdt_dev *wdev = platform_get_drvdata(omap_wdt_dev);
-	void __iomem *base = wdev->base;
+	struct omap_wdt_dev *wdev = NULL;
+	void __iomem *base;
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
+	if (!wdev)
+		return -ENODEV;
+
+	base = wdev->base;
 
 	if (test_and_set_bit(1, (unsigned long *)&(wdev->omap_wdt_users)))
 		return -EBUSY;
@@ -272,7 +289,7 @@ static int __devinit omap_wdt_probe(struct platform_device *pdev)
 		goto err_get_resource;
 	}
 
-	if (omap_wdt_dev) {
+	if (omap_wdt_dev[pdev->id]) {
 		ret = -EBUSY;
 		goto err_busy;
 	}
@@ -321,9 +338,9 @@ static int __devinit omap_wdt_probe(struct platform_device *pdev)
 	omap_wdt_adjust_timeout(timer_margin);
 
 	wdev->omap_wdt_miscdev.parent = &pdev->dev;
-	wdev->omap_wdt_miscdev.minor = WATCHDOG_MINOR;
-	wdev->omap_wdt_miscdev.name = "watchdog";
+	wdev->omap_wdt_miscdev.minor = MISC_DYNAMIC_MINOR;
 	wdev->omap_wdt_miscdev.fops = &omap_wdt_fops;
+	wdev->omap_wdt_miscdev.name = (char *) pdev->dev.platform_data;
 
 	ret = misc_register(&(wdev->omap_wdt_miscdev));
 	if (ret)
@@ -339,7 +356,8 @@ static int __devinit omap_wdt_probe(struct platform_device *pdev)
 	clk_disable(wdev->ick);
 	clk_disable(wdev->fck);
 
-	omap_wdt_dev = pdev;
+	/* keep track of the wdt platform devices in local device array */
+	omap_wdt_dev[pdev->id] = pdev;
 
 	return 0;
 
@@ -391,7 +409,7 @@ static int __devexit omap_wdt_remove(struct platform_device *pdev)
 	iounmap(wdev->base);
 
 	kfree(wdev);
-	omap_wdt_dev = NULL;
+	omap_wdt_dev[pdev->id] = NULL;
 
 	return 0;
 }
-- 
1.5.4.3

