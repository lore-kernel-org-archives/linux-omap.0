From: Felipe Balbi <balbi@ti.com>
Subject: [RFT/PATCH 3/8] cbus: retu: pass irq number via struct resource
Date: Tue, 14 Sep 2010 11:30:11 +0300
Message-ID: <1284453016-8295-4-git-send-email-balbi@ti.com>
References: <1284453016-8295-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46589 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752062Ab0INIa3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Sep 2010 04:30:29 -0400
In-Reply-To: <1284453016-8295-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Jarkko Nikula <jhnikula@gmail.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>

this patch prepares retu to be able to create and
register the platform_device on board files. IRQ
number is now being passed via struct resource as
it should be.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/retu.c |  103 +++++++++++++++++++++++++++++++-------------------
 1 files changed, 64 insertions(+), 39 deletions(-)

diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index 15368dc..67b663e 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -398,32 +398,12 @@ static int retu_allocate_children(struct device *parent)
 static int __devinit retu_probe(struct platform_device *pdev)
 {
 	int rev, ret;
+	int irq;
 
 	/* Prepare tasklet */
 	tasklet_init(&retu_tasklet, retu_tasklet_handler, 0);
 
-	/* REVISIT: Pass these from board-*.c files in platform_data */
-	if (machine_is_nokia770()) {
-		retu_irq_pin = 62;
-	} else if (machine_is_nokia_n800() || machine_is_nokia_n810() ||
-			machine_is_nokia_n810_wimax()) {
-		retu_irq_pin = 108;
-	} else {
-		dev_err(&pdev->dev, "cbus: Unsupported board for tahvo\n");
-		return -ENODEV;
-	}
-
-	ret = gpio_request(retu_irq_pin, "RETU irq");
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Unable to reserve IRQ GPIO\n");
-		return ret;
-	}
-
-	/* Set the pin as input */
-	gpio_direction_input(retu_irq_pin);
-
-	/* Rising edge triggers the IRQ */
-	set_irq_type(gpio_to_irq(retu_irq_pin), IRQ_TYPE_EDGE_RISING);
+	irq = platform_get_irq(pdev, 0);
 
 	retu_initialized = 1;
 
@@ -437,14 +417,14 @@ static int __devinit retu_probe(struct platform_device *pdev)
 	/* Mask all RETU interrupts */
 	retu_write_reg(RETU_REG_IMR, 0xffff);
 
-	ret = request_irq(gpio_to_irq(retu_irq_pin), retu_irq_handler, 0,
+	ret = request_irq(irq, retu_irq_handler, 0,
 			  "retu", 0);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Unable to register IRQ handler\n");
-		gpio_free(retu_irq_pin);
 		return ret;
 	}
-	set_irq_wake(gpio_to_irq(retu_irq_pin), 1);
+
+	set_irq_wake(irq, 1);
 
 	/* Register power off function */
 	pm_power_off = retu_power_off;
@@ -453,8 +433,7 @@ static int __devinit retu_probe(struct platform_device *pdev)
 	/* Initialize user-space interface */
 	if (retu_user_init() < 0) {
 		dev_err(&pdev->dev, "Unable to initialize driver\n");
-		free_irq(gpio_to_irq(retu_irq_pin), 0);
-		gpio_free(retu_irq_pin);
+		free_irq(irq, 0);
 		return ret;
 	}
 #endif
@@ -466,8 +445,7 @@ static int __devinit retu_probe(struct platform_device *pdev)
 		retu_user_cleanup();
 #endif
 		retu_write_reg(RETU_REG_IMR, 0xffff);
-		free_irq(gpio_to_irq(retu_irq_pin), 0);
-		gpio_free(retu_irq_pin);
+		free_irq(irq, 0);
 		tasklet_kill(&retu_tasklet);
 		return ret;
 	}
@@ -477,13 +455,16 @@ static int __devinit retu_probe(struct platform_device *pdev)
 
 static int __devexit retu_remove(struct platform_device *pdev)
 {
+	int irq;
+
+	irq = platform_get_irq(pdev, 0);
+
 #ifdef CONFIG_CBUS_RETU_USER
 	retu_user_cleanup();
 #endif
 	/* Mask all RETU interrupts */
 	retu_write_reg(RETU_REG_IMR, 0xffff);
-	free_irq(gpio_to_irq(retu_irq_pin), 0);
-	gpio_free(retu_irq_pin);
+	free_irq(irq, 0);
 	tasklet_kill(&retu_tasklet);
 
 	return 0;
@@ -497,9 +478,18 @@ static struct platform_driver retu_driver = {
 	},
 };
 
+static struct resource retu_resource[] = {
+	{
+		.start	= -EINVAL, /* set later */
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
 static struct platform_device retu_device = {
 	.name		= "retu",
 	.id		= -1,
+	.resource	= retu_resource,
+	.num_resources	= ARRAY_SIZE(retu_resource),
 };
 
 /**
@@ -511,21 +501,55 @@ static int __init retu_init(void)
 {
 	int ret = 0;
 
-	if (!(machine_is_nokia770() || machine_is_nokia_n800() ||
-		machine_is_nokia_n810() || machine_is_nokia_n810_wimax()))
-			return -ENODEV;
+	/* REVISIT: Pass these from board-*.c files in platform_data */
+	if (machine_is_nokia770()) {
+		retu_irq_pin = 62;
+	} else if (machine_is_nokia_n800() || machine_is_nokia_n810() ||
+			machine_is_nokia_n810_wimax()) {
+		retu_irq_pin = 108;
+	} else {
+		pr_err("retu: Unsupported board for retu\n");
+		ret = -ENODEV;
+		goto err0;
+	}
+
+	ret = gpio_request(retu_irq_pin, "RETU irq");
+	if (ret < 0) {
+		pr_err("retu: Unable to reserve IRQ GPIO\n");
+		goto err0;
+	}
+
+	/* Set the pin as input */
+	ret = gpio_direction_input(retu_irq_pin);
+	if (ret < 0) {
+		pr_err("retu: Unable to change gpio direction\n");
+		goto err1;
+	}
+
+	/* Rising edge triggers the IRQ */
+	set_irq_type(gpio_to_irq(retu_irq_pin), IRQ_TYPE_EDGE_RISING);
+
+	/* Set up correct gpio number on struct resource */
+	retu_resource[0].start = gpio_to_irq(retu_irq_pin);
 
 	ret = platform_driver_register(&retu_driver);
 	if (ret < 0)
-		return ret;
+		goto err1;
 
 	ret = platform_device_register(&retu_device);
-	if (ret < 0) {
-		platform_driver_unregister(&retu_driver);
-		return ret;
-	}
+	if (ret < 0)
+		goto err2;
 
 	return 0;
+
+err2:
+	platform_driver_unregister(&retu_driver);
+
+err1:
+	gpio_free(retu_irq_pin);
+
+err0:
+	return ret;
 }
 
 /*
@@ -535,6 +559,7 @@ static void __exit retu_exit(void)
 {
 	platform_device_unregister(&retu_device);
 	platform_driver_unregister(&retu_driver);
+	gpio_free(retu_irq_pin);
 }
 
 subsys_initcall(retu_init);
-- 
1.7.3.rc0.35.g8ac8c

