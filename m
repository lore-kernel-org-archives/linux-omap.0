From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 17/23] IGEPv2: Use Red Led1 as Heartbeat if configured
Date: Wed, 17 Feb 2010 17:32:33 -0800
Message-ID: <20100218013233.32075.60849.stgit@baageli.muru.com>
References: <20100218013012.32075.43788.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63488 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755072Ab0BRBbn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Feb 2010 20:31:43 -0500
In-Reply-To: <20100218013012.32075.43788.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Jonas Zetterberg <jozz@jozz.se>, linux-omap@vger.kernel.org

From: Jonas Zetterberg <jozz@jozz.se>

If not configured it will be exported as normal GPIO led.

Signed-off-by: Jonas Zetterberg <jozz@jozz.se>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-igep0020.c |   30 ++++++++++++++++++++++++++++--
 1 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 4a5d663..748f418 100644
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
@@ -456,14 +482,14 @@ static void __init igep2_init(void)
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

