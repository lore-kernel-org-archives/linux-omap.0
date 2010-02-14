From: Jonas Zetterberg <jozz@jozz.se>
Subject: [PATCH 2/2] IGEPv2: Use Red Led1 as Heartbeat if configured
Date: Sun, 14 Feb 2010 20:33:26 +0100
Message-ID: <4B785006.9090502@jozz.se>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060907040509000901040202"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from proxy1.bredband.net ([195.54.101.71]:46291 "EHLO
	proxy1.bredband.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752858Ab0BNTd0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 14 Feb 2010 14:33:26 -0500
Received: from ipb2.telenor.se (195.54.127.165) by proxy1.bredband.net (7.3.140.3)
        id 4B62ECEA00A3642C for linux-omap@vger.kernel.org; Sun, 14 Feb 2010 20:33:26 +0100
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: =?UTF-8?B?RW5yaWMgQmFsbGV0YsOyIGkgU2VycmE=?= <eballetbo@iseebcn.com>, Anders Hedlund <anders.j.hedlund@gmail.com>

This is a multi-part message in MIME format.
--------------060907040509000901040202
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


If not configured it will be exported as normal GPIO led.

Signed-off-by: Jonas Zetterberg <jozz@jozz.se>
---
  arch/arm/mach-omap2/board-igep0020.c |   30 ++++++++++++++++++++++++++++--
  1 files changed, 28 insertions(+), 2 deletions(-)



--------------060907040509000901040202
Content-Type: text/x-patch;
 name="0002-IGEPv2-Use-Red-Led1-as-Heartbeat-if-configured.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-IGEPv2-Use-Red-Led1-as-Heartbeat-if-configured.patch"

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 00ea2d6..9958987 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -16,6 +16,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/gpio.h>
+#include <linux/leds.h>
 #include <linux/interrupt.h>
 
 #include <linux/regulator/machine.h>
@@ -354,9 +355,34 @@ static void __init igep2_display_init(void)
 	    gpio_direction_output(IGEP2_GPIO_DVI_PUP, 1))
 		pr_err("IGEP v2: Could not obtain gpio GPIO_DVI_PUP\n");
 }
+#ifdef CONFIG_LEDS_TRIGGERS
+static struct gpio_led gpio_leds[] = {
+	{
+		.name = "GPIO_LED1_RED",
+		.default_trigger = "heartbeat",
+		.gpio = IGEP2_GPIO_LED1_RED,
+	},
+};
+
+static struct gpio_led_platform_data gpio_leds_info = {
+	.leds           = gpio_leds,
+	.num_leds       = ARRAY_SIZE(gpio_leds),
+};
+
+static struct platform_device leds_gpio = {
+	 .name   = "leds-gpio",
+	 .id     = -1,
+	 .dev    = {
+		 .platform_data  =  &gpio_leds_info,
+	},
+};
+#endif
 
 static struct platform_device *igep2_devices[] __initdata = {
 	&igep2_dss_device,
+#ifdef CONFIG_LEDS_TRIGGERS
+	&leds_gpio,
+#endif
 };
 
 static void __init igep2_init_irq(void)
@@ -462,14 +488,14 @@ static void __init igep2_init(void)
 		gpio_set_value(IGEP2_GPIO_LED0_GREEN, 0);
 	} else
 		pr_warning("IGEP v2: Could not obtain gpio GPIO_LED0_GREEN\n");
-
+#ifndef CONFIG_LEDS_TRIGGERS
 	if ((gpio_request(IGEP2_GPIO_LED1_RED, "GPIO_LED1_RED") == 0) &&
 	    (gpio_direction_output(IGEP2_GPIO_LED1_RED, 1) == 0)) {
 		gpio_export(IGEP2_GPIO_LED1_RED, 0);
 		gpio_set_value(IGEP2_GPIO_LED1_RED, 0);
 	} else
 		pr_warning("IGEP v2: Could not obtain gpio GPIO_LED1_RED\n");
-
+#endif
 	/* GPIO W-LAN + Bluetooth combo module */
 	if ((gpio_request(IGEP2_GPIO_WIFI_NPD, "GPIO_WIFI_NPD") == 0) &&
 	    (gpio_direction_output(IGEP2_GPIO_WIFI_NPD, 1) == 0)) {


--------------060907040509000901040202--
