From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH 4/7] [OMAP] htcherald: SPI register config, TSC2046 touchscreen
Date: Mon, 19 Jul 2010 21:07:43 -0700
Message-ID: <1279598866-18716-3-git-send-email-darkstar6262@gmail.com>
References: <1279598866-18716-1-git-send-email-darkstar6262@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60023 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100Ab0GTEIM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Jul 2010 00:08:12 -0400
Received: by mail-iw0-f174.google.com with SMTP id 7so5354123iwn.19
        for <linux-omap@vger.kernel.org>; Mon, 19 Jul 2010 21:08:12 -0700 (PDT)
In-Reply-To: <1279598866-18716-1-git-send-email-darkstar6262@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Cory Maccarrone <darkstar6262@gmail.com>

This change adds SPI bus support for the HTC Herald, and adds in
support for the TSC2046-based touchscreen attached to this
device (using the ADS7846 driver).

Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
---
 arch/arm/mach-omap1/board-htcherald.c |   35 +++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
index 2f0bb39..1b12b75 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -35,6 +35,8 @@
 #include <linux/i2c-gpio.h>
 #include <linux/htcpld.h>
 #include <linux/leds.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/ads7846.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -63,6 +65,9 @@
 #define HTCHERALD_GPIO_SLIDE 174
 #define HTCHERALD_GIRQ_BTNS 141
 
+/* GPIO definitions for the touchscreen */
+#define HTCHERALD_GPIO_TS 76
+
 /* HTCPLD definitions */
 
 /*
@@ -429,6 +434,33 @@ static struct platform_device *devices[] __initdata = {
 };
 
 /*
+ * Touchscreen
+ */
+static const struct ads7846_platform_data htcherald_ts_platform_data = {
+	.model			= 7846,
+	.keep_vref_on		= 1,
+	.x_plate_ohms		= 496,
+	.gpio_pendown		= HTCHERALD_GPIO_TS,
+	.pressure_max		= 100000,
+	.pressure_min		= 5000,
+	.x_min			= 528,
+	.x_max			= 3760,
+	.y_min			= 624,
+	.y_max			= 3760,
+};
+
+static struct spi_board_info __initdata htcherald_spi_board_info[] = {
+	{
+		.modalias		= "ads7846",
+		.platform_data		= &htcherald_ts_platform_data,
+		.irq			= OMAP_GPIO_IRQ(HTCHERALD_GPIO_TS),
+		.max_speed_hz		= 2500000,
+		.bus_num		= 2,
+		.chip_select		= 1,
+	}
+};
+
+/*
  * Init functions from here on
  */
 
@@ -558,6 +590,9 @@ static void __init htcherald_init(void)
 	htcherald_usb_enable();
 	omap1_usb_init(&htcherald_usb_config);
 
+	spi_register_board_info(htcherald_spi_board_info,
+		ARRAY_SIZE(htcherald_spi_board_info));
+
 	omap_register_i2c_bus(1, 100, NULL, 0);
 
 #if defined(CONFIG_MMC_OMAP) || defined(CONFIG_MMC_OMAP_MODULE)
-- 
1.7.0.4

