From: Bryan Wu <bryan.wu@canonical.com>
Subject: [PATCH 2/3] OMAP: DSS2: remove generic panel driver duplicated panel drivers
Date: Tue,  2 Nov 2010 16:39:51 -0400
Message-ID: <1288730392-11223-3-git-send-email-bryan.wu@canonical.com>
References: <1288730392-11223-1-git-send-email-bryan.wu@canonical.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:39906 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704Ab0KBUkR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Nov 2010 16:40:17 -0400
Received: by vws13 with SMTP id 13so153529vws.19
        for <linux-omap@vger.kernel.org>; Tue, 02 Nov 2010 13:40:16 -0700 (PDT)
In-Reply-To: <1288730392-11223-1-git-send-email-bryan.wu@canonical.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gadiyar@ti.com, notasas@gmail.com

Still keep sharp_ls_panel driver, because it contains blacklight control driver.

Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
---
 drivers/video/omap2/displays/Kconfig               |   12 --
 drivers/video/omap2/displays/Makefile              |    2 -
 .../video/omap2/displays/panel-sharp-lq043t1dg01.c |  165 --------------------
 .../video/omap2/displays/panel-toppoly-tdo35s.c    |  164 -------------------
 4 files changed, 0 insertions(+), 343 deletions(-)
 delete mode 100644 drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c
 delete mode 100644 drivers/video/omap2/displays/panel-toppoly-tdo35s.c

diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/omap2/displays/Kconfig
index 1a455d7..ae1aabe 100644
--- a/drivers/video/omap2/displays/Kconfig
+++ b/drivers/video/omap2/displays/Kconfig
@@ -16,24 +16,12 @@ config PANEL_SHARP_LS037V7DW01
         help
           LCD Panel used in TI's SDP3430 and EVM boards
 
-config PANEL_SHARP_LQ043T1DG01
-        tristate "Sharp LQ043T1DG01 LCD Panel"
-        depends on OMAP2_DSS
-        help
-          LCD Panel used in TI's OMAP3517 EVM boards
-
 config PANEL_TAAL
         tristate "Taal DSI Panel"
         depends on OMAP2_DSS_DSI
         help
           Taal DSI command mode panel from TPO.
 
-config PANEL_TOPPOLY_TDO35S
-        tristate "Toppoly TDO35S LCD Panel support"
-        depends on OMAP2_DSS
-        help
-          LCD Panel used in CM-T35
-
 config PANEL_TPO_TD043MTEA1
         tristate "TPO TD043MTEA1 LCD Panel"
         depends on OMAP2_DSS && SPI
diff --git a/drivers/video/omap2/displays/Makefile b/drivers/video/omap2/displays/Makefile
index aa38609..004335c 100644
--- a/drivers/video/omap2/displays/Makefile
+++ b/drivers/video/omap2/displays/Makefile
@@ -1,8 +1,6 @@
 obj-$(CONFIG_PANEL_GENERIC) += panel-generic.o
 obj-$(CONFIG_PANEL_SHARP_LS037V7DW01) += panel-sharp-ls037v7dw01.o
-obj-$(CONFIG_PANEL_SHARP_LQ043T1DG01) += panel-sharp-lq043t1dg01.o
 
 obj-$(CONFIG_PANEL_TAAL) += panel-taal.o
-obj-$(CONFIG_PANEL_TOPPOLY_TDO35S) += panel-toppoly-tdo35s.o
 obj-$(CONFIG_PANEL_TPO_TD043MTEA1) += panel-tpo-td043mtea1.o
 obj-$(CONFIG_PANEL_ACX565AKM) += panel-acx565akm.o
diff --git a/drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c b/drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c
deleted file mode 100644
index 0c6896c..0000000
--- a/drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c
+++ /dev/null
@@ -1,165 +0,0 @@
-/*
- * LCD panel driver for Sharp LQ043T1DG01
- *
- * Copyright (C) 2009 Texas Instruments Inc
- * Author: Vaibhav Hiremath <hvaibhav@ti.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-
-#include <linux/module.h>
-#include <linux/delay.h>
-#include <linux/device.h>
-#include <linux/err.h>
-
-#include <plat/display.h>
-
-static struct omap_video_timings sharp_lq_timings = {
-	.x_res = 480,
-	.y_res = 272,
-
-	.pixel_clock	= 9000,
-
-	.hsw		= 42,
-	.hfp		= 3,
-	.hbp		= 2,
-
-	.vsw		= 11,
-	.vfp		= 3,
-	.vbp		= 2,
-};
-
-static int sharp_lq_panel_power_on(struct omap_dss_device *dssdev)
-{
-	int r;
-
-	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
-		return 0;
-
-	r = omapdss_dpi_display_enable(dssdev);
-	if (r)
-		goto err0;
-
-	/* wait couple of vsyncs until enabling the LCD */
-	msleep(50);
-
-	if (dssdev->platform_enable) {
-		r = dssdev->platform_enable(dssdev);
-		if (r)
-			goto err1;
-	}
-
-	return 0;
-err1:
-	omapdss_dpi_display_disable(dssdev);
-err0:
-	return r;
-}
-
-static void sharp_lq_panel_power_off(struct omap_dss_device *dssdev)
-{
-	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
-		return;
-
-	if (dssdev->platform_disable)
-		dssdev->platform_disable(dssdev);
-
-	/* wait at least 5 vsyncs after disabling the LCD */
-	msleep(100);
-
-	omapdss_dpi_display_disable(dssdev);
-}
-
-static int sharp_lq_panel_probe(struct omap_dss_device *dssdev)
-{
-
-	dssdev->panel.config = OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
-		OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IEO;
-	dssdev->panel.acb = 0x0;
-	dssdev->panel.timings = sharp_lq_timings;
-
-	return 0;
-}
-
-static void sharp_lq_panel_remove(struct omap_dss_device *dssdev)
-{
-}
-
-static int sharp_lq_panel_enable(struct omap_dss_device *dssdev)
-{
-	int r = 0;
-
-	r = sharp_lq_panel_power_on(dssdev);
-	if (r)
-		return r;
-
-	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
-
-	return 0;
-}
-
-static void sharp_lq_panel_disable(struct omap_dss_device *dssdev)
-{
-	sharp_lq_panel_power_off(dssdev);
-
-	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
-}
-
-static int sharp_lq_panel_suspend(struct omap_dss_device *dssdev)
-{
-	sharp_lq_panel_power_off(dssdev);
-	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
-	return 0;
-}
-
-static int sharp_lq_panel_resume(struct omap_dss_device *dssdev)
-{
-	int r = 0;
-
-	r = sharp_lq_panel_power_on(dssdev);
-	if (r)
-		return r;
-
-	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
-
-	return 0;
-}
-
-static struct omap_dss_driver sharp_lq_driver = {
-	.probe		= sharp_lq_panel_probe,
-	.remove		= sharp_lq_panel_remove,
-
-	.enable		= sharp_lq_panel_enable,
-	.disable	= sharp_lq_panel_disable,
-	.suspend	= sharp_lq_panel_suspend,
-	.resume		= sharp_lq_panel_resume,
-
-	.driver         = {
-		.name   = "sharp_lq_panel",
-		.owner  = THIS_MODULE,
-	},
-};
-
-static int __init sharp_lq_panel_drv_init(void)
-{
-	return omap_dss_register_driver(&sharp_lq_driver);
-}
-
-static void __exit sharp_lq_panel_drv_exit(void)
-{
-	omap_dss_unregister_driver(&sharp_lq_driver);
-}
-
-module_init(sharp_lq_panel_drv_init);
-module_exit(sharp_lq_panel_drv_exit);
-MODULE_LICENSE("GPL");
diff --git a/drivers/video/omap2/displays/panel-toppoly-tdo35s.c b/drivers/video/omap2/displays/panel-toppoly-tdo35s.c
deleted file mode 100644
index 526e906..0000000
--- a/drivers/video/omap2/displays/panel-toppoly-tdo35s.c
+++ /dev/null
@@ -1,164 +0,0 @@
-/*
- * LCD panel driver for Toppoly TDO35S
- *
- * Copyright (C) 2009 CompuLab, Ltd.
- * Author: Mike Rapoport <mike@compulab.co.il>
- *
- * Based on generic panel support
- * Copyright (C) 2008 Nokia Corporation
- * Author: Tomi Valkeinen <tomi.valkeinen@nokia.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program.  If not, see <http://www.gnu.org/licenses/>.
- */
-
-#include <linux/module.h>
-#include <linux/delay.h>
-
-#include <plat/display.h>
-
-static struct omap_video_timings toppoly_tdo_panel_timings = {
-	/* 640 x 480 @ 60 Hz  Reduced blanking VESA CVT 0.31M3-R */
-	.x_res		= 480,
-	.y_res		= 640,
-
-	.pixel_clock	= 26000,
-
-	.hfp		= 104,
-	.hsw		= 8,
-	.hbp		= 8,
-
-	.vfp		= 4,
-	.vsw		= 2,
-	.vbp		= 2,
-};
-
-static int toppoly_tdo_panel_power_on(struct omap_dss_device *dssdev)
-{
-	int r;
-
-	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
-		return 0;
-
-	r = omapdss_dpi_display_enable(dssdev);
-	if (r)
-		goto err0;
-
-	if (dssdev->platform_enable) {
-		r = dssdev->platform_enable(dssdev);
-		if (r)
-			goto err1;
-	}
-
-	return 0;
-err1:
-	omapdss_dpi_display_disable(dssdev);
-err0:
-	return r;
-}
-
-static void toppoly_tdo_panel_power_off(struct omap_dss_device *dssdev)
-{
-	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
-		return;
-
-	if (dssdev->platform_disable)
-		dssdev->platform_disable(dssdev);
-
-	omapdss_dpi_display_disable(dssdev);
-}
-
-static int toppoly_tdo_panel_probe(struct omap_dss_device *dssdev)
-{
-	dssdev->panel.config = OMAP_DSS_LCD_TFT |
-			       OMAP_DSS_LCD_IVS |
-			       OMAP_DSS_LCD_IHS |
-			       OMAP_DSS_LCD_IPC |
-			       OMAP_DSS_LCD_ONOFF;
-
-	dssdev->panel.timings = toppoly_tdo_panel_timings;
-
-	return 0;
-}
-
-static void toppoly_tdo_panel_remove(struct omap_dss_device *dssdev)
-{
-}
-
-static int toppoly_tdo_panel_enable(struct omap_dss_device *dssdev)
-{
-	int r = 0;
-
-	r = toppoly_tdo_panel_power_on(dssdev);
-	if (r)
-		return r;
-
-	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
-
-	return 0;
-}
-
-static void toppoly_tdo_panel_disable(struct omap_dss_device *dssdev)
-{
-	toppoly_tdo_panel_power_off(dssdev);
-
-	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
-}
-
-static int toppoly_tdo_panel_suspend(struct omap_dss_device *dssdev)
-{
-	toppoly_tdo_panel_power_off(dssdev);
-	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
-	return 0;
-}
-
-static int toppoly_tdo_panel_resume(struct omap_dss_device *dssdev)
-{
-	int r = 0;
-
-	r = toppoly_tdo_panel_power_on(dssdev);
-	if (r)
-		return r;
-
-	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
-
-	return 0;
-}
-
-static struct omap_dss_driver generic_driver = {
-	.probe		= toppoly_tdo_panel_probe,
-	.remove		= toppoly_tdo_panel_remove,
-
-	.enable		= toppoly_tdo_panel_enable,
-	.disable	= toppoly_tdo_panel_disable,
-	.suspend	= toppoly_tdo_panel_suspend,
-	.resume		= toppoly_tdo_panel_resume,
-
-	.driver         = {
-		.name   = "toppoly_tdo35s_panel",
-		.owner  = THIS_MODULE,
-	},
-};
-
-static int __init toppoly_tdo_panel_drv_init(void)
-{
-	return omap_dss_register_driver(&generic_driver);
-}
-
-static void __exit toppoly_tdo_panel_drv_exit(void)
-{
-	omap_dss_unregister_driver(&generic_driver);
-}
-
-module_init(toppoly_tdo_panel_drv_init);
-module_exit(toppoly_tdo_panel_drv_exit);
-MODULE_LICENSE("GPL");
-- 
1.7.1

