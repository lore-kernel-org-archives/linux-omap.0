From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 6/6] OMAP: Apollon: Port the display driver to new DSS2
Date: Mon,  9 May 2011 10:36:07 +0300
Message-ID: <1304926567-26814-7-git-send-email-tomi.valkeinen@ti.com>
References: <1304926567-26814-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:32934 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752947Ab1EIHgc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 May 2011 03:36:32 -0400
Received: by mail-ey0-f181.google.com with SMTP id 5so1540721eyh.26
        for <linux-omap@vger.kernel.org>; Mon, 09 May 2011 00:36:31 -0700 (PDT)
In-Reply-To: <1304926567-26814-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>

Port the old omapfb panel driver to DSS2. This patch changes the board
file only, the driver is ported in separate patch.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-omap2/board-apollon.c |   34 ++++++++++++++++++++++------------
 1 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index f4f8374..0414c17 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -39,6 +39,8 @@
 #include <plat/board.h>
 #include <plat/common.h>
 #include <plat/gpmc.h>
+#include <plat/display.h>
+#include <plat/panel-generic-dpi.h>
 
 #include "mux.h"
 #include "control.h"
@@ -149,11 +151,6 @@ static struct platform_device apollon_smc91x_device = {
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
@@ -191,7 +188,6 @@ static struct platform_device apollon_led_device = {
 static struct platform_device *apollon_devices[] __initdata = {
 	&apollon_onenand_device,
 	&apollon_smc91x_device,
-	&apollon_lcd_device,
 	&apollon_led_device,
 };
 
@@ -266,12 +262,26 @@ static struct omap_usb_config apollon_usb_config __initdata = {
 	.pins[0]	= 6,
 };
 
-static struct omap_lcd_config apollon_lcd_config __initdata = {
-	.ctrl_name	= "internal",
+static struct panel_generic_dpi_data apollon_panel_data = {
+	.name			= "apollon",
+};
+
+static struct omap_dss_device apollon_lcd_device = {
+	.name			= "lcd",
+	.driver_name		= "generic_dpi_panel",
+	.type			= OMAP_DISPLAY_TYPE_DPI,
+	.phy.dpi.data_lines	= 18,
+	.data			= &apollon_panel_data,
 };
 
-static struct omap_board_config_kernel apollon_config[] __initdata = {
-	{ OMAP_TAG_LCD,		&apollon_lcd_config },
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
@@ -317,8 +327,6 @@ static void __init omap_apollon_init(void)
 	u32 v;
 
 	omap2420_mux_init(board_mux, OMAP_PACKAGE_ZAC);
-	omap_board_config = apollon_config;
-	omap_board_config_size = ARRAY_SIZE(apollon_config);
 
 	apollon_init_smc91x();
 	apollon_led_init();
@@ -343,6 +351,8 @@ static void __init omap_apollon_init(void)
 	 */
 	platform_add_devices(apollon_devices, ARRAY_SIZE(apollon_devices));
 	omap_serial_init();
+
+	omap_display_init(&apollon_dss_data);
 }
 
 static void __init omap_apollon_map_io(void)
-- 
1.7.4.1

