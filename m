From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 6/6] OMAP: Apollon: Port the display driver to new DSS2
Date: Mon, 12 Sep 2011 14:20:48 +0300
Message-ID: <1315826448-27891-7-git-send-email-tomi.valkeinen@ti.com>
References: <1315826448-27891-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:50567 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755147Ab1ILLVN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Sep 2011 07:21:13 -0400
Received: by mail-bw0-f46.google.com with SMTP id zt4so2514048bkb.5
        for <linux-omap@vger.kernel.org>; Mon, 12 Sep 2011 04:21:12 -0700 (PDT)
In-Reply-To: <1315826448-27891-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>

Port the old omapfb panel driver to DSS2. This patch changes the board
file only, the driver is ported in separate patch.

Cc: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/board-apollon.c |   35 +++++++++++++++++++++++------------
 1 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index 7021170..d8eb81e 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -40,6 +40,9 @@
 #include <plat/common.h>
 #include <plat/gpmc.h>
 
+#include <video/omapdss.h>
+#include <video/omap-panel-generic-dpi.h>
+
 #include "mux.h"
 #include "control.h"
 
@@ -149,11 +152,6 @@ static struct platform_device apollon_smc91x_device = {
 	.resource	= apollon_smc91x_resources,
 };
 
-static struct platform_device apollon_lcd_device = {
-	.name		= "apollon_lcd",
-	.id		= -1,
-};
-
 static struct omap_led_config apollon_led_config[] = {
 	{
 		.cdev	= {
@@ -191,7 +189,6 @@ static struct platform_device apollon_led_device = {
 static struct platform_device *apollon_devices[] __initdata = {
 	&apollon_onenand_device,
 	&apollon_smc91x_device,
-	&apollon_lcd_device,
 	&apollon_led_device,
 };
 
@@ -265,12 +262,26 @@ static struct omap_usb_config apollon_usb_config __initdata = {
 	.pins[0]	= 6,
 };
 
-static struct omap_lcd_config apollon_lcd_config __initdata = {
-	.ctrl_name	= "internal",
+static struct panel_generic_dpi_data apollon_panel_data = {
+	.name			= "apollon",
 };
 
-static struct omap_board_config_kernel apollon_config[] __initdata = {
-	{ OMAP_TAG_LCD,		&apollon_lcd_config },
+static struct omap_dss_device apollon_lcd_device = {
+	.name			= "lcd",
+	.driver_name		= "generic_dpi_panel",
+	.type			= OMAP_DISPLAY_TYPE_DPI,
+	.phy.dpi.data_lines	= 18,
+	.data			= &apollon_panel_data,
+};
+
+static struct omap_dss_device *apollon_dss_devices[] = {
+	&apollon_lcd_device,
+};
+
+static struct omap_dss_board_info apollon_dss_data = {
+	.num_devices	= ARRAY_SIZE(apollon_dss_devices),
+	.devices	= apollon_dss_devices,
+	.default_device	= &apollon_lcd_device,
 };
 
 static void __init omap_apollon_init_early(void)
@@ -314,8 +325,6 @@ static void __init omap_apollon_init(void)
 	u32 v;
 
 	omap2420_mux_init(board_mux, OMAP_PACKAGE_ZAC);
-	omap_board_config = apollon_config;
-	omap_board_config_size = ARRAY_SIZE(apollon_config);
 
 	apollon_init_smc91x();
 	apollon_led_init();
@@ -340,6 +349,8 @@ static void __init omap_apollon_init(void)
 	 */
 	platform_add_devices(apollon_devices, ARRAY_SIZE(apollon_devices));
 	omap_serial_init();
+
+	omap_display_init(&apollon_dss_data);
 }
 
 static void __init omap_apollon_map_io(void)
-- 
1.7.4.1

