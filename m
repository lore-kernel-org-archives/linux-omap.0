From: felipe.balbi@nokia.com
Subject: [RFC PATCH 37/37] cbus: retu-wdt: misc cleanup on retu-wdt driver
Date: Wed,  7 Apr 2010 19:04:28 +0300
Message-ID: <1270656268-7034-38-git-send-email-felipe.balbi@nokia.com>
References: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:42778 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932693Ab0DGQFm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 12:05:42 -0400
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o37G5XCD030894
	for <linux-omap@vger.kernel.org>; Wed, 7 Apr 2010 19:05:40 +0300
In-Reply-To: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

a trivial cleanup on the driver. No functional changes.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/cbus/retu-wdt.c |   25 +++++++++++--------------
 1 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/drivers/cbus/retu-wdt.c b/drivers/cbus/retu-wdt.c
index 53bec32..1014165 100644
--- a/drivers/cbus/retu-wdt.c
+++ b/drivers/cbus/retu-wdt.c
@@ -225,7 +225,7 @@ static int retu_wdt_ioctl(struct inode *inode, struct file *file,
 }
 
 /* Start kicking retu watchdog until user space starts doing the kicking */
-static int __init retu_wdt_ping(void)
+static int __devinit retu_wdt_ping(void)
 {
 	int r;
 
@@ -243,11 +243,11 @@ static int __init retu_wdt_ping(void)
 }
 
 static const struct file_operations retu_wdt_fops = {
-	.owner = THIS_MODULE,
-	.write = retu_wdt_write,
-	.ioctl = retu_wdt_ioctl,
-	.open = retu_wdt_open,
-	.release = retu_wdt_release,
+	.owner		= THIS_MODULE,
+	.write		= retu_wdt_write,
+	.ioctl		= retu_wdt_ioctl,
+	.open		= retu_wdt_open,
+	.release	= retu_wdt_release,
 };
 
 /*----------------------------------------------------------------------------*/
@@ -269,15 +269,13 @@ static int __devinit retu_wdt_probe(struct platform_device *pdev)
 
 	ret = device_create_file(&pdev->dev, &dev_attr_period);
 	if (ret) {
-		printk(KERN_ERR "retu_wdt_probe: Error creating "
-					"sys device file: period\n");
+		dev_err(&pdev->dev, "Error creating sysfs period\n");
 		goto free1;
 	}
 
 	ret = device_create_file(&pdev->dev, &dev_attr_counter);
 	if (ret) {
-		printk(KERN_ERR "retu_wdt_probe: Error creating "
-					"sys device file: counter\n");
+		dev_err(&pdev->dev, "Error creating sysfs counter\n");
 		goto free2;
 	}
 
@@ -298,8 +296,7 @@ static int __devinit retu_wdt_probe(struct platform_device *pdev)
 	ret = retu_modify_counter(counter_param);
 	if (ret == -EINVAL) {
 		ret = retu_modify_counter(RETU_WDT_DEFAULT_TIMER);
-		printk(KERN_INFO
-		       "retu_wdt_init: Intializing to default value\n");
+		dev_dbg(&pdev->dev, "Initializing to default value\n");
 	}
 
 	/* Kick the watchdog for kernel booting to finish */
@@ -307,7 +304,7 @@ static int __devinit retu_wdt_probe(struct platform_device *pdev)
 
 	ret = retu_wdt_ping();
 	if (ret < 0) {
-		printk(KERN_INFO "retu_wdt_init: Failed to ping\n");
+		dev_err(&pdev->dev, "Failed to ping\n");
 		goto free4;
 	}
 
@@ -333,7 +330,7 @@ static int __devexit retu_wdt_remove(struct platform_device *pdev)
 	struct retu_wdt_dev *wdev;
 
 	wdev = platform_get_drvdata(pdev);
-	misc_deregister(&(wdev->retu_wdt_miscdev));
+	misc_deregister(&wdev->retu_wdt_miscdev);
 	device_remove_file(&pdev->dev, &dev_attr_period);
 	device_remove_file(&pdev->dev, &dev_attr_counter);
 	kfree(wdev);
-- 
1.7.0.rc0.33.g7c3932

