From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 1/3] watchdog: sync mainline changes
Date: Tue, 23 Sep 2008 14:33:49 +0300
Message-ID: <1222169631-24556-2-git-send-email-felipe.balbi@nokia.com>
References: <1222169631-24556-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:35139 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbYIWLe0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Sep 2008 07:34:26 -0400
In-Reply-To: <1222169631-24556-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>, Felipe Balbi <felipe.balbi@nokia.com>

Some changes to omap_wdt.c were lost due to, probably,
mis-merges and developers working separately on
linux-omap and mainline.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/watchdog/omap_wdt.c |   43 +++++++++++++++++++++++++++----------------
 1 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index b111dec..12b0771 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -40,11 +40,10 @@
 #include <linux/moduleparam.h>
 #include <linux/clk.h>
 
-#include <asm/io.h>
-#include <asm/uaccess.h>
+#include <linux/bitops.h>
+#include <linux/io.h>
+#include <linux/uaccess.h>
 #include <mach/hardware.h>
-#include <asm/bitops.h>
-
 #include <mach/prcm.h>
 
 #include "omap_wdt.h"
@@ -56,6 +55,8 @@ module_param(timer_margin, uint, 0);
 MODULE_PARM_DESC(timer_margin, "initial watchdog timeout (in seconds)");
 
 static unsigned int wdt_trgr_pattern = 0x1234;
+static spinlock_t wdt_lock;
+
 struct omap_wdt_dev {
 	void __iomem    *base;          /* physical */
 	struct device   *dev;
@@ -190,25 +191,26 @@ static int omap_wdt_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static ssize_t
-omap_wdt_write(struct file *file, const char __user *data,
+static ssize_t omap_wdt_write(struct file *file, const char __user *data,
 		size_t len, loff_t *ppos)
 {
 	struct omap_wdt_dev *wdev;
 	wdev = file->private_data;
 	/* Refresh LOAD_TIME. */
-	if (len)
+	if (len) {
+		spin_lock(&wdt_lock);
 		omap_wdt_ping(wdev);
+		spin_unlock(&wdt_lock);
+	}
 	return len;
 }
 
-static int
-omap_wdt_ioctl(struct inode *inode, struct file *file,
-	unsigned int cmd, unsigned long arg)
+static long omap_wdt_ioctl(struct file *file, unsigned int cmd,
+						unsigned long arg)
 {
 	struct omap_wdt_dev *wdev;
 	int new_margin;
-	static struct watchdog_info ident = {
+	static const struct watchdog_info ident = {
 		.identity = "OMAP Watchdog",
 		.options = WDIOF_SETTIMEOUT,
 		.firmware_version = 0,
@@ -216,8 +218,6 @@ omap_wdt_ioctl(struct inode *inode, struct file *file,
 	wdev = file->private_data;
 
 	switch (cmd) {
-	default:
-		return -ENOTTY;
 	case WDIOC_GETSUPPORT:
 		return copy_to_user((struct watchdog_info __user *)arg, &ident,
 				sizeof(ident));
@@ -231,21 +231,27 @@ omap_wdt_ioctl(struct inode *inode, struct file *file,
 			return put_user(omap_prcm_get_reset_sources(),
 					(int __user *)arg);
 	case WDIOC_KEEPALIVE:
+		spin_lock(&wdt_lock);
 		omap_wdt_ping(wdev);
+		spin_unlock(&wdt_lock);
 		return 0;
 	case WDIOC_SETTIMEOUT:
 		if (get_user(new_margin, (int __user *)arg))
 			return -EFAULT;
 		omap_wdt_adjust_timeout(new_margin);
 
+		spin_lock(&wdt_lock);
 		omap_wdt_disable(wdev);
 		omap_wdt_set_timeout(wdev);
 		omap_wdt_enable(wdev);
 
 		omap_wdt_ping(wdev);
+		spin_unlock(&wdt_lock);
 		/* Fall */
 	case WDIOC_GETTIMEOUT:
 		return put_user(timer_margin, (int __user *)arg);
+	default:
+		return -ENOTTY;
 	}
 	return 0;
 }
@@ -253,7 +259,7 @@ omap_wdt_ioctl(struct inode *inode, struct file *file,
 static const struct file_operations omap_wdt_fops = {
 	.owner = THIS_MODULE,
 	.write = omap_wdt_write,
-	.ioctl = omap_wdt_ioctl,
+	.unlocked_ioctl = omap_wdt_ioctl,
 	.open = omap_wdt_open,
 	.release = omap_wdt_release,
 };
@@ -362,7 +368,7 @@ fail:
 		kfree(wdev);
 	}
 	if (mem) {
-		release_resource(mem);
+		release_mem_region(res->start, res->end - res->start + 1);
 	}
 	return ret;
 }
@@ -380,9 +386,13 @@ static int omap_wdt_remove(struct platform_device *pdev)
 {
 	struct omap_wdt_dev *wdev;
 	wdev = platform_get_drvdata(pdev);
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	if (!res)
+		return -ENOENT;
 
 	misc_deregister(&(wdev->omap_wdt_miscdev));
-	release_resource(wdev->mem);
+	release_mem_region(res->start, res->end - res->start + 1);
 	platform_set_drvdata(pdev, NULL);
 	if (wdev->armwdt_ck) {
 		clk_put(wdev->armwdt_ck);
@@ -448,6 +458,7 @@ static struct platform_driver omap_wdt_driver = {
 
 static int __init omap_wdt_init(void)
 {
+	spin_lock_init(&wdt_lock);
 	return platform_driver_register(&omap_wdt_driver);
 }
 
-- 
1.6.0.1.308.gede4c

