From: "Nagarajan, Rajkumar" <x0133774@ti.com>
Subject: [PATCH 1/2 V7] OMAP: ZOOM2/3&SDP3630: Add display board file for
 zoom boards
Date: Fri, 21 May 2010 20:47:39 +0530
Message-ID: <FF55437E1F14DA4BAEB721A458B6701706BD6F2257@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57951 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932381Ab0EUPRp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 21 May 2010 11:17:45 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o4LFHfrS009608
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 21 May 2010 10:17:44 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id o4LFHfSU014766
	for <linux-omap@vger.kernel.org>; Fri, 21 May 2010 20:47:41 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


board-zoom-display.c added as a common file for display functionality
on boards zoom2, zoom3 and 3630sdp

Signed-off-by: Mukund Mittal <mmittal@ti.com>
Signed-off-by: Kishore Y <kishore.y@ti.com>
Signed-off-by: Rajkumar N <rajkumar.nagarajan@ti.com>
Reviewed-by: Gadiyar, Anand <gadiyar@ti.com>
---
 arch/arm/mach-omap2/Makefile                  |    3 +
 arch/arm/mach-omap2/board-3630sdp.c           |    1 +
 arch/arm/mach-omap2/board-zoom-display.c      |  158 +++++++++++++++++++++++++
 arch/arm/mach-omap2/board-zoom-peripherals.c  |   48 ++++++++-
 arch/arm/mach-omap2/board-zoom2.c             |    1 +
 arch/arm/mach-omap2/board-zoom3.c             |    1 +
 arch/arm/mach-omap2/include/mach/board-zoom.h |    3 +
 7 files changed, 214 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-zoom-display.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index b03cbb4..a79e6f0 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -125,14 +125,17 @@ obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
 					   board-rx51-video.o \
 					   hsmmc.o
 obj-$(CONFIG_MACH_OMAP_ZOOM2)		+= board-zoom2.o \
+						board-zoom-display.o \
 					   board-zoom-peripherals.o \
 					   hsmmc.o \
 					   board-zoom-debugboard.o
 obj-$(CONFIG_MACH_OMAP_ZOOM3)		+= board-zoom3.o \
+						board-zoom-display.o \
 					   board-zoom-peripherals.o \
 					   hsmmc.o \
 					   board-zoom-debugboard.o
 obj-$(CONFIG_MACH_OMAP_3630SDP)		+= board-3630sdp.o \
+						board-zoom-display.o \
 					   board-zoom-peripherals.o \
 					   hsmmc.o
 obj-$(CONFIG_MACH_CM_T35)		+= board-cm-t35.o \
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index a0a2a11..048afe3 100644
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -97,6 +97,7 @@ static void __init omap_sdp_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBP);
 	zoom_peripherals_init();
+	zoom_display_init(OMAP_DSS_VENC_TYPE_SVIDEO);
 	board_smc91x_init();
 	enable_board_wakeup_source();
 	usb_ehci_init(&ehci_pdata);
diff --git a/arch/arm/mach-omap2/board-zoom-display.c b/arch/arm/mach-omap2/board-zoom-display.c
new file mode 100644
index 0000000..e6e4f08
--- /dev/null
+++ b/arch/arm/mach-omap2/board-zoom-display.c
@@ -0,0 +1,158 @@
+/*
+ * Copyright (C) 2010 Texas Instruments Inc.
+ *
+ * Modified from mach-omap2/board-zoom-peripherals.c
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
+#include <linux/i2c/twl.h>
+#include <linux/spi/spi.h>
+#include <plat/common.h>
+#include <plat/control.h>
+#include <plat/mcspi.h>
+#include <plat/display.h>
+
+#define LCD_PANEL_ENABLE_GPIO		(7 + OMAP_MAX_GPIO_LINES)
+#define LCD_PANEL_RESET_GPIO_PROD	96
+#define LCD_PANEL_RESET_GPIO_PILOT	55
+#define LCD_PANEL_QVGA_GPIO		56
+#define TV_PANEL_ENABLE_GPIO		95
+
+static void zoom_lcd_tv_panel_init(void)
+{
+	int ret;
+	unsigned char lcd_panel_reset_gpio;
+
+	lcd_panel_reset_gpio = (omap_rev() > OMAP3430_REV_ES3_0) ?
+				LCD_PANEL_RESET_GPIO_PROD :
+				LCD_PANEL_RESET_GPIO_PILOT;
+
+	ret = gpio_request(lcd_panel_reset_gpio, "lcd reset");
+	if (ret) {
+		pr_err("Failed to get LCD reset GPIO (gpio%d)\n",
+			lcd_panel_reset_gpio);
+		return;
+	}
+	gpio_direction_output(lcd_panel_reset_gpio, 1);
+
+	ret = gpio_request(LCD_PANEL_QVGA_GPIO, "lcd qvga");
+	if (ret) {
+		pr_err("Failed to get LCD_PANEL_QVGA_GPIO (gpio%d).\n",
+			LCD_PANEL_QVGA_GPIO);
+		goto err0;
+	}
+	gpio_direction_output(LCD_PANEL_QVGA_GPIO, 1);
+
+	ret = gpio_request(TV_PANEL_ENABLE_GPIO, "tv panel");
+	if (ret) {
+		pr_err("Failed to get TV_PANEL_ENABLE_GPIO (gpio%d).\n",
+			TV_PANEL_ENABLE_GPIO);
+		goto err1;
+	}
+	gpio_direction_output(TV_PANEL_ENABLE_GPIO, 1);
+
+	return;
+
+err1:
+	gpio_free(LCD_PANEL_QVGA_GPIO);
+err0:
+	gpio_free(lcd_panel_reset_gpio);
+}
+
+static int zoom_panel_enable_lcd(struct omap_dss_device *dssdev)
+{
+	gpio_set_value(LCD_PANEL_ENABLE_GPIO, 1);
+
+	return 0;
+}
+
+static void zoom_panel_disable_lcd(struct omap_dss_device *dssdev)
+{
+	gpio_set_value(LCD_PANEL_ENABLE_GPIO, 0);
+}
+
+static int zoom_panel_enable_tv(struct omap_dss_device *dssdev)
+{
+	gpio_set_value(TV_PANEL_ENABLE_GPIO, 0);
+
+	return 0;
+}
+
+static void zoom_panel_disable_tv(struct omap_dss_device *dssdev)
+{
+	gpio_set_value(TV_PANEL_ENABLE_GPIO, 1);
+}
+
+static struct omap_dss_device zoom_lcd_device = {
+	.name = "lcd",
+	.driver_name = "NEC_8048_panel",
+	.type = OMAP_DISPLAY_TYPE_DPI,
+	.phy.dpi.data_lines = 24,
+	.platform_enable = zoom_panel_enable_lcd,
+	.platform_disable = zoom_panel_disable_lcd,
+};
+
+static struct omap_dss_device zoom_tv_device = {
+	.name                   = "tv",
+	.driver_name            = "venc",
+	.type                   = OMAP_DISPLAY_TYPE_VENC,
+	.phy.venc.type          = -1,
+	.platform_enable        = zoom_panel_enable_tv,
+	.platform_disable       = zoom_panel_disable_tv,
+};
+
+static struct omap_dss_device *zoom_dss_devices[] = {
+	&zoom_lcd_device,
+	&zoom_tv_device,
+};
+
+static struct omap_dss_board_info zoom_dss_data = {
+	.num_devices = ARRAY_SIZE(zoom_dss_devices),
+	.devices = zoom_dss_devices,
+	.default_device = &zoom_lcd_device,
+};
+
+static struct platform_device zoom_dss_device = {
+	.name          = "omapdss",
+	.id            = -1,
+	.dev            = {
+		.platform_data = &zoom_dss_data,
+	},
+};
+
+static struct omap2_mcspi_device_config dss_lcd_mcspi_config = {
+	.turbo_mode             = 1,
+	.single_channel         = 1,  /* 0: slave, 1: master */
+};
+
+static struct spi_board_info nec_8048_spi_board_info[] __initdata = {
+	[0] = {
+		.modalias               = "nec_8048_spi",
+		.bus_num                = 1,
+		.chip_select            = 2,
+		.max_speed_hz           = 375000,
+		.controller_data        = &dss_lcd_mcspi_config,
+	},
+};
+
+static struct platform_device *zoom_display_devices[] __initdata = {
+	&zoom_dss_device,
+};
+
+void __init zoom_display_init(enum omap_dss_venc_type venc_type)
+{
+	zoom_tv_device.phy.venc.type = venc_type;
+	platform_add_devices(zoom_display_devices,
+				ARRAY_SIZE(zoom_display_devices));
+	spi_register_board_info(nec_8048_spi_board_info,
+				ARRAY_SIZE(nec_8048_spi_board_info));
+	zoom_lcd_tv_panel_init();
+}
+
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index ca95d8d..306167e 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -27,6 +27,8 @@
 #include "mux.h"
 #include "hsmmc.h"
 
+#define LCD_PANEL_ENABLE_GPIO		(7 + OMAP_MAX_GPIO_LINES)
+
 /* Zoom2 has Qwerty keyboard*/
 static int board_keymap[] = {
 	KEY(0, 0, KEY_E),
@@ -171,9 +173,43 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 	{}      /* Terminator */
 };
 
+static struct regulator_consumer_supply zoom_vpll2_supply =
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss");
+
+static struct regulator_consumer_supply zoom_vdda_dac_supply =
+	REGULATOR_SUPPLY("vdda_dac", "omapdss");
+
+static struct regulator_init_data zoom_vpll2 = {
+	.constraints = {
+		.min_uV                 = 1800000,
+		.max_uV                 = 1800000,
+		.valid_modes_mask       = REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask         = REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies  = 1,
+	.consumer_supplies      = &zoom_vpll2_supply,
+};
+
+static struct regulator_init_data zoom_vdac = {
+	.constraints = {
+		.min_uV                 = 1800000,
+		.max_uV                 = 1800000,
+		.valid_modes_mask       = REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask         = REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies  = 1,
+	.consumer_supplies      = &zoom_vdda_dac_supply,
+};
+
 static int zoom_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
+	int ret;
+
 	/* gpio + 0 is "mmc0_cd" (input/IRQ) */
 	mmc[0].gpio_cd = gpio + 0;
 	omap2_hsmmc_init(mmc);
@@ -185,7 +221,15 @@ static int zoom_twl_gpio_setup(struct device *dev,
 	zoom_vsim_supply.dev = mmc[0].dev;
 	zoom_vmmc2_supply.dev = mmc[1].dev;
 
-	return 0;
+	ret = gpio_request(LCD_PANEL_ENABLE_GPIO, "lcd enable");
+	if (ret) {
+		pr_err("Failed to get LCD_PANEL_ENABLE_GPIO (gpio%d).\n",
+				LCD_PANEL_ENABLE_GPIO);
+		return ret;
+	}
+	gpio_direction_output(LCD_PANEL_ENABLE_GPIO, 0);
+
+	return ret;
 }
 
 
@@ -243,6 +287,8 @@ static struct twl4030_platform_data zoom_twldata = {
 	.vmmc1          = &zoom_vmmc1,
 	.vmmc2          = &zoom_vmmc2,
 	.vsim           = &zoom_vsim,
+	.vpll2		= &zoom_vpll2,
+	.vdac		= &zoom_vdac,
 
 };
 
diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index 9a26f84..c432a21 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -82,6 +82,7 @@ static void __init omap_zoom2_init(void)
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	zoom_peripherals_init();
 	zoom_debugboard_init();
+	zoom_display_init(OMAP_DSS_VENC_TYPE_COMPOSITE);
 }
 
 static void __init omap_zoom2_map_io(void)
diff --git a/arch/arm/mach-omap2/board-zoom3.c b/arch/arm/mach-omap2/board-zoom3.c
index cd3e40c..25ed9b4 100644
--- a/arch/arm/mach-omap2/board-zoom3.c
+++ b/arch/arm/mach-omap2/board-zoom3.c
@@ -70,6 +70,7 @@ static void __init omap_zoom_init(void)
 
 	omap_mux_init_gpio(64, OMAP_PIN_OUTPUT);
 	usb_ehci_init(&ehci_pdata);
+	zoom_display_init(OMAP_DSS_VENC_TYPE_COMPOSITE);
 }
 
 MACHINE_START(OMAP_ZOOM3, "OMAP Zoom3 board")
diff --git a/arch/arm/mach-omap2/include/mach/board-zoom.h b/arch/arm/mach-omap2/include/mach/board-zoom.h
index c93b29e..aec73b4 100644
--- a/arch/arm/mach-omap2/include/mach/board-zoom.h
+++ b/arch/arm/mach-omap2/include/mach/board-zoom.h
@@ -1,5 +1,8 @@
 /*
  * Defines for zoom boards
  */
+#include <plat/display.h>
+
 extern int __init zoom_debugboard_init(void);
 extern void __init zoom_peripherals_init(void);
+extern void __init zoom_display_init(enum omap_dss_venc_type venc_type);
-- 
1.5.4.3
