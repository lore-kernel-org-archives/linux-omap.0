From: felipe.balbi@nokia.com
Subject: [RFC PATCH 23/37] cbus: tahvo: convert printk into dev_*
Date: Wed,  7 Apr 2010 19:04:14 +0300
Message-ID: <1270656268-7034-24-git-send-email-felipe.balbi@nokia.com>
References: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:58495 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932862Ab0DGQFW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 12:05:22 -0400
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o37G58eq004996
	for <linux-omap@vger.kernel.org>; Wed, 7 Apr 2010 19:05:19 +0300
In-Reply-To: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

during probe() we have a device * available so we
can use dev_* macros instead of printk.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/cbus/tahvo.c |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
index fc25a89..9bc3f56 100644
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -322,11 +322,11 @@ static int __devinit tahvo_probe(struct device *dev)
 		tahvo_is_betty = 1;
 		tahvo_7bit_backlight = 1;
 	} else {
-		printk(KERN_ERR "Tahvo/Betty chip not found");
+		dev_err(dev, "Tahvo/Betty chip not found");
 		return -ENODEV;
 	}
 
-	printk(KERN_INFO "%s v%d.%d found\n", tahvo_is_betty ? "Betty" : "Tahvo",
+	dev_err(dev, "%s v%d.%d found\n", tahvo_is_betty ? "Betty" : "Tahvo",
 	       (rev >> 4) & 0x0f, rev & 0x0f);
 
 	/* REVISIT: Pass these from board-*.c files in platform_data */
@@ -336,13 +336,13 @@ static int __devinit tahvo_probe(struct device *dev)
 			machine_is_nokia_n810_wimax()) {
 		tahvo_irq_pin = 111;
 	} else {
-		printk(KERN_ERR "cbus: Unsupported board for tahvo\n");
+		dev_err(dev, "cbus: Unsupported board for tahvo\n");
 		return -ENODEV;
 	}
 
 	ret = gpio_request(tahvo_irq_pin, "TAHVO irq");
 	if (ret) {
-		printk(KERN_ERR PFX "Unable to reserve IRQ GPIO\n");
+		dev_err(dev, "Unable to reserve IRQ GPIO\n");
 		return ret;
 	}
 
@@ -358,14 +358,14 @@ static int __devinit tahvo_probe(struct device *dev)
 	ret = request_irq(gpio_to_irq(tahvo_irq_pin), tahvo_irq_handler, 0,
 			  "tahvo", 0);
 	if (ret < 0) {
-		printk(KERN_ERR PFX "Unable to register IRQ handler\n");
+		dev_err(dev, "Unable to register IRQ handler\n");
 		gpio_free(tahvo_irq_pin);
 		return ret;
 	}
 #ifdef CONFIG_CBUS_TAHVO_USER
 	/* Initialize user-space interface */
 	if (tahvo_user_init() < 0) {
-		printk(KERN_ERR "Unable to initialize driver\n");
+		dev_err(dev, "Unable to initialize driver\n");
 		free_irq(gpio_to_irq(tahvo_irq_pin), 0);
 		gpio_free(tahvo_irq_pin);
 		return ret;
@@ -421,8 +421,6 @@ static int __init tahvo_init(void)
 		machine_is_nokia_n810() || machine_is_nokia_n810_wimax()))
 			return -ENODEV;
 
-	printk(KERN_INFO "Tahvo/Betty driver initialising\n");
-
 	init_completion(&device_release);
 
 	ret = driver_register(&tahvo_driver);
-- 
1.7.0.rc0.33.g7c3932

