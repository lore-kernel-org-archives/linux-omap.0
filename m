From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 14/28] ARM: OMAP: Stalker: use new TFP410 platform driver
Date: Thu, 28 Mar 2013 14:49:08 +0200
Message-ID: <1364474962-20439-15-git-send-email-tomi.valkeinen@ti.com>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44554 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756070Ab3C1MuC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Mar 2013 08:50:02 -0400
In-Reply-To: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Use the new TFP410 platform driver instead of the old omap_dss_driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-omap3stalker.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index d427240..3d10d7c 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -107,27 +107,27 @@ static struct omap_dss_device omap3_stalker_tv_device = {
 };
 
 static struct tfp410_platform_data dvi_panel = {
+	.name			= "dvi",
+	.source			= "dpi.0",
+	.data_lines		= 24,
 	.power_down_gpio	= DSS_ENABLE_GPIO,
 	.i2c_bus_num		= -1,
 };
 
-static struct omap_dss_device omap3_stalker_dvi_device = {
-	.name			= "dvi",
-	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.driver_name		= "tfp410",
-	.data			= &dvi_panel,
-	.phy.dpi.data_lines	= 24,
+static struct platform_device omap3_stalker_dvi_device = {
+	.name			= "tfp410",
+	.id			= 0,
+	.dev.platform_data	= &dvi_panel,
 };
 
 static struct omap_dss_device *omap3_stalker_dss_devices[] = {
 	&omap3_stalker_tv_device,
-	&omap3_stalker_dvi_device,
 };
 
 static struct omap_dss_board_info omap3_stalker_dss_data = {
 	.num_devices	= ARRAY_SIZE(omap3_stalker_dss_devices),
 	.devices	= omap3_stalker_dss_devices,
-	.default_device	= &omap3_stalker_dvi_device,
+	.default_display_name = "dvi",
 };
 
 static struct regulator_consumer_supply omap3stalker_vmmc1_supply[] = {
@@ -349,6 +349,7 @@ static int __init omap3_stalker_i2c_init(void)
 
 static struct platform_device *omap3_stalker_devices[] __initdata = {
 	&keys_gpio,
+	&omap3_stalker_dvi_device,
 };
 
 static struct usbhs_omap_platform_data usbhs_bdata __initdata = {
-- 
1.7.10.4

