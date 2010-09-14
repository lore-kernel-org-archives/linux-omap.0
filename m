From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/PATCH 7/8] cbus: tahvo: pass irq via struct resource
Date: Tue, 14 Sep 2010 11:30:15 +0300
Message-ID: <1284453016-8295-8-git-send-email-balbi@ti.com>
References: <1284453016-8295-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52452 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516Ab0INIai (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Sep 2010 04:30:38 -0400
In-Reply-To: <1284453016-8295-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>

prepare tahvo for platform_device creation on
board files. Start passing irq number via
struct resource.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/tahvo.c |   96 ++++++++++++++++++++++++++++++-------------------
 1 files changed, 59 insertions(+), 37 deletions(-)

diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
index 7c57ca4..8e41758 100644
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -304,6 +304,7 @@ EXPORT_SYMBOL(tahvo_free_irq);
 static int __devinit tahvo_probe(struct platform_device *pdev)
 {
 	int rev, id, ret;
+	int irq;
 
 	/* Prepare tasklet */
 	tasklet_init(&tahvo_tasklet, tahvo_tasklet_handler, 0);
@@ -327,45 +328,22 @@ static int __devinit tahvo_probe(struct platform_device *pdev)
 	dev_err(&pdev->dev, "%s v%d.%d found\n", tahvo_is_betty ? "Betty" : "Tahvo",
 	       (rev >> 4) & 0x0f, rev & 0x0f);
 
-	/* REVISIT: Pass these from board-*.c files in platform_data */
-	if (machine_is_nokia770()) {
-		tahvo_irq_pin = 40;
-	} else if (machine_is_nokia_n800() || machine_is_nokia_n810() ||
-			machine_is_nokia_n810_wimax()) {
-		tahvo_irq_pin = 111;
-	} else {
-		dev_err(&pdev->dev, "cbus: Unsupported board for tahvo\n");
-		return -ENODEV;
-	}
-
-	ret = gpio_request(tahvo_irq_pin, "TAHVO irq");
-	if (ret) {
-		dev_err(&pdev->dev, "Unable to reserve IRQ GPIO\n");
-		return ret;
-	}
-
-	/* Set the pin as input */
-	gpio_direction_input(tahvo_irq_pin);
-
-	/* Rising edge triggers the IRQ */
-	set_irq_type(gpio_to_irq(tahvo_irq_pin), IRQ_TYPE_EDGE_RISING);
+	irq = platform_get_irq(pdev, 0);
 
 	/* Mask all TAHVO interrupts */
 	tahvo_write_reg(TAHVO_REG_IMR, 0xffff);
 
-	ret = request_irq(gpio_to_irq(tahvo_irq_pin), tahvo_irq_handler, 0,
-			  "tahvo", 0);
+	ret = request_irq(irq, tahvo_irq_handler, IRQF_TRIGGER_RISING,
+			"tahvo", 0);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Unable to register IRQ handler\n");
-		gpio_free(tahvo_irq_pin);
 		return ret;
 	}
 #ifdef CONFIG_CBUS_TAHVO_USER
 	/* Initialize user-space interface */
 	if (tahvo_user_init() < 0) {
 		dev_err(&pdev->dev, "Unable to initialize driver\n");
-		free_irq(gpio_to_irq(tahvo_irq_pin), 0);
-		gpio_free(tahvo_irq_pin);
+		free_irq(irq, 0);
 		return ret;
 	}
 #endif
@@ -374,13 +352,16 @@ static int __devinit tahvo_probe(struct platform_device *pdev)
 
 static int __devexit tahvo_remove(struct platform_device *pdev)
 {
+	int irq;
+
+	irq = platform_get_irq(pdev, 0);
+
 #ifdef CONFIG_CBUS_TAHVO_USER
 	tahvo_user_cleanup();
 #endif
 	/* Mask all TAHVO interrupts */
 	tahvo_write_reg(TAHVO_REG_IMR, 0xffff);
-	free_irq(gpio_to_irq(tahvo_irq_pin), 0);
-	gpio_free(tahvo_irq_pin);
+	free_irq(irq, 0);
 	tasklet_kill(&tahvo_tasklet);
 
 	return 0;
@@ -394,9 +375,18 @@ static struct platform_driver tahvo_driver = {
 	},
 };
 
+static struct resource tahvo_resource[] = {
+	{
+		.start	= -EINVAL, /* set later */
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
 static struct platform_device tahvo_device = {
 	.name		= "tahvo",
 	.id		= -1,
+	.resource	= tahvo_resource,
+	.num_resources	= ARRAY_SIZE(tahvo_resource),
 };
 
 /**
@@ -408,20 +398,51 @@ static int __init tahvo_init(void)
 {
 	int ret = 0;
 
-	if (!(machine_is_nokia770() || machine_is_nokia_n800() ||
-		machine_is_nokia_n810() || machine_is_nokia_n810_wimax()))
-			return -ENODEV;
+	/* REVISIT: Pass these from board-*.c files in platform_data */
+	if (machine_is_nokia770()) {
+		tahvo_irq_pin = 40;
+	} else if (machine_is_nokia_n800() || machine_is_nokia_n810() ||
+			machine_is_nokia_n810_wimax()) {
+		tahvo_irq_pin = 111;
+	} else {
+		pr_err("tahvo: Unsupported board for tahvo\n");
+		ret = -ENODEV;
+		goto err0;
+	}
+
+	ret = gpio_request(tahvo_irq_pin, "TAHVO irq");
+	if (ret) {
+		pr_err("tahvo: Unable to reserve IRQ GPIO\n");
+		goto err0;
+	}
+
+	/* Set the pin as input */
+	ret = gpio_direction_input(tahvo_irq_pin);
+	if (ret) {
+		pr_err("tahvo: Unable to change direction\n");
+		goto err1;
+	}
+
+	tahvo_resource[0].start = gpio_to_irq(tahvo_irq_pin);
 
 	ret = platform_driver_register(&tahvo_driver);
 	if (ret)
-		return ret;
+		goto err1;
 
 	ret = platform_device_register(&tahvo_device);
-	if (ret) {
-		platform_driver_unregister(&tahvo_driver);
-		return ret;
-	}
+	if (ret)
+		goto err2;
+
 	return 0;
+
+err2:
+	platform_driver_unregister(&tahvo_driver);
+
+err1:
+	gpio_free(tahvo_irq_pin);
+
+err0:
+	return ret;
 }
 
 /*
@@ -431,6 +452,7 @@ static void __exit tahvo_exit(void)
 {
 	platform_device_unregister(&tahvo_device);
 	platform_driver_unregister(&tahvo_driver);
+	gpio_free(tahvo_irq_pin);
 }
 
 subsys_initcall(tahvo_init);
-- 
1.7.3.rc0.35.g8ac8c

