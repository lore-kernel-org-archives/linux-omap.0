From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 09/21] ARM: OMAP: devkit8000: use new display drivers
Date: Fri, 26 Jul 2013 10:08:12 +0300
Message-ID: <1374822504-28949-10-git-send-email-tomi.valkeinen@ti.com>
References: <1374822504-28949-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38932 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757225Ab3GZHJm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Jul 2013 03:09:42 -0400
In-Reply-To: <1374822504-28949-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Use new display drivers for devkit8000 board.

The new OMAP display drivers were merged for 3.11, and we can now change
the board files to use the new ones and phase out the old ones.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-devkit8000.c | 96 +++++++++++++++++++++++-----------
 1 file changed, 65 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index f1d91ba..cdc4fb9 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -112,50 +112,81 @@ static struct regulator_consumer_supply devkit8000_vio_supply[] = {
 	REGULATOR_SUPPLY("vcc", "spi2.0"),
 };
 
-static struct panel_generic_dpi_data lcd_panel = {
-	.name			= "innolux_at070tn83",
-	/* gpios filled in code */
+static const struct display_timing devkit8000_lcd_videomode = {
+	.pixelclock	= { 0, 40000000, 0 },
+
+	.hactive = { 0, 800, 0 },
+	.hfront_porch = { 0, 1, 0 },
+	.hback_porch = { 0, 1, 0 },
+	.hsync_len = { 0, 48, 0 },
+
+	.vactive = { 0, 480, 0 },
+	.vfront_porch = { 0, 12, 0 },
+	.vback_porch = { 0, 25, 0 },
+	.vsync_len = { 0, 3, 0 },
+
+	.flags = DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW |
+		DISPLAY_FLAGS_DE_HIGH | DISPLAY_FLAGS_PIXDATA_POSEDGE,
 };
 
-static struct omap_dss_device devkit8000_lcd_device = {
+static struct panel_dpi_platform_data devkit8000_lcd_pdata = {
 	.name                   = "lcd",
-	.type                   = OMAP_DISPLAY_TYPE_DPI,
-	.driver_name            = "generic_dpi_panel",
-	.data			= &lcd_panel,
-	.phy.dpi.data_lines     = 24,
+	.source                 = "dpi.0",
+
+	.data_lines		= 24,
+
+	.display_timing		= &devkit8000_lcd_videomode,
+
+	.enable_gpio		= -1,	/* filled in code */
+	.backlight_gpio		= -1,
 };
 
-static struct tfp410_platform_data dvi_panel = {
-	.power_down_gpio	= -1,
-	.i2c_bus_num		= 1,
+static struct platform_device devkit8000_lcd_device = {
+	.name                   = "panel-dpi",
+	.id                     = 0,
+	.dev.platform_data      = &devkit8000_lcd_pdata,
 };
 
-static struct omap_dss_device devkit8000_dvi_device = {
+static struct connector_dvi_platform_data devkit8000_dvi_connector_pdata = {
 	.name                   = "dvi",
-	.type                   = OMAP_DISPLAY_TYPE_DPI,
-	.driver_name            = "tfp410",
-	.data			= &dvi_panel,
-	.phy.dpi.data_lines     = 24,
+	.source                 = "tfp410.0",
+	.i2c_bus_num            = 1,
 };
 
-static struct omap_dss_device devkit8000_tv_device = {
-	.name                   = "tv",
-	.driver_name            = "venc",
-	.type                   = OMAP_DISPLAY_TYPE_VENC,
-	.phy.venc.type          = OMAP_DSS_VENC_TYPE_SVIDEO,
+static struct platform_device devkit8000_dvi_connector_device = {
+	.name                   = "connector-dvi",
+	.id                     = 0,
+	.dev.platform_data      = &devkit8000_dvi_connector_pdata,
 };
 
+static struct encoder_tfp410_platform_data devkit8000_tfp410_pdata = {
+	.name                   = "tfp410.0",
+	.source                 = "dpi.0",
+	.data_lines             = 24,
+	.power_down_gpio        = -1,	/* filled in code */
+};
 
-static struct omap_dss_device *devkit8000_dss_devices[] = {
-	&devkit8000_lcd_device,
-	&devkit8000_dvi_device,
-	&devkit8000_tv_device,
+static struct platform_device devkit8000_tfp410_device = {
+	.name                   = "tfp410",
+	.id                     = 0,
+	.dev.platform_data      = &devkit8000_tfp410_pdata,
+};
+
+static struct connector_atv_platform_data devkit8000_tv_pdata = {
+	.name = "tv",
+	.source = "venc.0",
+	.connector_type = OMAP_DSS_VENC_TYPE_SVIDEO,
+	.invert_polarity = false,
+};
+
+static struct platform_device devkit8000_tv_connector_device = {
+	.name                   = "connector-analog-tv",
+	.id                     = 0,
+	.dev.platform_data      = &devkit8000_tv_pdata,
 };
 
 static struct omap_dss_board_info devkit8000_dss_data = {
-	.num_devices = ARRAY_SIZE(devkit8000_dss_devices),
-	.devices = devkit8000_dss_devices,
-	.default_device = &devkit8000_lcd_device,
+	.default_display_name = "lcd",
 };
 
 static uint32_t board_keymap[] = {
@@ -204,11 +235,10 @@ static int devkit8000_twl_gpio_setup(struct device *dev,
 	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
 
 	/* TWL4030_GPIO_MAX + 0 is "LCD_PWREN" (out, active high) */
-	lcd_panel.num_gpios = 1;
-	lcd_panel.gpios[0] = gpio + TWL4030_GPIO_MAX + 0;
+	devkit8000_lcd_pdata.enable_gpio = gpio + TWL4030_GPIO_MAX + 0;
 
 	/* gpio + 7 is "DVI_PD" (out, active low) */
-	dvi_panel.power_down_gpio = gpio + 7;
+	devkit8000_tfp410_pdata.power_down_gpio = gpio + 7;
 
 	return 0;
 }
@@ -413,6 +443,10 @@ static struct platform_device *devkit8000_devices[] __initdata = {
 	&leds_gpio,
 	&keys_gpio,
 	&omap_dm9000_dev,
+	&devkit8000_lcd_device,
+	&devkit8000_tfp410_device,
+	&devkit8000_dvi_connector_device,
+	&devkit8000_tv_connector_device,
 };
 
 static struct usbhs_omap_platform_data usbhs_bdata __initdata = {
-- 
1.8.1.2

