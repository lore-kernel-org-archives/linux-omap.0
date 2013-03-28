From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 15/28] ARM: OMAP: OMAP3EVM: use new TFP410 platform driver
Date: Thu, 28 Mar 2013 14:49:09 +0200
Message-ID: <1364474962-20439-16-git-send-email-tomi.valkeinen@ti.com>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44560 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756089Ab3C1MuD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Mar 2013 08:50:03 -0400
In-Reply-To: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Use the new TFP410 platform driver instead of the old omap_dss_driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |   17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 2050679..de92965 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -238,21 +238,21 @@ static void __init omap3_evm_display_init(void)
 }
 
 static struct tfp410_platform_data dvi_panel = {
+	.name			= "dvi",
+	.source			= "dpi.0",
+	.data_lines		= 24,
 	.power_down_gpio	= OMAP3EVM_DVI_PANEL_EN_GPIO,
 	.i2c_bus_num		= -1,
 };
 
-static struct omap_dss_device omap3_evm_dvi_device = {
-	.name			= "dvi",
-	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.driver_name		= "tfp410",
-	.data			= &dvi_panel,
-	.phy.dpi.data_lines	= 24,
+static struct platform_device omap3_evm_dvi_device = {
+	.name			= "tfp410",
+	.id			= 0,
+	.dev.platform_data	= &dvi_panel,
 };
 
 static struct omap_dss_device *omap3_evm_dss_devices[] = {
 	&omap3_evm_tv_device,
-	&omap3_evm_dvi_device,
 };
 
 static struct omap_dss_board_info omap3_evm_dss_data = {
@@ -705,6 +705,9 @@ static void __init omap3_evm_init(void)
 
 	omap3_evm_i2c_init();
 
+#if defined(CONFIG_MACH_OMAP3EVM_EXPANSION_DVI)
+	platform_device_register(&omap3_evm_dvi_device);
+#endif
 	omap_display_init(&omap3_evm_dss_data);
 
 	omap_serial_init();
-- 
1.7.10.4

