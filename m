From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 3/4] cbus: tahvo: move platform_device to board file
Date: Tue, 19 Oct 2010 10:29:17 +0300
Message-ID: <1287473358-25634-4-git-send-email-balbi@ti.com>
References: <1287473358-25634-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36789 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758086Ab0JSH3k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Oct 2010 03:29:40 -0400
In-Reply-To: <1287473358-25634-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

No functional changes, just moving platform_device
registration to the proper location.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap1/board-nokia770.c |   32 ++++++++++++++++
 arch/arm/mach-omap2/board-n8x0.c     |   33 +++++++++++++++++
 drivers/cbus/tahvo.c                 |   65 +---------------------------------
 3 files changed, 66 insertions(+), 64 deletions(-)

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 3969f2d..fabc154 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -127,6 +127,20 @@ static struct platform_device retu_device = {
 	.num_resources	= ARRAY_SIZE(retu_resource),
 };
 
+static struct resource tahvo_resource[] = {
+	{
+		.start	= -EINVAL, /* set later */
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+static struct platform_device tahvo_device = {
+	.name		= "tahvo",
+	.id		= -1,
+	.resource	= tahvo_resource,
+	.num_resources	= ARRAY_SIZE(tahvo_resource),
+};
+
 static void __init nokia770_cbus_init(void)
 {
 	int		ret;
@@ -149,6 +163,24 @@ static void __init nokia770_cbus_init(void)
 	set_irq_type(gpio_to_irq(62), IRQ_TYPE_EDGE_RISING);
 	retu_resource[0].start = gpio_to_irq(62);
 	platform_device_register(&retu_device);
+
+	ret = gpio_request(40, "TAHVO irq");
+	if (ret) {
+		pr_err("tahvo: Unable to reserve IRQ GPIO\n");
+		gpio_free(62);
+		return;
+	}
+
+	ret = gpio_direction_input(40);
+	if (ret) {
+		pr_err("tahvo: Unable to change direction\n");
+		gpio_free(62);
+		gpio_free(40);
+		return;
+	}
+
+	tahvo_resource[0].start = gpio_to_irq(40);
+	platform_device_register(&tahvo_device);
 }
 
 #else
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index 938742d..1823f01 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -236,6 +236,20 @@ static struct platform_device retu_device = {
 	.num_resources	= ARRAY_SIZE(retu_resource),
 };
 
+static struct resource tahvo_resource[] = {
+	{
+		.start	= -EINVAL, /* set later */
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+static struct platform_device tahvo_device = {
+	.name		= "tahvo",
+	.id		= -1,
+	.resource	= tahvo_resource,
+	.num_resources	= ARRAY_SIZE(tahvo_resource),
+};
+
 static void __init n8x0_cbus_init(void)
 {
 	int		ret;
@@ -258,6 +272,25 @@ static void __init n8x0_cbus_init(void)
 	set_irq_type(gpio_to_irq(108), IRQ_TYPE_EDGE_RISING);
 	retu_resource[0].start = gpio_to_irq(108);
 	platform_device_register(&retu_device);
+
+	ret = gpio_request(111, "TAHVO irq");
+	if (ret) {
+		pr_err("tahvo: Unable to reserve IRQ GPIO\n");
+		gpio_free(108);
+		return;
+	}
+
+	/* Set the pin as input */
+	ret = gpio_direction_input(111);
+	if (ret) {
+		pr_err("tahvo: Unable to change direction\n");
+		gpio_free(108);
+		gpio_free(111);
+		return;
+	}
+
+	tahvo_resource[0].start = gpio_to_irq(111);
+	platform_device_register(&tahvo_device);
 }
 
 #else
diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
index 2ae1ac4..9699056 100644
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -50,7 +50,6 @@
 #define PFX			"tahvo: "
 
 static int tahvo_initialized;
-static int tahvo_irq_pin;
 static int tahvo_is_betty;
 
 static struct tasklet_struct tahvo_tasklet;
@@ -374,20 +373,6 @@ static struct platform_driver tahvo_driver = {
 	},
 };
 
-static struct resource tahvo_resource[] = {
-	{
-		.start	= -EINVAL, /* set later */
-		.flags	= IORESOURCE_IRQ,
-	}
-};
-
-static struct platform_device tahvo_device = {
-	.name		= "tahvo",
-	.id		= -1,
-	.resource	= tahvo_resource,
-	.num_resources	= ARRAY_SIZE(tahvo_resource),
-};
-
 /**
  * tahvo_init - initialise Tahvo driver
  *
@@ -395,53 +380,7 @@ static struct platform_device tahvo_device = {
  */
 static int __init tahvo_init(void)
 {
-	int ret = 0;
-
-	/* REVISIT: Pass these from board-*.c files in platform_data */
-	if (machine_is_nokia770()) {
-		tahvo_irq_pin = 40;
-	} else if (machine_is_nokia_n800() || machine_is_nokia_n810() ||
-			machine_is_nokia_n810_wimax()) {
-		tahvo_irq_pin = 111;
-	} else {
-		pr_err("tahvo: Unsupported board for tahvo\n");
-		ret = -ENODEV;
-		goto err0;
-	}
-
-	ret = gpio_request(tahvo_irq_pin, "TAHVO irq");
-	if (ret) {
-		pr_err("tahvo: Unable to reserve IRQ GPIO\n");
-		goto err0;
-	}
-
-	/* Set the pin as input */
-	ret = gpio_direction_input(tahvo_irq_pin);
-	if (ret) {
-		pr_err("tahvo: Unable to change direction\n");
-		goto err1;
-	}
-
-	tahvo_resource[0].start = gpio_to_irq(tahvo_irq_pin);
-
-	ret = platform_driver_probe(&tahvo_driver, tahvo_probe);
-	if (ret)
-		goto err1;
-
-	ret = platform_device_register(&tahvo_device);
-	if (ret)
-		goto err2;
-
-	return 0;
-
-err2:
-	platform_driver_unregister(&tahvo_driver);
-
-err1:
-	gpio_free(tahvo_irq_pin);
-
-err0:
-	return ret;
+	return platform_driver_probe(&tahvo_driver, tahvo_probe);
 }
 
 /*
@@ -449,9 +388,7 @@ err0:
  */
 static void __exit tahvo_exit(void)
 {
-	platform_device_unregister(&tahvo_device);
 	platform_driver_unregister(&tahvo_driver);
-	gpio_free(tahvo_irq_pin);
 }
 
 subsys_initcall(tahvo_init);
-- 
1.7.3.rc0.35.g8ac8c

