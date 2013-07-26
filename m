From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 17/21] ARM: OMAP: OMAP3EVM: use new display drivers
Date: Fri, 26 Jul 2013 10:08:20 +0300
Message-ID: <1374822504-28949-18-git-send-email-tomi.valkeinen@ti.com>
References: <1374822504-28949-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37023 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757347Ab3GZHJu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Jul 2013 03:09:50 -0400
In-Reply-To: <1374822504-28949-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Use new display drivers for OMAP3EVM board.

The new OMAP display drivers were merged for 3.11, and we can now change
the board files to use the new ones and phase out the old ones.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm.c | 87 +++++++++++++++++++++---------------
 1 file changed, 52 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 8c02626..004c646 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -166,14 +166,6 @@ static inline void __init omap3evm_init_smsc911x(void) { return; }
  */
 #define OMAP3EVM_DVI_PANEL_EN_GPIO	199
 
-static struct panel_sharp_ls037v7dw01_data omap3_evm_lcd_data = {
-	.resb_gpio = OMAP3EVM_LCD_PANEL_RESB,
-	.ini_gpio = OMAP3EVM_LCD_PANEL_INI,
-	.mo_gpio = OMAP3EVM_LCD_PANEL_QVGA,
-	.lr_gpio = OMAP3EVM_LCD_PANEL_LR,
-	.ud_gpio = OMAP3EVM_LCD_PANEL_UD,
-};
-
 #ifdef CONFIG_BROKEN
 static void __init omap3_evm_display_init(void)
 {
@@ -196,44 +188,65 @@ static void __init omap3_evm_display_init(void)
 }
 #endif
 
-static struct omap_dss_device omap3_evm_lcd_device = {
-	.name			= "lcd",
-	.driver_name		= "sharp_ls_panel",
-	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.phy.dpi.data_lines	= 18,
-	.data			= &omap3_evm_lcd_data,
+static struct panel_sharp_ls037v7dw01_platform_data omap3_evm_lcd_pdata = {
+	.name                   = "lcd",
+	.source                 = "dpi.0",
+
+	.data_lines		= 18,
+
+	.resb_gpio		= OMAP3EVM_LCD_PANEL_RESB,
+	.ini_gpio		= OMAP3EVM_LCD_PANEL_INI,
+	.mo_gpio		= OMAP3EVM_LCD_PANEL_QVGA,
+	.lr_gpio		= OMAP3EVM_LCD_PANEL_LR,
+	.ud_gpio		= OMAP3EVM_LCD_PANEL_UD,
+};
+
+static struct platform_device omap3_evm_lcd_device = {
+	.name                   = "panel-sharp-ls037v7dw01",
+	.id                     = 0,
+	.dev.platform_data      = &omap3_evm_lcd_pdata,
+};
+
+static struct connector_dvi_platform_data omap3_evm_dvi_connector_pdata = {
+	.name                   = "dvi",
+	.source                 = "tfp410.0",
+	.i2c_bus_num            = -1,
+};
+
+static struct platform_device omap3_evm_dvi_connector_device = {
+	.name                   = "connector-dvi",
+	.id                     = 0,
+	.dev.platform_data      = &omap3_evm_dvi_connector_pdata,
 };
 
-static struct omap_dss_device omap3_evm_tv_device = {
-	.name			= "tv",
-	.driver_name		= "venc",
-	.type			= OMAP_DISPLAY_TYPE_VENC,
-	.phy.venc.type		= OMAP_DSS_VENC_TYPE_SVIDEO,
+static struct encoder_tfp410_platform_data omap3_evm_tfp410_pdata = {
+	.name                   = "tfp410.0",
+	.source                 = "dpi.0",
+	.data_lines             = 24,
+	.power_down_gpio        = OMAP3EVM_DVI_PANEL_EN_GPIO,
 };
 
-static struct tfp410_platform_data dvi_panel = {
-	.power_down_gpio	= OMAP3EVM_DVI_PANEL_EN_GPIO,
-	.i2c_bus_num		= -1,
+static struct platform_device omap3_evm_tfp410_device = {
+	.name                   = "tfp410",
+	.id                     = 0,
+	.dev.platform_data      = &omap3_evm_tfp410_pdata,
 };
 
-static struct omap_dss_device omap3_evm_dvi_device = {
-	.name			= "dvi",
-	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.driver_name		= "tfp410",
-	.data			= &dvi_panel,
-	.phy.dpi.data_lines	= 24,
+static struct connector_atv_platform_data omap3_evm_tv_pdata = {
+	.name = "tv",
+	.source = "venc.0",
+	.connector_type = OMAP_DSS_VENC_TYPE_SVIDEO,
+	.invert_polarity = false,
 };
 
-static struct omap_dss_device *omap3_evm_dss_devices[] = {
-	&omap3_evm_lcd_device,
-	&omap3_evm_tv_device,
-	&omap3_evm_dvi_device,
+static struct platform_device omap3_evm_tv_connector_device = {
+	.name                   = "connector-analog-tv",
+	.id                     = 0,
+	.dev.platform_data      = &omap3_evm_tv_pdata,
 };
 
 static struct omap_dss_board_info omap3_evm_dss_data = {
-	.num_devices	= ARRAY_SIZE(omap3_evm_dss_devices),
-	.devices	= omap3_evm_dss_devices,
-	.default_device	= &omap3_evm_lcd_device,
+	.default_display_name = "lcd",
 };
 
 static struct regulator_consumer_supply omap3evm_vmmc1_supply[] = {
@@ -678,6 +691,10 @@ static void __init omap3_evm_init(void)
 	omap3_evm_i2c_init();
 
 	omap_display_init(&omap3_evm_dss_data);
+	platform_device_register(&omap3_evm_lcd_device);
+	platform_device_register(&omap3_evm_tfp410_device);
+	platform_device_register(&omap3_evm_dvi_connector_device);
+	platform_device_register(&omap3_evm_tv_connector_device);
 
 	omap_serial_init();
 	omap_sdrc_init(mt46h32m32lf6_sdrc_params, NULL);
-- 
1.8.1.2

