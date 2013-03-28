From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 24/28] ARM: OMAP: H4: use new generic-dpi-panel platform driver
Date: Thu, 28 Mar 2013 14:49:18 +0200
Message-ID: <1364474962-20439-25-git-send-email-tomi.valkeinen@ti.com>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57281 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756118Ab3C1MuQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Mar 2013 08:50:16 -0400
In-Reply-To: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Use the new generic-dpi-panel platform driver instead of the old
omap_dss_driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-h4.c |   24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 812c829..bbcbc31 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -194,30 +194,26 @@ static struct platform_device h4_flash_device = {
 	.resource	= &h4_flash_resource,
 };
 
-static struct platform_device *h4_devices[] __initdata = {
-	&h4_flash_device,
-};
-
 static struct panel_generic_dpi_data h4_panel_data = {
+	.display_name		= "lcd",
+	.source			= "dpi.0",
 	.name			= "h4",
+	.data_lines		= 16,
 };
 
-static struct omap_dss_device h4_lcd_device = {
-	.name			= "lcd",
-	.driver_name		= "generic_dpi_panel",
-	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.phy.dpi.data_lines	= 16,
-	.data			= &h4_panel_data,
+static struct platform_device h4_lcd_device = {
+	.name			= "generic_dpi_panel",
+	.id			= 0,
+	.dev.platform_data	= &h4_panel_data,
 };
 
-static struct omap_dss_device *h4_dss_devices[] = {
+static struct platform_device *h4_devices[] __initdata = {
+	&h4_flash_device,
 	&h4_lcd_device,
 };
 
 static struct omap_dss_board_info h4_dss_data = {
-	.num_devices	= ARRAY_SIZE(h4_dss_devices),
-	.devices	= h4_dss_devices,
-	.default_device	= &h4_lcd_device,
+	.default_display_name = "lcd",
 };
 
 /* 2420 Sysboot setup (2430 is different) */
-- 
1.7.10.4

