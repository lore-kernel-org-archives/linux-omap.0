From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 16/28] ARM: OMAP: IGEP0020: use new TFP410 platform driver
Date: Thu, 28 Mar 2013 14:49:10 +0200
Message-ID: <1364474962-20439-17-git-send-email-tomi.valkeinen@ti.com>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57265 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756070Ab3C1MuG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Mar 2013 08:50:06 -0400
In-Reply-To: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

Use the new TFP410 platform driver instead of the old omap_dss_driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-igep0020.c |   22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index bf92678..28d0b3e 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -430,30 +430,26 @@ static struct twl4030_gpio_platform_data igep_twl4030_gpio_pdata = {
 };
 
 static struct tfp410_platform_data dvi_panel = {
+	.name			= "dvi",
+	.source			= "dpi.0",
+	.data_lines		= 24,
 	.i2c_bus_num		= 3,
 	.power_down_gpio	= IGEP2_GPIO_DVI_PUP,
 };
 
-static struct omap_dss_device igep2_dvi_device = {
-	.type			= OMAP_DISPLAY_TYPE_DPI,
-	.name			= "dvi",
-	.driver_name		= "tfp410",
-	.data			= &dvi_panel,
-	.phy.dpi.data_lines	= 24,
-};
-
-static struct omap_dss_device *igep2_dss_devices[] = {
-	&igep2_dvi_device
+static struct platform_device igep2_dvi_device = {
+	.name			= "tfp410",
+	.id			= 0,
+	.dev.platform_data	= &dvi_panel,
 };
 
 static struct omap_dss_board_info igep2_dss_data = {
-	.num_devices	= ARRAY_SIZE(igep2_dss_devices),
-	.devices	= igep2_dss_devices,
-	.default_device	= &igep2_dvi_device,
+	.default_display_name = "dvi",
 };
 
 static struct platform_device *igep_devices[] __initdata = {
 	&igep_vwlan_device,
+	&igep2_dvi_device,
 };
 
 static int igep2_keymap[] = {
-- 
1.7.10.4

