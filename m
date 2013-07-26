From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 14/21] ARM: OMAP: cm-t35: use new display drivers
Date: Fri, 26 Jul 2013 10:08:17 +0300
Message-ID: <1374822504-28949-15-git-send-email-tomi.valkeinen@ti.com>
References: <1374822504-28949-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40818 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757295Ab3GZHJn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Jul 2013 03:09:43 -0400
In-Reply-To: <1374822504-28949-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Use new display drivers for cm-t35 board.

The new OMAP display drivers were merged for 3.11, and we can now change
the board files to use the new ones and phase out the old ones.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-cm-t35.c | 100 +++++++++++++++++++++++++------------
 1 file changed, 67 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index d4622ed..33d159e 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -190,52 +190,81 @@ static inline void cm_t35_init_nand(void) {}
 #define CM_T35_LCD_BL_GPIO 58
 #define CM_T35_DVI_EN_GPIO 54
 
-static struct panel_generic_dpi_data lcd_panel = {
-	.name			= "toppoly_tdo35s",
-	.num_gpios		= 1,
-	.gpios			= {
-		CM_T35_LCD_BL_GPIO,
-	},
+static const struct display_timing cm_t35_lcd_videomode = {
+	.pixelclock	= { 0, 26000000, 0 },
+
+	.hactive = { 0, 480, 0 },
+	.hfront_porch = { 0, 104, 0 },
+	.hback_porch = { 0, 8, 0 },
+	.hsync_len = { 0, 8, 0 },
+
+	.vactive = { 0, 640, 0 },
+	.vfront_porch = { 0, 4, 0 },
+	.vback_porch = { 0, 2, 0 },
+	.vsync_len = { 0, 2, 0 },
+
+	.flags = DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW |
+		DISPLAY_FLAGS_DE_HIGH | DISPLAY_FLAGS_PIXDATA_NEGEDGE,
+};
+
+static struct panel_dpi_platform_data cm_t35_lcd_pdata = {
+	.name                   = "lcd",
+	.source                 = "dpi.0",
+
+	.data_lines		= 18,
+
+	.display_timing		= &cm_t35_lcd_videomode,
+
+	.enable_gpio		= -1,
+	.backlight_gpio		= CM_T35_LCD_BL_GPIO,
+};
+
+static struct platform_device cm_t35_lcd_device = {
+	.name                   = "panel-dpi",
+	.id                     = 0,
+	.dev.platform_data      = &cm_t35_lcd_pdata,
 };
 
-static struct omap_dss_device cm_t35_lcd_device = {
-	.name			= "lcd",
-	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.driver_name		= "generic_dpi_panel",
-	.data			= &lcd_panel,
-	.phy.dpi.data_lines	= 18,
+static struct connector_dvi_platform_data cm_t35_dvi_connector_pdata = {
+	.name                   = "dvi",
+	.source                 = "tfp410.0",
+	.i2c_bus_num            = -1,
 };
 
-static struct tfp410_platform_data dvi_panel = {
-	.power_down_gpio	= CM_T35_DVI_EN_GPIO,
-	.i2c_bus_num		= -1,
+static struct platform_device cm_t35_dvi_connector_device = {
+	.name                   = "connector-dvi",
+	.id                     = 0,
+	.dev.platform_data      = &cm_t35_dvi_connector_pdata,
 };
 
-static struct omap_dss_device cm_t35_dvi_device = {
-	.name			= "dvi",
-	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.driver_name		= "tfp410",
-	.data			= &dvi_panel,
-	.phy.dpi.data_lines	= 24,
+static struct encoder_tfp410_platform_data cm_t35_tfp410_pdata = {
+	.name                   = "tfp410.0",
+	.source                 = "dpi.0",
+	.data_lines             = 24,
+	.power_down_gpio        = CM_T35_DVI_EN_GPIO,
 };
 
-static struct omap_dss_device cm_t35_tv_device = {
-	.name			= "tv",
-	.driver_name		= "venc",
-	.type			= OMAP_DISPLAY_TYPE_VENC,
-	.phy.venc.type		= OMAP_DSS_VENC_TYPE_SVIDEO,
+static struct platform_device cm_t35_tfp410_device = {
+	.name                   = "tfp410",
+	.id                     = 0,
+	.dev.platform_data      = &cm_t35_tfp410_pdata,
 };
 
-static struct omap_dss_device *cm_t35_dss_devices[] = {
-	&cm_t35_lcd_device,
-	&cm_t35_dvi_device,
-	&cm_t35_tv_device,
+static struct connector_atv_platform_data cm_t35_tv_pdata = {
+	.name = "tv",
+	.source = "venc.0",
+	.connector_type = OMAP_DSS_VENC_TYPE_SVIDEO,
+	.invert_polarity = false,
+};
+
+static struct platform_device cm_t35_tv_connector_device = {
+	.name                   = "connector-analog-tv",
+	.id                     = 0,
+	.dev.platform_data      = &cm_t35_tv_pdata,
 };
 
 static struct omap_dss_board_info cm_t35_dss_data = {
-	.num_devices	= ARRAY_SIZE(cm_t35_dss_devices),
-	.devices	= cm_t35_dss_devices,
-	.default_device	= &cm_t35_dvi_device,
+	.default_display_name = "dvi",
 };
 
 static struct omap2_mcspi_device_config tdo24m_mcspi_config = {
@@ -280,6 +309,11 @@ static void __init cm_t35_init_display(void)
 		pr_err("CM-T35: failed to register DSS device\n");
 		gpio_free(CM_T35_LCD_EN_GPIO);
 	}
+
+	platform_device_register(&cm_t35_tfp410_device);
+	platform_device_register(&cm_t35_dvi_connector_device);
+	platform_device_register(&cm_t35_lcd_device);
+	platform_device_register(&cm_t35_tv_connector_device);
 }
 
 static struct regulator_consumer_supply cm_t35_vmmc1_supply[] = {
-- 
1.8.1.2

