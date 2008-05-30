From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: [PATCH] ARM: OMAP: omap3beagle: add a platform device to hook up the GPIO leds to the leds-gpio driver
Date: Fri, 30 May 2008 13:54:08 +0200
Message-ID: <1212148448-7049-1-git-send-email-k.kooi@student.utwente.nl>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.utsp.utwente.nl ([130.89.2.8]:42098 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750822AbYE3MAS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 May 2008 08:00:18 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Koen Kooi <koen@openembedded.org>

From: Koen Kooi <koen@openembedded.org>

omap3beagle: add a platform device to hook up the GPIO leds to the leds-gpio driver
 * on revision A5 and earlier board the two leds can't be controlled seperately, should be fixed in rev. B and C boards.

Signed-off-by: Koen Kooi <koen@openembedded.org>
---
 arch/arm/mach-omap2/board-omap3beagle.c |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index c992cc7..83891fc 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -19,6 +19,7 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/leds.h>
 
 #include <asm/hardware.h>
 #include <asm/mach-types.h>
@@ -72,6 +73,32 @@ static struct omap_lcd_config omap3_beagle_lcd_config __initdata = {
 	.ctrl_name	= "internal",
 };
 
+struct gpio_led gpio_leds[] = {
+	{
+		.name = "beagleboard::led0",
+		.default_trigger = "none",
+		.gpio = 149,
+	},
+	{
+		.name = "beagleboard::led1",
+		.default_trigger = "none",
+		.gpio = 150,
+	},
+};
+
+static struct gpio_led_platform_data gpio_led_info = {
+	.leds = gpio_leds,
+	.num_leds = ARRAY_SIZE(gpio_leds),
+};
+
+static struct platform_device leds_gpio = {
+	.name = "leds-gpio",
+	.id   = -1,
+	.dev  = {
+		.platform_data = &gpio_led_info,
+	},
+};
+
 static struct omap_board_config_kernel omap3_beagle_config[] __initdata = {
 	{ OMAP_TAG_UART,	&omap3_beagle_uart_config },
 	{ OMAP_TAG_MMC,		&omap3beagle_mmc_config },
@@ -83,6 +110,7 @@ static struct platform_device *omap3_beagle_devices[] __initdata = {
 #ifdef CONFIG_RTC_DRV_TWL4030
 	&omap3_beagle_twl4030rtc_device,
 #endif
+	&leds_gpio,
 };
 
 static void __init omap3_beagle_init(void)
-- 
1.5.4.3

