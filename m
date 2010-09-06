From: Ricardo Salveti de Araujo <ricardo.salveti@canonical.com>
Subject: [PATCH] omap4: board-omap4panda: adding leds status1 and status2
Date: Mon,  6 Sep 2010 19:02:21 -0300
Message-ID: <1283810541-9247-1-git-send-email-ricardo.salveti@canonical.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:32899 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448Ab0IFWC6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Sep 2010 18:02:58 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Bryan Wu <bryan.wu@canonical.com>, Ricardo Salveti de Araujo <ricardo.salveti@canonical.com>

At Pandaboard we have 2 status leds, so adding them with similar usage as
we have for Beagleboard (heartbeat and mmc0). The patch basically adds the
platform data required by leds-gpio driver.

Signed-off-by: Ricardo Salveti de Araujo <ricardo.salveti@canonical.com>
---
 arch/arm/mach-omap2/board-omap4panda.c |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 96f5bbb..e67bd2c 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -20,6 +20,7 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/leds.h>
 #include <linux/gpio.h>
 #include <linux/usb/otg.h>
 #include <linux/i2c/twl.h>
@@ -40,6 +41,36 @@
 #include "hsmmc.h"
 
 
+static struct gpio_led gpio_leds[] = {
+	{
+		.name			= "pandaboard::status1",
+		.default_trigger	= "heartbeat",
+		.gpio			= 7,
+	},
+	{
+		.name			= "pandaboard::status2",
+		.default_trigger	= "mmc0",
+		.gpio			= 8,
+	},
+};
+
+static struct gpio_led_platform_data gpio_led_info = {
+	.leds		= gpio_leds,
+	.num_leds	= ARRAY_SIZE(gpio_leds),
+};
+
+static struct platform_device leds_gpio = {
+	.name	= "leds-gpio",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &gpio_led_info,
+	},
+};
+
+static struct platform_device *panda_devices[] __initdata = {
+	&leds_gpio,
+};
+
 static void __init omap4_panda_init_irq(void)
 {
 	omap2_init_common_hw(NULL, NULL);
@@ -275,6 +306,7 @@ static int __init omap4_panda_i2c_init(void)
 static void __init omap4_panda_init(void)
 {
 	omap4_panda_i2c_init();
+	platform_add_devices(panda_devices, ARRAY_SIZE(panda_devices));
 	omap_serial_init();
 	omap4_twl6030_hsmmc_init(mmc);
 	/* OMAP4 Panda uses internal transceiver so register nop transceiver */
-- 
1.7.1

