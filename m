From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 20/28] ARM: OMAP: 3430SDP: use new TFP410 platform driver
Date: Thu, 28 Mar 2013 14:49:14 +0200
Message-ID: <1364474962-20439-21-git-send-email-tomi.valkeinen@ti.com>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57270 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754669Ab3C1MuL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Mar 2013 08:50:11 -0400
In-Reply-To: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Use the new TFP410 platform driver instead of the old omap_dss_driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c |   19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 4acd4aa..2f9d4e0 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -119,27 +119,27 @@ static void __init sdp3430_display_init(void)
 }
 
 static struct tfp410_platform_data dvi_panel = {
+	.name			= "dvi",
+	.source			= "dpi.0",
+	.data_lines		= 24,
 	.power_down_gpio	= -1,
 	.i2c_bus_num		= -1,
 };
 
-static struct omap_dss_device sdp3430_dvi_device = {
-	.name			= "dvi",
-	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.driver_name		= "tfp410",
-	.data			= &dvi_panel,
-	.phy.dpi.data_lines	= 24,
+static struct platform_device sdp3430_dvi_device = {
+	.name			= "tfp410",
+	.id			= 0,
+	.dev.platform_data	= &dvi_panel,
 };
 
 static struct omap_dss_device *sdp3430_dss_devices[] = {
-	&sdp3430_dvi_device,
 	&sdp3430_tv_device,
 };
 
 static struct omap_dss_board_info sdp3430_dss_data = {
 	.num_devices	= ARRAY_SIZE(sdp3430_dss_devices),
 	.devices	= sdp3430_dss_devices,
-	.default_device	= &sdp3430_dvi_device,
+	.default_display_name = "dvi",
 };
 
 #elif defined(CONFIG_MACH_OMAP_3430SDP_EXPANSION_LCD)
@@ -612,6 +612,9 @@ static void __init omap_3430sdp_init(void)
 	board_smc91x_init();
 	board_flash_init(sdp_flash_partitions, chip_sel_3430, 0);
 	sdp3430_display_init();
+#if defined(CONFIG_MACH_OMAP_3430SDP_EXPANSION_DVI)
+	platform_device_register(&sdp3430_dvi_device);
+#endif
 	enable_board_wakeup_source();
 	usbhs_init(&usbhs_bdata);
 }
-- 
1.7.10.4

