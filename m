From: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
Subject: [PATCH 2/2] Watchdog: omap_wdt: fix interface clock handling
Date: Tue,  8 Mar 2011 15:06:23 +0200
Message-ID: <1299589583-22632-3-git-send-email-kalle.jokiniemi@nokia.com>
References: <1299589583-22632-1-git-send-email-kalle.jokiniemi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:51317 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753099Ab1CHNI5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Mar 2011 08:08:57 -0500
In-Reply-To: <1299589583-22632-1-git-send-email-kalle.jokiniemi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, tony@atomide.com
Cc: ilkka.koskinen@nokia.com, wim@iguana.be, Kalle Jokiniemi <kalle.jokiniemi@nokia.com>, Atal Shargorodsky <ext-atal.shargorodsky@nokia.com>

Keeping the omap watchdog interface clock always enabled
blocks OMAP CORE power domain from sleeping. Introduce
fine grain clock control to fix the issue.

This patch is based on a patch created by Atal
Shargorodsky: http://lkml.org/lkml/2009/3/10/266.

Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@nokia.com>
Cc: Atal Shargorodsky <ext-atal.shargorodsky@nokia.com>
---
 drivers/watchdog/omap_wdt.c |   22 ++++++++++++++++++++--
 1 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 81e3d61..f74eca2 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -126,6 +126,7 @@ static void omap_wdt_set_timeout(struct omap_wdt_dev *wdev)
 	u32 pre_margin = GET_WLDR_VAL(timer_margin);
 	void __iomem *base = wdev->base;
 
+	clk_enable(wdev->ick);
 	/* just count up at 32 KHz */
 	while (__raw_readl(base + OMAP_WATCHDOG_WPS) & 0x04)
 		cpu_relax();
@@ -133,6 +134,7 @@ static void omap_wdt_set_timeout(struct omap_wdt_dev *wdev)
 	__raw_writel(pre_margin, base + OMAP_WATCHDOG_LDR);
 	while (__raw_readl(base + OMAP_WATCHDOG_WPS) & 0x04)
 		cpu_relax();
+	clk_disable(wdev->ick);
 }
 
 /*
@@ -162,6 +164,7 @@ static int omap_wdt_open(struct inode *inode, struct file *file)
 	omap_wdt_set_timeout(wdev);
 	omap_wdt_ping(wdev); /* trigger loading of new timeout value */
 	omap_wdt_enable(wdev);
+	clk_disable(wdev->ick);
 
 	return nonseekable_open(inode, file);
 }
@@ -175,6 +178,7 @@ static int omap_wdt_release(struct inode *inode, struct file *file)
 	 */
 #ifndef CONFIG_WATCHDOG_NOWAYOUT
 
+	clk_enable(wdev->ick);
 	omap_wdt_disable(wdev);
 
 	clk_disable(wdev->ick);
@@ -194,9 +198,11 @@ static ssize_t omap_wdt_write(struct file *file, const char __user *data,
 
 	/* Refresh LOAD_TIME. */
 	if (len) {
+		clk_enable(wdev->ick);
 		spin_lock(&wdt_lock);
 		omap_wdt_ping(wdev);
 		spin_unlock(&wdt_lock);
+		clk_disable(wdev->ick);
 	}
 	return len;
 }
@@ -228,15 +234,18 @@ static long omap_wdt_ioctl(struct file *file, unsigned int cmd,
 			return put_user(omap_prcm_get_reset_sources(),
 					(int __user *)arg);
 	case WDIOC_KEEPALIVE:
+		clk_enable(wdev->ick);
 		spin_lock(&wdt_lock);
 		omap_wdt_ping(wdev);
 		spin_unlock(&wdt_lock);
+		clk_disable(wdev->ick);
 		return 0;
 	case WDIOC_SETTIMEOUT:
 		if (get_user(new_margin, (int __user *)arg))
 			return -EFAULT;
 		omap_wdt_adjust_timeout(new_margin);
 
+		clk_enable(wdev->ick);
 		spin_lock(&wdt_lock);
 		omap_wdt_disable(wdev);
 		omap_wdt_set_timeout(wdev);
@@ -244,6 +253,7 @@ static long omap_wdt_ioctl(struct file *file, unsigned int cmd,
 
 		omap_wdt_ping(wdev);
 		spin_unlock(&wdt_lock);
+		clk_disable(wdev->ick);
 		/* Fall */
 	case WDIOC_GETTIMEOUT:
 		return put_user(timer_margin, (int __user *)arg);
@@ -371,8 +381,11 @@ static void omap_wdt_shutdown(struct platform_device *pdev)
 {
 	struct omap_wdt_dev *wdev = platform_get_drvdata(pdev);
 
-	if (wdev->omap_wdt_users)
+	if (wdev->omap_wdt_users) {
+		clk_enable(wdev->ick);
 		omap_wdt_disable(wdev);
+		clk_disable(wdev->ick);
+	}
 }
 
 static int __devexit omap_wdt_remove(struct platform_device *pdev)
@@ -409,8 +422,11 @@ static int omap_wdt_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	struct omap_wdt_dev *wdev = platform_get_drvdata(pdev);
 
-	if (wdev->omap_wdt_users)
+	if (wdev->omap_wdt_users) {
+		clk_enable(wdev->ick);
 		omap_wdt_disable(wdev);
+		clk_disable(wdev->ick);
+	}
 
 	return 0;
 }
@@ -420,8 +436,10 @@ static int omap_wdt_resume(struct platform_device *pdev)
 	struct omap_wdt_dev *wdev = platform_get_drvdata(pdev);
 
 	if (wdev->omap_wdt_users) {
+		clk_enable(wdev->ick);
 		omap_wdt_enable(wdev);
 		omap_wdt_ping(wdev);
+		clk_disable(wdev->ick);
 	}
 
 	return 0;
-- 
1.7.1

