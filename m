From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCH 3/4] omap3: fix and improve the LED handling on IGEP v2 board.
Date: Tue,  3 Aug 2010 13:56:13 +0200
Message-ID: <1280836574-32467-4-git-send-email-eballetbo@gmail.com>
References: <1280836574-32467-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45985 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756006Ab0HCL40 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Aug 2010 07:56:26 -0400
Received: by mail-ww0-f44.google.com with SMTP id 40so5028712wwj.1
        for <linux-omap@vger.kernel.org>; Tue, 03 Aug 2010 04:56:25 -0700 (PDT)
In-Reply-To: <1280836574-32467-1-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>, Enric Balletbo i Serra <eballetbo@gmail.com>

From: Enric Balletbo i Serra <eballetbo@iseebcn.com>

The IGEP v2 board has four leds, this patch allows control all
of these LEDs using the LED class if CONFIG_LEDS_GPIO is selected
or using the General Purpose Input/Output (GPIO) interface if
CONFIG_LEDS_GPIO is not selected.

Signed-off-by: Enric Balletbo i Serra <eballetbo@gmail.com>
---
 arch/arm/mach-omap2/board-igep0020.c |  103 ++++++++++++++++++++--------------
 1 files changed, 61 insertions(+), 42 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index d88fc08..6868dda 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -272,6 +272,54 @@ static struct omap2_hsmmc_info mmc[] = {
 	{}      /* Terminator */
 };
 
+#if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
+#include <linux/leds.h>
+
+static struct gpio_led igep2_gpio_leds[] = {
+	[0] = {
+		.name = "led0:red",
+		.gpio = IGEP2_GPIO_LED0_RED,
+		.default_trigger = "default-off",
+	},
+	[1] = {
+		.name = "led0:green",
+		.gpio = IGEP2_GPIO_LED0_GREEN,
+		.default_trigger = "default-off",
+	},
+	[2] = {
+		.name = "led1:red",
+		.gpio = IGEP2_GPIO_LED1_RED,
+		.default_trigger = "default-off",
+	},
+	[3] = {
+		.name = "led1:green",
+		.default_trigger = "heartbeat",
+		.gpio = -EINVAL, /* gets replaced */
+	},
+};
+
+static struct gpio_led_platform_data igep2_led_pdata = {
+	.leds           = igep2_gpio_leds,
+	.num_leds       = ARRAY_SIZE(igep2_gpio_leds),
+};
+
+static struct platform_device igep2_led_device = {
+	 .name   = "leds-gpio",
+	 .id     = -1,
+	 .dev    = {
+		 .platform_data  =  &igep2_led_pdata,
+	},
+};
+
+static void __init igep2_init_led(void)
+{
+	platform_device_register(&igep2_led_device);
+}
+
+#else
+static inline void igep2_init_led(void) {}
+#endif
+
 static int igep2_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
@@ -295,6 +343,18 @@ static int igep2_twl_gpio_setup(struct device *dev,
 	gpio_request(gpio + TWL4030_GPIO_MAX, "GPIO_USB_CPEN");
 	gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
 
+	/* TWL4030_GPIO_MAX + 1 == ledB (out, active low LED) */
+#if !defined(CONFIG_LEDS_GPIO) && !defined(CONFIG_LEDS_GPIO_MODULE)
+	if ((gpio_request(gpio + TWL4030_GPIO_MAX + 1, "led1:green") == 0) &&
+	    (gpio_direction_output(gpio + TWL4030_GPIO_MAX + 1, 1) == 0)) {
+		gpio_export(gpio + TWL4030_GPIO_MAX + 1, 0);
+		gpio_set_value(gpio + TWL4030_GPIO_MAX + 1, 0);
+	} else
+		pr_warning("IGEP v2: Could not obtain gpio GPIO_LED1_GREEN\n");
+#else
+	igep2_gpio_leds[3].gpio = gpio + TWL4030_GPIO_MAX + 1;
+#endif
+
 	return 0;
 };
 
@@ -302,7 +362,7 @@ static struct twl4030_gpio_platform_data igep2_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
 	.irq_end	= TWL4030_GPIO_IRQ_END,
-	.use_leds	= false,
+	.use_leds	= true,
 	.setup		= igep2_twl_gpio_setup,
 };
 
@@ -376,47 +436,6 @@ static void __init igep2_display_init(void)
 		pr_err("IGEP v2: Could not obtain gpio GPIO_DVI_PUP\n");
 }
 
-#if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
-#include <linux/leds.h>
-
-static struct gpio_led igep2_gpio_leds[] = {
-	{
-		.name = "led0:red",
-		.gpio = IGEP2_GPIO_LED0_RED,
-	},
-	{
-		.name = "led0:green",
-		.default_trigger = "heartbeat",
-		.gpio = IGEP2_GPIO_LED0_GREEN,
-	},
-	{
-		.name = "led1:red",
-		.gpio = IGEP2_GPIO_LED1_RED,
-	},
-};
-
-static struct gpio_led_platform_data igep2_led_pdata = {
-	.leds           = igep2_gpio_leds,
-	.num_leds       = ARRAY_SIZE(igep2_gpio_leds),
-};
-
-static struct platform_device igep2_led_device = {
-	 .name   = "leds-gpio",
-	 .id     = -1,
-	 .dev    = {
-		 .platform_data  =  &igep2_led_pdata,
-	},
-};
-
-static void __init igep2_init_led(void)
-{
-	platform_device_register(&igep2_led_device);
-}
-
-#else
-static inline void igep2_init_led(void) {}
-#endif
-
 static struct platform_device *igep2_devices[] __initdata = {
 	&igep2_dss_device,
 };
-- 
1.7.0.4

