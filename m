From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 7/7] OMAP: Apollon: Port the display driver to new DSS2
Date: Wed,  4 May 2011 15:27:39 +0300
Message-ID: <1304512059-10372-8-git-send-email-tomi.valkeinen@ti.com>
References: <1304512059-10372-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:43645 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753528Ab1EDM2L (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 May 2011 08:28:11 -0400
In-Reply-To: <1304512059-10372-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>

Port the old omapfb panel driver to DSS2 and change the board file
accordingly.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-omap2/board-apollon.c              |   34 ++++--
 drivers/video/omap/Makefile                      |    1 -
 drivers/video/omap/lcd_apollon.c                 |  136 ----------------------
 drivers/video/omap2/displays/panel-generic-dpi.c |   22 ++++
 4 files changed, 44 insertions(+), 149 deletions(-)
 delete mode 100644 drivers/video/omap/lcd_apollon.c

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
diff --git a/drivers/video/omap/Makefile b/drivers/video/omap/Makefile
index 22fef61..ef78550 100644
--- a/drivers/video/omap/Makefile
+++ b/drivers/video/omap/Makefile
@@ -25,7 +25,6 @@ objs-$(CONFIG_ARCH_OMAP16XX)$(CONFIG_MACH_OMAP_INNOVATOR) += lcd_inn1610.o
 objs-$(CONFIG_ARCH_OMAP15XX)$(CONFIG_MACH_OMAP_INNOVATOR) += lcd_inn1510.o
 objs-y$(CONFIG_MACH_OMAP_OSK) += lcd_osk.o
 
-objs-y$(CONFIG_MACH_OMAP_APOLLON) += lcd_apollon.o
 objs-y$(CONFIG_FB_OMAP_LCD_MIPID) += lcd_mipid.o
 objs-y$(CONFIG_MACH_HERALD) += lcd_htcherald.o
 
diff --git a/drivers/video/omap/lcd_apollon.c b/drivers/video/omap/lcd_apollon.c
deleted file mode 100644
index 10459d8..0000000
--- a/drivers/video/omap/lcd_apollon.c
+++ /dev/null
@@ -1,136 +0,0 @@
-/*
- * LCD panel support for the Samsung OMAP2 Apollon board
- *
- * Copyright (C) 2005,2006 Samsung Electronics
- * Author: Kyungmin Park <kyungmin.park@samsung.com>
- *
- * Derived from drivers/video/omap/lcd-h4.c
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
- * option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
- */
-
-#include <linux/module.h>
-#include <linux/platform_device.h>
-
-#include <mach/gpio.h>
-
-#include "omapfb.h"
-
-/* #define USE_35INCH_LCD 1 */
-
-static int apollon_panel_init(struct lcd_panel *panel,
-				struct omapfb_device *fbdev)
-{
-	return 0;
-}
-
-static void apollon_panel_cleanup(struct lcd_panel *panel)
-{
-}
-
-static int apollon_panel_enable(struct lcd_panel *panel)
-{
-	return 0;
-}
-
-static void apollon_panel_disable(struct lcd_panel *panel)
-{
-}
-
-static unsigned long apollon_panel_get_caps(struct lcd_panel *panel)
-{
-	return 0;
-}
-
-struct lcd_panel apollon_panel = {
-	.name		= "apollon",
-	.config		= OMAP_LCDC_PANEL_TFT | OMAP_LCDC_INV_VSYNC |
-			  OMAP_LCDC_INV_HSYNC,
-
-	.bpp		= 16,
-	.data_lines	= 18,
-#ifdef USE_35INCH_LCD
-	.x_res		= 240,
-	.y_res		= 320,
-	.hsw		= 2,
-	.hfp		= 3,
-	.hbp		= 9,
-	.vsw		= 4,
-	.vfp		= 3,
-	.vbp		= 5,
-#else
-	.x_res		= 480,
-	.y_res		= 272,
-	.hsw		= 41,
-	.hfp		= 2,
-	.hbp		= 2,
-	.vsw		= 10,
-	.vfp		= 2,
-	.vbp		= 2,
-#endif
-	.pixel_clock	= 6250,
-
-	.init		= apollon_panel_init,
-	.cleanup	= apollon_panel_cleanup,
-	.enable		= apollon_panel_enable,
-	.disable	= apollon_panel_disable,
-	.get_caps	= apollon_panel_get_caps,
-};
-
-static int apollon_panel_probe(struct platform_device *pdev)
-{
-	omapfb_register_panel(&apollon_panel);
-	return 0;
-}
-
-static int apollon_panel_remove(struct platform_device *pdev)
-{
-	return 0;
-}
-
-static int apollon_panel_suspend(struct platform_device *pdev,
-				  pm_message_t mesg)
-{
-	return 0;
-}
-
-static int apollon_panel_resume(struct platform_device *pdev)
-{
-	return 0;
-}
-
-struct platform_driver apollon_panel_driver = {
-	.probe		= apollon_panel_probe,
-	.remove		= apollon_panel_remove,
-	.suspend	= apollon_panel_suspend,
-	.resume		= apollon_panel_resume,
-	.driver		= {
-		.name	= "apollon_lcd",
-		.owner	= THIS_MODULE,
-	},
-};
-
-static int __init apollon_panel_drv_init(void)
-{
-	return platform_driver_register(&apollon_panel_driver);
-}
-
-static void __exit apollon_panel_drv_exit(void)
-{
-	platform_driver_unregister(&apollon_panel_driver);
-}
-
-module_init(apollon_panel_drv_init);
-module_exit(apollon_panel_drv_exit);
diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
index 92bf63e..5b8ef3e 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -223,6 +223,28 @@ static struct panel_config generic_dpi_panels[] = {
 
 		.name			= "h4",
 	},
+
+	/* Unknown panel used in Samsung OMAP2 Apollon */
+	{
+		{
+			.x_res		= 480,
+			.y_res		= 272,
+
+			.pixel_clock	= 6250,
+
+			.hsw		= 41,
+			.hfp		= 2,
+			.hbp		= 2,
+
+			.vsw		= 10,
+			.vfp		= 2,
+			.vbp		= 2,
+		},
+		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
+						OMAP_DSS_LCD_IHS,
+
+		.name			= "apollon",
+	},
 };
 
 struct panel_drv_data {
-- 
1.7.4.1

