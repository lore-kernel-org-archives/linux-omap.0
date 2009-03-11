From: Atal Shargorodsky <ext-atal.shargorodsky@nokia.com>
Subject: [PATCH 4/6] OMAP: omap_wdt: Proper interface clock management.
Date: Wed, 11 Mar 2009 17:29:36 +0200
Message-ID: <0db69821a1be58e0b8889609ff2b2ee272aa3286.1236609434.git.ext-atal.shargorodsky__35519.6363678717$1236785554$gmane$org@nokia.com>
References: <>
 <1236785378-14640-1-git-send-email-ext-atal.shargorodsky@nokia.com>
 <cbbca1e42421e2ada459f0c0881f087977e34eed.1236609434.git.ext-atal.shargorodsky@nokia.com>
 <0fe7f2934f8416e9b5f05e2f18766362560116ee.1236609434.git.ext-atal.shargorodsky@nokia.com>
 <7992fd993e5b420f9c2aac55f6e674169b36c666.1236609434.git.ext-atal.shargorodsky@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:28515 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752645AbZCKPa4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Mar 2009 11:30:56 -0400
In-Reply-To: <7992fd993e5b420f9c2aac55f6e674169b36c666.1236609434.git.ext-atal.shargorodsky@nokia.com>
In-Reply-To: <cbbca1e42421e2ada459f0c0881f087977e34eed.1236609434.git.ext-atal.shargorodsky@nokia.com>
References: <cbbca1e42421e2ada459f0c0881f087977e34eed.1236609434.git.ext-atal.shargorodsky@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.arm.linux.org.uk, Atal Shargorodsky <ext-atal.shargorodsky@nokia.com>

Enable interface clock only when accesssing the hw.

Signed-off-by: Atal Shargorodsky <ext-atal.shargorodsky@nokia.com>
---
 drivers/watchdog/omap_wdt.c |   47 +++++++++++++++++++++++++++++++-----------
 1 files changed, 34 insertions(+), 13 deletions(-)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 1364d7e..d033139 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -83,6 +83,16 @@ static void omap_wdt_ping(struct omap_wdt_dev *wdev)
 	/* reloaded WCRR from WLDR */
 }
 
+static void omap_wdt_ick_enable(struct clk *ick, int enable)
+{
+	if (ick) {
+		if (enable)
+			clk_enable(ick);
+		else
+			clk_disable(ick);
+	}
+}
+
 static void omap_wdt_enable(struct omap_wdt_dev *wdev)
 {
 	void __iomem *base = wdev->base;
@@ -145,9 +155,7 @@ static int omap_wdt_open(struct inode *inode, struct file *file)
 	if (test_and_set_bit(1, (unsigned long *)&(wdev->omap_wdt_users)))
 		return -EBUSY;
 
-	if (wdev->mpu_wdt_ick)
-		clk_enable(wdev->mpu_wdt_ick);
-
+	omap_wdt_ick_enable(wdev->mpu_wdt_ick, 1);
 	clk_enable(wdev->mpu_wdt_fck);
 
 	/* initialize prescaler */
@@ -162,6 +170,7 @@ static int omap_wdt_open(struct inode *inode, struct file *file)
 
 	omap_wdt_set_timeout(wdev);
 	omap_wdt_enable(wdev);
+	omap_wdt_ick_enable(wdev->mpu_wdt_ick, 0);
 
 	return nonseekable_open(inode, file);
 }
@@ -175,10 +184,9 @@ static int omap_wdt_release(struct inode *inode, struct file *file)
 	 */
 #ifndef CONFIG_WATCHDOG_NOWAYOUT
 
+	omap_wdt_ick_enable(wdev->mpu_wdt_ick, 1);
 	omap_wdt_disable(wdev);
-
-	if (wdev->mpu_wdt_ick)
-		clk_disable(wdev->mpu_wdt_ick);
+	omap_wdt_ick_enable(wdev->mpu_wdt_ick, 0);
 
 	clk_disable(wdev->mpu_wdt_fck);
 #else
@@ -196,9 +204,11 @@ static ssize_t omap_wdt_write(struct file *file, const char __user *data,
 
 	/* Refresh LOAD_TIME. */
 	if (len) {
+		omap_wdt_ick_enable(wdev->mpu_wdt_ick, 1);
 		spin_lock(&wdt_lock);
 		omap_wdt_ping(wdev);
 		spin_unlock(&wdt_lock);
+		omap_wdt_ick_enable(wdev->mpu_wdt_ick, 0);
 	}
 	return len;
 }
@@ -230,15 +240,18 @@ static long omap_wdt_ioctl(struct file *file, unsigned int cmd,
 			return put_user(omap_prcm_get_reset_sources(),
 					(int __user *)arg);
 	case WDIOC_KEEPALIVE:
+		omap_wdt_ick_enable(wdev->mpu_wdt_ick, 1);
 		spin_lock(&wdt_lock);
 		omap_wdt_ping(wdev);
 		spin_unlock(&wdt_lock);
+		omap_wdt_ick_enable(wdev->mpu_wdt_ick, 0);
 		return 0;
 	case WDIOC_SETTIMEOUT:
 		if (get_user(new_margin, (int __user *)arg))
 			return -EFAULT;
 		omap_wdt_adjust_timeout(new_margin);
 
+		omap_wdt_ick_enable(wdev->mpu_wdt_ick, 1);
 		spin_lock(&wdt_lock);
 		omap_wdt_disable(wdev);
 		omap_wdt_set_timeout(wdev);
@@ -246,6 +259,7 @@ static long omap_wdt_ioctl(struct file *file, unsigned int cmd,
 
 		omap_wdt_ping(wdev);
 		spin_unlock(&wdt_lock);
+		omap_wdt_ick_enable(wdev->mpu_wdt_ick, 0);
 		/* Fall */
 	case WDIOC_GETTIMEOUT:
 		return put_user(timer_margin, (int __user *)arg);
@@ -344,9 +358,7 @@ static int __init omap_wdt_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, wdev);
 
 	/* enable clocks for register access */
-	if (wdev->mpu_wdt_ick)
-		clk_enable(wdev->mpu_wdt_ick);
-
+	omap_wdt_ick_enable(wdev->mpu_wdt_ick, 1);
 	clk_enable(wdev->mpu_wdt_fck);
 
 	omap_wdt_disable(wdev);
@@ -369,8 +381,7 @@ static int __init omap_wdt_probe(struct platform_device *pdev)
 	__raw_writel(0x01, wdev->base + OMAP_WATCHDOG_SYS_CONFIG);
 
 	/* disable clocks since we don't need them now */
-	if (wdev->mpu_wdt_ick)
-		clk_disable(wdev->mpu_wdt_ick);
+	omap_wdt_ick_enable(wdev->mpu_wdt_ick, 0);
 	clk_disable(wdev->mpu_wdt_fck);
 
 	omap_wdt_dev = pdev;
@@ -378,6 +389,8 @@ static int __init omap_wdt_probe(struct platform_device *pdev)
 	return 0;
 
 err_misc:
+	omap_wdt_ick_enable(wdev->mpu_wdt_ick, 0);
+	clk_disable(wdev->mpu_wdt_fck);
 	platform_set_drvdata(pdev, NULL);
 	iounmap(wdev->base);
 
@@ -404,8 +417,11 @@ static void omap_wdt_shutdown(struct platform_device *pdev)
 {
 	struct omap_wdt_dev *wdev = platform_get_drvdata(pdev);
 
-	if (wdev->omap_wdt_users)
+	if (wdev->omap_wdt_users) {
+		omap_wdt_ick_enable(wdev->mpu_wdt_ick, 1);
 		omap_wdt_disable(wdev);
+		omap_wdt_ick_enable(wdev->mpu_wdt_ick, 0);
+	}
 }
 
 static int omap_wdt_remove(struct platform_device *pdev)
@@ -449,8 +465,11 @@ static int omap_wdt_suspend(struct platform_device *pdev, pm_message_t state)
 {
 	struct omap_wdt_dev *wdev = platform_get_drvdata(pdev);
 
-	if (wdev->omap_wdt_users)
+	if (wdev->omap_wdt_users) {
+		omap_wdt_ick_enable(wdev->mpu_wdt_ick, 1);
 		omap_wdt_disable(wdev);
+		omap_wdt_ick_enable(wdev->mpu_wdt_ick, 0);
+	}
 
 	return 0;
 }
@@ -460,8 +479,10 @@ static int omap_wdt_resume(struct platform_device *pdev)
 	struct omap_wdt_dev *wdev = platform_get_drvdata(pdev);
 
 	if (wdev->omap_wdt_users) {
+		omap_wdt_ick_enable(wdev->mpu_wdt_ick, 1);
 		omap_wdt_enable(wdev);
 		omap_wdt_ping(wdev);
+		omap_wdt_ick_enable(wdev->mpu_wdt_ick, 0);
 	}
 
 	return 0;
-- 
1.5.4.3

