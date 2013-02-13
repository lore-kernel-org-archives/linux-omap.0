From: Archit Taneja <archit@ti.com>
Subject: [PATCH 10/33] arm: omap: board-overo: use lb035q02 dpi panel's gpio handling
Date: Wed, 13 Feb 2013 19:52:02 +0530
Message-ID: <1360765345-19312-11-git-send-email-archit@ti.com>
References: <1360765345-19312-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56528 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756877Ab3BMOXo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Feb 2013 09:23:44 -0500
In-Reply-To: <1360765345-19312-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>, Tony Lindgren <tony@atomide.com>

The overo board file currently requests gpios required by the lb035q02 panel,
and provides platform_enable/disable callbacks to configure them.

These tasks have been moved to the lb035q02 dpi panel driver itself and should
be removed from the board files.

The lb035q02 panel driver uses generic dpi panel's platform data struct
internally. Remove the gpio requests and the platform callbacks from the board
file. Add the gpio information to the generic dpi panel platform data struct so
that it's passed to the panel driver.

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/mach-omap2/board-overo.c |   58 +++++++++----------------------------
 1 file changed, 14 insertions(+), 44 deletions(-)

diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index bf6b2ce..888e150 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -144,28 +144,9 @@ static inline void __init overo_init_smsc911x(void) { return; }
 #endif
 
 /* DSS */
-static int lcd_enabled;
-static int dvi_enabled;
-
 #define OVERO_GPIO_LCD_EN 144
 #define OVERO_GPIO_LCD_BL 145
 
-static struct gpio overo_dss_gpios[] __initdata = {
-	{ OVERO_GPIO_LCD_EN, GPIOF_OUT_INIT_HIGH, "OVERO_GPIO_LCD_EN" },
-	{ OVERO_GPIO_LCD_BL, GPIOF_OUT_INIT_HIGH, "OVERO_GPIO_LCD_BL" },
-};
-
-static void __init overo_display_init(void)
-{
-	if (gpio_request_array(overo_dss_gpios, ARRAY_SIZE(overo_dss_gpios))) {
-		printk(KERN_ERR "could not obtain DSS control GPIOs\n");
-		return;
-	}
-
-	gpio_export(OVERO_GPIO_LCD_EN, 0);
-	gpio_export(OVERO_GPIO_LCD_BL, 0);
-}
-
 static struct tfp410_platform_data dvi_panel = {
 	.i2c_bus_num		= 3,
 	.power_down_gpio	= -1,
@@ -186,30 +167,13 @@ static struct omap_dss_device overo_tv_device = {
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
 static struct panel_generic_dpi_data lcd43_panel = {
 	.name			= "samsung_lte430wq_f0c",
-	.platform_enable	= overo_panel_enable_lcd,
-	.platform_disable	= overo_panel_disable_lcd,
+	.num_gpios		= 2,
+	.gpios			= {
+		OVERO_GPIO_LCD_EN,
+		OVERO_GPIO_LCD_BL
+	},
 };
 
 static struct omap_dss_device overo_lcd43_device = {
@@ -222,13 +186,20 @@ static struct omap_dss_device overo_lcd43_device = {
 
 #if defined(CONFIG_PANEL_LGPHILIPS_LB035Q02) || \
 	defined(CONFIG_PANEL_LGPHILIPS_LB035Q02_MODULE)
+static struct panel_generic_dpi_data lcd35_panel = {
+	.num_gpios		= 2,
+	.gpios			= {
+		OVERO_GPIO_LCD_EN,
+		OVERO_GPIO_LCD_BL
+	},
+};
+
 static struct omap_dss_device overo_lcd35_device = {
 	.type			= OMAP_DISPLAY_TYPE_DPI,
 	.name			= "lcd35",
 	.driver_name		= "lgphilips_lb035q02_panel",
 	.phy.dpi.data_lines	= 24,
-	.platform_enable	= overo_panel_enable_lcd,
-	.platform_disable	= overo_panel_disable_lcd,
+	.data			= &lcd35_panel,
 };
 #endif
 
@@ -502,7 +473,6 @@ static void __init overo_init(void)
 	usbhs_init(&usbhs_bdata);
 	overo_spi_init();
 	overo_init_smsc911x();
-	overo_display_init();
 	overo_init_led();
 	overo_init_keys();
 	omap_twl4030_audio_init("overo");
-- 
1.7.9.5

