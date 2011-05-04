From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 6/7] OMAP: H4: Port the display driver to new DSS2
Date: Wed,  4 May 2011 15:27:38 +0300
Message-ID: <1304512059-10372-7-git-send-email-tomi.valkeinen@ti.com>
References: <1304512059-10372-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:42360 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753301Ab1EDM2J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 May 2011 08:28:09 -0400
In-Reply-To: <1304512059-10372-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Imre Deak <imre.deak@nokia.com>

Port the old omapfb panel driver to DSS2 and change the board file
accordingly.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Imre Deak <imre.deak@nokia.com>
---
 arch/arm/mach-omap2/board-h4.c                   |   41 +++++---
 drivers/video/omap/Makefile                      |    1 -
 drivers/video/omap/lcd_h4.c                      |  117 ----------------------
 drivers/video/omap2/displays/panel-generic-dpi.c |   21 ++++
 4 files changed, 46 insertions(+), 134 deletions(-)
 delete mode 100644 drivers/video/omap/lcd_h4.c

diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index bac7933..991e71e 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -39,6 +39,8 @@
 #include <plat/menelaus.h>
 #include <plat/dma.h>
 #include <plat/gpmc.h>
+#include <plat/display.h>
+#include <plat/panel-generic-dpi.h>
 
 #include "mux.h"
 #include "control.h"
@@ -157,17 +159,33 @@ static struct platform_device h4_kp_device = {
 	},
 };
 
-static struct platform_device h4_lcd_device = {
-	.name		= "lcd_h4",
-	.id		= -1,
-};
-
 static struct platform_device *h4_devices[] __initdata = {
 	&h4_flash_device,
 	&h4_kp_device,
+};
+
+static struct panel_generic_dpi_data h4_panel_data = {
+	.name			= "h4",
+};
+
+static struct omap_dss_device h4_lcd_device = {
+	.name			= "lcd",
+	.driver_name		= "generic_dpi_panel",
+	.type			= OMAP_DISPLAY_TYPE_DPI,
+	.phy.dpi.data_lines	= 16,
+	.data			= &h4_panel_data,
+};
+
+static struct omap_dss_device *h4_dss_devices[] = {
 	&h4_lcd_device,
 };
 
+static struct omap_dss_board_info h4_dss_data = {
+	.num_devices	= ARRAY_SIZE(h4_dss_devices),
+	.devices	= h4_dss_devices,
+	.default_device	= &h4_lcd_device,
+};
+
 /* 2420 Sysboot setup (2430 is different) */
 static u32 get_sysboot_value(void)
 {
@@ -271,10 +289,6 @@ static void __init h4_init_flash(void)
 	h4_flash_resource.end	= base + SZ_64M - 1;
 }
 
-static struct omap_lcd_config h4_lcd_config __initdata = {
-	.ctrl_name	= "internal",
-};
-
 static struct omap_usb_config h4_usb_config __initdata = {
 	/* S1.10 OFF -- usb "download port"
 	 * usb0 switched to Mini-B port and isp1105 transceiver;
@@ -286,10 +300,6 @@ static struct omap_usb_config h4_usb_config __initdata = {
 	.hmc_mode	= 0x00,		/* 0:dev|otg 1:disable 2:disable */
 };
 
-static struct omap_board_config_kernel h4_config[] __initdata = {
-	{ OMAP_TAG_LCD,		&h4_lcd_config },
-};
-
 static void __init omap_h4_init_early(void)
 {
 	omap2_init_common_infrastructure();
@@ -331,9 +341,6 @@ static void __init omap_h4_init(void)
 {
 	omap2420_mux_init(board_mux, OMAP_PACKAGE_ZAF);
 
-	omap_board_config = h4_config;
-	omap_board_config_size = ARRAY_SIZE(h4_config);
-
 	/*
 	 * Make sure the serial ports are muxed on at this point.
 	 * You have to mux them off in device drivers later on
@@ -372,6 +379,8 @@ static void __init omap_h4_init(void)
 	omap2_usbfs_init(&h4_usb_config);
 	omap_serial_init();
 	h4_init_flash();
+
+	omap_display_init(&h4_dss_data);
 }
 
 static void __init omap_h4_map_io(void)
diff --git a/drivers/video/omap/Makefile b/drivers/video/omap/Makefile
index 43eb64a..22fef61 100644
--- a/drivers/video/omap/Makefile
+++ b/drivers/video/omap/Makefile
@@ -17,7 +17,6 @@ objs-y$(CONFIG_FB_OMAP_LCDC_HWA742) += hwa742.o
 objs-y$(CONFIG_FB_OMAP_LCDC_BLIZZARD) += blizzard.o
 
 objs-y$(CONFIG_MACH_AMS_DELTA) += lcd_ams_delta.o
-objs-y$(CONFIG_MACH_OMAP_H4) += lcd_h4.o
 objs-y$(CONFIG_MACH_OMAP_H3) += lcd_h3.o
 objs-y$(CONFIG_MACH_OMAP_PALMTE) += lcd_palmte.o
 objs-y$(CONFIG_MACH_OMAP_PALMTT) += lcd_palmtt.o
diff --git a/drivers/video/omap/lcd_h4.c b/drivers/video/omap/lcd_h4.c
deleted file mode 100644
index 03a06a9..0000000
--- a/drivers/video/omap/lcd_h4.c
+++ /dev/null
@@ -1,117 +0,0 @@
-/*
- * LCD panel support for the TI OMAP H4 board
- *
- * Copyright (C) 2004 Nokia Corporation
- * Author: Imre Deak <imre.deak@nokia.com>
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
-#include "omapfb.h"
-
-static int h4_panel_init(struct lcd_panel *panel, struct omapfb_device *fbdev)
-{
-	return 0;
-}
-
-static void h4_panel_cleanup(struct lcd_panel *panel)
-{
-}
-
-static int h4_panel_enable(struct lcd_panel *panel)
-{
-	return 0;
-}
-
-static void h4_panel_disable(struct lcd_panel *panel)
-{
-}
-
-static unsigned long h4_panel_get_caps(struct lcd_panel *panel)
-{
-	return 0;
-}
-
-static struct lcd_panel h4_panel = {
-	.name		= "h4",
-	.config		= OMAP_LCDC_PANEL_TFT,
-
-	.bpp		= 16,
-	.data_lines	= 16,
-	.x_res		= 240,
-	.y_res		= 320,
-	.pixel_clock	= 6250,
-	.hsw		= 15,
-	.hfp		= 15,
-	.hbp		= 60,
-	.vsw		= 1,
-	.vfp		= 1,
-	.vbp		= 1,
-
-	.init		= h4_panel_init,
-	.cleanup	= h4_panel_cleanup,
-	.enable		= h4_panel_enable,
-	.disable	= h4_panel_disable,
-	.get_caps	= h4_panel_get_caps,
-};
-
-static int h4_panel_probe(struct platform_device *pdev)
-{
-	omapfb_register_panel(&h4_panel);
-	return 0;
-}
-
-static int h4_panel_remove(struct platform_device *pdev)
-{
-	return 0;
-}
-
-static int h4_panel_suspend(struct platform_device *pdev, pm_message_t mesg)
-{
-	return 0;
-}
-
-static int h4_panel_resume(struct platform_device *pdev)
-{
-	return 0;
-}
-
-static struct platform_driver h4_panel_driver = {
-	.probe		= h4_panel_probe,
-	.remove		= h4_panel_remove,
-	.suspend	= h4_panel_suspend,
-	.resume		= h4_panel_resume,
-	.driver		= {
-		.name	= "lcd_h4",
-		.owner	= THIS_MODULE,
-	},
-};
-
-static int __init h4_panel_drv_init(void)
-{
-	return platform_driver_register(&h4_panel_driver);
-}
-
-static void __exit h4_panel_drv_cleanup(void)
-{
-	platform_driver_unregister(&h4_panel_driver);
-}
-
-module_init(h4_panel_drv_init);
-module_exit(h4_panel_drv_cleanup);
-
diff --git a/drivers/video/omap2/displays/panel-generic-dpi.c b/drivers/video/omap2/displays/panel-generic-dpi.c
index 2c1b093..92bf63e 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -202,6 +202,27 @@ static struct panel_config generic_dpi_panels[] = {
 						OMAP_DSS_LCD_IHS,
 		.name			= "2430sdp",
 	},
+
+	/* Unknown panel used in OMAP H4 */
+	{
+		{
+			.x_res		= 240,
+			.y_res		= 320,
+
+			.pixel_clock	= 6250,
+
+			.hsw		= 15,
+			.hfp		= 15,
+			.hbp		= 60,
+
+			.vsw		= 1,
+			.vfp		= 1,
+			.vbp		= 1,
+		},
+		.config			= OMAP_DSS_LCD_TFT,
+
+		.name			= "h4",
+	},
 };
 
 struct panel_drv_data {
-- 
1.7.4.1

