From: Samreen <samreen@ti.com>
Subject: [PATCH 1/2] OMAP3: ZOOM2/3/3630SDP: Add display board file for OMAP3
Date: Thu, 14 Oct 2010 16:57:08 +0530
Message-ID: <1287055629-25153-2-git-send-email-samreen@ti.com>
References: <1287055629-25153-1-git-send-email-samreen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46924 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753109Ab0JNLbz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Oct 2010 07:31:55 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o9EBVtCc023949
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 14 Oct 2010 06:31:55 -0500
In-Reply-To: <1287055629-25153-1-git-send-email-samreen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kishore Y <kishore.y@ti.com>, Mukund Mittal <mmittal@ti.com>, Rajkumar N <rajkumar.nagarajan@ti.com>, Samreen <samreen@ti.com>

From: Kishore Y <kishore.y@ti.com>

Board-zoom-display.c added as a common file for display functionality
on boards zoom2, zoom3 and 3630sdp

Signed-off-by: Mukund Mittal <mmittal@ti.com>
Signed-off-by: Kishore Y <kishore.y@ti.com>
Signed-off-by: Rajkumar N <rajkumar.nagarajan@ti.com>
Signed-off-by: Samreen <samreen@ti.com>
---
 arch/arm/mach-omap2/Makefile                  |    3 +
 arch/arm/mach-omap2/board-zoom-display.c      |  165 +++++++++++++++++++++++++
 arch/arm/mach-omap2/board-zoom-peripherals.c  |   49 +++++++-
 arch/arm/mach-omap2/include/mach/board-zoom.h |    2 +
 4 files changed, 217 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-zoom-display.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 88d3a1e..95e0ecf 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -132,16 +132,19 @@ obj-$(CONFIG_MACH_NOKIA_RX51)		+= board-rx51.o \
 					   hsmmc.o
 obj-$(CONFIG_MACH_OMAP_ZOOM2)		+= board-zoom2.o \
 					   board-zoom-peripherals.o \
+					   board-zoom-display.o \
 					   board-flash.o \
 					   hsmmc.o \
 					   board-zoom-debugboard.o
 obj-$(CONFIG_MACH_OMAP_ZOOM3)		+= board-zoom3.o \
 					   board-zoom-peripherals.o \
+					   board-zoom-display.o \
 					   board-flash.o \
 					   hsmmc.o \
 					   board-zoom-debugboard.o
 obj-$(CONFIG_MACH_OMAP_3630SDP)		+= board-3630sdp.o \
 					   board-zoom-peripherals.o \
+					   board-zoom-display.o \
 					   board-flash.o \
 					   hsmmc.o
 obj-$(CONFIG_MACH_CM_T35)		+= board-cm-t35.o \
diff --git a/arch/arm/mach-omap2/board-zoom-display.c b/arch/arm/mach-omap2/board-zoom-display.c
new file mode 100644
index 0000000..1e0b3da
--- /dev/null
+++ b/arch/arm/mach-omap2/board-zoom-display.c
@@ -0,0 +1,165 @@
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
+#include <plat/mcspi.h>
+#include <plat/display.h>
+
+#define LCD_PANEL_ENABLE_GPIO		(7 + OMAP_MAX_GPIO_LINES)
+#define LCD_PANEL_RESET_GPIO_PROD	96
+#define LCD_PANEL_RESET_GPIO_PILOT	55
+#define LCD_PANEL_QVGA_GPIO		56
+
+static void zoom_lcd_panel_init(void)
+{
+	int ret;
+	unsigned char lcd_panel_reset_gpio;
+
+	lcd_panel_reset_gpio = (omap_rev() > OMAP3430_REV_ES3_0) ?
+			LCD_PANEL_RESET_GPIO_PROD :
+			LCD_PANEL_RESET_GPIO_PILOT;
+
+	ret = gpio_request(lcd_panel_reset_gpio, "lcd reset");
+	if (ret) {
+		pr_err("Failed to get LCD reset GPIO (gpio%d).\n",
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
+	return;
+err0:
+	gpio_free(lcd_panel_reset_gpio);
+}
+
+static int zoom_panel_enable_lcd(struct omap_dss_device *dssdev)
+{
+	return 0;
+}
+
+static void zoom_panel_disable_lcd(struct omap_dss_device *dssdev)
+{
+}
+
+/*
+ * PWMA/B register offsets (TWL4030_MODULE_PWMA)
+ */
+#define TWL_INTBR_PMBR1	0xD
+#define TWL_INTBR_GPBR1	0xC
+#define TWL_LED_PWMON	0x0
+#define TWL_LED_PWMOFF	0x1
+
+static int zoom_set_bl_intensity(struct omap_dss_device *dssdev, int level)
+{
+	unsigned char c;
+	u8 mux_pwm, enb_pwm;
+
+	if (level > 100)
+		return -1;
+
+	twl_i2c_read_u8(TWL4030_MODULE_INTBR, &mux_pwm, TWL_INTBR_PMBR1);
+	twl_i2c_read_u8(TWL4030_MODULE_INTBR, &enb_pwm, TWL_INTBR_GPBR1);
+
+	if (level == 0) {
+		/* disable pwm1 output and clock */
+		enb_pwm = enb_pwm & 0xF5;
+		/* change pwm1 pin to gpio pin */
+		mux_pwm = mux_pwm & 0xCF;
+		twl_i2c_write_u8(TWL4030_MODULE_INTBR,
+					enb_pwm, TWL_INTBR_GPBR1);
+		twl_i2c_write_u8(TWL4030_MODULE_INTBR,
+					mux_pwm, TWL_INTBR_PMBR1);
+		return 0;
+	}
+
+	/* change gpio pin to pwm1 pin */
+	mux_pwm = mux_pwm | 0x30;
+	/* enable pwm1 output and clock*/
+	enb_pwm = enb_pwm | 0x0A;
+	twl_i2c_write_u8(TWL4030_MODULE_INTBR, mux_pwm, TWL_INTBR_PMBR1);
+	twl_i2c_write_u8(TWL4030_MODULE_INTBR, enb_pwm, TWL_INTBR_GPBR1);
+
+	c = ((50 * (100 - level)) / 100) + 1;
+	twl_i2c_write_u8(TWL4030_MODULE_PWM1, 0x7F, TWL_LED_PWMOFF);
+	twl_i2c_write_u8(TWL4030_MODULE_PWM1, c, TWL_LED_PWMON);
+
+	return 0;
+}
+
+static struct omap_dss_device zoom_lcd_device = {
+	.name			= "lcd",
+	.driver_name		= "NEC_8048_panel",
+	.type			= OMAP_DISPLAY_TYPE_DPI,
+	.phy.dpi.data_lines	= 24,
+	.platform_enable	= zoom_panel_enable_lcd,
+	.platform_disable	= zoom_panel_disable_lcd,
+	.max_backlight_level	= 100,
+	.set_backlight		= zoom_set_bl_intensity,
+};
+
+static struct omap_dss_device *zoom_dss_devices[] = {
+	&zoom_lcd_device,
+};
+
+static struct omap_dss_board_info zoom_dss_data = {
+	.num_devices		= ARRAY_SIZE(zoom_dss_devices),
+	.devices		= zoom_dss_devices,
+	.default_device		= &zoom_lcd_device,
+};
+
+static struct platform_device zoom_dss_device = {
+	.name				= "omapdss",
+	.id				= -1,
+	.dev				= {
+		.platform_data		= &zoom_dss_data,
+	},
+};
+
+static struct omap2_mcspi_device_config dss_lcd_mcspi_config = {
+	.turbo_mode		= 1,
+	.single_channel	= 1,  /* 0: slave, 1: master */
+};
+
+static struct spi_board_info nec_8048_spi_board_info[] __initdata = {
+	[0] = {
+		.modalias		= "nec_8048_spi",
+		.bus_num		= 1,
+		.chip_select		= 2,
+		.max_speed_hz		= 375000,
+		.controller_data	= &dss_lcd_mcspi_config,
+	},
+};
+
+static struct platform_device *zoom_display_devices[] __initdata = {
+	&zoom_dss_device,
+};
+
+void __init zoom_display_init(void)
+{
+	platform_add_devices(zoom_display_devices,
+				ARRAY_SIZE(zoom_display_devices));
+	spi_register_board_info(nec_8048_spi_board_info,
+				ARRAY_SIZE(nec_8048_spi_board_info));
+	zoom_lcd_panel_init();
+}
+
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 6b39849..ebcfbed 100644
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
+	.num_consumer_supplies		= 1,
+	.consumer_supplies		= &zoom_vpll2_supply,
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
+	.num_consumer_supplies		= 1,
+	.consumer_supplies		= &zoom_vdda_dac_supply,
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
 
 
@@ -243,7 +287,8 @@ static struct twl4030_platform_data zoom_twldata = {
 	.vmmc1          = &zoom_vmmc1,
 	.vmmc2          = &zoom_vmmc2,
 	.vsim           = &zoom_vsim,
-
+	.vpll2		= &zoom_vpll2,
+	.vdac		= &zoom_vdac,
 };
 
 static struct i2c_board_info __initdata zoom_i2c_boardinfo[] = {
diff --git a/arch/arm/mach-omap2/include/mach/board-zoom.h b/arch/arm/mach-omap2/include/mach/board-zoom.h
index 3af69d2..8d8eeb2 100644
--- a/arch/arm/mach-omap2/include/mach/board-zoom.h
+++ b/arch/arm/mach-omap2/include/mach/board-zoom.h
@@ -3,9 +3,11 @@
  */
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
+#include <plat/display.h>
 
 #define ZOOM_NAND_CS    0
 
 extern void __init board_nand_init(struct mtd_partition *, u8 nr_parts, u8 cs);
 extern int __init zoom_debugboard_init(void);
 extern void __init zoom_peripherals_init(void);
+extern void __init zoom_display_init(void);
-- 
1.5.6.3

