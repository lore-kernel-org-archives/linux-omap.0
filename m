From: felipe.balbi@nokia.com
Subject: [RFC PATCH 24/37] cbus: tahvo: convert to platform_driver
Date: Wed,  7 Apr 2010 19:04:15 +0300
Message-ID: <1270656268-7034-25-git-send-email-felipe.balbi@nokia.com>
References: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:42747 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932570Ab0DGQFW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 12:05:22 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o37G5994030675
	for <linux-omap@vger.kernel.org>; Wed, 7 Apr 2010 19:05:20 +0300
In-Reply-To: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

cleanup a bit and start preparing for splitting
platform_device from platform_driver.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/cbus/tahvo.c |   31 ++++++++++++++++---------------
 1 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
index 9bc3f56..7d49252 100644
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -303,7 +303,7 @@ EXPORT_SYMBOL(tahvo_free_irq);
  * Probe for the Tahvo ASIC and allocate memory
  * for its device-struct if found
  */
-static int __devinit tahvo_probe(struct device *dev)
+static int __devinit tahvo_probe(struct platform_device *pdev)
 {
 	int rev, id, ret;
 
@@ -322,11 +322,11 @@ static int __devinit tahvo_probe(struct device *dev)
 		tahvo_is_betty = 1;
 		tahvo_7bit_backlight = 1;
 	} else {
-		dev_err(dev, "Tahvo/Betty chip not found");
+		dev_err(&pdev->dev, "Tahvo/Betty chip not found");
 		return -ENODEV;
 	}
 
-	dev_err(dev, "%s v%d.%d found\n", tahvo_is_betty ? "Betty" : "Tahvo",
+	dev_err(&pdev->dev, "%s v%d.%d found\n", tahvo_is_betty ? "Betty" : "Tahvo",
 	       (rev >> 4) & 0x0f, rev & 0x0f);
 
 	/* REVISIT: Pass these from board-*.c files in platform_data */
@@ -336,13 +336,13 @@ static int __devinit tahvo_probe(struct device *dev)
 			machine_is_nokia_n810_wimax()) {
 		tahvo_irq_pin = 111;
 	} else {
-		dev_err(dev, "cbus: Unsupported board for tahvo\n");
+		dev_err(&pdev->dev, "cbus: Unsupported board for tahvo\n");
 		return -ENODEV;
 	}
 
 	ret = gpio_request(tahvo_irq_pin, "TAHVO irq");
 	if (ret) {
-		dev_err(dev, "Unable to reserve IRQ GPIO\n");
+		dev_err(&pdev->dev, "Unable to reserve IRQ GPIO\n");
 		return ret;
 	}
 
@@ -358,14 +358,14 @@ static int __devinit tahvo_probe(struct device *dev)
 	ret = request_irq(gpio_to_irq(tahvo_irq_pin), tahvo_irq_handler, 0,
 			  "tahvo", 0);
 	if (ret < 0) {
-		dev_err(dev, "Unable to register IRQ handler\n");
+		dev_err(&pdev->dev, "Unable to register IRQ handler\n");
 		gpio_free(tahvo_irq_pin);
 		return ret;
 	}
 #ifdef CONFIG_CBUS_TAHVO_USER
 	/* Initialize user-space interface */
 	if (tahvo_user_init() < 0) {
-		dev_err(dev, "Unable to initialize driver\n");
+		dev_err(&pdev->dev, "Unable to initialize driver\n");
 		free_irq(gpio_to_irq(tahvo_irq_pin), 0);
 		gpio_free(tahvo_irq_pin);
 		return ret;
@@ -374,7 +374,7 @@ static int __devinit tahvo_probe(struct device *dev)
 	return 0;
 }
 
-static int tahvo_remove(struct device *dev)
+static int __devexit tahvo_remove(struct platform_device *pdev)
 {
 #ifdef CONFIG_CBUS_TAHVO_USER
 	tahvo_user_cleanup();
@@ -393,11 +393,12 @@ static void tahvo_device_release(struct device *dev)
 	complete(&device_release);
 }
 
-static struct device_driver tahvo_driver = {
-	.name		= "tahvo",
-	.bus		= &platform_bus_type,
+static struct platform_driver tahvo_driver = {
 	.probe		= tahvo_probe,
-	.remove		= tahvo_remove,
+	.remove		= __devexit_p(tahvo_remove),
+	.driver		= {
+		.name	= "tahvo",
+	},
 };
 
 static struct platform_device tahvo_device = {
@@ -423,13 +424,13 @@ static int __init tahvo_init(void)
 
 	init_completion(&device_release);
 
-	ret = driver_register(&tahvo_driver);
+	ret = platform_driver_register(&tahvo_driver);
 	if (ret)
 		return ret;
 
 	ret = platform_device_register(&tahvo_device);
 	if (ret) {
-		driver_unregister(&tahvo_driver);
+		platform_driver_unregister(&tahvo_driver);
 		return ret;
 	}
 	return 0;
@@ -441,7 +442,7 @@ static int __init tahvo_init(void)
 static void __exit tahvo_exit(void)
 {
 	platform_device_unregister(&tahvo_device);
-	driver_unregister(&tahvo_driver);
+	platform_driver_unregister(&tahvo_driver);
 	wait_for_completion(&device_release);
 }
 
-- 
1.7.0.rc0.33.g7c3932

