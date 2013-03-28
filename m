From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 27/28] ARM: OMAP: AM3517EVM: use new generic-dpi-panel platform driver
Date: Thu, 28 Mar 2013 14:49:21 +0200
Message-ID: <1364474962-20439-28-git-send-email-tomi.valkeinen@ti.com>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55107 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756118Ab3C1MuU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Mar 2013 08:50:20 -0400
In-Reply-To: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Use the new generic-dpi-panel platform driver instead of the old
omap_dss_driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-am3517evm.c |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index c545981..a7e728e 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -169,21 +169,21 @@ static void am3517_evm_panel_disable_lcd(struct omap_dss_device *dssdev)
 }
 
 static struct panel_generic_dpi_data lcd_panel = {
+	.display_name		= "lcd",
+	.source			= "dpi.0",
 	.name			= "sharp_lq",
+	.data_lines		= 16,
 	.platform_enable	= am3517_evm_panel_enable_lcd,
 	.platform_disable	= am3517_evm_panel_disable_lcd,
 };
 
-static struct omap_dss_device am3517_evm_lcd_device = {
-	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.name			= "lcd",
-	.driver_name		= "generic_dpi_panel",
-	.data			= &lcd_panel,
-	.phy.dpi.data_lines 	= 16,
+static struct platform_device am3517_evm_lcd_device = {
+	.name			= "generic_dpi_panel",
+	.id			= 0,
+	.dev.platform_data	= &lcd_panel,
 };
 
 static struct omap_dss_device *am3517_evm_dss_devices[] = {
-	&am3517_evm_lcd_device,
 	&am3517_evm_tv_device,
 };
 
@@ -362,6 +362,9 @@ static void __init am3517_evm_init(void)
 #if defined(CONFIG_MACH_OMAP3517EVM_EXPANSION_DVI)
 	platform_device_register(&am3517_evm_dvi_device);
 #endif
+#if defined(CONFIG_MACH_OMAP3517EVM_EXPANSION_LCD)
+	platform_device_register(&am3517_evm_lcd_device);
+#endif
 
 	/* RTC - S35390A */
 	am3517_evm_rtc_init();
-- 
1.7.10.4

