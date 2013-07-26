From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 19/21] ARM: OMAP: Zoom: use new display drivers
Date: Fri, 26 Jul 2013 10:08:22 +0300
Message-ID: <1374822504-28949-20-git-send-email-tomi.valkeinen@ti.com>
References: <1374822504-28949-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37017 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757357Ab3GZHJs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Jul 2013 03:09:48 -0400
In-Reply-To: <1374822504-28949-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Use new display drivers for Zoom board.

The new OMAP display drivers were merged for 3.11, and we can now change
the board files to use the new ones and phase out the old ones.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-zoom-display.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom-display.c b/arch/arm/mach-omap2/board-zoom-display.c
index c2a079c..3d8ecc1 100644
--- a/arch/arm/mach-omap2/board-zoom-display.c
+++ b/arch/arm/mach-omap2/board-zoom-display.c
@@ -25,32 +25,23 @@
 #define LCD_PANEL_RESET_GPIO_PILOT	55
 #define LCD_PANEL_QVGA_GPIO		56
 
-static struct panel_nec_nl8048_data zoom_lcd_data = {
-	/* res_gpio filled in code */
-	.qvga_gpio = LCD_PANEL_QVGA_GPIO,
-};
+static struct panel_nec_nl8048hl11_platform_data zoom_lcd_pdata = {
+	.name                   = "lcd",
+	.source                 = "dpi.0",
 
-static struct omap_dss_device zoom_lcd_device = {
-	.name			= "lcd",
-	.driver_name		= "NEC_8048_panel",
-	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.phy.dpi.data_lines	= 24,
-	.data			= &zoom_lcd_data,
-};
+	.data_lines		= 24,
 
-static struct omap_dss_device *zoom_dss_devices[] = {
-	&zoom_lcd_device,
+	.res_gpio		= -1,	/* filled in code */
+	.qvga_gpio		= LCD_PANEL_QVGA_GPIO,
 };
 
 static struct omap_dss_board_info zoom_dss_data = {
-	.num_devices		= ARRAY_SIZE(zoom_dss_devices),
-	.devices		= zoom_dss_devices,
-	.default_device		= &zoom_lcd_device,
+	.default_display_name = "lcd",
 };
 
 static void __init zoom_lcd_panel_init(void)
 {
-	zoom_lcd_data.res_gpio = (omap_rev() > OMAP3430_REV_ES3_0) ?
+	zoom_lcd_pdata.res_gpio = (omap_rev() > OMAP3430_REV_ES3_0) ?
 			LCD_PANEL_RESET_GPIO_PROD :
 			LCD_PANEL_RESET_GPIO_PILOT;
 }
@@ -61,19 +52,20 @@ static struct omap2_mcspi_device_config dss_lcd_mcspi_config = {
 
 static struct spi_board_info nec_8048_spi_board_info[] __initdata = {
 	[0] = {
-		.modalias		= "nec_8048_spi",
+		.modalias		= "panel-nec-nl8048hl11",
 		.bus_num		= 1,
 		.chip_select		= 2,
 		.max_speed_hz		= 375000,
 		.controller_data	= &dss_lcd_mcspi_config,
+		.platform_data		= &zoom_lcd_pdata,
 	},
 };
 
 void __init zoom_display_init(void)
 {
 	omap_display_init(&zoom_dss_data);
+	zoom_lcd_panel_init();
 	spi_register_board_info(nec_8048_spi_board_info,
 				ARRAY_SIZE(nec_8048_spi_board_info));
-	zoom_lcd_panel_init();
 }
 
-- 
1.8.1.2

