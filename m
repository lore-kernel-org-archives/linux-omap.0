From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH 3/3] clk: use clk_associate on watchdog driver
Date: Sat, 25 Oct 2008 22:55:48 +0300
Message-ID: <1224964548-31844-3-git-send-email-me@felipebalbi.com>
References: <1224964548-31844-1-git-send-email-me@felipebalbi.com>
 <1224964548-31844-2-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:52395 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918AbYJYTz7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 25 Oct 2008 15:55:59 -0400
In-Reply-To: <1224964548-31844-2-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>, Wim Van Sebroeck <wim@iguana.be>

From: Felipe Balbi <felipe.balbi@nokia.com>

Get rid of clk mess on omap_watchdog driver by
using clk_associate.

Cc: Wim Van Sebroeck <wim@iguana.be>
Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/plat-omap/devices.c |   18 ++++++--
 drivers/watchdog/omap_wdt.c  |   87 ++++++++++++-----------------------------
 2 files changed, 39 insertions(+), 66 deletions(-)

diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index c22bd5f..c53c333 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -298,16 +298,24 @@ static struct platform_device omap_wdt_device = {
 
 static void omap_init_wdt(void)
 {
-	if (cpu_is_omap16xx())
+	if (cpu_is_omap16xx()) {
+		omap_clk_associate("armwdt_ck", &omap_wdt_device.dev);
 		wdt_resources[0].start = 0xfffeb000;
-	else if (cpu_is_omap2420())
+	} else if (cpu_is_omap2420()) {
+		omap_clk_associate("mpu_wdt_fck", &omap_wdt_device.dev);
+		omap_clk_associate("mpu_wdt_ick", &omap_wdt_device.dev);
 		wdt_resources[0].start = 0x48022000; /* WDT2 */
-	else if (cpu_is_omap2430())
+	} else if (cpu_is_omap2430()) {
+		omap_clk_associate("mpu_wdt_fck", &omap_wdt_device.dev);
+		omap_clk_associate("mpu_wdt_ick", &omap_wdt_device.dev);
 		wdt_resources[0].start = 0x49016000; /* WDT2 */
-	else if (cpu_is_omap343x())
+	} else if (cpu_is_omap343x()) {
+		omap_clk_associate("wdt2_fck", &omap_wdt_device.dev);
+		omap_clk_associate("wdt2_ick", &omap_wdt_device.dev);
 		wdt_resources[0].start = 0x48314000; /* WDT2 */
-	else
+	} else {
 		return;
+	}
 
 	wdt_resources[0].end = wdt_resources[0].start + 0x4f;
 
diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 7bcbb7f..aa4557a 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -60,9 +60,8 @@ struct omap_wdt_dev {
 	void __iomem    *base;          /* physical */
 	struct device   *dev;
 	int             omap_wdt_users;
-	struct clk      *armwdt_ck;
-	struct clk      *mpu_wdt_ick;
-	struct clk      *mpu_wdt_fck;
+	struct clk      *ick;
+	struct clk      *fck;
 	struct resource *mem;
 	struct miscdevice omap_wdt_miscdev;
 };
@@ -146,13 +145,10 @@ static int omap_wdt_open(struct inode *inode, struct file *file)
 	if (test_and_set_bit(1, (unsigned long *)&(wdev->omap_wdt_users)))
 		return -EBUSY;
 
-	if (cpu_is_omap16xx())
-		clk_enable(wdev->armwdt_ck);	/* Enable the clock */
-
-	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
-		clk_enable(wdev->mpu_wdt_ick);    /* Enable the interface clock */
-		clk_enable(wdev->mpu_wdt_fck);    /* Enable the functional clock */
-	}
+	if (wdev->fck)
+		clk_enable(wdev->fck);    /* Enable the functional clock */
+	if (wdev->ick)
+		clk_enable(wdev->ick);    /* Enable the interface clock */
 
 	/* initialize prescaler */
 	while (__raw_readl(base + OMAP_WATCHDOG_WPS) & 0x01)
@@ -303,44 +299,20 @@ static int __init omap_wdt_probe(struct platform_device *pdev)
 	wdev->omap_wdt_users = 0;
 	wdev->mem = mem;
 
-	if (cpu_is_omap16xx()) {
-		wdev->armwdt_ck = clk_get(&pdev->dev, "armwdt_ck");
-		if (IS_ERR(wdev->armwdt_ck)) {
-			ret = PTR_ERR(wdev->armwdt_ck);
-			wdev->armwdt_ck = NULL;
-			goto err_clk;
-		}
+	wdev->fck = clk_get(&pdev->dev, "fclk");
+	if (IS_ERR(wdev->fck)) {
+		ret = PTR_ERR(wdev->fck);
+		wdev->fck = NULL;
+		goto err_clk;
 	}
 
-	if (cpu_is_omap24xx()) {
-		wdev->mpu_wdt_ick = clk_get(&pdev->dev, "mpu_wdt_ick");
-		if (IS_ERR(wdev->mpu_wdt_ick)) {
-			ret = PTR_ERR(wdev->mpu_wdt_ick);
-			wdev->mpu_wdt_ick = NULL;
-			goto err_clk;
-		}
-		wdev->mpu_wdt_fck = clk_get(&pdev->dev, "mpu_wdt_fck");
-		if (IS_ERR(wdev->mpu_wdt_fck)) {
-			ret = PTR_ERR(wdev->mpu_wdt_fck);
-			wdev->mpu_wdt_fck = NULL;
-			goto err_clk;
-		}
+	wdev->ick = clk_get(&pdev->dev, "iclk");
+	if (IS_ERR(wdev->ick)) {
+		ret = PTR_ERR(wdev->ick);
+		wdev->ick = NULL;
+		goto err_clk;
 	}
 
-	if (cpu_is_omap34xx()) {
-		wdev->mpu_wdt_ick = clk_get(&pdev->dev, "wdt2_ick");
-		if (IS_ERR(wdev->mpu_wdt_ick)) {
-			ret = PTR_ERR(wdev->mpu_wdt_ick);
-			wdev->mpu_wdt_ick = NULL;
-			goto err_clk;
-		}
-		wdev->mpu_wdt_fck = clk_get(&pdev->dev, "wdt2_fck");
-		if (IS_ERR(wdev->mpu_wdt_fck)) {
-			ret = PTR_ERR(wdev->mpu_wdt_fck);
-			wdev->mpu_wdt_fck = NULL;
-			goto err_clk;
-		}
-	}
 	wdev->base = ioremap(res->start, res->end - res->start + 1);
 	if (!wdev->base) {
 		ret = -ENOMEM;
@@ -380,12 +352,10 @@ err_ioremap:
 	wdev->base = NULL;
 
 err_clk:
-	if (wdev->armwdt_ck)
-		clk_put(wdev->armwdt_ck);
-	if (wdev->mpu_wdt_ick)
-		clk_put(wdev->mpu_wdt_ick);
-	if (wdev->mpu_wdt_fck)
-		clk_put(wdev->mpu_wdt_fck);
+	if (wdev->ick)
+		clk_put(wdev->ick);
+	if (wdev->fck)
+		clk_put(wdev->fck);
 	kfree(wdev);
 
 err_kzalloc:
@@ -417,19 +387,14 @@ static int omap_wdt_remove(struct platform_device *pdev)
 	release_mem_region(res->start, res->end - res->start + 1);
 	platform_set_drvdata(pdev, NULL);
 
-	if (wdev->armwdt_ck) {
-		clk_put(wdev->armwdt_ck);
-		wdev->armwdt_ck = NULL;
-	}
-
-	if (wdev->mpu_wdt_ick) {
-		clk_put(wdev->mpu_wdt_ick);
-		wdev->mpu_wdt_ick = NULL;
+	if (wdev->ick) {
+		clk_put(wdev->ick);
+		wdev->ick = NULL;
 	}
 
-	if (wdev->mpu_wdt_fck) {
-		clk_put(wdev->mpu_wdt_fck);
-		wdev->mpu_wdt_fck = NULL;
+	if (wdev->fck) {
+		clk_put(wdev->fck);
+		wdev->fck = NULL;
 	}
 	iounmap(wdev->base);
 
-- 
1.6.0.2.307.gc427

