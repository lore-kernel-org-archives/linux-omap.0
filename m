From: Ulrik Bech Hald <ubh@ti.com>
Subject: [PATCH 2/3] OMAP3:WDT:Enable support for IVA and SECURE
Date: Mon,  8 Jun 2009 16:08:12 -0500
Message-ID: <1244495293-17244-3-git-send-email-ubh@ti.com>
References: <1244495293-17244-1-git-send-email-ubh@ti.com>
 <1244495293-17244-2-git-send-email-ubh@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39385 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755586AbZFHVCQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Jun 2009 17:02:16 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n58L2Deh013778
	for <linux-omap@vger.kernel.org>; Mon, 8 Jun 2009 16:02:18 -0500
In-Reply-To: <1244495293-17244-2-git-send-email-ubh@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Ulrik Bech Hald <ubh@ti.com>

This patch enables the IVA and SECURE WDTs in the omap_wdt
driver for omap34xx family. SECURE will be available as /dev/watchdog1
HS/EMU devices and IVA will be available as /dev/watchdog3.
MPU will be available as /dev/watchdog2
For omap versions earlier than 34xx only MPU watchdog is present and
will be available as /dev/watchdog for backwards compatibility.

Signed-off-by: Ulrik Bech Hald <ubh@ti.com>
---
 drivers/watchdog/omap_wdt.c |   42 +++++++++++++++++++++++++++++++++++-------
 1 files changed, 35 insertions(+), 7 deletions(-)
 mode change 100644 => 100755 drivers/watchdog/omap_wdt.c

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
old mode 100644
new mode 100755
index f271385..26935c7
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
@@ -139,8 +141,26 @@ static void omap_wdt_set_timeout(struct omap_wdt_dev *wdev)
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
+	/* if multiple wdts, find match between device node and wdt device */
+	if (cpu_is_omap34xx()) {
+		int i;
+		for (i = 0; i < NUM_WDTS; i++) {
+			if (omap_wdt_dev[i]) {
+				wdev = platform_get_drvdata(omap_wdt_dev[i]);
+				if (iminor(inode)
+					== wdev->omap_wdt_miscdev.minor)
+					break;
+			}
+		}
+	}
+
+	base = wdev->base;
 
 	if (test_and_set_bit(1, (unsigned long *)&(wdev->omap_wdt_users)))
 		return -EBUSY;
@@ -263,6 +283,7 @@ static int __devinit omap_wdt_probe(struct platform_device *pdev)
 	struct resource *res, *mem;
 	struct omap_wdt_dev *wdev;
 	int ret;
+	static char wdt_name[32];
 
 	/* reserve static register mappings */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -271,7 +292,7 @@ static int __devinit omap_wdt_probe(struct platform_device *pdev)
 		goto err_get_resource;
 	}
 
-	if (omap_wdt_dev) {
+	if (omap_wdt_dev[pdev->id-1]) {
 		ret = -EBUSY;
 		goto err_busy;
 	}
@@ -318,8 +339,14 @@ static int __devinit omap_wdt_probe(struct platform_device *pdev)
 
 	wdev->omap_wdt_miscdev.parent = &pdev->dev;
 	wdev->omap_wdt_miscdev.minor = WATCHDOG_MINOR;
-	wdev->omap_wdt_miscdev.name = "watchdog";
 	wdev->omap_wdt_miscdev.fops = &omap_wdt_fops;
+	wdev->omap_wdt_miscdev.name = "watchdog";
+	if (cpu_is_omap34xx()) {
+		snprintf(wdt_name, sizeof(wdt_name), "watchdog%d", pdev->id);
+		wdev->omap_wdt_miscdev.name = wdt_name;
+		if (pdev->id != 2)
+			wdev->omap_wdt_miscdev.minor = MISC_DYNAMIC_MINOR;
+	}
 
 	ret = misc_register(&(wdev->omap_wdt_miscdev));
 	if (ret)
@@ -332,7 +359,8 @@ static int __devinit omap_wdt_probe(struct platform_device *pdev)
 	/* autogate OCP interface clock */
 	__raw_writel(0x01, wdev->base + OMAP_WATCHDOG_SYS_CONFIG);
 
-	omap_wdt_dev = pdev;
+	/* keep track of the wdt platform devices in local device array */
+	omap_wdt_dev[pdev->id - 1] = pdev;
 
 	return 0;
 
@@ -384,7 +412,7 @@ static int __devexit omap_wdt_remove(struct platform_device *pdev)
 	iounmap(wdev->base);
 
 	kfree(wdev);
-	omap_wdt_dev = NULL;
+	omap_wdt_dev[pdev->id-1] = NULL;
 
 	return 0;
 }
-- 
1.5.4.3

