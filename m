From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 09/17] OMAP: DSS2: move get_resolution()
Date: Mon,  8 Feb 2010 17:57:33 +0200
Message-ID: <1265644661-3694-10-git-send-email-tomi.valkeinen@nokia.com>
References: <1265644661-3694-1-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-2-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-3-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-4-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-5-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-6-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-7-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-8-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-9-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:26930 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753603Ab0BHPzf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Feb 2010 10:55:35 -0500
In-Reply-To: <1265644661-3694-9-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Move get_resolution() from omap_dss_device to omap_dss_driver.

This is part of a larger patch-set, which moves the control from omapdss
driver to the display driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 arch/arm/plat-omap/include/plat/display.h |    7 +++++--
 drivers/video/omap2/displays/panel-taal.c |    2 +-
 drivers/video/omap2/dss/core.c            |    4 ++++
 drivers/video/omap2/dss/display.c         |    4 ++--
 drivers/video/omap2/dss/dsi.c             |    4 ++--
 drivers/video/omap2/dss/overlay.c         |    2 +-
 drivers/video/omap2/dss/venc.c            |    2 ++
 drivers/video/omap2/omapfb/omapfb-ioctl.c |    2 +-
 drivers/video/omap2/omapfb/omapfb-main.c  |    9 +++++----
 9 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index df8277c..c66397f 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -473,8 +473,6 @@ struct omap_dss_device {
 	int (*suspend)(struct omap_dss_device *dssdev);
 	int (*resume)(struct omap_dss_device *dssdev);
 
-	void (*get_resolution)(struct omap_dss_device *dssdev,
-			u16 *xres, u16 *yres);
 	int (*get_recommended_bpp)(struct omap_dss_device *dssdev);
 
 	int (*check_timings)(struct omap_dss_device *dssdev,
@@ -532,6 +530,9 @@ struct omap_dss_driver {
 	int (*memory_read)(struct omap_dss_device *dssdev,
 			void *buf, size_t size,
 			u16 x, u16 y, u16 w, u16 h);
+
+	void (*get_resolution)(struct omap_dss_device *dssdev,
+			u16 *xres, u16 *yres);
 };
 
 int omap_dss_register_driver(struct omap_dss_driver *);
@@ -556,6 +557,8 @@ struct omap_overlay_manager *omap_dss_get_overlay_manager(int num);
 int omap_dss_get_num_overlays(void);
 struct omap_overlay *omap_dss_get_overlay(int num);
 
+void omapdss_default_get_resolution(struct omap_dss_device *dssdev,
+		u16 *xres, u16 *yres);
 typedef void (*omap_dispc_isr_t) (void *arg, u32 mask);
 int omap_dispc_register_isr(omap_dispc_isr_t isr, void *arg, u32 mask);
 int omap_dispc_unregister_isr(omap_dispc_isr_t isr, void *arg, u32 mask);
diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 8f90de0..11d69b6 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -517,7 +517,6 @@ static int taal_probe(struct omap_dss_device *dssdev)
 	dev_set_drvdata(&dssdev->dev, td);
 
 	dssdev->get_timings = taal_get_timings;
-	dssdev->get_resolution = taal_get_resolution;
 
 	/* if no platform set_backlight() defined, presume DSI backlight
 	 * control */
@@ -990,6 +989,7 @@ static struct omap_dss_driver taal_driver = {
 	.resume		= taal_resume,
 
 	.setup_update	= taal_setup_update,
+	.get_resolution	= taal_get_resolution,
 	.enable_te	= taal_enable_te,
 	.wait_for_te	= taal_wait_te,
 	.set_rotate	= taal_rotate,
diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 5939da9..67ea00d 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -811,6 +811,10 @@ int omap_dss_register_driver(struct omap_dss_driver *dssdriver)
 	dssdriver->driver.bus = &dss_bus_type;
 	dssdriver->driver.probe = dss_driver_probe;
 	dssdriver->driver.remove = dss_driver_remove;
+
+	if (dssdriver->get_resolution == NULL)
+		dssdriver->get_resolution = omapdss_default_get_resolution;
+
 	return driver_register(&dssdriver->driver);
 }
 EXPORT_SYMBOL(omap_dss_register_driver);
diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index 987a8ae..6c34233 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -303,12 +303,13 @@ static struct device_attribute *display_sysfs_attrs[] = {
 	NULL
 };
 
-static void default_get_resolution(struct omap_dss_device *dssdev,
+void omapdss_default_get_resolution(struct omap_dss_device *dssdev,
 			u16 *xres, u16 *yres)
 {
 	*xres = dssdev->panel.timings.x_res;
 	*yres = dssdev->panel.timings.y_res;
 }
+EXPORT_SYMBOL(omapdss_default_get_resolution);
 
 void default_get_overlay_fifo_thresholds(enum omap_plane plane,
 		u32 fifo_size, enum omap_burst_size *burst_size,
@@ -412,7 +413,6 @@ void dss_init_device(struct platform_device *pdev,
 		return;
 	}
 
-	dssdev->get_resolution = default_get_resolution;
 	dssdev->get_recommended_bpp = default_get_recommended_bpp;
 
 	switch (dssdev->type) {
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index e355517..eab45b8 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -2866,7 +2866,7 @@ static int dsi_set_update_mode(struct omap_dss_device *dssdev,
 
 			DSSDBG("starting auto update\n");
 
-			dssdev->get_resolution(dssdev, &w, &h);
+			dssdev->driver->get_resolution(dssdev, &w, &h);
 
 			dsi_set_update_region(dssdev, 0, 0, w, h);
 
@@ -3420,7 +3420,7 @@ static int dsi_display_update(struct omap_dss_device *dssdev,
 	if (dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
 		goto end;
 
-	dssdev->get_resolution(dssdev, &dw, &dh);
+	dssdev->driver->get_resolution(dssdev, &dw, &dh);
 
 	if  (x > dw || y > dh)
 		goto end;
diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index b7f9a73..0c5bea2 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -350,7 +350,7 @@ int dss_check_overlay(struct omap_overlay *ovl, struct omap_dss_device *dssdev)
 		return -EINVAL;
 	}
 
-	dssdev->get_resolution(dssdev, &dw, &dh);
+	dssdev->driver->get_resolution(dssdev, &dw, &dh);
 
 	DSSDBG("check_overlay %d: (%d,%d %dx%d -> %dx%d) disp (%dx%d)\n",
 			ovl->id,
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 4e6bd1d..65514f0 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -459,6 +459,8 @@ static struct omap_dss_driver venc_driver = {
 	.suspend	= venc_panel_suspend,
 	.resume		= venc_panel_resume,
 
+	.get_resolution	= omapdss_default_get_resolution,
+
 	.driver         = {
 		.name   = "venc",
 		.owner  = THIS_MODULE,
diff --git a/drivers/video/omap2/omapfb/omapfb-ioctl.c b/drivers/video/omap2/omapfb/omapfb-ioctl.c
index 4e1b0cc..e18a723 100644
--- a/drivers/video/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/omap2/omapfb/omapfb-ioctl.c
@@ -208,7 +208,7 @@ static int omapfb_update_window_nolock(struct fb_info *fbi,
 	if (w == 0 || h == 0)
 		return 0;
 
-	display->get_resolution(display, &dw, &dh);
+	display->driver->get_resolution(display, &dw, &dh);
 
 	if (x + w > dw || y + h > dh)
 		return -EINVAL;
diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index d17caef..75d517e 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -1254,7 +1254,7 @@ exit:
 
 	if (r == 0 && do_update && display->update) {
 		u16 w, h;
-		display->get_resolution(display, &w, &h);
+		display->driver->get_resolution(display, &w, &h);
 
 		r = display->update(display, 0, 0, w, h);
 	}
@@ -1427,7 +1427,7 @@ static int omapfb_alloc_fbmem_display(struct fb_info *fbi, unsigned long size,
 	if (!size) {
 		u16 w, h;
 
-		display->get_resolution(display, &w, &h);
+		display->driver->get_resolution(display, &w, &h);
 
 		if (ofbi->rotation_type == OMAP_DSS_ROT_VRFB) {
 			size = max(omap_vrfb_min_phys_size(w, h, bytespp),
@@ -1745,7 +1745,7 @@ static int omapfb_fb_init(struct omapfb2_device *fbdev, struct fb_info *fbi)
 		u16 w, h;
 		int rotation = (var->rotate + ofbi->rotation[0]) % 4;
 
-		display->get_resolution(display, &w, &h);
+		display->driver->get_resolution(display, &w, &h);
 
 		if (rotation == FB_ROTATE_CW ||
 				rotation == FB_ROTATE_CCW) {
@@ -2190,7 +2190,8 @@ static int omapfb_probe(struct platform_device *pdev)
 				def_display->set_update_mode(def_display,
 						OMAP_DSS_UPDATE_MANUAL);
 
-			def_display->get_resolution(def_display, &w, &h);
+			def_display->driver->get_resolution(def_display,
+					&w, &h);
 			def_display->update(def_display, 0, 0, w, h);
 #endif
 		} else {
-- 
1.6.5

