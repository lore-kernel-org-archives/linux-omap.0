From: "Y, Kishore" <kishore.y@ti.com>
Subject: [PATCH 1/5] ZOOM: DSS2: changes in zoom board file for display
 support
Date: Fri, 20 Nov 2009 19:57:15 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E940254331084@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47901 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752296AbZKTO1L convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Nov 2009 09:27:11 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id nAKEREM7029904
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 20 Nov 2009 08:27:16 -0600
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id nAKEREOB020286
	for <linux-omap@vger.kernel.org>; Fri, 20 Nov 2009 19:57:14 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

>From e9394adabaa4418db50147cb464f314f396e0ec5 Mon Sep 17 00:00:00 2001
From: Mukund Mittal <mmittal@ti.com>
Date: Fri, 20 Nov 2009 18:14:30 +0530
Subject: [PATCH] ZOOM: DSS2: changes in zoom board file for display support

board-zoom-peripherals.c is common file for zoom boards to support
peripherals. Display support has been added here to enable display in
zoom2 and zoom3

Signed-off-by: Kishore Y <kishore.y@ti.com>
---
 arch/arm/mach-omap2/board-zoom-peripherals.c |  212 +++++++++++++++++++++++++-
 1 files changed, 209 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 32adfea..a8628db 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -27,10 +27,166 @@
 #include <plat/usb.h>
 #include <plat/mux.h>
 
+#include <plat/mcspi.h>
+#include <linux/spi/spi.h>
+#include <plat/display.h>
 #include "mmc-twl4030.h"
 
 #define OMAP_SYNAPTICS_GPIO		163
 
+#define LCD_PANEL_BACKLIGHT_GPIO        (15 + OMAP_MAX_GPIO_LINES)
+#define LCD_PANEL_ENABLE_GPIO           (7 + OMAP_MAX_GPIO_LINES)
+
+#define LCD_PANEL_RESET_GPIO            55
+#define LCD_PANEL_QVGA_GPIO             56
+
+#define TV_PANEL_ENABLE_GPIO            95
+
+
+#define ENABLE_VAUX2_DEDICATED          0x09
+#define ENABLE_VAUX2_DEV_GRP            0x20
+#define ENABLE_VAUX3_DEDICATED          0x03
+#define ENABLE_VAUX3_DEV_GRP            0x20
+
+#define ENABLE_VPLL2_DEDICATED          0x05
+#define ENABLE_VPLL2_DEV_GRP            0xE0
+#define TWL4030_VPLL2_DEV_GRP           0x33
+#define TWL4030_VPLL2_DEDICATED         0x36
+
+/*#define SIL9022_RESET_GPIO              97*/
+
+
+static void zoom_lcd_tv_panel_init(void)
+{
+	unsigned char lcd_panel_reset_gpio;
+
+	if (omap_rev() > OMAP3430_REV_ES3_0) {
+		/* Production Zoom Board:
+ * 		 * GPIO-96 is the LCD_RESET_GPIO
+ * 		 		 */
+		lcd_panel_reset_gpio = 96;
+	} else {
+	/* Pilot Zoom board
+ * 	 * GPIO-55 is the LCD_RESET_GPIO
+ * 	 		 */
+		lcd_panel_reset_gpio = 55;
+	}
+
+	gpio_request(lcd_panel_reset_gpio, "lcd reset");
+	gpio_request(LCD_PANEL_QVGA_GPIO, "lcd qvga");
+	gpio_request(LCD_PANEL_ENABLE_GPIO, "lcd panel");
+	gpio_request(LCD_PANEL_BACKLIGHT_GPIO, "lcd backlight");
+
+	gpio_request(TV_PANEL_ENABLE_GPIO, "tv panel");
+
+	gpio_direction_output(LCD_PANEL_QVGA_GPIO, 0);
+	gpio_direction_output(lcd_panel_reset_gpio, 0);
+	gpio_direction_output(LCD_PANEL_ENABLE_GPIO, 0);
+	gpio_direction_output(LCD_PANEL_BACKLIGHT_GPIO, 0);
+	gpio_direction_output(TV_PANEL_ENABLE_GPIO, 0);
+
+	gpio_direction_output(LCD_PANEL_QVGA_GPIO, 1);
+	gpio_direction_output(lcd_panel_reset_gpio, 1);
+}
+
+static int zoom_panel_power_enable(int enable)
+{
+	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+				(enable) ? ENABLE_VPLL2_DEDICATED : 0,
+				TWL4030_VPLL2_DEDICATED);
+	twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+				(enable) ? ENABLE_VPLL2_DEV_GRP : 0,
+				TWL4030_VPLL2_DEV_GRP);
+	return 0;
+}
+
+static int zoom_panel_enable_lcd(struct omap_dss_device *dssdev)
+{
+	zoom_panel_power_enable(1);
+
+	gpio_request(LCD_PANEL_ENABLE_GPIO, "lcd panel");
+	gpio_direction_output(LCD_PANEL_ENABLE_GPIO, 1);
+	gpio_request(LCD_PANEL_BACKLIGHT_GPIO, "lcd backlight");
+	gpio_direction_output(LCD_PANEL_BACKLIGHT_GPIO, 1);
+
+	return 0;
+}
+
+static void zoom_panel_disable_lcd(struct omap_dss_device *dssdev)
+{
+	zoom_panel_power_enable(0);
+
+	gpio_request(LCD_PANEL_ENABLE_GPIO, "lcd panel");
+	gpio_direction_output(LCD_PANEL_ENABLE_GPIO, 0);
+	gpio_request(LCD_PANEL_BACKLIGHT_GPIO, "lcd backlight");
+	gpio_direction_output(LCD_PANEL_BACKLIGHT_GPIO, 0);
+
+}
+
+static struct omap_dss_device zoom_lcd_device = {
+	.name = "lcd",
+	.driver_name = "NEC_panel",
+	.type = OMAP_DISPLAY_TYPE_DPI,
+	.phy.dpi.data_lines = 24,
+	.platform_enable = zoom_panel_enable_lcd,
+	.platform_disable = zoom_panel_disable_lcd,
+ };
+
+static struct omap_dss_device *zoom_dss_devices[] = {
+	&zoom_lcd_device,
+/*        &zoom_tv_device,
+ *        #ifdef CONFIG_SIL9022
+ *        	&zoom_hdmi_device,
+ *        	#endif
+ *        	*/
+};
+
+
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
+static struct regulator_consumer_supply zoom_vdda_dac_supply = {
+	.supply         = "vdda_dac",
+	.dev            = &zoom_dss_device.dev,
+};
+
+
+#ifdef CONFIG_FB_OMAP2
+static struct resource zoom_vout_resource[3 - CONFIG_FB_OMAP2_NUM_FBS] = {
+};
+#else
+static struct resource zoom_vout_resource[2] = {
+};
+#endif
+
+
+static struct omap2_mcspi_device_config dss_lcd_mcspi_config = {
+	.turbo_mode             = 0,
+	.single_channel         = 1,  /* 0: slave, 1: master */
+};
+
+static struct spi_board_info dss_spi_board_info[] __initdata = {
+	[0] = {
+		.modalias               = "disp_spi",
+		.bus_num                = 1,
+		.chip_select            = 2,
+		.max_speed_hz           = 375000,
+		.controller_data        = &dss_lcd_mcspi_config,
+	},
+};
+
 /* Zoom2 has Qwerty keyboard*/
 static int board_keymap[] = {
 	KEY(0, 0, KEY_E),
@@ -184,6 +340,19 @@ static struct regulator_init_data zoom_vsim = {
 	.consumer_supplies      = &zoom_vsim_supply,
 };
 
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
@@ -342,7 +511,7 @@ static struct twl4030_platform_data zoom_twldata = {
 	/* .vaux2		= &zoom_vaux2,*/
 	/* .vaux4		= &zoom_vaux4,*/
 	.vsim           = &zoom_vsim,
-	/* .vdac		= &zoom_vdac,*/
+	.vdac		= &zoom_vdac,
 };
 
 static struct i2c_board_info __initdata zoom_i2c_boardinfo[] = {
@@ -383,7 +552,7 @@ static struct synaptics_i2c_rmi_platform_data synaptics_platform_data[] = {
 	}
 };
 
-static struct i2c_board_info __initdata zoom2_i2c_boardinfo2[] = {
+static struct i2c_board_info __initdata zoom_i2c_boardinfo2[] = {
 	{
 		I2C_BOARD_INFO(SYNAPTICS_I2C_RMI_NAME,  0x20),
 		.platform_data = &synaptics_platform_data,
@@ -396,7 +565,7 @@ static int __init zoom_i2c_init(void)
 	omap_register_i2c_bus(1, 2200, zoom_i2c_boardinfo,
 			ARRAY_SIZE(zoom_i2c_boardinfo));
 
-	/* TODO: I2C2 on zoom2/3:
+	/* TODO: I2C2 on zoom/3:
 	 * Add Synaptic RMI controller
 	 * Add Camera sensor IMX046
 	 * Add Camera sensor LV8093
@@ -410,11 +579,48 @@ static int __init zoom_i2c_init(void)
 	return 0;
 }
 
+/*
+#ifdef CONFIG_PM
+struct vout_platform_data zoom_vout_data = {
+	.set_min_bus_tput = omap_pm_set_min_bus_tput,
+	.set_max_mpu_wakeup_lat =  omap_pm_set_max_mpu_wakeup_lat,
+	.set_cpu_freq = omap_pm_cpu_set_freq,
+};
+#endif
+*/
+
+static struct platform_device zoom_vout_device = {
+	.name           = "omap_vout",
+	.num_resources  = ARRAY_SIZE(zoom_vout_resource),
+	.resource       = &zoom_vout_resource[0],
+	.id             = -1,
+/*
+#ifdef CONFIG_PM
+	.dev            = {
+		.platform_data = &zoom_vout_data,
+	}
+#else
+*/
+	.dev            = {
+		.platform_data = NULL,
+	}
+/*#endif*/
+};
+
+
+ static struct platform_device *zoom_devices[] __initdata = {
+	&zoom_dss_device,
+	/*&zoom_vout_device,*/
+ };
 
 void __init zoom_peripherals_init(void)
 {
 	zoom_i2c_init();
+	platform_add_devices(zoom_devices, ARRAY_SIZE(zoom_devices));
 	synaptics_dev_init();
+	spi_register_board_info(dss_spi_board_info,
+				ARRAY_SIZE(dss_spi_board_info));
 	omap_serial_init();
 	usb_musb_init();
+	zoom_lcd_tv_panel_init();
 }
-- 
1.5.4.3


Regards,
Kishore Y
Ph:- +918039813085

