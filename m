From: Enric Balletbo i Serra <eballetbo@gmail.com>
Subject: [PATCH] omap3: Fix support for the LEDs connected to GPIO outputs on IGEP v2 board.
Date: Mon,  1 Mar 2010 12:18:08 +0100
Message-ID: <1267442288-3106-2-git-send-email-eballetbo@gmail.com>
References: <1267442288-3106-1-git-send-email-eballetbo@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:38453 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754969Ab0CCRhu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Mar 2010 12:37:50 -0500
Received: by mail-bw0-f209.google.com with SMTP id 1so114868bwz.21
        for <linux-omap@vger.kernel.org>; Wed, 03 Mar 2010 09:37:50 -0800 (PST)
In-Reply-To: <1267442288-3106-1-git-send-email-eballetbo@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Enric Balletbo i Serra <eballetbo@iseebcn.com>

From: Enric Balletbo i Serra <eballetbo@iseebcn.com>

Select CONFIG_LEDS_GPIO to enable IGEP v2 LED support and control of supported
LEDs from userspace. Otherwise GPIO LEDs are exported as GPIO 26, 27 and 28 using
the gpiolib framework.

Signed-off-by: Enric Balletbo i Serra <eballetbo@iseebcn.com>
---
 arch/arm/mach-omap2/board-igep0020.c |   54 ++++++++++++++++++++++-----------
 1 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 26f65ca..19aaff0 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -16,7 +16,6 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
-#include <linux/leds.h>
 #include <linux/interrupt.h>
 
 #include <linux/regulator/machine.h>
@@ -39,8 +38,8 @@
 #define IGEP2_SMSC911X_CS       5
 #define IGEP2_SMSC911X_GPIO     176
 #define IGEP2_GPIO_USBH_NRESET  24
-#define IGEP2_GPIO_LED0_RED 	26
-#define IGEP2_GPIO_LED0_GREEN 	27
+#define IGEP2_GPIO_LED0_GREEN 	26
+#define IGEP2_GPIO_LED0_RED 	27
 #define IGEP2_GPIO_LED1_RED   	28
 #define IGEP2_GPIO_DVI_PUP	170
 #define IGEP2_GPIO_WIFI_NPD 	94
@@ -355,34 +354,50 @@ static void __init igep2_display_init(void)
 	    gpio_direction_output(IGEP2_GPIO_DVI_PUP, 1))
 		pr_err("IGEP v2: Could not obtain gpio GPIO_DVI_PUP\n");
 }
-#ifdef CONFIG_LEDS_TRIGGERS
-static struct gpio_led gpio_leds[] = {
+
+#if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
+#include <linux/leds.h>
+
+static struct gpio_led igep2_gpio_leds[] = {
 	{
-		.name = "GPIO_LED1_RED",
+		.name = "led0:red",
+		.gpio = IGEP2_GPIO_LED0_RED,
+	},
+	{
+		.name = "led0:green",
 		.default_trigger = "heartbeat",
+		.gpio = IGEP2_GPIO_LED0_GREEN,
+	},
+	{
+		.name = "led1:red",
 		.gpio = IGEP2_GPIO_LED1_RED,
 	},
 };
 
-static struct gpio_led_platform_data gpio_leds_info = {
-	.leds           = gpio_leds,
-	.num_leds       = ARRAY_SIZE(gpio_leds),
+static struct gpio_led_platform_data igep2_led_pdata = {
+	.leds           = igep2_gpio_leds,
+	.num_leds       = ARRAY_SIZE(igep2_gpio_leds),
 };
 
-static struct platform_device leds_gpio = {
+static struct platform_device igep2_led_device = {
 	 .name   = "leds-gpio",
 	 .id     = -1,
 	 .dev    = {
-		 .platform_data  =  &gpio_leds_info,
+		 .platform_data  =  &igep2_led_pdata,
 	},
 };
+
+static void __init igep2_init_led(void)
+{
+	platform_device_register(&igep2_led_device);
+}
+
+#else
+static inline void igep2_init_led(void) {}
 #endif
 
 static struct platform_device *igep2_devices[] __initdata = {
 	&igep2_dss_device,
-#ifdef CONFIG_LEDS_TRIGGERS
-	&leds_gpio,
-#endif
 };
 
 static void __init igep2_init_irq(void)
@@ -471,31 +486,34 @@ static void __init igep2_init(void)
 	usb_ehci_init(&ehci_pdata);
 
 	igep2_flash_init();
+	igep2_init_led();
 	igep2_display_init();
 	igep2_init_smsc911x();
 
 	/* GPIO userspace leds */
-	if ((gpio_request(IGEP2_GPIO_LED0_RED, "GPIO_LED0_RED") == 0) &&
+#if !defined(CONFIG_LEDS_GPIO) && !defined(CONFIG_LEDS_GPIO_MODULE)
+	if ((gpio_request(IGEP2_GPIO_LED0_RED, "led0:red") == 0) &&
 	    (gpio_direction_output(IGEP2_GPIO_LED0_RED, 1) == 0)) {
 		gpio_export(IGEP2_GPIO_LED0_RED, 0);
 		gpio_set_value(IGEP2_GPIO_LED0_RED, 0);
 	} else
 		pr_warning("IGEP v2: Could not obtain gpio GPIO_LED0_RED\n");
 
-	if ((gpio_request(IGEP2_GPIO_LED0_GREEN, "GPIO_LED0_GREEN") == 0) &&
+	if ((gpio_request(IGEP2_GPIO_LED0_GREEN, "led0:green") == 0) &&
 	    (gpio_direction_output(IGEP2_GPIO_LED0_GREEN, 1) == 0)) {
 		gpio_export(IGEP2_GPIO_LED0_GREEN, 0);
 		gpio_set_value(IGEP2_GPIO_LED0_GREEN, 0);
 	} else
 		pr_warning("IGEP v2: Could not obtain gpio GPIO_LED0_GREEN\n");
-#ifndef CONFIG_LEDS_TRIGGERS
-	if ((gpio_request(IGEP2_GPIO_LED1_RED, "GPIO_LED1_RED") == 0) &&
+
+	if ((gpio_request(IGEP2_GPIO_LED1_RED, "led1:red") == 0) &&
 	    (gpio_direction_output(IGEP2_GPIO_LED1_RED, 1) == 0)) {
 		gpio_export(IGEP2_GPIO_LED1_RED, 0);
 		gpio_set_value(IGEP2_GPIO_LED1_RED, 0);
 	} else
 		pr_warning("IGEP v2: Could not obtain gpio GPIO_LED1_RED\n");
 #endif
+
 	/* GPIO W-LAN + Bluetooth combo module */
 	if ((gpio_request(IGEP2_GPIO_WIFI_NPD, "GPIO_WIFI_NPD") == 0) &&
 	    (gpio_direction_output(IGEP2_GPIO_WIFI_NPD, 1) == 0)) {
-- 
1.5.4.3

