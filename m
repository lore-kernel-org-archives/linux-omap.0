From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 28/28] ARM: OMAP: 2430SDP: use new generic-dpi-panel platform driver
Date: Thu, 28 Mar 2013 14:49:22 +0200
Message-ID: <1364474962-20439-29-git-send-email-tomi.valkeinen@ti.com>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44585 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756134Ab3C1MuV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Mar 2013 08:50:21 -0400
In-Reply-To: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Use the new generic-dpi-panel platform driver instead of the old
omap_dss_driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-2430sdp.c |   24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index a3e0aaa..4f94dec 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -100,10 +100,6 @@ static struct platform_device sdp2430_flash_device = {
 	.resource	= &sdp2430_flash_resource,
 };
 
-static struct platform_device *sdp2430_devices[] __initdata = {
-	&sdp2430_flash_device,
-};
-
 /* LCD */
 #define SDP2430_LCD_PANEL_BACKLIGHT_GPIO	91
 #define SDP2430_LCD_PANEL_ENABLE_GPIO		154
@@ -123,27 +119,27 @@ static void sdp2430_panel_disable_lcd(struct omap_dss_device *dssdev)
 }
 
 static struct panel_generic_dpi_data sdp2430_panel_data = {
+	.display_name		= "lcd",
+	.source			= "dpi.0",
 	.name			= "nec_nl2432dr22-11b",
+	.data_lines		= 16,
 	.platform_enable	= sdp2430_panel_enable_lcd,
 	.platform_disable	= sdp2430_panel_disable_lcd,
 };
 
-static struct omap_dss_device sdp2430_lcd_device = {
-	.name			= "lcd",
-	.driver_name		= "generic_dpi_panel",
-	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.phy.dpi.data_lines	= 16,
-	.data			= &sdp2430_panel_data,
+static struct platform_device sdp2430_lcd_device = {
+	.name			= "generic_dpi_panel",
+	.id			= 0,
+	.dev.platform_data	= &sdp2430_panel_data,
 };
 
-static struct omap_dss_device *sdp2430_dss_devices[] = {
+static struct platform_device *sdp2430_devices[] __initdata = {
+	&sdp2430_flash_device,
 	&sdp2430_lcd_device,
 };
 
 static struct omap_dss_board_info sdp2430_dss_data = {
-	.num_devices	= ARRAY_SIZE(sdp2430_dss_devices),
-	.devices	= sdp2430_dss_devices,
-	.default_device	= &sdp2430_lcd_device,
+	.default_display_name = "lcd",
 };
 
 static void __init sdp2430_display_init(void)
-- 
1.7.10.4

