From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCHv2 3/4] OMAP: H4: Port the display driver to new DSS2
Date: Mon, 12 Sep 2011 14:21:33 +0300
Message-ID: <1315826494-27993-4-git-send-email-tomi.valkeinen@ti.com>
References: <1315826494-27993-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:58573 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755240Ab1ILLVu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 12 Sep 2011 07:21:50 -0400
Received: by mail-bw0-f53.google.com with SMTP id zt12so1943199bkb.40
        for <linux-omap@vger.kernel.org>; Mon, 12 Sep 2011 04:21:49 -0700 (PDT)
In-Reply-To: <1315826494-27993-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>, Imre Deak <imre.deak@nokia.com>

Port the old omapfb panel driver for H4 to DSS2.

Cc: Imre Deak <imre.deak@nokia.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap/Makefile                      |    1 -
 drivers/video/omap/lcd_h4.c                      |  117 ----------------------
 drivers/video/omap2/displays/panel-generic-dpi.c |   21 ++++
 3 files changed, 21 insertions(+), 118 deletions(-)
 delete mode 100644 drivers/video/omap/lcd_h4.c

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
index 0a4d340..6f0da49 100644
--- a/drivers/video/omap2/displays/panel-generic-dpi.c
+++ b/drivers/video/omap2/displays/panel-generic-dpi.c
@@ -278,6 +278,27 @@ static struct panel_config generic_dpi_panels[] = {
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

