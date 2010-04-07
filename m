From: felipe.balbi@nokia.com
Subject: [RFC PATCH 18/37] cbus: retu: convert printk to dev_*
Date: Wed,  7 Apr 2010 19:04:09 +0300
Message-ID: <1270656268-7034-19-git-send-email-felipe.balbi@nokia.com>
References: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62330 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932662Ab0DGQFT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 12:05:19 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o37G56B0007315
	for <linux-omap@vger.kernel.org>; Wed, 7 Apr 2010 11:05:18 -0500
In-Reply-To: <1270656268-7034-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

during probe(), we have a dev * available, and we
can use that for pretty printing with dev_* macros.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/cbus/retu.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index 8382694..8b85221 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -350,13 +350,13 @@ static int __devinit retu_probe(struct device *dev)
 			machine_is_nokia_n810_wimax()) {
 		retu_irq_pin = 108;
 	} else {
-		printk(KERN_ERR "cbus: Unsupported board for tahvo\n");
+		dev_err(dev, "cbus: Unsupported board for tahvo\n");
 		return -ENODEV;
 	}
 
 	ret = gpio_request(retu_irq_pin, "RETU irq");
 	if (ret < 0) {
-		printk(KERN_ERR PFX "Unable to reserve IRQ GPIO\n");
+		dev_err(dev, "Unable to reserve IRQ GPIO\n");
 		return ret;
 	}
 
@@ -372,7 +372,7 @@ static int __devinit retu_probe(struct device *dev)
 	if (rev & (1 << 7))
 		retu_is_vilma = 1;
 
-	printk(KERN_INFO "%s v%d.%d found\n", retu_is_vilma ? "Vilma" : "Retu",
+	dev_info(dev, "%s v%d.%d found\n", retu_is_vilma ? "Vilma" : "Retu",
 	       (rev >> 4) & 0x07, rev & 0x0f);
 
 	/* Mask all RETU interrupts */
@@ -381,7 +381,7 @@ static int __devinit retu_probe(struct device *dev)
 	ret = request_irq(gpio_to_irq(retu_irq_pin), retu_irq_handler, 0,
 			  "retu", 0);
 	if (ret < 0) {
-		printk(KERN_ERR PFX "Unable to register IRQ handler\n");
+		dev_err(dev, "Unable to register IRQ handler\n");
 		gpio_free(retu_irq_pin);
 		return ret;
 	}
@@ -393,7 +393,7 @@ static int __devinit retu_probe(struct device *dev)
 #ifdef CONFIG_CBUS_RETU_USER
 	/* Initialize user-space interface */
 	if (retu_user_init() < 0) {
-		printk(KERN_ERR "Unable to initialize driver\n");
+		dev_err(dev, "Unable to initialize driver\n");
 		free_irq(gpio_to_irq(retu_irq_pin), 0);
 		gpio_free(retu_irq_pin);
 		return ret;
@@ -450,8 +450,6 @@ static int __init retu_init(void)
 		machine_is_nokia_n810() || machine_is_nokia_n810_wimax()))
 			return -ENODEV;
 
-	printk(KERN_INFO "Retu/Vilma driver initialising\n");
-
 	init_completion(&device_release);
 
 	ret = driver_register(&retu_driver);
-- 
1.7.0.rc0.33.g7c3932

