From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 21/28] ARM: OMAP: Overo: use new TFP410 platform driver
Date: Thu, 28 Mar 2013 14:49:15 +0200
Message-ID: <1364474962-20439-22-git-send-email-tomi.valkeinen@ti.com>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57272 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754669Ab3C1MuM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Mar 2013 08:50:12 -0400
In-Reply-To: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Use the new TFP410 platform driver instead of the old omap_dss_driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-overo.c |   20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 3253682..9cb29fc 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -148,30 +148,26 @@ static inline void __init overo_init_smsc911x(void) { return; }
 #if defined(CONFIG_MACH_OVERO_EXPANSION_SUMMIT)
 
 static struct tfp410_platform_data dvi_panel = {
+	.name			= "dvi",
+	.source			= "dpi.0",
+	.data_lines		= 24,
 	.i2c_bus_num		= 3,
 	.power_down_gpio	= -1,
 };
 
-static struct omap_dss_device overo_dvi_device = {
-	.name			= "dvi",
-	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.driver_name		= "tfp410",
-	.data			= &dvi_panel,
-	.phy.dpi.data_lines	= 24,
-};
-
-static struct omap_dss_device *overo_dss_devices[] = {
-	&overo_dvi_device,
+static struct platform_device overo_dvi_device = {
+	.name			= "tfp410",
+	.id			= 0,
+	.dev.platform_data	= &dvi_panel,
 };
 
 static struct omap_dss_board_info overo_dss_data = {
-	.num_devices	= ARRAY_SIZE(overo_dss_devices),
-	.devices	= overo_dss_devices,
 	.default_display_name = "dvi",
 };
 
 static void __init overo_display_init(void)
 {
+	platform_device_register(&overo_dvi_device);
 }
 
 #elif defined(CONFIG_MACH_OVERO_EXPANSION_PALO35)
-- 
1.7.10.4

