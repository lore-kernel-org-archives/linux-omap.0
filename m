From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 11/24] omap4: clocks: Make watchdog driver's clock calls OMAP4 compatible
Date: Tue, 16 Feb 2010 21:28:02 +0530
Message-ID: <1266335895-32741-11-git-send-email-santosh.shilimkar@ti.com>
References: <1266335895-32741-1-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-2-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-3-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-4-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-5-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-6-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-7-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-8-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-9-git-send-email-santosh.shilimkar@ti.com>
 <1266335895-32741-10-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54299 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757015Ab0BPP6d (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Feb 2010 10:58:33 -0500
In-Reply-To: <1266335895-32741-10-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, ben@fluff.org.uk, sameo@linux.intel.com, lrg@slimlogic.co.uk, paul@pwsan.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Abhijit Pagare <abhijitpagare@ti.com>

The watchdog driver has been adapted for the OMAP4 way of clock calls.
In OMAP4, WDT iclk are hw controlled and no sw control is available

Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
---
 drivers/watchdog/omap_wdt.c |   39 +++++++++++++++++++++++++++------------
 1 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index c6aaf28..df9f714 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -145,7 +145,9 @@ static int omap_wdt_open(struct inode *inode, struct file *file)
 	if (test_and_set_bit(1, (unsigned long *)&(wdev->omap_wdt_users)))
 		return -EBUSY;
 
-	clk_enable(wdev->ick);    /* Enable the interface clock */
+	/* OMAP4 iclk are hw controlled and no sw control is available */
+	if (!cpu_is_omap44xx())
+		clk_enable(wdev->ick);    /* Enable the interface clock */
 	clk_enable(wdev->fck);    /* Enable the functional clock */
 
 	/* initialize prescaler */
@@ -176,7 +178,9 @@ static int omap_wdt_release(struct inode *inode, struct file *file)
 
 	omap_wdt_disable(wdev);
 
-	clk_disable(wdev->ick);
+	/* OMAP4 iclk are hw controlled and no sw control is available */
+	if (!cpu_is_omap44xx())
+		clk_disable(wdev->ick);
 	clk_disable(wdev->fck);
 #else
 	printk(KERN_CRIT "omap_wdt: Unexpected close, not stopping!\n");
@@ -292,11 +296,14 @@ static int __devinit omap_wdt_probe(struct platform_device *pdev)
 	wdev->omap_wdt_users = 0;
 	wdev->mem = mem;
 
-	wdev->ick = clk_get(&pdev->dev, "ick");
-	if (IS_ERR(wdev->ick)) {
-		ret = PTR_ERR(wdev->ick);
-		wdev->ick = NULL;
-		goto err_clk;
+	/* OMAP4 iclk are hw controlled and no sw control is available */
+	if (!cpu_is_omap44xx()) {
+		wdev->ick = clk_get(&pdev->dev, "ick");
+		if (IS_ERR(wdev->ick)) {
+			ret = PTR_ERR(wdev->ick);
+			wdev->ick = NULL;
+			goto err_clk;
+		}
 	}
 	wdev->fck = clk_get(&pdev->dev, "fck");
 	if (IS_ERR(wdev->fck)) {
@@ -313,7 +320,9 @@ static int __devinit omap_wdt_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, wdev);
 
-	clk_enable(wdev->ick);
+	/* OMAP4 iclk are hw controlled and no sw control is available */
+	if (!cpu_is_omap44xx())
+		clk_enable(wdev->ick);
 	clk_enable(wdev->fck);
 
 	omap_wdt_disable(wdev);
@@ -335,7 +344,9 @@ static int __devinit omap_wdt_probe(struct platform_device *pdev)
 	/* autogate OCP interface clock */
 	__raw_writel(0x01, wdev->base + OMAP_WATCHDOG_SYS_CONFIG);
 
-	clk_disable(wdev->ick);
+	/* OMAP4 iclk are hw controlled and no sw control is available */
+	if (!cpu_is_omap44xx())
+		clk_disable(wdev->ick);
 	clk_disable(wdev->fck);
 
 	omap_wdt_dev = pdev;
@@ -350,8 +361,10 @@ err_ioremap:
 	wdev->base = NULL;
 
 err_clk:
-	if (wdev->ick)
-		clk_put(wdev->ick);
+	/* OMAP4 iclk are hw controlled and no sw control is available */
+	if (!cpu_is_omap44xx())
+		if (wdev->ick)
+			clk_put(wdev->ick);
 	if (wdev->fck)
 		clk_put(wdev->fck);
 	kfree(wdev);
@@ -385,7 +398,9 @@ static int __devexit omap_wdt_remove(struct platform_device *pdev)
 	release_mem_region(res->start, resource_size(res));
 	platform_set_drvdata(pdev, NULL);
 
-	clk_put(wdev->ick);
+	/* OMAP4 iclk are hw controlled and no sw control is available */
+	if (!cpu_is_omap44xx())
+		clk_put(wdev->ick);
 	clk_put(wdev->fck);
 	iounmap(wdev->base);
 
-- 
1.6.0.4

