From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 23/28] ARM: OMAP: LDP: use new generic-dpi-panel platform driver
Date: Thu, 28 Mar 2013 14:49:17 +0200
Message-ID: <1364474962-20439-24-git-send-email-tomi.valkeinen@ti.com>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55095 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756118Ab3C1MuP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Mar 2013 08:50:15 -0400
In-Reply-To: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Use the new generic-dpi-panel platform driver instead of the old
omap_dss_driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-ldp.c |   22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index b12fe96..78e0470 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -206,27 +206,22 @@ static void ldp_panel_disable_lcd(struct omap_dss_device *dssdev)
 }
 
 static struct panel_generic_dpi_data ldp_panel_data = {
+	.display_name		= "lcd",
+	.source			= "dpi.0",
 	.name			= "nec_nl2432dr22-11b",
+	.data_lines		= 18,
 	.platform_enable	= ldp_panel_enable_lcd,
 	.platform_disable	= ldp_panel_disable_lcd,
 };
 
-static struct omap_dss_device ldp_lcd_device = {
-	.name			= "lcd",
-	.driver_name		= "generic_dpi_panel",
-	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.phy.dpi.data_lines	= 18,
-	.data			= &ldp_panel_data,
-};
-
-static struct omap_dss_device *ldp_dss_devices[] = {
-	&ldp_lcd_device,
+static struct platform_device ldp_lcd_device = {
+	.name			= "generic_dpi_panel",
+	.id			= 0,
+	.dev.platform_data	= &ldp_panel_data,
 };
 
 static struct omap_dss_board_info ldp_dss_data = {
-	.num_devices	= ARRAY_SIZE(ldp_dss_devices),
-	.devices	= ldp_dss_devices,
-	.default_device	= &ldp_lcd_device,
+	.default_display_name = "lcd",
 };
 
 static void __init ldp_display_init(void)
@@ -364,6 +359,7 @@ static struct omap2_hsmmc_info mmc[] __initdata = {
 
 static struct platform_device *ldp_devices[] __initdata = {
 	&ldp_gpio_keys_device,
+	&ldp_lcd_device,
 };
 
 #ifdef CONFIG_OMAP_MUX
-- 
1.7.10.4

