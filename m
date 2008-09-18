From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH] watchdog: another ioremap() fix
Date: Thu, 18 Sep 2008 16:55:46 +0300
Message-ID: <1221746146-18252-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:58375 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107AbYIROBN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Sep 2008 10:01:13 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: gdavis@mvista.com, Tony Lindgren <tony@atomide.com>, Russel King <rmk@dyn-67.arm.linux.org.uk>, Felipe Balbi <felipe.balbi@nokia.com>

convert to use ioremap() and __raw_{read/write} friends.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/watchdog/omap_wdt.c |   52 +++++++++++++++++++++++++-----------------
 1 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index b111dec..e395743 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -71,12 +71,12 @@ static void omap_wdt_ping(struct omap_wdt_dev *wdev)
 {
 	void __iomem    *base = wdev->base;
 	/* wait for posted write to complete */
-	while ((omap_readl(base + OMAP_WATCHDOG_WPS)) & 0x08)
+	while ((__raw_readl(base + OMAP_WATCHDOG_WPS)) & 0x08)
 		cpu_relax();
 	wdt_trgr_pattern = ~wdt_trgr_pattern;
-	omap_writel(wdt_trgr_pattern, (base + OMAP_WATCHDOG_TGR));
+	__raw_writel(wdt_trgr_pattern, (base + OMAP_WATCHDOG_TGR));
 	/* wait for posted write to complete */
-	while ((omap_readl(base + OMAP_WATCHDOG_WPS)) & 0x08)
+	while ((__raw_readl(base + OMAP_WATCHDOG_WPS)) & 0x08)
 		cpu_relax();
 	/* reloaded WCRR from WLDR */
 }
@@ -86,11 +86,11 @@ static void omap_wdt_enable(struct omap_wdt_dev *wdev)
 	void __iomem *base;
 	base = wdev->base;
 	/* Sequence to enable the watchdog */
-	omap_writel(0xBBBB, base + OMAP_WATCHDOG_SPR);
-	while ((omap_readl(base + OMAP_WATCHDOG_WPS)) & 0x10)
+	__raw_writel(0xBBBB, base + OMAP_WATCHDOG_SPR);
+	while ((__raw_readl(base + OMAP_WATCHDOG_WPS)) & 0x10)
 		cpu_relax();
-	omap_writel(0x4444, base + OMAP_WATCHDOG_SPR);
-	while ((omap_readl(base + OMAP_WATCHDOG_WPS)) & 0x10)
+	__raw_writel(0x4444, base + OMAP_WATCHDOG_SPR);
+	while ((__raw_readl(base + OMAP_WATCHDOG_WPS)) & 0x10)
 		cpu_relax();
 }
 
@@ -99,11 +99,11 @@ static void omap_wdt_disable(struct omap_wdt_dev *wdev)
 	void __iomem *base;
 	base = wdev->base;
 	/* sequence required to disable watchdog */
-	omap_writel(0xAAAA, base + OMAP_WATCHDOG_SPR);	/* TIMER_MODE */
-	while (omap_readl(base + OMAP_WATCHDOG_WPS) & 0x10)
+	__raw_writel(0xAAAA, base + OMAP_WATCHDOG_SPR);	/* TIMER_MODE */
+	while (__raw_readl(base + OMAP_WATCHDOG_WPS) & 0x10)
 		cpu_relax();
-	omap_writel(0x5555, base + OMAP_WATCHDOG_SPR);	/* TIMER_MODE */
-	while (omap_readl(base + OMAP_WATCHDOG_WPS) & 0x10)
+	__raw_writel(0x5555, base + OMAP_WATCHDOG_SPR);	/* TIMER_MODE */
+	while (__raw_readl(base + OMAP_WATCHDOG_WPS) & 0x10)
 		cpu_relax();
 }
 
@@ -123,10 +123,10 @@ static void omap_wdt_set_timeout(struct omap_wdt_dev *wdev)
 	base = wdev->base;
 
 	/* just count up at 32 KHz */
-	while (omap_readl(base + OMAP_WATCHDOG_WPS) & 0x04)
+	while (__raw_readl(base + OMAP_WATCHDOG_WPS) & 0x04)
 		cpu_relax();
-	omap_writel(pre_margin, base + OMAP_WATCHDOG_LDR);
-	while (omap_readl(base + OMAP_WATCHDOG_WPS) & 0x04)
+	__raw_writel(pre_margin, base + OMAP_WATCHDOG_LDR);
+	while (__raw_readl(base + OMAP_WATCHDOG_WPS) & 0x04)
 		cpu_relax();
 }
 
@@ -152,10 +152,10 @@ static int omap_wdt_open(struct inode *inode, struct file *file)
 	}
 
 	/* initialize prescaler */
-	while (omap_readl(base + OMAP_WATCHDOG_WPS) & 0x01)
+	while (__raw_readl(base + OMAP_WATCHDOG_WPS) & 0x01)
 		cpu_relax();
-	omap_writel((1 << 5) | (PTV << 2), base + OMAP_WATCHDOG_CNTRL);
-	while (omap_readl(base + OMAP_WATCHDOG_WPS) & 0x01)
+	__raw_writel((1 << 5) | (PTV << 2), base + OMAP_WATCHDOG_CNTRL);
+	while (__raw_readl(base + OMAP_WATCHDOG_WPS) & 0x01)
 		cpu_relax();
 
 	file->private_data = (void *) wdev;
@@ -225,7 +225,7 @@ omap_wdt_ioctl(struct inode *inode, struct file *file,
 		return put_user(0, (int __user *)arg);
 	case WDIOC_GETBOOTSTATUS:
 		if (cpu_is_omap16xx())
-			return put_user(omap_readw(ARM_SYSST),
+			return put_user(__raw_readw(ARM_SYSST),
 					(int __user *)arg);
 		if (cpu_is_omap24xx())
 			return put_user(omap_prcm_get_reset_sources(),
@@ -324,7 +324,12 @@ static int __init omap_wdt_probe(struct platform_device *pdev)
 			goto fail;
 		}
 	}
-	wdev->base = (void __iomem *) (mem->start);
+	wdev->base = ioremap(res->start, res->end - res->start + 1);
+	if (!wdev->base) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+
 	platform_set_drvdata(pdev, wdev);
 
 	omap_wdt_disable(wdev);
@@ -340,11 +345,11 @@ static int __init omap_wdt_probe(struct platform_device *pdev)
 		goto fail;
 
 	pr_info("OMAP Watchdog Timer Rev 0x%02x: initial timeout %d sec\n",
-		omap_readl(wdev->base + OMAP_WATCHDOG_REV) & 0xFF,
+		__raw_readl(wdev->base + OMAP_WATCHDOG_REV) & 0xFF,
 		timer_margin);
 
 	/* autogate OCP interface clock */
-	omap_writel(0x01, wdev->base + OMAP_WATCHDOG_SYS_CONFIG);
+	__raw_writel(0x01, wdev->base + OMAP_WATCHDOG_SYS_CONFIG);
 
 	omap_wdt_dev = pdev;
 
@@ -359,6 +364,8 @@ fail:
 			clk_put(wdev->mpu_wdt_ick);
 		if (wdev->mpu_wdt_fck)
 			clk_put(wdev->mpu_wdt_fck);
+		if (wdev->base)
+			iounmap(wdev->base);
 		kfree(wdev);
 	}
 	if (mem) {
@@ -396,6 +403,9 @@ static int omap_wdt_remove(struct platform_device *pdev)
 		clk_put(wdev->mpu_wdt_fck);
 		wdev->mpu_wdt_fck = NULL;
 	}
+	if (wdev->base)
+		iounmap(wdev->base);
+
 	kfree(wdev);
 	omap_wdt_dev = NULL;
 	return 0;
-- 
1.6.0.1.308.gede4c

