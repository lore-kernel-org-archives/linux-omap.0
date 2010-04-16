From: Kan-Ru Chen <kanru@0xlab.org>
Subject: [RFC] [PATCH] Devkit8000: Use generic panel driver instead of new driver for every panel
Date: Fri, 16 Apr 2010 16:12:21 +0800
Message-ID: <1271405541-7048-1-git-send-email-kanru@0xlab.org>
References: <1271329417.2690.243.camel@tubuntu.research.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cp20.secserverpros.com ([67.220.217.187]:55615 "EHLO
	cp20.secserverpros.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757109Ab0DPIOM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Apr 2010 04:14:12 -0400
Received: from 61-30-10-70.static.tfn.net.tw ([61.30.10.70] helo=kanru.info)
	by cp20.secserverpros.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <kanru@kanru.info>)
	id 1O2ggZ-0002XE-Ue
	for linux-omap@vger.kernel.org; Fri, 16 Apr 2010 08:14:08 +0000
In-Reply-To: <1271329417.2690.243.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: Kan-Ru Chen <kanru@0xlab.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Vaibhav Hiremath <hvaibhav@ti.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Thomas Weber <weber@corscience.de>

Instead of use special driver for every new panel, we can use the
generic driver and modedb database to specify the timing
information. Now supports 4.3, 5.6 and 7 inch panel.

Signed-off-by: Kan-Ru Chen <kanru@0xlab.org>
---

 Hi!

 Some time ago there was a discussion about implementing a common
 driver for dummy LCDs. I tried the generic-panel and found it can
 cover most panels, by adding new entries to modedb.

 I've discussed with Thomas and he think this approach might be
 cleaner. I'd like to know others opinions.

 arch/arm/mach-omap2/board-devkit8000.c       |    3 ++-
 drivers/video/modedb.c                       |   12 ++++++++++++
 drivers/video/omap2/displays/panel-generic.c |    3 ++-
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 5bfc13b..4f52dfd 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -172,8 +172,9 @@ static struct regulator_consumer_supply devkit8000_vsim_supply = {
 
 static struct omap_dss_device devkit8000_lcd_device = {
 	.name                   = "lcd",
-	.driver_name            = "innolux_at_panel",
+	.driver_name            = "generic_panel",
 	.type                   = OMAP_DISPLAY_TYPE_DPI,
+	.panel.config           = OMAP_DSS_LCD_TFT|OMAP_DSS_LCD_IVS|OMAP_DSS_LCD_IHS,
 	.phy.dpi.data_lines     = 24,
 	.platform_enable        = devkit8000_panel_enable_lcd,
 	.platform_disable       = devkit8000_panel_disable_lcd,
diff --git a/drivers/video/modedb.c b/drivers/video/modedb.c
index b895aae..89bb3e5 100644
--- a/drivers/video/modedb.c
+++ b/drivers/video/modedb.c
@@ -273,6 +273,18 @@ static const struct fb_videomode modedb[] = {
        /* 800x520i @ 50 Hz, 15.625 kHz hsync (PAL RGB) */
        NULL, 50, 800, 520, 58823, 144, 64, 72, 28, 80, 5,
        0, FB_VMODE_INTERLACED
+    }, {
+       /* 480x272 @ 60 Hz, Devkit8000 4.3 inch LCD */
+       NULL, 60, 480, 272, 111000, 2, 2, 2, 2, 41, 10,
+       0, FB_VMODE_NONINTERLACED
+    }, {
+       /* 640x480 @ 60 Hz, Devkit8000 5.6 inch LCD */
+       NULL, 60, 640, 480, 39682, 16, 143, 32, 12, 1, 1,
+       0, FB_VMODE_NONINTERLACED
+    }, {
+       /* 800x480 @ 60 Hz, Devkit8000 7 inch LCD */
+       NULL, 60, 800, 480, 24855, 210, 45, 132, 22, 1, 1,
+       0, FB_VMODE_NONINTERLACED
     },
 };
 
diff --git a/drivers/video/omap2/displays/panel-generic.c b/drivers/video/omap2/displays/panel-generic.c
index 300eff5..b0a5599 100644
--- a/drivers/video/omap2/displays/panel-generic.c
+++ b/drivers/video/omap2/displays/panel-generic.c
@@ -66,7 +66,8 @@ static void generic_panel_power_off(struct omap_dss_device *dssdev)
 
 static int generic_panel_probe(struct omap_dss_device *dssdev)
 {
-	dssdev->panel.config = OMAP_DSS_LCD_TFT;
+	if (dssdev->panel.config == 0)
+		dssdev->panel.config = OMAP_DSS_LCD_TFT;
 	dssdev->panel.timings = generic_panel_timings;
 
 	return 0;
-- 
1.7.0.4

