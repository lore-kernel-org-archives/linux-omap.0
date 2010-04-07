From: felipe.balbi@nokia.com
Subject: [RFC PATCH 19/37] cbus: retu: convert to a platform_driver
Date: Wed,  7 Apr 2010 19:04:10 +0300
Message-ID: <1270656268-7034-20-git-send-email-felipe.balbi@nokia.com>
References: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62331 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932570Ab0DGQFU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 12:05:20 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o37G56B2007315
	for <linux-omap@vger.kernel.org>; Wed, 7 Apr 2010 11:05:19 -0500
In-Reply-To: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

preparing this driver for mainline. Convert into
a platform_driver and prepare to split platform_device
code from platform_driver code.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/cbus/retu.c |   29 +++++++++++++++--------------
 1 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index 8b85221..ea09c17 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -336,7 +336,7 @@ static void retu_power_off(void)
  * Probe for the Retu ASIC and allocate memory
  * for its device-struct if found
  */
-static int __devinit retu_probe(struct device *dev)
+static int __devinit retu_probe(struct platform_device *pdev)
 {
 	int rev, ret;
 
@@ -350,13 +350,13 @@ static int __devinit retu_probe(struct device *dev)
 			machine_is_nokia_n810_wimax()) {
 		retu_irq_pin = 108;
 	} else {
-		dev_err(dev, "cbus: Unsupported board for tahvo\n");
+		dev_err(&pdev->dev, "cbus: Unsupported board for tahvo\n");
 		return -ENODEV;
 	}
 
 	ret = gpio_request(retu_irq_pin, "RETU irq");
 	if (ret < 0) {
-		dev_err(dev, "Unable to reserve IRQ GPIO\n");
+		dev_err(&pdev->dev, "Unable to reserve IRQ GPIO\n");
 		return ret;
 	}
 
@@ -372,7 +372,7 @@ static int __devinit retu_probe(struct device *dev)
 	if (rev & (1 << 7))
 		retu_is_vilma = 1;
 
-	dev_info(dev, "%s v%d.%d found\n", retu_is_vilma ? "Vilma" : "Retu",
+	dev_info(&pdev->dev, "%s v%d.%d found\n", retu_is_vilma ? "Vilma" : "Retu",
 	       (rev >> 4) & 0x07, rev & 0x0f);
 
 	/* Mask all RETU interrupts */
@@ -381,7 +381,7 @@ static int __devinit retu_probe(struct device *dev)
 	ret = request_irq(gpio_to_irq(retu_irq_pin), retu_irq_handler, 0,
 			  "retu", 0);
 	if (ret < 0) {
-		dev_err(dev, "Unable to register IRQ handler\n");
+		dev_err(&pdev->dev, "Unable to register IRQ handler\n");
 		gpio_free(retu_irq_pin);
 		return ret;
 	}
@@ -393,7 +393,7 @@ static int __devinit retu_probe(struct device *dev)
 #ifdef CONFIG_CBUS_RETU_USER
 	/* Initialize user-space interface */
 	if (retu_user_init() < 0) {
-		dev_err(dev, "Unable to initialize driver\n");
+		dev_err(&pdev->dev, "Unable to initialize driver\n");
 		free_irq(gpio_to_irq(retu_irq_pin), 0);
 		gpio_free(retu_irq_pin);
 		return ret;
@@ -403,7 +403,7 @@ static int __devinit retu_probe(struct device *dev)
 	return 0;
 }
 
-static int retu_remove(struct device *dev)
+static int __devexit retu_remove(struct platform_device *pdev)
 {
 #ifdef CONFIG_CBUS_RETU_USER
 	retu_user_cleanup();
@@ -422,11 +422,12 @@ static void retu_device_release(struct device *dev)
 	complete(&device_release);
 }
 
-static struct device_driver retu_driver = {
-	.name		= "retu",
-	.bus		= &platform_bus_type,
+static struct platform_driver retu_driver = {
 	.probe		= retu_probe,
-	.remove		= retu_remove,
+	.remove		= __devexit_p(retu_remove),
+	.driver		= {
+		.name	= "retu",
+	},
 };
 
 static struct platform_device retu_device = {
@@ -452,13 +453,13 @@ static int __init retu_init(void)
 
 	init_completion(&device_release);
 
-	ret = driver_register(&retu_driver);
+	ret = platform_driver_register(&retu_driver);
 	if (ret < 0)
 		return ret;
 
 	ret = platform_device_register(&retu_device);
 	if (ret < 0) {
-		driver_unregister(&retu_driver);
+		platform_driver_unregister(&retu_driver);
 		return ret;
 	}
 
@@ -471,7 +472,7 @@ static int __init retu_init(void)
 static void __exit retu_exit(void)
 {
 	platform_device_unregister(&retu_device);
-	driver_unregister(&retu_driver);
+	platform_driver_unregister(&retu_driver);
 	wait_for_completion(&device_release);
 }
 
-- 
1.7.0.rc0.33.g7c3932

