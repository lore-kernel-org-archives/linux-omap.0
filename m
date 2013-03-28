From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 26/28] ARM: OMAP: CM-T35: use new generic-dpi-panel platform driver
Date: Thu, 28 Mar 2013 14:49:20 +0200
Message-ID: <1364474962-20439-27-git-send-email-tomi.valkeinen@ti.com>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44580 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756128Ab3C1MuT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Mar 2013 08:50:19 -0400
In-Reply-To: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Mike Rapoport <mike@compulab.co.il>, Igor Grinberg <grinberg@compulab.co.il>

Use the new generic-dpi-panel platform driver instead of the old
omap_dss_driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Mike Rapoport <mike@compulab.co.il>
Cc: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-omap2/board-cm-t35.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 4f23be0..6b8aa87 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -214,21 +214,21 @@ static void cm_t35_panel_disable_lcd(struct omap_dss_device *dssdev)
 }
 
 static struct panel_generic_dpi_data lcd_panel = {
+	.display_name		= "lcd",
+	.source			= "dpi.0",
 	.name			= "toppoly_tdo35s",
+	.data_lines		= 18,
 	.platform_enable	= cm_t35_panel_enable_lcd,
 	.platform_disable	= cm_t35_panel_disable_lcd,
 };
 
-static struct omap_dss_device cm_t35_lcd_device = {
-	.name			= "lcd",
-	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.driver_name		= "generic_dpi_panel",
-	.data			= &lcd_panel,
-	.phy.dpi.data_lines	= 18,
+static struct platform_device cm_t35_lcd_device = {
+	.name			= "generic_dpi_panel",
+	.id			= 0,
+	.dev.platform_data	= &lcd_panel,
 };
 
 static struct omap_dss_device *cm_t35_dss_devices[] = {
-	&cm_t35_lcd_device,
 	&cm_t35_tv_device,
 };
 
@@ -282,6 +282,8 @@ static void __init cm_t35_init_display(void)
 	msleep(50);
 	gpio_set_value(CM_T35_LCD_EN_GPIO, 1);
 
+	platform_device_register(&cm_t35_lcd_device);
+
 	err = omap_display_init(&cm_t35_dss_data);
 	if (err) {
 		pr_err("CM-T35: failed to register DSS device\n");
-- 
1.7.10.4

