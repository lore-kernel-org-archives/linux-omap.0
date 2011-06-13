From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/3] OMAP: DSS2: OMAPFB: Add struct to store per-display data
Date: Mon, 13 Jun 2011 12:12:52 +0300
Message-ID: <1307956374-1107-2-git-send-email-tomi.valkeinen@ti.com>
References: <1307956374-1107-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:59399 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755222Ab1FMJNH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Jun 2011 05:13:07 -0400
In-Reply-To: <1307956374-1107-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Create a new struct omapfb_display_data to contain omapfb's private
per-display data. Move the bpp override there.

This struct will be used to hold auto/manual update state of a display
in the following patches.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |   29 +++++++++++++++--------------
 drivers/video/omap2/omapfb/omapfb.h      |   26 +++++++++++++++++++-------
 2 files changed, 34 insertions(+), 21 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 505bc12..44eb666 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -1858,10 +1858,11 @@ static void omapfb_free_resources(struct omapfb2_device *fbdev)
 	}
 
 	for (i = 0; i < fbdev->num_displays; i++) {
-		if (fbdev->displays[i]->state != OMAP_DSS_DISPLAY_DISABLED)
-			fbdev->displays[i]->driver->disable(fbdev->displays[i]);
+		struct omap_dss_device *dssdev = fbdev->displays[i].dssdev;
+		if (dssdev->state != OMAP_DSS_DISPLAY_DISABLED)
+			dssdev->driver->disable(dssdev);
 
-		omap_dss_put_device(fbdev->displays[i]);
+		omap_dss_put_device(dssdev);
 	}
 
 	dev_set_drvdata(fbdev->dev, NULL);
@@ -2084,14 +2085,14 @@ static int omapfb_set_def_mode(struct omapfb2_device *fbdev,
 	int r;
 	u8 bpp;
 	struct omap_video_timings timings, temp_timings;
+	struct omapfb_display_data *d;
 
 	r = omapfb_mode_to_timings(mode_str, &timings, &bpp);
 	if (r)
 		return r;
 
-	fbdev->bpp_overrides[fbdev->num_bpp_overrides].dssdev = display;
-	fbdev->bpp_overrides[fbdev->num_bpp_overrides].bpp = bpp;
-	++fbdev->num_bpp_overrides;
+	d = get_display_data(fbdev, display);
+	d->bpp_override = bpp;
 
 	if (display->driver->check_timings) {
 		r = display->driver->check_timings(display, &timings);
@@ -2117,14 +2118,14 @@ static int omapfb_set_def_mode(struct omapfb2_device *fbdev,
 static int omapfb_get_recommended_bpp(struct omapfb2_device *fbdev,
 		struct omap_dss_device *dssdev)
 {
-	int i;
+	struct omapfb_display_data *d;
 
 	BUG_ON(dssdev->driver->get_recommended_bpp == NULL);
 
-	for (i = 0; i < fbdev->num_bpp_overrides; ++i) {
-		if (dssdev == fbdev->bpp_overrides[i].dssdev)
-			return fbdev->bpp_overrides[i].bpp;
-	}
+	d = get_display_data(fbdev, dssdev);
+
+	if (d->bpp_override != 0)
+		return d->bpp_override;
 
 	return dssdev->driver->get_recommended_bpp(dssdev);
 }
@@ -2156,9 +2157,9 @@ static int omapfb_parse_def_modes(struct omapfb2_device *fbdev)
 
 		display = NULL;
 		for (i = 0; i < fbdev->num_displays; ++i) {
-			if (strcmp(fbdev->displays[i]->name,
+			if (strcmp(fbdev->displays[i].dssdev->name,
 						display_str) == 0) {
-				display = fbdev->displays[i];
+				display = fbdev->displays[i].dssdev;
 				break;
 			}
 		}
@@ -2282,7 +2283,7 @@ static int omapfb_probe(struct platform_device *pdev)
 			r = -ENODEV;
 		}
 
-		fbdev->displays[fbdev->num_displays++] = dssdev;
+		fbdev->displays[fbdev->num_displays++].dssdev = dssdev;
 	}
 
 	if (r)
diff --git a/drivers/video/omap2/omapfb/omapfb.h b/drivers/video/omap2/omapfb/omapfb.h
index aa1b1d9..f07dbbb 100644
--- a/drivers/video/omap2/omapfb/omapfb.h
+++ b/drivers/video/omap2/omapfb/omapfb.h
@@ -73,6 +73,11 @@ struct omapfb_info {
 	bool mirror;
 };
 
+struct omapfb_display_data {
+	struct omap_dss_device *dssdev;
+	u8 bpp_override;
+};
+
 struct omapfb2_device {
 	struct device *dev;
 	struct mutex  mtx;
@@ -86,17 +91,11 @@ struct omapfb2_device {
 	struct omapfb2_mem_region regions[10];
 
 	unsigned num_displays;
-	struct omap_dss_device *displays[10];
+	struct omapfb_display_data displays[10];
 	unsigned num_overlays;
 	struct omap_overlay *overlays[10];
 	unsigned num_managers;
 	struct omap_overlay_manager *managers[10];
-
-	unsigned num_bpp_overrides;
-	struct {
-		struct omap_dss_device *dssdev;
-		u8 bpp;
-	} bpp_overrides[10];
 };
 
 struct omapfb_colormode {
@@ -143,6 +142,19 @@ static inline struct omap_dss_device *fb2display(struct fb_info *fbi)
 	return NULL;
 }
 
+static inline struct omapfb_display_data *get_display_data(
+		struct omapfb2_device *fbdev, struct omap_dss_device *dssdev)
+{
+	int i;
+
+	for (i = 0; i < fbdev->num_displays; ++i)
+		if (fbdev->displays[i].dssdev == dssdev)
+			return &fbdev->displays[i];
+
+	/* This should never happen */
+	BUG();
+}
+
 static inline void omapfb_lock(struct omapfb2_device *fbdev)
 {
 	mutex_lock(&fbdev->mtx);
-- 
1.7.4.1

