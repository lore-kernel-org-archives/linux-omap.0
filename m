From: felipe.balbi@nokia.com
Subject: [RFC PATCH 36/37] cbus: retu-wtd: convert to platform_driver
Date: Wed,  7 Apr 2010 19:04:27 +0300
Message-ID: <1270656268-7034-37-git-send-email-felipe.balbi@nokia.com>
References: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:42772 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932892Ab0DGQFi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 12:05:38 -0400
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o37G5XC5030894
	for <linux-omap@vger.kernel.org>; Wed, 7 Apr 2010 19:05:36 +0300
In-Reply-To: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

trivial patch converting a device_driver into
platform_driver.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/cbus/retu-wdt.c |   77 +++++++++++++++++++++++++----------------------
 1 files changed, 41 insertions(+), 36 deletions(-)

diff --git a/drivers/cbus/retu-wdt.c b/drivers/cbus/retu-wdt.c
index 763b34f..53bec32 100644
--- a/drivers/cbus/retu-wdt.c
+++ b/drivers/cbus/retu-wdt.c
@@ -252,34 +252,38 @@ static const struct file_operations retu_wdt_fops = {
 
 /*----------------------------------------------------------------------------*/
 
-static int __devinit retu_wdt_probe(struct device *dev)
+static int __devinit retu_wdt_probe(struct platform_device *pdev)
 {
 	struct retu_wdt_dev *wdev;
 	int ret;
 
+	ret = retu_get_status();
+	if (!ret)
+		return -ENODEV;
+
 	wdev = kzalloc(sizeof(struct retu_wdt_dev), GFP_KERNEL);
 	if (!wdev)
 		return -ENOMEM;
 
 	wdev->users = 0;
 
-	ret = device_create_file(dev, &dev_attr_period);
+	ret = device_create_file(&pdev->dev, &dev_attr_period);
 	if (ret) {
 		printk(KERN_ERR "retu_wdt_probe: Error creating "
 					"sys device file: period\n");
 		goto free1;
 	}
 
-	ret = device_create_file(dev, &dev_attr_counter);
+	ret = device_create_file(&pdev->dev, &dev_attr_counter);
 	if (ret) {
 		printk(KERN_ERR "retu_wdt_probe: Error creating "
 					"sys device file: counter\n");
 		goto free2;
 	}
 
-	dev_set_drvdata(dev, wdev);
+	platform_set_drvdata(pdev, wdev);
 	retu_wdt = wdev;
-	wdev->retu_wdt_miscdev.parent = dev;
+	wdev->retu_wdt_miscdev.parent = &pdev->dev;
 	wdev->retu_wdt_miscdev.minor = WATCHDOG_MINOR;
 	wdev->retu_wdt_miscdev.name = "watchdog";
 	wdev->retu_wdt_miscdev.fops = &retu_wdt_fops;
@@ -290,68 +294,69 @@ static int __devinit retu_wdt_probe(struct device *dev)
 
 	setup_timer(&wdev->ping_timer, retu_wdt_set_ping_timer, 1);
 
+	/* passed as module parameter? */
+	ret = retu_modify_counter(counter_param);
+	if (ret == -EINVAL) {
+		ret = retu_modify_counter(RETU_WDT_DEFAULT_TIMER);
+		printk(KERN_INFO
+		       "retu_wdt_init: Intializing to default value\n");
+	}
+
 	/* Kick the watchdog for kernel booting to finish */
 	retu_modify_counter(RETU_WDT_MAX_TIMER);
 
+	ret = retu_wdt_ping();
+	if (ret < 0) {
+		printk(KERN_INFO "retu_wdt_init: Failed to ping\n");
+		goto free4;
+	}
+
 	return 0;
 
+free4:
+	misc_deregister(&wdev->retu_wdt_miscdev);
+
 free3:
-	device_remove_file(dev, &dev_attr_counter);
+	device_remove_file(&pdev->dev, &dev_attr_counter);
 
 free2:
-	device_remove_file(dev, &dev_attr_period);
+	device_remove_file(&pdev->dev, &dev_attr_period);
+
 free1:
 	kfree(wdev);
 
 	return ret;
 }
 
-static int __devexit retu_wdt_remove(struct device *dev)
+static int __devexit retu_wdt_remove(struct platform_device *pdev)
 {
 	struct retu_wdt_dev *wdev;
 
-	wdev = dev_get_drvdata(dev);
+	wdev = platform_get_drvdata(pdev);
 	misc_deregister(&(wdev->retu_wdt_miscdev));
-	device_remove_file(dev, &dev_attr_period);
-	device_remove_file(dev, &dev_attr_counter);
+	device_remove_file(&pdev->dev, &dev_attr_period);
+	device_remove_file(&pdev->dev, &dev_attr_counter);
 	kfree(wdev);
 
 	return 0;
 }
 
-static struct device_driver retu_wdt_driver = {
-	.name = "retu-wdt",
-	.bus = &platform_bus_type,
-	.probe = retu_wdt_probe,
-	.remove = __devexit_p(retu_wdt_remove),
+static struct platform_driver retu_wdt_driver = {
+	.probe		= retu_wdt_probe,
+	.remove		= __devexit_p(retu_wdt_remove),
+	.driver		= {
+		.name	= "retu-wdt",
+	},
 };
 
 static int __init retu_wdt_init(void)
 {
-	int ret;
-
-	ret = retu_get_status();
-	if (!ret)
-		return -ENODEV;
-
-	ret = driver_register(&retu_wdt_driver);
-	if (ret)
-		return ret;
-
-	/* passed as module parameter? */
-	ret = retu_modify_counter(counter_param);
-	if (ret == -EINVAL) {
-		ret = retu_modify_counter(RETU_WDT_DEFAULT_TIMER);
-		printk(KERN_INFO
-		       "retu_wdt_init: Intializing to default value\n");
-	}
-
-	return retu_wdt_ping();
+	return platform_driver_register(&retu_wdt_driver);
 }
 
 static void __exit retu_wdt_exit(void)
 {
-	driver_unregister(&retu_wdt_driver);
+	platform_driver_unregister(&retu_wdt_driver);
 }
 
 module_init(retu_wdt_init);
-- 
1.7.0.rc0.33.g7c3932

