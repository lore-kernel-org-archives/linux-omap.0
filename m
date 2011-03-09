From: Steve Sakoman <steve@sakoman.com>
Subject: [PATCH 1/2] OMAP: Add gpio-leds support for Overo
Date: Wed,  9 Mar 2011 12:20:54 -0800
Message-ID: <1299702055-12480-2-git-send-email-steve@sakoman.com>
References: <1299702055-12480-1-git-send-email-steve@sakoman.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45276 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818Ab1CIUVf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Mar 2011 15:21:35 -0500
Received: by mail-fx0-f46.google.com with SMTP id 17so872047fxm.19
        for <linux-omap@vger.kernel.org>; Wed, 09 Mar 2011 12:21:34 -0800 (PST)
In-Reply-To: <1299702055-12480-1-git-send-email-steve@sakoman.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tomi.valkeinen@ti.com, Steve Sakoman <steve@sakoman.com>

This patch adds support for the standard LEDs on the Overo COM and expansion boards

Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 arch/arm/mach-omap2/board-overo.c |   51 +++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 4278ecb..adc204b 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -473,6 +473,52 @@ static struct regulator_consumer_supply overo_vmmc1_supply = {
 	.supply			= "vmmc",
 };
 
+#if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
+#include <linux/leds.h>
+
+static struct gpio_led gpio_leds[] = {
+	{
+		.name			= "overo:red:gpio21",
+		.default_trigger	= "heartbeat",
+		.gpio			= 21,
+		.active_low		= true,
+	},
+	{
+		.name			= "overo:blue:gpio22",
+		.default_trigger	= "none",
+		.gpio			= 22,
+		.active_low		= true,
+	},
+	{
+		.name			= "overo:blue:COM",
+		.default_trigger	= "mmc0",
+		.gpio			= -EINVAL,	/* gets replaced */
+		.active_low		= true,
+	},
+};
+
+static struct gpio_led_platform_data gpio_leds_pdata = {
+	.leds		= gpio_leds,
+	.num_leds	= ARRAY_SIZE(gpio_leds),
+};
+
+static struct platform_device gpio_leds_device = {
+	.name	= "leds-gpio",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &gpio_leds_pdata,
+	},
+};
+
+static void __init overo_init_led(void)
+{
+	platform_device_register(&gpio_leds_device);
+}
+
+#else
+static inline void __init overo_init_led(void) { return; }
+#endif
+
 static int overo_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
@@ -480,6 +526,9 @@ static int overo_twl_gpio_setup(struct device *dev,
 
 	overo_vmmc1_supply.dev = mmc[0].dev;
 
+	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
+	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
+
 	return 0;
 }
 
@@ -487,6 +536,7 @@ static struct twl4030_gpio_platform_data overo_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
 	.irq_end	= TWL4030_GPIO_IRQ_END,
+	.use_leds	= true,
 	.setup		= overo_twl_gpio_setup,
 };
 
@@ -648,6 +698,7 @@ static void __init overo_init(void)
 	overo_spi_init();
 	overo_init_smsc911x();
 	overo_display_init();
+	overo_init_led();
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
 	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
-- 
1.7.0.4

