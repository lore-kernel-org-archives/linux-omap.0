From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 12/15] OMAP: stalker: Remove LCD device from board file
Date: Mon, 12 Sep 2011 12:13:35 +0300
Message-ID: <1315818818-18733-13-git-send-email-tomi.valkeinen@ti.com>
References: <1315818818-18733-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:48497 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754425Ab1ILJOW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Sep 2011 05:14:22 -0400
In-Reply-To: <1315818818-18733-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jason Lam <lzg@ema-tech.com>

OMAP3 Stalker board has definitions for LCD, but uses the generic driver
without any information what kind of LCD it has. The board should use a
particular panel type from panel-generic-dpi driver, not the generic
one.

As I haven't gotten response the signer-off of stalker board about the
issue, this patch removes the LCD support from the board file. This will
allow us to clean up the panel-generic-dpi driver and make it support
only fixed size panels.

CC: Jason Lam <lzg@ema-tech.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-omap3stalker.c |   34 ------------------------------
 1 files changed, 0 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index 8ab99f1..106a2ba 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -108,39 +108,6 @@ static void __init omap3_stalker_display_init(void)
 	return;
 }
 
-static int omap3_stalker_enable_lcd(struct omap_dss_device *dssdev)
-{
-	if (dvi_enabled) {
-		printk(KERN_ERR "cannot enable LCD, DVI is enabled\n");
-		return -EINVAL;
-	}
-	gpio_set_value(DSS_ENABLE_GPIO, 1);
-	gpio_set_value(LCD_PANEL_BKLIGHT_GPIO, 1);
-	lcd_enabled = 1;
-	return 0;
-}
-
-static void omap3_stalker_disable_lcd(struct omap_dss_device *dssdev)
-{
-	gpio_set_value(DSS_ENABLE_GPIO, 0);
-	gpio_set_value(LCD_PANEL_BKLIGHT_GPIO, 0);
-	lcd_enabled = 0;
-}
-
-static struct panel_generic_dpi_data lcd_panel = {
-	.name			= "generic",
-	.platform_enable	= omap3_stalker_enable_lcd,
-	.platform_disable	= omap3_stalker_disable_lcd,
-};
-
-static struct omap_dss_device omap3_stalker_lcd_device = {
-	.name			= "lcd",
-	.driver_name		= "generic_dpi_panel",
-	.data			= &lcd_panel,
-	.phy.dpi.data_lines	= 24,
-	.type			= OMAP_DISPLAY_TYPE_DPI,
-};
-
 static int omap3_stalker_enable_tv(struct omap_dss_device *dssdev)
 {
 	return 0;
@@ -194,7 +161,6 @@ static struct omap_dss_device omap3_stalker_dvi_device = {
 };
 
 static struct omap_dss_device *omap3_stalker_dss_devices[] = {
-	&omap3_stalker_lcd_device,
 	&omap3_stalker_tv_device,
 	&omap3_stalker_dvi_device,
 };
-- 
1.7.4.1

