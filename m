From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 2/4] cbus: retu: move platform_device to board file
Date: Fri,  1 Oct 2010 10:47:16 +0300
Message-ID: <1285919238-26555-3-git-send-email-balbi@ti.com>
References: <1285919238-26555-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57796 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754211Ab0JAHrX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Oct 2010 03:47:23 -0400
In-Reply-To: <1285919238-26555-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

No functional changes, just moving platform_device
registration to the proper location.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/board-n8x0.c |   45 ++++++++++++++++++++++++
 drivers/cbus/retu.c              |   69 +-------------------------------------
 2 files changed, 46 insertions(+), 68 deletions(-)

diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index c14d398..82c9880 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -15,6 +15,7 @@
 #include <linux/delay.h>
 #include <linux/gpio.h>
 #include <linux/init.h>
+#include <linux/irq.h>
 #include <linux/io.h>
 #include <linux/stddef.h>
 #include <linux/platform_device.h>
@@ -221,9 +222,53 @@ static struct platform_device n8x0_cbus_device = {
 	},
 };
 
+static struct resource retu_resource[] = {
+	{
+		.start	= -EINVAL, /* set later */
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device retu_device = {
+	.name		= "retu",
+	.id		= -1,
+	.resource	= retu_resource,
+	.num_resources	= ARRAY_SIZE(retu_resource),
+};
+
 static void __init n8x0_cbus_init(void)
 {
+	int		retu_irq_pin;
+	int		ret;
+
 	platform_device_register(&n8x0_cbus_device);
+
+	if (machine_is_nokia770()) {
+		retu_irq_pin = 62;
+	} else if (machine_is_nokia_n800() || machine_is_nokia_n810() ||
+			machine_is_nokia_n810_wimax()) {
+		retu_irq_pin = 108;
+	} else {
+		pr_err("retu: Unsupported board for retu\n");
+		return;
+	}
+
+	ret = gpio_request(retu_irq_pin, "RETU irq");
+	if (ret < 0) {
+		pr_err("retu: Unable to reserve IRQ GPIO\n");
+		return;
+	}
+
+	ret = gpio_direction_input(retu_irq_pin);
+	if (ret < 0) {
+		pr_err("retu: Unable to change gpio direction\n");
+		gpio_free(retu_irq_pin);
+		return;
+	}
+
+	set_irq_type(gpio_to_irq(retu_irq_pin), IRQ_TYPE_EDGE_RISING);
+	retu_resource[0].start = gpio_to_irq(retu_irq_pin);
+	platform_device_register(&retu_device);
 }
 
 #else
diff --git a/drivers/cbus/retu.c b/drivers/cbus/retu.c
index 4a072da..a2977c9 100644
--- a/drivers/cbus/retu.c
+++ b/drivers/cbus/retu.c
@@ -50,7 +50,6 @@
 #define PFX			"retu: "
 
 static int retu_initialized;
-static int retu_irq_pin;
 static int retu_is_vilma;
 
 static struct tasklet_struct retu_tasklet;
@@ -477,20 +476,6 @@ static struct platform_driver retu_driver = {
 	},
 };
 
-static struct resource retu_resource[] = {
-	{
-		.start	= -EINVAL, /* set later */
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device retu_device = {
-	.name		= "retu",
-	.id		= -1,
-	.resource	= retu_resource,
-	.num_resources	= ARRAY_SIZE(retu_resource),
-};
-
 /**
  * retu_init - initialise Retu driver
  *
@@ -498,57 +483,7 @@ static struct platform_device retu_device = {
  */
 static int __init retu_init(void)
 {
-	int ret = 0;
-
-	/* REVISIT: Pass these from board-*.c files in platform_data */
-	if (machine_is_nokia770()) {
-		retu_irq_pin = 62;
-	} else if (machine_is_nokia_n800() || machine_is_nokia_n810() ||
-			machine_is_nokia_n810_wimax()) {
-		retu_irq_pin = 108;
-	} else {
-		pr_err("retu: Unsupported board for retu\n");
-		ret = -ENODEV;
-		goto err0;
-	}
-
-	ret = gpio_request(retu_irq_pin, "RETU irq");
-	if (ret < 0) {
-		pr_err("retu: Unable to reserve IRQ GPIO\n");
-		goto err0;
-	}
-
-	/* Set the pin as input */
-	ret = gpio_direction_input(retu_irq_pin);
-	if (ret < 0) {
-		pr_err("retu: Unable to change gpio direction\n");
-		goto err1;
-	}
-
-	/* Rising edge triggers the IRQ */
-	set_irq_type(gpio_to_irq(retu_irq_pin), IRQ_TYPE_EDGE_RISING);
-
-	/* Set up correct gpio number on struct resource */
-	retu_resource[0].start = gpio_to_irq(retu_irq_pin);
-
-	ret = platform_device_register(&retu_device);
-	if (ret < 0)
-		goto err1;
-
-	ret = platform_driver_probe(&retu_driver, retu_probe);
-	if (ret < 0)
-		goto err2;
-
-	return 0;
-
-err2:
-	platform_driver_unregister(&retu_driver);
-
-err1:
-	gpio_free(retu_irq_pin);
-
-err0:
-	return ret;
+	return platform_driver_probe(&retu_driver, retu_probe);
 }
 
 /*
@@ -556,9 +491,7 @@ err0:
  */
 static void __exit retu_exit(void)
 {
-	platform_device_unregister(&retu_device);
 	platform_driver_unregister(&retu_driver);
-	gpio_free(retu_irq_pin);
 }
 
 subsys_initcall(retu_init);
-- 
1.7.3.rc0.35.g8ac8c

