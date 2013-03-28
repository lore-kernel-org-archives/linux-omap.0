From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 08/28] ARM: OMAP: CM-T35: Kconfig option for the display options
Date: Thu, 28 Mar 2013 14:49:02 +0200
Message-ID: <1364474962-20439-9-git-send-email-tomi.valkeinen@ti.com>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44544 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755121Ab3C1Mtz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Mar 2013 08:49:55 -0400
In-Reply-To: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Mike Rapoport <mike@compulab.co.il>, Igor Grinberg <grinberg@compulab.co.il>

Boards with multiple display options for the same video bus have all the
possible linux display devices present at the same time. Only one of
those devices should be used at a time, as the video bus cannot be
shared.

This model is hacky, and will be changed in the forthcoming DSS patches
to a model where only one display device can be present on a single
video bus.

This patch creates Kconfig options to select which of the display
devices is present on the board. While this model is also somewhat
hacky, and prevents us from using a single kernel image for all the
display options, it allows us to make the DSS driver changes for DT
adaptation. And with DT, the information about display devices can be
passed from the bootloader, solving the mess.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Mike Rapoport <mike@compulab.co.il>
Cc: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-omap2/Kconfig        |   13 ++++++
 arch/arm/mach-omap2/board-cm-t35.c |   84 +++++++++++++++++++++---------------
 2 files changed, 62 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 4108d07..6e73cb4 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -387,6 +387,19 @@ config MACH_CM_T35
 	select MACH_CM_T3730
 	select OMAP_PACKAGE_CUS
 
+choice
+	depends on MACH_CM_T35
+	default MACH_CM_T35_EXPANSION_LCD
+	prompt "CM-T35/CM-T3730 video output"
+
+config MACH_CM_T35_EXPANSION_LCD
+	bool "CM-T35/CM-T3730 with LCD"
+
+config MACH_CM_T35_EXPANSION_DVI
+	bool "CM-T35/CM-T3730 with DVI"
+
+endchoice
+
 config MACH_CM_T3517
 	bool "CompuLab CM-T3517 module"
 	depends on ARCH_OMAP3
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 9c1895a..1b34c96 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -187,32 +187,28 @@ static void __init cm_t35_init_nand(void)
 static inline void cm_t35_init_nand(void) {}
 #endif
 
+static struct omap_dss_device cm_t35_tv_device = {
+	.name			= "tv",
+	.driver_name		= "venc",
+	.type			= OMAP_DISPLAY_TYPE_VENC,
+	.phy.venc.type		= OMAP_DSS_VENC_TYPE_SVIDEO,
+};
+
+#if defined(CONFIG_MACH_CM_T35_EXPANSION_LCD)
+
 #define CM_T35_LCD_EN_GPIO 157
 #define CM_T35_LCD_BL_GPIO 58
-#define CM_T35_DVI_EN_GPIO 54
-
-static int lcd_enabled;
-static int dvi_enabled;
 
 static int cm_t35_panel_enable_lcd(struct omap_dss_device *dssdev)
 {
-	if (dvi_enabled) {
-		printk(KERN_ERR "cannot enable LCD, DVI is enabled\n");
-		return -EINVAL;
-	}
-
 	gpio_set_value(CM_T35_LCD_EN_GPIO, 1);
 	gpio_set_value(CM_T35_LCD_BL_GPIO, 1);
 
-	lcd_enabled = 1;
-
 	return 0;
 }
 
 static void cm_t35_panel_disable_lcd(struct omap_dss_device *dssdev)
 {
-	lcd_enabled = 0;
-
 	gpio_set_value(CM_T35_LCD_BL_GPIO, 0);
 	gpio_set_value(CM_T35_LCD_EN_GPIO, 0);
 }
@@ -231,36 +227,15 @@ static struct omap_dss_device cm_t35_lcd_device = {
 	.phy.dpi.data_lines	= 18,
 };
 
-static struct tfp410_platform_data dvi_panel = {
-	.power_down_gpio	= CM_T35_DVI_EN_GPIO,
-	.i2c_bus_num		= -1,
-};
-
-static struct omap_dss_device cm_t35_dvi_device = {
-	.name			= "dvi",
-	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.driver_name		= "tfp410",
-	.data			= &dvi_panel,
-	.phy.dpi.data_lines	= 24,
-};
-
-static struct omap_dss_device cm_t35_tv_device = {
-	.name			= "tv",
-	.driver_name		= "venc",
-	.type			= OMAP_DISPLAY_TYPE_VENC,
-	.phy.venc.type		= OMAP_DSS_VENC_TYPE_SVIDEO,
-};
-
 static struct omap_dss_device *cm_t35_dss_devices[] = {
 	&cm_t35_lcd_device,
-	&cm_t35_dvi_device,
 	&cm_t35_tv_device,
 };
 
 static struct omap_dss_board_info cm_t35_dss_data = {
 	.num_devices	= ARRAY_SIZE(cm_t35_dss_devices),
 	.devices	= cm_t35_dss_devices,
-	.default_device	= &cm_t35_dvi_device,
+	.default_display_name = "lcd",
 };
 
 static struct omap2_mcspi_device_config tdo24m_mcspi_config = {
@@ -314,6 +289,45 @@ static void __init cm_t35_init_display(void)
 	}
 }
 
+#elif defined(CONFIG_MACH_CM_T35_EXPANSION_DVI)
+
+#define CM_T35_DVI_EN_GPIO 54
+
+static struct tfp410_platform_data dvi_panel = {
+	.power_down_gpio	= CM_T35_DVI_EN_GPIO,
+	.i2c_bus_num		= -1,
+};
+
+static struct omap_dss_device cm_t35_dvi_device = {
+	.name			= "dvi",
+	.type			= OMAP_DISPLAY_TYPE_DPI,
+	.driver_name		= "tfp410",
+	.data			= &dvi_panel,
+	.phy.dpi.data_lines	= 24,
+};
+
+static struct omap_dss_device *cm_t35_dss_devices[] = {
+	&cm_t35_dvi_device,
+	&cm_t35_tv_device,
+};
+
+static struct omap_dss_board_info cm_t35_dss_data = {
+	.num_devices	= ARRAY_SIZE(cm_t35_dss_devices),
+	.devices	= cm_t35_dss_devices,
+	.default_display_name = "dvi",
+};
+
+static void __init cm_t35_init_display(void)
+{
+	int err;
+
+	err = omap_display_init(&cm_t35_dss_data);
+	if (err)
+		pr_err("CM-T35: failed to register DSS device\n");
+}
+
+#endif
+
 static struct regulator_consumer_supply cm_t35_vmmc1_supply[] = {
 	REGULATOR_SUPPLY("vmmc", "omap_hsmmc.0"),
 };
-- 
1.7.10.4

