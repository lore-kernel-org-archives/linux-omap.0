From: Bryan Wu <bryan.wu@canonical.com>
Subject: [PATCH 1/3] OMAP: DSS2: Add generic panel display driver
Date: Tue,  2 Nov 2010 16:39:50 -0400
Message-ID: <1288730392-11223-2-git-send-email-bryan.wu@canonical.com>
References: <1288730392-11223-1-git-send-email-bryan.wu@canonical.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:41959 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752794Ab0KBUkO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Nov 2010 16:40:14 -0400
Received: by gxk23 with SMTP id 23so4414478gxk.19
        for <linux-omap@vger.kernel.org>; Tue, 02 Nov 2010 13:40:13 -0700 (PDT)
In-Reply-To: <1288730392-11223-1-git-send-email-bryan.wu@canonical.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gadiyar@ti.com, notasas@gmail.com

Generic panel driver includes the driver and 4 similar panel configurations. It
will match the panel name which is passed from platform data and setup the
right configurations.

With generic panel driver, we can remove those 4 duplicated panel display
drivers. In the future, it is simple for us just add new panel configuration
date in panel-generic.c to support new display panel.

Signed-off-by: Bryan Wu <bryan.wu@canonical.com>
---
 drivers/video/omap2/displays/Kconfig         |    4 +-
 drivers/video/omap2/displays/panel-generic.c |  153 +++++++++++++++++++++++---
 2 files changed, 142 insertions(+), 15 deletions(-)

diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/omap2/displays/Kconfig
index 12327bb..1a455d7 100644
--- a/drivers/video/omap2/displays/Kconfig
+++ b/drivers/video/omap2/displays/Kconfig
@@ -5,7 +5,9 @@ config PANEL_GENERIC
         tristate "Generic Panel"
         help
 	  Generic panel driver.
-	  Used for DVI output for Beagle and OMAP3 SDP.
+	  Supports DVI output for Beagle and OMAP3 SDP.
+	  Supports LCD Panel used in TI SDP3430 and EVM boards,
+	  OMAP3517 EVM boards and CM-T35.
 
 config PANEL_SHARP_LS037V7DW01
         tristate "Sharp LS037V7DW01 LCD Panel"
diff --git a/drivers/video/omap2/displays/panel-generic.c b/drivers/video/omap2/displays/panel-generic.c
index 395a68d..88e5bdf 100644
--- a/drivers/video/omap2/displays/panel-generic.c
+++ b/drivers/video/omap2/displays/panel-generic.c
@@ -1,5 +1,8 @@
 /*
- * Generic panel support
+ * Generic Panels support
+ *
+ * Copyright (C) 2010 Canonical Ltd.
+ * Author: Bryan Wu <bryan.wu@canonical.com>
  *
  * Copyright (C) 2008 Nokia Corporation
  * Author: Tomi Valkeinen <tomi.valkeinen@nokia.com>
@@ -22,22 +25,113 @@
 
 #include <plat/display.h>
 
-static struct omap_video_timings generic_panel_timings = {
-	/* 640 x 480 @ 60 Hz  Reduced blanking VESA CVT 0.31M3-R */
-	.x_res		= 640,
-	.y_res		= 480,
-	.pixel_clock	= 23500,
-	.hfp		= 48,
-	.hsw		= 32,
-	.hbp		= 80,
-	.vfp		= 3,
-	.vsw		= 4,
-	.vbp		= 7,
+/* Panel configurations */
+static struct omap_display_panel generic_panels[] = {
+	/* Generic Panel for DVI */
+	{
+		{
+			.x_res		= 640,
+			.y_res		= 480,
+
+			.pixel_clock	= 23500,
+
+			.hfp		= 48,
+			.hsw		= 32,
+			.hbp		= 80,
+
+			.vfp		= 3,
+			.vsw		= 4,
+			.vbp		= 7,
+		},
+		.acbi			= 0x0,
+		.acb			= 0x0,
+		.config			= OMAP_DSS_LCD_TFT,
+		.power_on_delay		= 0,
+		.power_off_delay	= 0,
+		.name			= "dvi",
+	},
+
+	/* Sharp LQ043T1DG01 */
+	{
+		{
+			.x_res		= 480,
+			.y_res		= 272,
+
+			.pixel_clock	= 9000,
+
+			.hsw		= 42,
+			.hfp		= 3,
+			.hbp		= 2,
+
+			.vsw		= 11,
+			.vfp		= 3,
+			.vbp		= 2,
+		},
+		.acbi			= 0x0,
+		.acb			= 0x0,
+		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
+					OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IEO,
+		.power_on_delay		= 50,
+		.power_off_delay	= 100,
+		.name			= "sharp_lq",
+	},
+
+	/* Sharp LS037V7DW01 */
+	{
+		{
+			.x_res		= 480,
+			.y_res		= 640,
+
+			.pixel_clock	= 19200,
+
+			.hsw		= 2,
+			.hfp		= 1,
+			.hbp		= 28,
+
+			.vsw		= 1,
+			.vfp		= 1,
+			.vbp		= 1,
+		},
+		.acbi			= 0x0,
+		.acb			= 0x28,
+		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
+						OMAP_DSS_LCD_IHS,
+		.power_on_delay		= 50,
+		.power_off_delay	= 100,
+		.name			= "sharp_ls",
+	},
+
+	/* Toppoly TDO35S */
+	{
+		{
+			.x_res		= 480,
+			.y_res		= 640,
+
+			.pixel_clock	= 26000,
+
+			.hfp		= 104,
+			.hsw		= 8,
+			.hbp		= 8,
+
+			.vfp		= 4,
+			.vsw		= 2,
+			.vbp		= 2,
+		},
+		.acbi			= 0x0,
+		.acb			= 0x0,
+		.config			= OMAP_DSS_LCD_TFT | OMAP_DSS_LCD_IVS |
+					OMAP_DSS_LCD_IHS | OMAP_DSS_LCD_IPC |
+					OMAP_DSS_LCD_ONOFF,
+		.power_on_delay		= 0,
+		.power_off_delay	= 0,
+		.name			= "toppoly_tdo35s",
+	},
 };
 
 static int generic_panel_power_on(struct omap_dss_device *dssdev)
 {
 	int r;
+	struct omap_display_panel *p = &dssdev->panel;
 
 	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
 		return 0;
@@ -46,6 +140,10 @@ static int generic_panel_power_on(struct omap_dss_device *dssdev)
 	if (r)
 		goto err0;
 
+	/* wait couple of vsyncs until enabling the LCD */
+	if (p->power_on_delay)
+		msleep(p->power_on_delay);
+
 	if (dssdev->platform_enable) {
 		r = dssdev->platform_enable(dssdev);
 		if (r)
@@ -61,19 +159,44 @@ err0:
 
 static void generic_panel_power_off(struct omap_dss_device *dssdev)
 {
+	struct omap_display_panel *p = &dssdev->panel;
+
 	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
 		return;
 
 	if (dssdev->platform_disable)
 		dssdev->platform_disable(dssdev);
 
+	/* wait couple of vsyncs after disabling the LCD */
+	if (p->power_off_delay)
+		msleep(p->power_off_delay);
+
 	omapdss_dpi_display_disable(dssdev);
 }
 
 static int generic_panel_probe(struct omap_dss_device *dssdev)
 {
-	dssdev->panel.config = OMAP_DSS_LCD_TFT;
-	dssdev->panel.timings = generic_panel_timings;
+	struct omap_display_panel *dp = &dssdev->panel;
+	struct omap_display_panel *pp = NULL;
+	int i;
+	int matched = 0;
+
+	if (dp->name == NULL)
+		return -ENODEV;
+
+	/* Match for the configuration of the panel */
+	for (i = 0; i < ARRAY_SIZE(generic_panels); i++) {
+		pp = &generic_panels[i];
+		if (strcmp(pp->name, dp->name) == 0) {
+			matched = 1;
+			break;
+		}
+	}
+
+	if (!matched)
+		return -ENODEV;
+
+	memcpy(dp, pp, sizeof(struct omap_display_panel));
 
 	return 0;
 }
@@ -105,7 +228,9 @@ static void generic_panel_disable(struct omap_dss_device *dssdev)
 static int generic_panel_suspend(struct omap_dss_device *dssdev)
 {
 	generic_panel_power_off(dssdev);
+
 	dssdev->state = OMAP_DSS_DISPLAY_SUSPENDED;
+
 	return 0;
 }
 
-- 
1.7.1

