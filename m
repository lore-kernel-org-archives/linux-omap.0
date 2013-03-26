From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 26/26] ARM: OMAP: Overo: use new generic-dpi-panel platform driver
Date: Tue, 26 Mar 2013 15:33:56 +0200
Message-ID: <1364304836-18134-27-git-send-email-tomi.valkeinen@ti.com>
References: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36332 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759777Ab3CZNgB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Mar 2013 09:36:01 -0400
In-Reply-To: <1364304836-18134-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Use the new generic-dpi-panel platform driver instead of the old
omap_dss_driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-overo.c |   71 +++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index e3cd2bd..21579f8 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -152,6 +152,41 @@ static int dvi_enabled;
 #define OVERO_GPIO_LCD_EN 144
 #define OVERO_GPIO_LCD_BL 145
 
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
+static struct panel_generic_dpi_data overo_lcd43_data = {
+	.display_name		= "lcd43",
+	.source			= "dpi.0",
+	.name			= "samsung_lte430wq_f0c",
+	.platform_enable	= overo_panel_enable_lcd,
+	.platform_disable	= overo_panel_disable_lcd,
+	.data_lines		= 24,
+};
+
+static struct platform_device overo_lcd43_device = {
+	.name			= "generic_dpi_panel",
+	.id			= 0,
+	.dev.platform_data	= &overo_lcd43_data,
+};
+
 static struct gpio overo_dss_gpios[] __initdata = {
 	{ OVERO_GPIO_LCD_EN, GPIOF_OUT_INIT_HIGH, "OVERO_GPIO_LCD_EN" },
 	{ OVERO_GPIO_LCD_BL, GPIOF_OUT_INIT_HIGH, "OVERO_GPIO_LCD_BL" },
@@ -182,6 +217,7 @@ static void __init overo_display_init(void)
 	gpio_export(OVERO_GPIO_LCD_BL, 0);
 
 	platform_device_register(&overo_dvi_device);
+	platform_device_register(&overo_lcd43_device);
 }
 
 static struct omap_dss_device overo_tv_device = {
@@ -191,40 +227,6 @@ static struct omap_dss_device overo_tv_device = {
 	.phy.venc.type = OMAP_DSS_VENC_TYPE_SVIDEO,
 };
 
-static int overo_panel_enable_lcd(struct omap_dss_device *dssdev)
-{
-	if (dvi_enabled) {
-		printk(KERN_ERR "cannot enable LCD, DVI is enabled\n");
-		return -EINVAL;
-	}
-
-	gpio_set_value(OVERO_GPIO_LCD_EN, 1);
-	gpio_set_value(OVERO_GPIO_LCD_BL, 1);
-	lcd_enabled = 1;
-	return 0;
-}
-
-static void overo_panel_disable_lcd(struct omap_dss_device *dssdev)
-{
-	gpio_set_value(OVERO_GPIO_LCD_EN, 0);
-	gpio_set_value(OVERO_GPIO_LCD_BL, 0);
-	lcd_enabled = 0;
-}
-
-static struct panel_generic_dpi_data lcd43_panel = {
-	.name			= "samsung_lte430wq_f0c",
-	.platform_enable	= overo_panel_enable_lcd,
-	.platform_disable	= overo_panel_disable_lcd,
-};
-
-static struct omap_dss_device overo_lcd43_device = {
-	.name			= "lcd43",
-	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.driver_name		= "generic_dpi_panel",
-	.data			= &lcd43_panel,
-	.phy.dpi.data_lines	= 24,
-};
-
 #if defined(CONFIG_PANEL_LGPHILIPS_LB035Q02) || \
 	defined(CONFIG_PANEL_LGPHILIPS_LB035Q02_MODULE)
 static struct omap_dss_device overo_lcd35_device = {
@@ -243,7 +245,6 @@ static struct omap_dss_device *overo_dss_devices[] = {
 	defined(CONFIG_PANEL_LGPHILIPS_LB035Q02_MODULE)
 	&overo_lcd35_device,
 #endif
-	&overo_lcd43_device,
 };
 
 static struct omap_dss_board_info overo_dss_data = {
-- 
1.7.10.4

