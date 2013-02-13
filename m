From: Archit Taneja <archit@ti.com>
Subject: [PATCH 03/11] OMAPDSS: ZOOM/NEC-nl8048hl11: remove platform backlight support
Date: Wed, 13 Feb 2013 19:37:06 +0530
Message-ID: <1360764434-18788-4-git-send-email-archit@ti.com>
References: <1360764434-18788-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59379 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933917Ab3BMOIE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Feb 2013 09:08:04 -0500
In-Reply-To: <1360764434-18788-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>, Tony Lindgren <tony@atomide.com>

omap_dss_device provides a callback function to set backlight. Panel backlight
on Zoom board is implemented by the function zoom_set_bl_intensity() in the
board file. This needs to be removed. The PWM backlight should be implemented
with the pwm_bl driver.

For now, function zoom_set_bl_intensity() is left as is, but omap_dss_device's
set_backlight func pointer and max_brightness_level are removed. NEC-nl8048hl11
panel driver contains support to call platform backlight functions. These are
not used any more in zoom and are now removed.

Signed-off-by: Archit Taneja <archit@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-zoom-display.c           |    2 -
 .../omap2/displays/panel-nec-nl8048hl11-01b.c      |   74 --------------------
 2 files changed, 76 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom-display.c b/arch/arm/mach-omap2/board-zoom-display.c
index 1c7c834..4717ed5 100644
--- a/arch/arm/mach-omap2/board-zoom-display.c
+++ b/arch/arm/mach-omap2/board-zoom-display.c
@@ -109,8 +109,6 @@ static struct omap_dss_device zoom_lcd_device = {
 	.phy.dpi.data_lines	= 24,
 	.platform_enable	= zoom_panel_enable_lcd,
 	.platform_disable	= zoom_panel_disable_lcd,
-	.max_backlight_level	= 100,
-	.set_backlight		= zoom_set_bl_intensity,
 };
 
 static struct omap_dss_device *zoom_dss_devices[] = {
diff --git a/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c b/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
index c4e9c2b..c197927 100644
--- a/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
+++ b/drivers/video/omap2/displays/panel-nec-nl8048hl11-01b.c
@@ -19,7 +19,6 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/spi/spi.h>
-#include <linux/backlight.h>
 #include <linux/fb.h>
 
 #include <video/omapdss.h>
@@ -33,7 +32,6 @@
 #define LCD_PIXEL_CLOCK		23800
 
 struct nec_8048_data {
-	struct backlight_device *bl;
 };
 
 static const struct {
@@ -84,43 +82,9 @@ static struct omap_video_timings nec_8048_panel_timings = {
 	.sync_pclk_edge	= OMAPDSS_DRIVE_SIG_RISING_EDGE,
 };
 
-static int nec_8048_bl_update_status(struct backlight_device *bl)
-{
-	struct omap_dss_device *dssdev = dev_get_drvdata(&bl->dev);
-	int level;
-
-	if (!dssdev->set_backlight)
-		return -EINVAL;
-
-	if (bl->props.fb_blank == FB_BLANK_UNBLANK &&
-			bl->props.power == FB_BLANK_UNBLANK)
-		level = bl->props.brightness;
-	else
-		level = 0;
-
-	return dssdev->set_backlight(dssdev, level);
-}
-
-static int nec_8048_bl_get_brightness(struct backlight_device *bl)
-{
-	if (bl->props.fb_blank == FB_BLANK_UNBLANK &&
-			bl->props.power == FB_BLANK_UNBLANK)
-		return bl->props.brightness;
-
-	return 0;
-}
-
-static const struct backlight_ops nec_8048_bl_ops = {
-	.get_brightness	= nec_8048_bl_get_brightness,
-	.update_status	= nec_8048_bl_update_status,
-};
-
 static int nec_8048_panel_probe(struct omap_dss_device *dssdev)
 {
-	struct backlight_device *bl;
 	struct nec_8048_data *necd;
-	struct backlight_properties props;
-	int r;
 
 	dssdev->panel.timings = nec_8048_panel_timings;
 
@@ -130,38 +94,12 @@ static int nec_8048_panel_probe(struct omap_dss_device *dssdev)
 
 	dev_set_drvdata(&dssdev->dev, necd);
 
-	memset(&props, 0, sizeof(struct backlight_properties));
-	props.max_brightness = 255;
-
-	bl = backlight_device_register("nec-8048", &dssdev->dev, dssdev,
-			&nec_8048_bl_ops, &props);
-	if (IS_ERR(bl)) {
-		r = PTR_ERR(bl);
-		kfree(necd);
-		return r;
-	}
-	necd->bl = bl;
-
-	bl->props.fb_blank = FB_BLANK_UNBLANK;
-	bl->props.power = FB_BLANK_UNBLANK;
-	bl->props.max_brightness = dssdev->max_backlight_level;
-	bl->props.brightness = dssdev->max_backlight_level;
-
-	r = nec_8048_bl_update_status(bl);
-	if (r < 0)
-		dev_err(&dssdev->dev, "failed to set lcd brightness\n");
-
 	return 0;
 }
 
 static void nec_8048_panel_remove(struct omap_dss_device *dssdev)
 {
 	struct nec_8048_data *necd = dev_get_drvdata(&dssdev->dev);
-	struct backlight_device *bl = necd->bl;
-
-	bl->props.power = FB_BLANK_POWERDOWN;
-	nec_8048_bl_update_status(bl);
-	backlight_device_unregister(bl);
 
 	kfree(necd);
 }
@@ -169,8 +107,6 @@ static void nec_8048_panel_remove(struct omap_dss_device *dssdev)
 static int nec_8048_panel_power_on(struct omap_dss_device *dssdev)
 {
 	int r;
-	struct nec_8048_data *necd = dev_get_drvdata(&dssdev->dev);
-	struct backlight_device *bl = necd->bl;
 
 	if (dssdev->state == OMAP_DSS_DISPLAY_ACTIVE)
 		return 0;
@@ -188,10 +124,6 @@ static int nec_8048_panel_power_on(struct omap_dss_device *dssdev)
 			goto err1;
 	}
 
-	r = nec_8048_bl_update_status(bl);
-	if (r < 0)
-		dev_err(&dssdev->dev, "failed to set lcd brightness\n");
-
 	return 0;
 err1:
 	omapdss_dpi_display_disable(dssdev);
@@ -201,15 +133,9 @@ err0:
 
 static void nec_8048_panel_power_off(struct omap_dss_device *dssdev)
 {
-	struct nec_8048_data *necd = dev_get_drvdata(&dssdev->dev);
-	struct backlight_device *bl = necd->bl;
-
 	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
 		return;
 
-	bl->props.brightness = 0;
-	nec_8048_bl_update_status(bl);
-
 	if (dssdev->platform_disable)
 		dssdev->platform_disable(dssdev);
 
-- 
1.7.9.5

