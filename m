From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 22/28] ARM: OMAP: Overo: use new generic-dpi-panel platform driver
Date: Thu, 28 Mar 2013 14:49:16 +0200
Message-ID: <1364474962-20439-23-git-send-email-tomi.valkeinen@ti.com>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57274 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754669Ab3C1MuN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Mar 2013 08:50:13 -0400
In-Reply-To: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Use the new generic-dpi-panel platform driver instead of the old
omap_dss_driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-overo.c |   23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 9cb29fc..03624c5 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -241,27 +241,22 @@ static void overo_panel_disable_lcd(struct omap_dss_device *dssdev)
 	gpio_set_value(OVERO_GPIO_LCD_BL, 0);
 }
 
-static struct panel_generic_dpi_data lcd43_panel = {
+static struct panel_generic_dpi_data overo_lcd43_data = {
+	.display_name		= "lcd43",
+	.source			= "dpi.0",
 	.name			= "samsung_lte430wq_f0c",
 	.platform_enable	= overo_panel_enable_lcd,
 	.platform_disable	= overo_panel_disable_lcd,
+	.data_lines		= 24,
 };
 
-static struct omap_dss_device overo_lcd43_device = {
-	.name			= "lcd43",
-	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.driver_name		= "generic_dpi_panel",
-	.data			= &lcd43_panel,
-	.phy.dpi.data_lines	= 24,
-};
-
-static struct omap_dss_device *overo_dss_devices[] = {
-	&overo_lcd43_device,
+static struct platform_device overo_lcd43_device = {
+	.name			= "generic_dpi_panel",
+	.id			= 0,
+	.dev.platform_data	= &overo_lcd43_data,
 };
 
 static struct omap_dss_board_info overo_dss_data = {
-	.num_devices	= ARRAY_SIZE(overo_dss_devices),
-	.devices	= overo_dss_devices,
 	.default_display_name = "lcd43",
 };
 
@@ -279,6 +274,8 @@ static void __init overo_display_init(void)
 
 	gpio_export(OVERO_GPIO_LCD_EN, 0);
 	gpio_export(OVERO_GPIO_LCD_BL, 0);
+
+	platform_device_register(&overo_lcd43_device);
 }
 
 #endif
-- 
1.7.10.4

