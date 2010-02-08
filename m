From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 10/17] OMAP: DSS2: move get_recommended_bpp()
Date: Mon,  8 Feb 2010 17:57:34 +0200
Message-ID: <1265644661-3694-11-git-send-email-tomi.valkeinen@nokia.com>
References: <1265644661-3694-1-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-2-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-3-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-4-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-5-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-6-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-7-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-8-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-9-git-send-email-tomi.valkeinen@nokia.com>
 <1265644661-3694-10-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:26948 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753648Ab0BHPzn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Feb 2010 10:55:43 -0500
In-Reply-To: <1265644661-3694-10-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>

Move get_recommended_bpp() from omap_dss_device to omap_dss_driver.

This is part of a larger patch-set, which moves the control from omapdss
driver to the display driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 arch/arm/plat-omap/include/plat/display.h |    7 ++---
 drivers/video/omap2/displays/panel-taal.c |    2 +
 drivers/video/omap2/dss/core.c            |    3 ++
 drivers/video/omap2/dss/display.c         |    8 +-----
 drivers/video/omap2/dss/venc.c            |    1 +
 drivers/video/omap2/omapfb/omapfb-main.c  |   31 ++++++++++++++++++++++++----
 drivers/video/omap2/omapfb/omapfb.h       |    6 +++++
 7 files changed, 43 insertions(+), 15 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index c66397f..950d781 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -434,8 +434,6 @@ struct omap_dss_device {
 
 		enum omap_panel_config config;
 
-		u8 recommended_bpp;
-
 		struct omap_dss_device *ctrl;
 	} panel;
 
@@ -473,8 +471,6 @@ struct omap_dss_device {
 	int (*suspend)(struct omap_dss_device *dssdev);
 	int (*resume)(struct omap_dss_device *dssdev);
 
-	int (*get_recommended_bpp)(struct omap_dss_device *dssdev);
-
 	int (*check_timings)(struct omap_dss_device *dssdev,
 			struct omap_video_timings *timings);
 	void (*set_timings)(struct omap_dss_device *dssdev,
@@ -533,6 +529,7 @@ struct omap_dss_driver {
 
 	void (*get_resolution)(struct omap_dss_device *dssdev,
 			u16 *xres, u16 *yres);
+	int (*get_recommended_bpp)(struct omap_dss_device *dssdev);
 };
 
 int omap_dss_register_driver(struct omap_dss_driver *);
@@ -559,6 +556,8 @@ struct omap_overlay *omap_dss_get_overlay(int num);
 
 void omapdss_default_get_resolution(struct omap_dss_device *dssdev,
 		u16 *xres, u16 *yres);
+int omapdss_default_get_recommended_bpp(struct omap_dss_device *dssdev);
+
 typedef void (*omap_dispc_isr_t) (void *arg, u32 mask);
 int omap_dispc_register_isr(omap_dispc_isr_t isr, void *arg, u32 mask);
 int omap_dispc_unregister_isr(omap_dispc_isr_t isr, void *arg, u32 mask);
diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index 11d69b6..e00502e 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -990,6 +990,8 @@ static struct omap_dss_driver taal_driver = {
 
 	.setup_update	= taal_setup_update,
 	.get_resolution	= taal_get_resolution,
+	.get_recommended_bpp = omapdss_default_get_recommended_bpp,
+
 	.enable_te	= taal_enable_te,
 	.wait_for_te	= taal_wait_te,
 	.set_rotate	= taal_rotate,
diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index 67ea00d..991dd29 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -814,6 +814,9 @@ int omap_dss_register_driver(struct omap_dss_driver *dssdriver)
 
 	if (dssdriver->get_resolution == NULL)
 		dssdriver->get_resolution = omapdss_default_get_resolution;
+	if (dssdriver->get_recommended_bpp == NULL)
+		dssdriver->get_recommended_bpp =
+			omapdss_default_get_recommended_bpp;
 
 	return driver_register(&dssdriver->driver);
 }
diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index 6c34233..c5fecee 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -324,11 +324,8 @@ void default_get_overlay_fifo_thresholds(enum omap_plane plane,
 	*fifo_low = fifo_size - burst_size_bytes;
 }
 
-static int default_get_recommended_bpp(struct omap_dss_device *dssdev)
+int omapdss_default_get_recommended_bpp(struct omap_dss_device *dssdev)
 {
-	if (dssdev->panel.recommended_bpp)
-		return dssdev->panel.recommended_bpp;
-
 	switch (dssdev->type) {
 	case OMAP_DISPLAY_TYPE_DPI:
 		if (dssdev->phy.dpi.data_lines == 24)
@@ -350,6 +347,7 @@ static int default_get_recommended_bpp(struct omap_dss_device *dssdev)
 		BUG();
 	}
 }
+EXPORT_SYMBOL(omapdss_default_get_recommended_bpp);
 
 /* Checks if replication logic should be used. Only use for active matrix,
  * when overlay is in RGB12U or RGB16 mode, and LCD interface is
@@ -413,8 +411,6 @@ void dss_init_device(struct platform_device *pdev,
 		return;
 	}
 
-	dssdev->get_recommended_bpp = default_get_recommended_bpp;
-
 	switch (dssdev->type) {
 	case OMAP_DISPLAY_TYPE_DPI:
 		r = dpi_init_display(dssdev);
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 65514f0..d13071d 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -460,6 +460,7 @@ static struct omap_dss_driver venc_driver = {
 	.resume		= venc_panel_resume,
 
 	.get_resolution	= omapdss_default_get_resolution,
+	.get_recommended_bpp = omapdss_default_get_recommended_bpp,
 
 	.driver         = {
 		.name   = "venc",
diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 75d517e..f77256f 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -54,6 +54,8 @@ module_param_named(test, omapfb_test_pattern, bool, 0644);
 #endif
 
 static int omapfb_fb_init(struct omapfb2_device *fbdev, struct fb_info *fbi);
+static int omapfb_get_recommended_bpp(struct omapfb2_device *fbdev,
+		struct omap_dss_device *dssdev);
 
 #ifdef DEBUG
 static void draw_pixel(struct fb_info *fbi, int x, int y, unsigned color)
@@ -1404,6 +1406,7 @@ static int omapfb_alloc_fbmem_display(struct fb_info *fbi, unsigned long size,
 		unsigned long paddr)
 {
 	struct omapfb_info *ofbi = FB2OFB(fbi);
+	struct omapfb2_device *fbdev = ofbi->fbdev;
 	struct omap_dss_device *display;
 	int bytespp;
 
@@ -1412,7 +1415,7 @@ static int omapfb_alloc_fbmem_display(struct fb_info *fbi, unsigned long size,
 	if (!display)
 		return 0;
 
-	switch (display->get_recommended_bpp(display)) {
+	switch (omapfb_get_recommended_bpp(fbdev, display)) {
 	case 16:
 		bytespp = 2;
 		break;
@@ -1760,7 +1763,7 @@ static int omapfb_fb_init(struct omapfb2_device *fbdev, struct fb_info *fbi)
 		var->yres_virtual = var->yres;
 
 		if (!var->bits_per_pixel) {
-			switch (display->get_recommended_bpp(display)) {
+			switch (omapfb_get_recommended_bpp(fbdev, display)) {
 			case 16:
 				var->bits_per_pixel = 16;
 				break;
@@ -2011,7 +2014,8 @@ static int omapfb_mode_to_timings(const char *mode_str,
 	}
 }
 
-static int omapfb_set_def_mode(struct omap_dss_device *display, char *mode_str)
+static int omapfb_set_def_mode(struct omapfb2_device *fbdev,
+		struct omap_dss_device *display, char *mode_str)
 {
 	int r;
 	u8 bpp;
@@ -2021,7 +2025,9 @@ static int omapfb_set_def_mode(struct omap_dss_device *display, char *mode_str)
 	if (r)
 		return r;
 
-	display->panel.recommended_bpp = bpp;
+	fbdev->bpp_overrides[fbdev->num_bpp_overrides].dssdev = display;
+	fbdev->bpp_overrides[fbdev->num_bpp_overrides].bpp = bpp;
+	++fbdev->num_bpp_overrides;
 
 	if (!display->check_timings || !display->set_timings)
 		return -EINVAL;
@@ -2035,6 +2041,21 @@ static int omapfb_set_def_mode(struct omap_dss_device *display, char *mode_str)
 	return 0;
 }
 
+static int omapfb_get_recommended_bpp(struct omapfb2_device *fbdev,
+		struct omap_dss_device *dssdev)
+{
+	int i;
+
+	BUG_ON(dssdev->driver->get_recommended_bpp == NULL);
+
+	for (i = 0; i < fbdev->num_bpp_overrides; ++i) {
+		if (dssdev == fbdev->bpp_overrides[i].dssdev)
+			return fbdev->bpp_overrides[i].bpp;
+	}
+
+	return dssdev->driver->get_recommended_bpp(dssdev);
+}
+
 static int omapfb_parse_def_modes(struct omapfb2_device *fbdev)
 {
 	char *str, *options, *this_opt;
@@ -2073,7 +2094,7 @@ static int omapfb_parse_def_modes(struct omapfb2_device *fbdev)
 			break;
 		}
 
-		r = omapfb_set_def_mode(display, mode_str);
+		r = omapfb_set_def_mode(fbdev, display, mode_str);
 		if (r)
 			break;
 	}
diff --git a/drivers/video/omap2/omapfb/omapfb.h b/drivers/video/omap2/omapfb/omapfb.h
index 4ae0b64..cd54fdb 100644
--- a/drivers/video/omap2/omapfb/omapfb.h
+++ b/drivers/video/omap2/omapfb/omapfb.h
@@ -83,6 +83,12 @@ struct omapfb2_device {
 	struct omap_overlay *overlays[10];
 	unsigned num_managers;
 	struct omap_overlay_manager *managers[10];
+
+	unsigned num_bpp_overrides;
+	struct {
+		struct omap_dss_device *dssdev;
+		u8 bpp;
+	} bpp_overrides[10];
 };
 
 struct omapfb_colormode {
-- 
1.6.5

