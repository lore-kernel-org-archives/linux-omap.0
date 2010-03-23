From: Roger Quadros <roger.quadros@nokia.com>
Subject: [PATCH 1/5] OMAP: RX51: Add LCD Panel support
Date: Tue, 23 Mar 2010 11:56:27 +0200
Message-ID: <1269338191-10734-2-git-send-email-roger.quadros@nokia.com>
References: <1269338191-10734-1-git-send-email-roger.quadros@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:49785 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753471Ab0CWJ5I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Mar 2010 05:57:08 -0400
In-Reply-To: <1269338191-10734-1-git-send-email-roger.quadros@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: Tomi.Valkeinen@nokia.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

From: Roger Quadros <roger.quadros@nokia.com>

Adds basic support for LCD Panel on Nokia N900

Signed-off-by: Roger Quadros <roger.quadros@nokia.com>
---
 arch/arm/mach-omap2/Makefile                 |    1 +
 arch/arm/mach-omap2/board-rx51-peripherals.c |   13 ++++
 arch/arm/mach-omap2/board-rx51-video.c       |   95 ++++++++++++++++++++++++++
 3 files changed, 109 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-rx51-video.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 4b9fc57..b03cbb4 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -122,6 +122,7 @@ obj-$(CONFIG_MACH_NOKIA_N8X0)		+= board-n8x0.o
 obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
 					   board-rx51-sdram.o \
 					   board-rx51-peripherals.o \
+					   board-rx51-video.o \
 					   hsmmc.o
 obj-$(CONFIG_MACH_OMAP_ZOOM2)		+= board-zoom2.o \
 					   board-zoom-peripherals.o \
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 4377a4c..f404537 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -45,6 +45,7 @@
 /* list all spi devices here */
 enum {
 	RX51_SPI_WL1251,
+	RX51_SPI_MIPID,		/* LCD panel */
 };
 
 static struct wl12xx_platform_data wl1251_pdata;
@@ -54,6 +55,11 @@ static struct omap2_mcspi_device_config wl1251_mcspi_config = {
 	.single_channel	= 1,
 };
 
+static struct omap2_mcspi_device_config mipid_mcspi_config = {
+	.turbo_mode	= 0,
+	.single_channel	= 1,
+};
+
 static struct spi_board_info rx51_peripherals_spi_board_info[] __initdata = {
 	[RX51_SPI_WL1251] = {
 		.modalias		= "wl1251",
@@ -64,6 +70,13 @@ static struct spi_board_info rx51_peripherals_spi_board_info[] __initdata = {
 		.controller_data	= &wl1251_mcspi_config,
 		.platform_data		= &wl1251_pdata,
 	},
+	[RX51_SPI_MIPID] = {
+		.modalias		= "acx565akm",
+		.bus_num		= 1,
+		.chip_select		= 2,
+		.max_speed_hz		= 6000000,
+		.controller_data	= &mipid_mcspi_config,
+	},
 };
 
 #if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
diff --git a/arch/arm/mach-omap2/board-rx51-video.c b/arch/arm/mach-omap2/board-rx51-video.c
new file mode 100644
index 0000000..e3e22a8
--- /dev/null
+++ b/arch/arm/mach-omap2/board-rx51-video.c
@@ -0,0 +1,95 @@
+/*
+ * linux/arch/arm/mach-omap2/board-rx51-peripherals.c
+ *
+ * Copyright (C) 2010 Nokia
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+#include <linux/spi/spi.h>
+
+#include <asm/mach-types.h>
+#include <plat/mux.h>
+#include <plat/display.h>
+#include <plat/mcspi.h>
+
+#include "mux.h"
+
+#define RX51_LCD_RESET_GPIO	90
+
+#if defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE)
+
+static int rx51_lcd_enable(struct omap_dss_device *dssdev)
+{
+	gpio_set_value(dssdev->reset_gpio, 1);
+	return 0;
+}
+
+static void rx51_lcd_disable(struct omap_dss_device *dssdev)
+{
+	gpio_set_value(dssdev->reset_gpio, 0);
+}
+
+static struct omap_dss_device rx51_lcd_device = {
+	.name			= "lcd",
+	.driver_name		= "panel-acx565akm",
+	.type			= OMAP_DISPLAY_TYPE_SDI,
+	.phy.sdi.datapairs	= 2,
+	.reset_gpio		= RX51_LCD_RESET_GPIO,
+	.platform_enable	= rx51_lcd_enable,
+	.platform_disable	= rx51_lcd_disable,
+};
+
+static struct omap_dss_device *rx51_dss_devices[] = {
+	&rx51_lcd_device,
+};
+
+static struct omap_dss_board_info rx51_dss_board_info = {
+	.num_devices	= ARRAY_SIZE(rx51_dss_devices),
+	.devices	= rx51_dss_devices,
+	.default_device	= &rx51_lcd_device,
+};
+
+struct platform_device rx51_display_device = {
+	.name	= "omapdss",
+	.id	= -1,
+	.dev	= {
+		.platform_data = &rx51_dss_board_info,
+	},
+};
+
+static struct platform_device *rx51_video_devices[] __initdata = {
+	&rx51_display_device,
+};
+
+static int __init rx51_video_init(void)
+{
+	if (!machine_is_nokia_rx51())
+		return 0;
+
+	if (omap_mux_init_gpio(RX51_LCD_RESET_GPIO, OMAP_PIN_OUTPUT)) {
+		pr_err("%s cannot configure MUX for LCD RESET\n", __func__);
+		return 0;
+	}
+
+	if (gpio_request(RX51_LCD_RESET_GPIO, "LCD ACX565AKM reset")) {
+		pr_err("%s failed to get LCD Reset GPIO\n", __func__);
+		return 0;
+	}
+
+	gpio_direction_output(RX51_LCD_RESET_GPIO, 1);
+
+	platform_add_devices(rx51_video_devices,
+				ARRAY_SIZE(rx51_video_devices));
+	return 0;
+}
+
+subsys_initcall(rx51_video_init);
+
+#endif /* defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE) */
-- 
1.6.0.4

