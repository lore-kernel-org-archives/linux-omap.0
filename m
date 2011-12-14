From: Alex <alexg@meprolight.com>
Subject: [PATCH v3] ARM: OMAP3LOGIC: Adding DSS support
Date: Wed, 14 Dec 2011 14:25:10 +0200
Message-ID: <1323865510-6273-1-git-send-email-alexg@meprolight.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ftp.meprolight.com ([194.90.149.17]:36422 "EHLO meprolight.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755219Ab1LNMa0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Dec 2011 07:30:26 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tim.nordell@logicpd.com, baruch@tkos.co.il, Alex <alexg@meprolight.com>

This patch adds DSS2 support to the LogicPD OMAP 35x Torpedo boardfile. LCD and
TV-out are supported.

Signed-off-by: Alex Gershgorin <alexg@meprolight.com>
---
 arch/arm/mach-omap2/board-omap3logic.c |   96 ++++++++++++++++++++++++++++++++
 1 files changed, 96 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
index 7c0f193..b44c485 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -7,6 +7,9 @@
  * Copyright (C) 2010 Logic Product Development, Inc.
  * Peter Barada <peter.barada@logicpd.com>
  *
+ * Copyright (C) 2011 Meprolight, Ltd.
+ * Alex Gershgorin <alexg@meprolight.com>
+ *
  * Modified from Beagle, EVM, and RX51
  *
  * This program is free software; you can redistribute it and/or modify
@@ -45,6 +48,9 @@
 #include <plat/gpmc.h>
 #include <plat/sdrc.h>
 
+#include <video/omapdss.h>
+#include <video/omap-panel-generic-dpi.h>
+
 #define OMAP3LOGIC_SMSC911X_CS			1
 
 #define OMAP3530_LV_SOM_MMC_GPIO_CD		110
@@ -95,6 +101,13 @@ static struct twl4030_platform_data omap3logic_twldata = {
 
 static int __init omap3logic_i2c_init(void)
 {
+	omap3_pmic_get_config(&omap3logic_twldata, TWL_COMMON_PDATA_USB,
+			TWL_COMMON_REGULATOR_VDAC | TWL_COMMON_REGULATOR_VPLL2);
+
+	omap3logic_twldata.vdac->constraints.apply_uV = true;
+	omap3logic_twldata.vpll2->constraints.apply_uV = true;
+	omap3logic_twldata.vpll2->constraints.name = "VDSI";
+
 	omap3_pmic_init("twl4030", &omap3logic_twldata);
 	return 0;
 }
@@ -182,6 +195,88 @@ static inline void __init board_smsc911x_init(void)
 	gpmc_smsc911x_init(&board_smsc911x_data);
 }
 
+#if defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE)
+
+#define OMAP3_TORPEDO_LCD_BACKLIGHT_GPIO	154
+#define OMAP3_TORPEDO_LCD_ENABLE_GPIO		155
+#define OMAP3_TORPEDO_LCD_PWM_GPIO		56
+
+static struct gpio omap3logic_dss_gpios[] __initdata = {
+	{OMAP3_TORPEDO_LCD_BACKLIGHT_GPIO, GPIOF_OUT_INIT_LOW, "lcd_bl_pwr"},
+	{OMAP3_TORPEDO_LCD_PWM_GPIO, GPIOF_OUT_INIT_LOW, "lcd bl enable"},
+	{OMAP3_TORPEDO_LCD_ENABLE_GPIO, GPIOF_OUT_INIT_LOW, "lcd enable"},
+};
+
+static int omap3logic_enable_lcd(struct omap_dss_device *dssdev)
+{
+	gpio_set_value_cansleep(OMAP3_TORPEDO_LCD_ENABLE_GPIO, 1);
+	gpio_set_value_cansleep(OMAP3_TORPEDO_LCD_BACKLIGHT_GPIO, 1);
+	gpio_set_value(OMAP3_TORPEDO_LCD_PWM_GPIO, 1);
+
+	return 0;
+}
+
+static void omap3logic_disable_lcd(struct omap_dss_device *dssdev)
+{
+	gpio_set_value_cansleep(OMAP3_TORPEDO_LCD_ENABLE_GPIO, 0);
+	gpio_set_value_cansleep(OMAP3_TORPEDO_LCD_BACKLIGHT_GPIO, 0);
+	gpio_set_value(OMAP3_TORPEDO_LCD_PWM_GPIO, 0);
+}
+
+static struct panel_generic_dpi_data lcd_panel = {
+	.name			= "sharp_lq",
+	.platform_enable	= omap3logic_enable_lcd,
+	.platform_disable	= omap3logic_disable_lcd,
+};
+
+static struct omap_dss_device omap3logic_lcd_device = {
+	.name			= "lcd",
+	.driver_name		= "generic_dpi_panel",
+	.type			= OMAP_DISPLAY_TYPE_DPI,
+	.data			= &lcd_panel,
+	.phy.dpi.data_lines	= 16,
+};
+
+static struct omap_dss_device omap3logic_tv_device = {
+	.name			= "tv",
+	.driver_name		= "venc",
+	.type			= OMAP_DISPLAY_TYPE_VENC,
+	.phy.venc.type		= OMAP_DSS_VENC_TYPE_SVIDEO,
+};
+
+static struct omap_dss_device *omap3logic_dss_devices[] = {
+	&omap3logic_lcd_device,
+	&omap3logic_tv_device,
+};
+
+static struct omap_dss_board_info omap3logic_dss_data = {
+	.num_devices		= ARRAY_SIZE(omap3logic_dss_devices),
+	.devices		= omap3logic_dss_devices,
+	.default_device		= &omap3logic_lcd_device,
+};
+
+static void __init omap3logic_display_init(void)
+{
+	int r;
+
+	r = gpio_request_array(omap3logic_dss_gpios,
+			       ARRAY_SIZE(omap3logic_dss_gpios));
+	if (r) {
+		printk(KERN_ERR "failed to get lcd_panel_* gpios\n");
+		return;
+	}
+
+	r = omap_display_init(&omap3logic_dss_data);
+	if (r) {
+		pr_err("OMAP3LOGIC: failed to register DSS device\n");
+		gpio_free_array(omap3logic_dss_gpios,
+				ARRAY_SIZE(omap3logic_dss_gpios));
+	}
+}
+#else
+static void __init omap3logic_display_init(void) { }
+#endif /* defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE) */
+
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
@@ -197,6 +292,7 @@ static void __init omap3logic_init(void)
 	omap_sdrc_init(NULL, NULL);
 	board_mmc_init();
 	board_smsc911x_init();
+	omap3logic_display_init();
 
 	/* Ensure SDRC pins are mux'd for self-refresh */
 	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
-- 
1.7.0.4

