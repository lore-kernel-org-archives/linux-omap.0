From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 03/28] ARM: OMAP: Overo: Kconfig option for the display options
Date: Thu, 28 Mar 2013 14:48:57 +0200
Message-ID: <1364474962-20439-4-git-send-email-tomi.valkeinen@ti.com>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44537 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755121Ab3C1Mtr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Mar 2013 08:49:47 -0400
In-Reply-To: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

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
---
 arch/arm/mach-omap2/Kconfig       |   22 ++++++
 arch/arm/mach-omap2/board-overo.c |  134 +++++++++++++++++++++++--------------
 2 files changed, 107 insertions(+), 49 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 8111cd9..f30aadb 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -238,6 +238,28 @@ config MACH_OVERO
 	default y
 	select OMAP_PACKAGE_CBB
 
+choice
+	depends on MACH_OVERO
+	default MACH_OVERO_EXPANSION_PALO43
+	prompt "Overo Expansion Board"
+
+config MACH_OVERO_EXPANSION_PALO43
+	bool "Gumstix Overo Palo43 Expansion Board"
+	help
+	  Palo43 Expansion board with Samsung 4.3" 480x272 LCD.
+
+config MACH_OVERO_EXPANSION_PALO35
+	bool "Gumstix Overo Palo35 Expansion Board"
+	help
+	  Palo35 Expansion board with LG 3.5" 320x240 LCD.
+
+config MACH_OVERO_EXPANSION_SUMMIT
+	bool "Gumstix Overo Summit Expansion Board"
+	help
+	  Summit expansion board with DVI output.
+
+endchoice
+
 config MACH_OMAP3EVM
 	bool "OMAP 3530 EVM board"
 	depends on ARCH_OMAP3
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 86bab51..3253682 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -145,13 +145,72 @@ static void __init overo_init_smsc911x(void)
 static inline void __init overo_init_smsc911x(void) { return; }
 #endif
 
-/* DSS */
-static int lcd_enabled;
-static int dvi_enabled;
+#if defined(CONFIG_MACH_OVERO_EXPANSION_SUMMIT)
+
+static struct tfp410_platform_data dvi_panel = {
+	.i2c_bus_num		= 3,
+	.power_down_gpio	= -1,
+};
+
+static struct omap_dss_device overo_dvi_device = {
+	.name			= "dvi",
+	.type			= OMAP_DISPLAY_TYPE_DPI,
+	.driver_name		= "tfp410",
+	.data			= &dvi_panel,
+	.phy.dpi.data_lines	= 24,
+};
+
+static struct omap_dss_device *overo_dss_devices[] = {
+	&overo_dvi_device,
+};
+
+static struct omap_dss_board_info overo_dss_data = {
+	.num_devices	= ARRAY_SIZE(overo_dss_devices),
+	.devices	= overo_dss_devices,
+	.default_display_name = "dvi",
+};
+
+static void __init overo_display_init(void)
+{
+}
+
+#elif defined(CONFIG_MACH_OVERO_EXPANSION_PALO35)
 
 #define OVERO_GPIO_LCD_EN 144
 #define OVERO_GPIO_LCD_BL 145
 
+static int overo_panel_enable_lcd(struct omap_dss_device *dssdev)
+{
+	gpio_set_value(OVERO_GPIO_LCD_EN, 1);
+	gpio_set_value(OVERO_GPIO_LCD_BL, 1);
+	return 0;
+}
+
+static void overo_panel_disable_lcd(struct omap_dss_device *dssdev)
+{
+	gpio_set_value(OVERO_GPIO_LCD_EN, 0);
+	gpio_set_value(OVERO_GPIO_LCD_BL, 0);
+}
+
+static struct omap_dss_device overo_lcd35_device = {
+	.type			= OMAP_DISPLAY_TYPE_DPI,
+	.name			= "lcd35",
+	.driver_name		= "lgphilips_lb035q02_panel",
+	.phy.dpi.data_lines	= 24,
+	.platform_enable	= overo_panel_enable_lcd,
+	.platform_disable	= overo_panel_disable_lcd,
+};
+
+static struct omap_dss_device *overo_dss_devices[] = {
+	&overo_lcd35_device,
+};
+
+static struct omap_dss_board_info overo_dss_data = {
+	.num_devices	= ARRAY_SIZE(overo_dss_devices),
+	.devices	= overo_dss_devices,
+	.default_display_name = "lcd35",
+};
+
 static struct gpio overo_dss_gpios[] __initdata = {
 	{ OVERO_GPIO_LCD_EN, GPIOF_OUT_INIT_HIGH, "OVERO_GPIO_LCD_EN" },
 	{ OVERO_GPIO_LCD_BL, GPIOF_OUT_INIT_HIGH, "OVERO_GPIO_LCD_BL" },
@@ -168,36 +227,15 @@ static void __init overo_display_init(void)
 	gpio_export(OVERO_GPIO_LCD_BL, 0);
 }
 
-static struct tfp410_platform_data dvi_panel = {
-	.i2c_bus_num		= 3,
-	.power_down_gpio	= -1,
-};
+#elif defined(CONFIG_MACH_OVERO_EXPANSION_PALO43)
 
-static struct omap_dss_device overo_dvi_device = {
-	.name			= "dvi",
-	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.driver_name		= "tfp410",
-	.data			= &dvi_panel,
-	.phy.dpi.data_lines	= 24,
-};
-
-static struct omap_dss_device overo_tv_device = {
-	.name = "tv",
-	.driver_name = "venc",
-	.type = OMAP_DISPLAY_TYPE_VENC,
-	.phy.venc.type = OMAP_DSS_VENC_TYPE_SVIDEO,
-};
+#define OVERO_GPIO_LCD_EN 144
+#define OVERO_GPIO_LCD_BL 145
 
 static int overo_panel_enable_lcd(struct omap_dss_device *dssdev)
 {
-	if (dvi_enabled) {
-		printk(KERN_ERR "cannot enable LCD, DVI is enabled\n");
-		return -EINVAL;
-	}
-
 	gpio_set_value(OVERO_GPIO_LCD_EN, 1);
 	gpio_set_value(OVERO_GPIO_LCD_BL, 1);
-	lcd_enabled = 1;
 	return 0;
 }
 
@@ -205,7 +243,6 @@ static void overo_panel_disable_lcd(struct omap_dss_device *dssdev)
 {
 	gpio_set_value(OVERO_GPIO_LCD_EN, 0);
 	gpio_set_value(OVERO_GPIO_LCD_BL, 0);
-	lcd_enabled = 0;
 }
 
 static struct panel_generic_dpi_data lcd43_panel = {
@@ -222,34 +259,34 @@ static struct omap_dss_device overo_lcd43_device = {
 	.phy.dpi.data_lines	= 24,
 };
 
-#if defined(CONFIG_PANEL_LGPHILIPS_LB035Q02) || \
-	defined(CONFIG_PANEL_LGPHILIPS_LB035Q02_MODULE)
-static struct omap_dss_device overo_lcd35_device = {
-	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.name			= "lcd35",
-	.driver_name		= "lgphilips_lb035q02_panel",
-	.phy.dpi.data_lines	= 24,
-	.platform_enable	= overo_panel_enable_lcd,
-	.platform_disable	= overo_panel_disable_lcd,
-};
-#endif
-
 static struct omap_dss_device *overo_dss_devices[] = {
-	&overo_dvi_device,
-	&overo_tv_device,
-#if defined(CONFIG_PANEL_LGPHILIPS_LB035Q02) || \
-	defined(CONFIG_PANEL_LGPHILIPS_LB035Q02_MODULE)
-	&overo_lcd35_device,
-#endif
 	&overo_lcd43_device,
 };
 
 static struct omap_dss_board_info overo_dss_data = {
 	.num_devices	= ARRAY_SIZE(overo_dss_devices),
 	.devices	= overo_dss_devices,
-	.default_device	= &overo_dvi_device,
+	.default_display_name = "lcd43",
+};
+
+static struct gpio overo_dss_gpios[] __initdata = {
+	{ OVERO_GPIO_LCD_EN, GPIOF_OUT_INIT_HIGH, "OVERO_GPIO_LCD_EN" },
+	{ OVERO_GPIO_LCD_BL, GPIOF_OUT_INIT_HIGH, "OVERO_GPIO_LCD_BL" },
 };
 
+static void __init overo_display_init(void)
+{
+	if (gpio_request_array(overo_dss_gpios, ARRAY_SIZE(overo_dss_gpios))) {
+		printk(KERN_ERR "could not obtain DSS control GPIOs\n");
+		return;
+	}
+
+	gpio_export(OVERO_GPIO_LCD_EN, 0);
+	gpio_export(OVERO_GPIO_LCD_BL, 0);
+}
+
+#endif
+
 static struct mtd_partition overo_nand_partitions[] = {
 	{
 		.name           = "xloader",
@@ -438,8 +475,7 @@ static int __init overo_i2c_init(void)
 }
 
 static struct spi_board_info overo_spi_board_info[] __initdata = {
-#if defined(CONFIG_PANEL_LGPHILIPS_LB035Q02) || \
-	defined(CONFIG_PANEL_LGPHILIPS_LB035Q02_MODULE)
+#ifdef MACH_OVERO_EXPANSION_PALO35
 	{
 		.modalias		= "lgphilips_lb035q02_panel-spi",
 		.bus_num		= 1,
-- 
1.7.10.4

