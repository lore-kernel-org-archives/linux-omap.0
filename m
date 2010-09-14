From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/PATCH 5/8] cbus: tahvo: usb: convert to platform_driver
Date: Tue, 14 Sep 2010 11:30:13 +0300
Message-ID: <1284453016-8295-6-git-send-email-balbi@ti.com>
References: <1284453016-8295-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46593 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753284Ab0INIad (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Sep 2010 04:30:33 -0400
In-Reply-To: <1284453016-8295-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>

tahvo-usb was already using a platform_device,
now also convert device_driver into platform_driver.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/tahvo-usb.c |   49 +++++++++++++++++++++++----------------------
 1 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/cbus/tahvo-usb.c b/drivers/cbus/tahvo-usb.c
index 9dc04ad..1cb81fd 100644
--- a/drivers/cbus/tahvo-usb.c
+++ b/drivers/cbus/tahvo-usb.c
@@ -188,11 +188,11 @@ static int tahvo_otg_init(void)
 	return 0;
 }
 
-static int omap_otg_probe(struct device *dev)
+static int __init omap_otg_probe(struct platform_device *pdev)
 {
 	int ret;
 
-	tahvo_otg_dev = to_platform_device(dev);
+	tahvo_otg_dev = pdev;
 	ret = tahvo_otg_init();
 	if (ret != 0) {
 		printk(KERN_ERR "tahvo-usb: tahvo_otg_init failed\n");
@@ -204,7 +204,7 @@ static int omap_otg_probe(struct device *dev)
 			   &tahvo_usb_device);
 }
 
-static int omap_otg_remove(struct device *dev)
+static int __exit omap_otg_remove(struct platform_device *pdev)
 {
 	free_irq(tahvo_otg_dev->resource[1].start, &tahvo_usb_device);
 	tahvo_otg_dev = NULL;
@@ -212,11 +212,11 @@ static int omap_otg_remove(struct device *dev)
 	return 0;
 }
 
-struct device_driver omap_otg_driver = {
-	.name		= "omap_otg",
-	.bus		= &platform_bus_type,
-	.probe		= omap_otg_probe,
-	.remove		= omap_otg_remove,
+struct platform_driver omap_otg_driver = {
+	.driver		= {
+		.name	= "omap_otg",
+	},
+	.remove		= __exit_p(omap_otg_remove),
 };
 
 /*
@@ -643,9 +643,10 @@ static ssize_t otg_mode_store(struct device *device,
 static DEVICE_ATTR(otg_mode, 0644, otg_mode_show, otg_mode_store);
 #endif
 
-static int tahvo_usb_probe(struct device *dev)
+static int __init tahvo_usb_probe(struct platform_device *pdev)
 {
 	struct tahvo_usb *tu;
+	struct device *dev = &pdev->dev;
 	int ret;
 
 	ret = tahvo_get_status();
@@ -720,25 +721,25 @@ static int tahvo_usb_probe(struct device *dev)
 	return 0;
 }
 
-static int tahvo_usb_remove(struct device *dev)
+static int __exit tahvo_usb_remove(struct platform_device *pdev)
 {
-	dev_dbg(dev, "remove\n");
+	dev_dbg(&pdev->dev, "remove\n");
 
 	tahvo_free_irq(TAHVO_INT_VBUSON);
 	flush_scheduled_work();
 	otg_set_transceiver(0);
-	device_remove_file(dev, &dev_attr_vbus_state);
+	device_remove_file(&pdev->dev, &dev_attr_vbus_state);
 #ifdef CONFIG_USB_OTG
-	device_remove_file(dev, &dev_attr_otg_mode);
+	device_remove_file(&pdev->dev, &dev_attr_otg_mode);
 #endif
 	return 0;
 }
 
-static struct device_driver tahvo_usb_driver = {
-	.name		= "tahvo-usb",
-	.bus		= &platform_bus_type,
-	.probe		= tahvo_usb_probe,
-	.remove		= tahvo_usb_remove,
+static struct platform_driver tahvo_usb_driver = {
+	.driver		= {
+		.name	= "tahvo-usb",
+	},
+	.remove		= __exit_p(tahvo_usb_remove),
 };
 
 static struct platform_device tahvo_usb_device = {
@@ -751,18 +752,18 @@ static int __init tahvo_usb_init(void)
 	int ret = 0;
 
 	printk(KERN_INFO "Tahvo USB transceiver driver initializing\n");
-	ret = driver_register(&tahvo_usb_driver);
+	ret = platform_driver_probe(&tahvo_usb_driver, tahvo_usb_probe);
 	if (ret)
 		return ret;
 	ret = platform_device_register(&tahvo_usb_device);
 	if (ret < 0) {
-		driver_unregister(&tahvo_usb_driver);
+		platform_driver_unregister(&tahvo_usb_driver);
 		return ret;
 	}
-	ret = driver_register(&omap_otg_driver);
+	ret = platform_driver_probe(&omap_otg_driver, omap_otg_probe);
 	if (ret) {
 		platform_device_unregister(&tahvo_usb_device);
-		driver_unregister(&tahvo_usb_driver);
+		platform_driver_unregister(&tahvo_usb_driver);
 		return ret;
 	}
 	return 0;
@@ -772,9 +773,9 @@ subsys_initcall(tahvo_usb_init);
 
 static void __exit tahvo_usb_exit(void)
 {
-	driver_unregister(&omap_otg_driver);
+	platform_driver_unregister(&omap_otg_driver);
 	platform_device_unregister(&tahvo_usb_device);
-	driver_unregister(&tahvo_usb_driver);
+	platform_driver_unregister(&tahvo_usb_driver);
 }
 module_exit(tahvo_usb_exit);
 
-- 
1.7.3.rc0.35.g8ac8c

