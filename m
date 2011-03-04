From: Steve Sakoman <steve@sakoman.com>
Subject: [PATCH v2 2/2] OMAP: DSS2: Add DSS2 support for Overo
Date: Fri,  4 Mar 2011 12:52:20 -0800
Message-ID: <1299271940-4286-3-git-send-email-steve@sakoman.com>
References: <1299271940-4286-1-git-send-email-steve@sakoman.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:65271 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760065Ab1CDUwh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 15:52:37 -0500
Received: by mail-fx0-f46.google.com with SMTP id 17so2557996fxm.19
        for <linux-omap@vger.kernel.org>; Fri, 04 Mar 2011 12:52:36 -0800 (PST)
In-Reply-To: <1299271940-4286-1-git-send-email-steve@sakoman.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tomi.valkeinen@ti.com, Steve Sakoman <steve@sakoman.com>

This patch adds DSS2 support for DVI, S-video, the 480x272 Samsung
LTE430WQ-F0C panel, and the 320x240 LG.Philips LB035Q02 panel.

Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 arch/arm/mach-omap2/board-overo.c |  239 +++++++++++++++++++++++++++++++------
 1 files changed, 202 insertions(+), 37 deletions(-)

diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index a33ec0e..a2c17c9 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -28,6 +28,7 @@
 #include <linux/platform_device.h>
 #include <linux/i2c/twl.h>
 #include <linux/regulator/machine.h>
+#include <linux/spi/spi.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
@@ -41,10 +42,14 @@
 
 #include <plat/board.h>
 #include <plat/common.h>
+#include <plat/display.h>
+#include <plat/panel-generic-dpi.h>
 #include <mach/gpio.h>
 #include <plat/gpmc.h>
 #include <mach/hardware.h>
 #include <plat/nand.h>
+#include <plat/mcspi.h>
+#include <plat/mux.h>
 #include <plat/usb.h>
 
 #include "mux.h"
@@ -68,8 +73,6 @@
 #if defined(CONFIG_TOUCHSCREEN_ADS7846) || \
 	defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
 
-#include <plat/mcspi.h>
-#include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
 
 static struct omap2_mcspi_device_config ads7846_mcspi_config = {
@@ -94,18 +97,6 @@ static struct ads7846_platform_data ads7846_config = {
 	.keep_vref_on		= 1,
 };
 
-static struct spi_board_info overo_spi_board_info[] __initdata = {
-	{
-		.modalias		= "ads7846",
-		.bus_num		= 1,
-		.chip_select		= 0,
-		.max_speed_hz		= 1500000,
-		.controller_data	= &ads7846_mcspi_config,
-		.irq			= OMAP_GPIO_IRQ(OVERO_GPIO_PENDOWN),
-		.platform_data		= &ads7846_config,
-	}
-};
-
 static void __init overo_ads7846_init(void)
 {
 	if ((gpio_request(OVERO_GPIO_PENDOWN, "ADS7846_PENDOWN") == 0) &&
@@ -115,9 +106,6 @@ static void __init overo_ads7846_init(void)
 		printk(KERN_ERR "could not obtain gpio for ADS7846_PENDOWN\n");
 		return;
 	}
-
-	spi_register_board_info(overo_spi_board_info,
-			ARRAY_SIZE(overo_spi_board_info));
 }
 
 #else
@@ -233,6 +221,137 @@ static inline void __init overo_init_smsc911x(void)
 static inline void __init overo_init_smsc911x(void) { return; }
 #endif
 
+/* DSS */
+static int lcd_enabled;
+static int dvi_enabled;
+
+#define OVERO_GPIO_LCD_EN 144
+#define OVERO_GPIO_LCD_BL 145
+
+static void __init overo_display_init(void)
+{
+	if ((gpio_request(OVERO_GPIO_LCD_EN, "OVERO_GPIO_LCD_EN") == 0) &&
+	    (gpio_direction_output(OVERO_GPIO_LCD_EN, 1) == 0))
+		gpio_export(OVERO_GPIO_LCD_EN, 0);
+	else
+		printk(KERN_ERR "could not obtain gpio for "
+					"OVERO_GPIO_LCD_EN\n");
+
+	if ((gpio_request(OVERO_GPIO_LCD_BL, "OVERO_GPIO_LCD_BL") == 0) &&
+	    (gpio_direction_output(OVERO_GPIO_LCD_BL, 1) == 0))
+		gpio_export(OVERO_GPIO_LCD_BL, 0);
+	else
+		printk(KERN_ERR "could not obtain gpio for "
+					"OVERO_GPIO_LCD_BL\n");
+}
+
+static int overo_panel_enable_dvi(struct omap_dss_device *dssdev)
+{
+	if (lcd_enabled) {
+		printk(KERN_ERR "cannot enable DVI, LCD is enabled\n");
+		return -EINVAL;
+	}
+	dvi_enabled = 1;
+
+	return 0;
+}
+
+static void overo_panel_disable_dvi(struct omap_dss_device *dssdev)
+{
+	dvi_enabled = 0;
+}
+
+static struct panel_generic_dpi_data dvi_panel = {
+	.name			= "generic",
+	.platform_enable	= overo_panel_enable_dvi,
+	.platform_disable	= overo_panel_disable_dvi,
+};
+
+static struct omap_dss_device overo_dvi_device = {
+	.name			= "dvi",
+	.type			= OMAP_DISPLAY_TYPE_DPI,
+	.driver_name		= "generic_dpi_panel",
+	.data			= &dvi_panel,
+	.phy.dpi.data_lines	= 24,
+};
+
+static struct omap_dss_device overo_tv_device = {
+	.name = "tv",
+	.driver_name = "venc",
+	.type = OMAP_DISPLAY_TYPE_VENC,
+	.phy.venc.type = OMAP_DSS_VENC_TYPE_SVIDEO,
+};
+
+static int overo_panel_enable_lcd(struct omap_dss_device *dssdev)
+{
+	if (dvi_enabled) {
+		printk(KERN_ERR "cannot enable LCD, DVI is enabled\n");
+		return -EINVAL;
+	}
+
+	gpio_set_value(OVERO_GPIO_LCD_EN, 1);
+	gpio_set_value(OVERO_GPIO_LCD_BL, 1);
+	lcd_enabled = 1;
+	return 0;
+}
+
+static void overo_panel_disable_lcd(struct omap_dss_device *dssdev)
+{
+	gpio_set_value(OVERO_GPIO_LCD_EN, 0);
+	gpio_set_value(OVERO_GPIO_LCD_BL, 0);
+	lcd_enabled = 0;
+}
+
+static struct panel_generic_dpi_data lcd43_panel = {
+	.name			= "samsung_lte430wq_f0c",
+	.platform_enable	= overo_panel_enable_lcd,
+	.platform_disable	= overo_panel_disable_lcd,
+};
+
+static struct omap_dss_device overo_lcd43_device = {
+	.name			= "lcd43",
+	.type			= OMAP_DISPLAY_TYPE_DPI,
+	.driver_name		= "generic_dpi_panel",
+	.data			= &lcd43_panel,
+	.phy.dpi.data_lines	= 24,
+};
+
+#if defined(CONFIG_PANEL_LGPHILIPS_LB035Q02) || \
+	defined(CONFIG_PANEL_LGPHILIPS_LB035Q02_MODULE)
+static struct omap_dss_device overo_lcd35_device = {
+	.type			= OMAP_DISPLAY_TYPE_DPI,
+	.name			= "lcd35",
+	.driver_name		= "lgphilips_lb035q02_panel",
+	.phy.dpi.data_lines	= 24,
+	.platform_enable	= overo_panel_enable_lcd,
+	.platform_disable	= overo_panel_disable_lcd,
+};
+#endif
+
+static struct omap_dss_device *overo_dss_devices[] = {
+	&overo_dvi_device,
+	&overo_tv_device,
+#if defined(CONFIG_PANEL_LGPHILIPS_LB035Q02) || \
+	defined(CONFIG_PANEL_LGPHILIPS_LB035Q02_MODULE)
+	&overo_lcd35_device,
+#endif
+	&overo_lcd43_device,
+};
+
+static struct omap_dss_board_info overo_dss_data = {
+	.num_devices	= ARRAY_SIZE(overo_dss_devices),
+	.devices	= overo_dss_devices,
+	.default_device	= &overo_dvi_device,
+};
+
+static struct regulator_consumer_supply overo_vdda_dac_supply =
+	REGULATOR_SUPPLY("vdda_dac", "omapdss_venc");
+
+static struct regulator_consumer_supply overo_vdds_dsi_supply[] = {
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
+	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi1"),
+};
+
 static struct mtd_partition overo_nand_partitions[] = {
 	{
 		.name           = "xloader",
@@ -358,6 +477,37 @@ static struct regulator_init_data overo_vmmc1 = {
 	.consumer_supplies	= &overo_vmmc1_supply,
 };
 
+/* VDAC for DSS driving S-Video (8 mA unloaded, max 65 mA) */
+static struct regulator_init_data overo_vdac = {
+	.constraints = {
+		.min_uV			= 1800000,
+		.max_uV			= 1800000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= 1,
+	.consumer_supplies	= &overo_vdda_dac_supply,
+};
+
+/* VPLL2 for digital video outputs */
+static struct regulator_init_data overo_vpll2 = {
+	.constraints = {
+		.name			= "VDVI",
+		.min_uV			= 1800000,
+		.max_uV			= 1800000,
+		.valid_modes_mask	= REGULATOR_MODE_NORMAL
+					| REGULATOR_MODE_STANDBY,
+		.valid_ops_mask		= REGULATOR_CHANGE_MODE
+					| REGULATOR_CHANGE_STATUS,
+	},
+	.num_consumer_supplies	= ARRAY_SIZE(overo_vdds_dsi_supply),
+	.consumer_supplies	= overo_vdds_dsi_supply,
+};
+
+/* mmc2 (WLAN) and Bluetooth don't use twl4030 regulators */
+
 static struct twl4030_codec_audio_data overo_audio_data = {
 	.audio_mclk = 26000000,
 };
@@ -367,8 +517,6 @@ static struct twl4030_codec_data overo_codec_data = {
 	.audio = &overo_audio_data,
 };
 
-/* mmc2 (WLAN) and Bluetooth don't use twl4030 regulators */
-
 static struct twl4030_platform_data overo_twldata = {
 	.irq_base	= TWL4030_IRQ_BASE,
 	.irq_end	= TWL4030_IRQ_END,
@@ -376,6 +524,8 @@ static struct twl4030_platform_data overo_twldata = {
 	.usb		= &overo_usb_data,
 	.codec		= &overo_codec_data,
 	.vmmc1		= &overo_vmmc1,
+	.vdac		= &overo_vdac,
+	.vpll2		= &overo_vpll2,
 };
 
 static struct i2c_board_info __initdata overo_i2c_boardinfo[] = {
@@ -396,32 +546,46 @@ static int __init overo_i2c_init(void)
 	return 0;
 }
 
-static struct platform_device overo_lcd_device = {
-	.name		= "overo_lcd",
-	.id		= -1,
-};
-
-static struct omap_lcd_config overo_lcd_config __initdata = {
-	.ctrl_name	= "internal",
+static struct spi_board_info overo_spi_board_info[] __initdata = {
+#if defined(CONFIG_TOUCHSCREEN_ADS7846) || \
+	defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
+	{
+		.modalias		= "ads7846",
+		.bus_num		= 1,
+		.chip_select		= 0,
+		.max_speed_hz		= 1500000,
+		.controller_data	= &ads7846_mcspi_config,
+		.irq			= OMAP_GPIO_IRQ(OVERO_GPIO_PENDOWN),
+		.platform_data		= &ads7846_config,
+	},
+#endif
+#if defined(CONFIG_PANEL_LGPHILIPS_LB035Q02) || \
+	defined(CONFIG_PANEL_LGPHILIPS_LB035Q02_MODULE)
+	{
+		.modalias		= "lgphilips_lb035q02_panel-spi",
+		.bus_num		= 1,
+		.chip_select		= 1,
+		.max_speed_hz		= 500000,
+		.mode			= SPI_MODE_3,
+	},
+#endif
 };
 
-static struct omap_board_config_kernel overo_config[] __initdata = {
-	{ OMAP_TAG_LCD,		&overo_lcd_config },
-};
+static int __init overo_spi_init(void)
+{
+	overo_ads7846_init();
+	spi_register_board_info(overo_spi_board_info,
+			ARRAY_SIZE(overo_spi_board_info));
+	return 0;
+}
 
 static void __init overo_init_early(void)
 {
-	omap_board_config = overo_config;
-	omap_board_config_size = ARRAY_SIZE(overo_config);
 	omap2_init_common_infrastructure();
 	omap2_init_common_devices(mt46h32m32lf6_sdrc_params,
 				  mt46h32m32lf6_sdrc_params);
 }
 
-static struct platform_device *overo_devices[] __initdata = {
-	&overo_lcd_device,
-};
-
 static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 	.port_mode[0] = EHCI_HCD_OMAP_MODE_UNKNOWN,
 	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
@@ -449,13 +613,14 @@ static void __init overo_init(void)
 {
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	overo_i2c_init();
-	platform_add_devices(overo_devices, ARRAY_SIZE(overo_devices));
+	omap_display_init(&overo_dss_data);
 	omap_serial_init();
 	overo_flash_init();
 	usb_musb_init(&musb_board_data);
 	usb_ehci_init(&ehci_pdata);
-	overo_ads7846_init();
+	overo_spi_init();
 	overo_init_smsc911x();
+	overo_display_init();
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
 	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
-- 
1.7.0.4

