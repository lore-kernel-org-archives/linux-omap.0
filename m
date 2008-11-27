From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH 1/2] Add support for GPIO LEDs on pandora
Date: Thu, 27 Nov 2008 12:02:42 +0200
Message-ID: <1227780163-5879-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:22623 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187AbYK0KDV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Nov 2008 05:03:21 -0500
Received: by ey-out-2122.google.com with SMTP id 6so384191eyi.37
        for <linux-omap@vger.kernel.org>; Thu, 27 Nov 2008 02:03:19 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Grazvydas Ignotas <notasas@gmail.com>

Pandora has some LEDs and backlights connected to OMAP
GPIOs and TWL4030/TPS65950 LED/PWM signals. This patch
registers them all with leds-gpio driver. TWL4030/TPS65950
controlled ones will be switched to PWM driver when it's ready.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 arch/arm/mach-omap2/board-omap3pandora.c |   60 ++++++++++++++++++++++++++++++
 1 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index 69517a5..2dfa988 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -28,6 +28,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
 #include <linux/i2c/twl4030.h>
+#include <linux/leds.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
@@ -166,6 +167,53 @@ static struct omap_uart_config omap3pandora_uart_config __initdata = {
 	.enabled_uarts	= (1 << 2), /* UART3 */
 };
 
+static struct gpio_led omap3pandora_gpio_leds[] = {
+	{
+		.name			= "pandora::keypad_bl",
+		.gpio			= -EINVAL,	/* gets replaced */
+		.active_low		= true,
+	}, {
+		.name			= "pandora::power",
+		.default_trigger	= "default-on",
+		.gpio			= -EINVAL,
+		.active_low		= true,
+	}, {
+		.name			= "pandora::lcd_bl",
+		.default_trigger	= "backlight",
+		.gpio			= -EINVAL,
+	}, {
+		.name			= "pandora::charger",
+		.gpio			= -EINVAL,
+	}, {
+		.name			= "pandora::sd1",
+		.default_trigger	= "mmc0",
+		.gpio			= 128,
+	}, {
+		.name			= "pandora::sd2",
+		.default_trigger	= "mmc1",
+		.gpio			= 129,
+	}, {
+		.name			= "pandora::bluetooth",
+		.gpio			= 158,
+	}, {
+		.name			= "pandora::wifi",
+		.gpio			= 159,
+	},
+};
+
+static struct gpio_led_platform_data omap3pandora_gpio_led_data = {
+	.leds		= omap3pandora_gpio_leds,
+	.num_leds	= ARRAY_SIZE(omap3pandora_gpio_leds),
+};
+
+static struct platform_device omap3pandora_leds_gpio = {
+	.name	= "leds-gpio",
+	.id	= -1,
+	.dev	= {
+		.platform_data	= &omap3pandora_gpio_led_data,
+	},
+};
+
 static int omap3pandora_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
@@ -174,6 +222,16 @@ static int omap3pandora_twl_gpio_setup(struct device *dev,
 	omap3pandora_mmc[1].gpio_cd = gpio + 1;
 	hsmmc_init(omap3pandora_mmc);
 
+	/* TWL4030_GPIO_MAX + 0 == ledA, KEYPAD_BACKLIGHT (out, active low) */
+	omap3pandora_gpio_leds[0].gpio = gpio + TWL4030_GPIO_MAX + 0;
+
+	/* TWL4030_GPIO_MAX + 1 == ledB, POWER_LED (out, active low) */
+	omap3pandora_gpio_leds[1].gpio = gpio + TWL4030_GPIO_MAX + 1;
+
+	/* gpio + {6,7} is PWM{0,1}, LCD_BACKLIGHT and CHARGER_LED */
+	omap3pandora_gpio_leds[2].gpio = gpio + 6;
+	omap3pandora_gpio_leds[3].gpio = gpio + 7;
+
 	return 0;
 }
 
@@ -181,6 +239,7 @@ static struct twl4030_gpio_platform_data omap3pandora_gpio_data = {
 	.gpio_base	= OMAP_MAX_GPIO_LINES,
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
 	.irq_end	= TWL4030_GPIO_IRQ_END,
+	.use_leds	= true,
 	.setup		= omap3pandora_twl_gpio_setup,
 };
 
@@ -285,6 +344,7 @@ static struct omap_board_config_kernel omap3pandora_config[] __initdata = {
 
 static struct platform_device *omap3pandora_devices[] __initdata = {
 	&omap3pandora_lcd_device,
+	&omap3pandora_leds_gpio,
 };
 
 static void __init omap3pandora_init(void)
-- 
1.5.4.3

