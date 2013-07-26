From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 10/21] ARM: OMAP: 2430SDP: use new display drivers
Date: Fri, 26 Jul 2013 10:08:13 +0300
Message-ID: <1374822504-28949-11-git-send-email-tomi.valkeinen@ti.com>
References: <1374822504-28949-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36998 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757117Ab3GZHJd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Jul 2013 03:09:33 -0400
In-Reply-To: <1374822504-28949-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Use new display drivers for 2430SDP board.

The new OMAP display drivers were merged for 3.11, and we can now change
the board files to use the new ones and phase out the old ones.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-2430sdp.c | 57 +++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 244d8a5..c711ad6 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -100,39 +100,52 @@ static struct platform_device sdp2430_flash_device = {
 	.resource	= &sdp2430_flash_resource,
 };
 
-static struct platform_device *sdp2430_devices[] __initdata = {
-	&sdp2430_flash_device,
-};
-
 /* LCD */
 #define SDP2430_LCD_PANEL_BACKLIGHT_GPIO	91
 #define SDP2430_LCD_PANEL_ENABLE_GPIO		154
 
-static struct panel_generic_dpi_data sdp2430_panel_data = {
-	.name			= "nec_nl2432dr22-11b",
-	.num_gpios		= 2,
-	.gpios			= {
-		SDP2430_LCD_PANEL_ENABLE_GPIO,
-		SDP2430_LCD_PANEL_BACKLIGHT_GPIO,
-	},
+static const struct display_timing sdp2430_lcd_videomode = {
+	.pixelclock	= { 0, 5400000, 0 },
+
+	.hactive = { 0, 240, 0 },
+	.hfront_porch = { 0, 3, 0 },
+	.hback_porch = { 0, 39, 0 },
+	.hsync_len = { 0, 3, 0 },
+
+	.vactive = { 0, 320, 0 },
+	.vfront_porch = { 0, 2, 0 },
+	.vback_porch = { 0, 7, 0 },
+	.vsync_len = { 0, 1, 0 },
+
+	.flags = DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW |
+		DISPLAY_FLAGS_DE_HIGH | DISPLAY_FLAGS_PIXDATA_POSEDGE,
 };
 
-static struct omap_dss_device sdp2430_lcd_device = {
-	.name			= "lcd",
-	.driver_name		= "generic_dpi_panel",
-	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.phy.dpi.data_lines	= 16,
-	.data			= &sdp2430_panel_data,
+static struct panel_dpi_platform_data sdp2430_lcd_pdata = {
+	.name                   = "lcd",
+	.source                 = "dpi.0",
+
+	.data_lines		= 16,
+
+	.display_timing		= &sdp2430_lcd_videomode,
+
+	.enable_gpio		= SDP2430_LCD_PANEL_ENABLE_GPIO,
+	.backlight_gpio		= SDP2430_LCD_PANEL_BACKLIGHT_GPIO,
 };
 
-static struct omap_dss_device *sdp2430_dss_devices[] = {
-	&sdp2430_lcd_device,
+static struct platform_device sdp2430_lcd_device = {
+	.name                   = "panel-dpi",
+	.id                     = 0,
+	.dev.platform_data      = &sdp2430_lcd_pdata,
 };
 
 static struct omap_dss_board_info sdp2430_dss_data = {
-	.num_devices	= ARRAY_SIZE(sdp2430_dss_devices),
-	.devices	= sdp2430_dss_devices,
-	.default_device	= &sdp2430_lcd_device,
+	.default_display_name = "lcd",
+};
+
+static struct platform_device *sdp2430_devices[] __initdata = {
+	&sdp2430_flash_device,
+	&sdp2430_lcd_device,
 };
 
 #if IS_ENABLED(CONFIG_SMC91X)
-- 
1.8.1.2

