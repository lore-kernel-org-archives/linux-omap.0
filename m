From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 4/4] OMAP: Apollon: Port the display driver to new DSS2
Date: Mon, 12 Sep 2011 14:21:34 +0300
Message-ID: <1315826494-27993-5-git-send-email-tomi.valkeinen@ti.com>
References: <1315826494-27993-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:60950 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755240Ab1ILLVw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Sep 2011 07:21:52 -0400
Received: by mail-bw0-f44.google.com with SMTP id q10so3195026bka.3
        for <linux-omap@vger.kernel.org>; Mon, 12 Sep 2011 04:21:51 -0700 (PDT)
In-Reply-To: <1315826494-27993-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>, Kyungmin Park <kyungmin.park@samsung.com>

Port the old omapfb panel driver for Apollon to DSS2.

Cc: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap/Makefile                      |    1 -
 drivers/video/omap/lcd_apollon.c                 |  136 ----------------------
 drivers/video/omap2/displays/panel-generic-dpi.c |   22 ++++
 3 files changed, 22 insertions(+), 137 deletions(-)
 delete mode 100644 drivers/video/omap/lcd_apollon.c

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
index 6f0da49..dddd235 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -299,6 +299,28 @@ static struct panel_config generic_dpi_panels[] = {
 
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

