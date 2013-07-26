From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 16/21] ARM: OMAP: 3430SDP: use new display drivers
Date: Fri, 26 Jul 2013 10:08:19 +0300
Message-ID: <1374822504-28949-17-git-send-email-tomi.valkeinen@ti.com>
References: <1374822504-28949-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38934 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757395Ab3GZHJt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Jul 2013 03:09:49 -0400
In-Reply-To: <1374822504-28949-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Use new display drivers for 3430SDP board.

The new OMAP display drivers were merged for 3.11, and we can now change
the board files to use the new ones and phase out the old ones.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c | 83 ++++++++++++++++++++++---------------
 1 file changed, 50 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 23b004a..d95d0ef 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -126,53 +126,65 @@ static void __init sdp3430_display_init(void)
 
 }
 
-static struct panel_sharp_ls037v7dw01_data sdp3430_lcd_data = {
-	.resb_gpio = SDP3430_LCD_PANEL_ENABLE_GPIO,
-	.ini_gpio = -1,
-	.mo_gpio = -1,
-	.lr_gpio = -1,
-	.ud_gpio = -1,
+static struct panel_sharp_ls037v7dw01_platform_data sdp3430_lcd_pdata = {
+	.name                   = "lcd",
+	.source                 = "dpi.0",
+
+	.data_lines		= 16,
+
+	.resb_gpio		= SDP3430_LCD_PANEL_ENABLE_GPIO,
+	.ini_gpio		= -1,
+	.mo_gpio		= -1,
+	.lr_gpio		= -1,
+	.ud_gpio		= -1,
+};
+
+static struct platform_device sdp3430_lcd_device = {
+	.name                   = "panel-sharp-ls037v7dw01",
+	.id                     = 0,
+	.dev.platform_data      = &sdp3430_lcd_pdata,
 };
 
-static struct omap_dss_device sdp3430_lcd_device = {
-	.name			= "lcd",
-	.driver_name		= "sharp_ls_panel",
-	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.phy.dpi.data_lines	= 16,
-	.data			= &sdp3430_lcd_data,
+static struct connector_dvi_platform_data sdp3430_dvi_connector_pdata = {
+	.name                   = "dvi",
+	.source                 = "tfp410.0",
+	.i2c_bus_num            = -1,
 };
 
-static struct tfp410_platform_data dvi_panel = {
-	.power_down_gpio	= -1,
-	.i2c_bus_num		= -1,
+static struct platform_device sdp3430_dvi_connector_device = {
+	.name                   = "connector-dvi",
+	.id                     = 0,
+	.dev.platform_data      = &sdp3430_dvi_connector_pdata,
 };
 
-static struct omap_dss_device sdp3430_dvi_device = {
-	.name			= "dvi",
-	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.driver_name		= "tfp410",
-	.data			= &dvi_panel,
-	.phy.dpi.data_lines	= 24,
+static struct encoder_tfp410_platform_data sdp3430_tfp410_pdata = {
+	.name                   = "tfp410.0",
+	.source                 = "dpi.0",
+	.data_lines             = 24,
+	.power_down_gpio        = -1,
 };
 
-static struct omap_dss_device sdp3430_tv_device = {
-	.name			= "tv",
-	.driver_name		= "venc",
-	.type			= OMAP_DISPLAY_TYPE_VENC,
-	.phy.venc.type		= OMAP_DSS_VENC_TYPE_SVIDEO,
+static struct platform_device sdp3430_tfp410_device = {
+	.name                   = "tfp410",
+	.id                     = 0,
+	.dev.platform_data      = &sdp3430_tfp410_pdata,
 };
 
+static struct connector_atv_platform_data sdp3430_tv_pdata = {
+	.name = "tv",
+	.source = "venc.0",
+	.connector_type = OMAP_DSS_VENC_TYPE_SVIDEO,
+	.invert_polarity = false,
+};
 
-static struct omap_dss_device *sdp3430_dss_devices[] = {
-	&sdp3430_lcd_device,
-	&sdp3430_dvi_device,
-	&sdp3430_tv_device,
+static struct platform_device sdp3430_tv_connector_device = {
+	.name                   = "connector-analog-tv",
+	.id                     = 0,
+	.dev.platform_data      = &sdp3430_tv_pdata,
 };
 
 static struct omap_dss_board_info sdp3430_dss_data = {
-	.num_devices	= ARRAY_SIZE(sdp3430_dss_devices),
-	.devices	= sdp3430_dss_devices,
-	.default_device	= &sdp3430_lcd_device,
+	.default_display_name = "lcd",
 };
 
 static struct omap2_hsmmc_info mmc[] = {
@@ -583,6 +595,11 @@ static void __init omap_3430sdp_init(void)
 	omap_hsmmc_init(mmc);
 	omap3430_i2c_init();
 	omap_display_init(&sdp3430_dss_data);
+	platform_device_register(&sdp3430_lcd_device);
+	platform_device_register(&sdp3430_tfp410_device);
+	platform_device_register(&sdp3430_dvi_connector_device);
+	platform_device_register(&sdp3430_tv_connector_device);
+
 	if (omap_rev() > OMAP3430_REV_ES1_0)
 		gpio_pendown = SDP3430_TS_GPIO_IRQ_SDPV2;
 	else
-- 
1.8.1.2

