From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 25/28] ARM: OMAP: Devkit8000: use new generic-dpi-panel platform driver
Date: Thu, 28 Mar 2013 14:49:19 +0200
Message-ID: <1364474962-20439-26-git-send-email-tomi.valkeinen@ti.com>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57283 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754669Ab3C1MuR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Mar 2013 08:50:17 -0400
In-Reply-To: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Use the new generic-dpi-panel platform driver instead of the old
omap_dss_driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-devkit8000.c |   33 ++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index d05f069..1e0343f 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -122,35 +122,37 @@ static struct omap_dss_device devkit8000_tv_device = {
 
 #if defined(CONFIG_MACH_DEVKIT8000_EXPANSION_LCD)
 
+static int lcd_reset_gpio;
+
 static int devkit8000_panel_enable_lcd(struct omap_dss_device *dssdev)
 {
-	if (gpio_is_valid(dssdev->reset_gpio))
-		gpio_set_value_cansleep(dssdev->reset_gpio, 1);
+	if (gpio_is_valid(lcd_reset_gpio))
+		gpio_set_value_cansleep(lcd_reset_gpio, 1);
 	return 0;
 }
 
 static void devkit8000_panel_disable_lcd(struct omap_dss_device *dssdev)
 {
-	if (gpio_is_valid(dssdev->reset_gpio))
-		gpio_set_value_cansleep(dssdev->reset_gpio, 0);
+	if (gpio_is_valid(lcd_reset_gpio))
+		gpio_set_value_cansleep(lcd_reset_gpio, 0);
 }
 
 static struct panel_generic_dpi_data lcd_panel = {
+	.display_name		= "lcd",
+	.source			= "dpi.0",
 	.name			= "innolux_at070tn83",
+	.data_lines		= 24,
 	.platform_enable        = devkit8000_panel_enable_lcd,
 	.platform_disable       = devkit8000_panel_disable_lcd,
 };
 
-static struct omap_dss_device devkit8000_lcd_device = {
-	.name                   = "lcd",
-	.type                   = OMAP_DISPLAY_TYPE_DPI,
-	.driver_name            = "generic_dpi_panel",
-	.data			= &lcd_panel,
-	.phy.dpi.data_lines     = 24,
+static struct platform_device devkit8000_lcd_device = {
+	.name			= "generic_dpi_panel",
+	.id			= 0,
+	.dev.platform_data	= &lcd_panel,
 };
 
 static struct omap_dss_device *devkit8000_dss_devices[] = {
-	&devkit8000_lcd_device,
 	&devkit8000_tv_device,
 };
 
@@ -238,11 +240,11 @@ static int devkit8000_twl_gpio_setup(struct device *dev,
 
 #if defined(CONFIG_MACH_DEVKIT8000_EXPANSION_LCD)
 	/* TWL4030_GPIO_MAX + 0 is "LCD_PWREN" (out, active high) */
-	devkit8000_lcd_device.reset_gpio = gpio + TWL4030_GPIO_MAX + 0;
-	ret = gpio_request_one(devkit8000_lcd_device.reset_gpio,
+	lcd_reset_gpio = gpio + TWL4030_GPIO_MAX + 0;
+	ret = gpio_request_one(lcd_reset_gpio,
 			       GPIOF_OUT_INIT_LOW, "LCD_PWREN");
 	if (ret < 0) {
-		devkit8000_lcd_device.reset_gpio = -EINVAL;
+		lcd_reset_gpio = -EINVAL;
 		printk(KERN_ERR "Failed to request GPIO for LCD_PWRN\n");
 	}
 #elif defined(CONFIG_MACH_DEVKIT8000_EXPANSION_DVI)
@@ -455,6 +457,9 @@ static struct platform_device *devkit8000_devices[] __initdata = {
 #if defined(CONFIG_MACH_DEVKIT8000_EXPANSION_DVI)
 	&devkit8000_dvi_device,
 #endif
+#if defined(CONFIG_MACH_DEVKIT8000_EXPANSION_LCD)
+	&devkit8000_lcd_device,
+#endif
 };
 
 static struct usbhs_omap_platform_data usbhs_bdata __initdata = {
-- 
1.7.10.4

