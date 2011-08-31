From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 12/12] OMAPFB: find best mode from edid
Date: Wed, 31 Aug 2011 16:23:23 +0300
Message-ID: <1314797003-17638-13-git-send-email-tomi.valkeinen@ti.com>
References: <1314797003-17638-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:56113 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755826Ab1HaNX7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Aug 2011 09:23:59 -0400
In-Reply-To: <1314797003-17638-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: archit@ti.com, mythripk@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Use the new read_edid() function to get EDID information from the
display (when available), and use the information to use a suitable mode
at initialization time.

Hot-plug is not yet supported, so the timings selected at init time will
stay even if the monitor would be changed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/omapfb/omapfb-main.c |  109 +++++++++++++++++++++++++++---
 1 files changed, 99 insertions(+), 10 deletions(-)

diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index cd2cae8e..c84cc29 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2276,6 +2276,87 @@ static int omapfb_parse_def_modes(struct omapfb2_device *fbdev)
 	return r;
 }
 
+static void fb_videomode_to_omap_timings(struct fb_videomode *m,
+		struct omap_video_timings *t)
+{
+	t->x_res = m->xres;
+	t->y_res = m->yres;
+	t->pixel_clock = PICOS2KHZ(m->pixclock);
+	t->hsw = m->hsync_len;
+	t->hfp = m->right_margin;
+	t->hbp = m->left_margin;
+	t->vsw = m->vsync_len;
+	t->vfp = m->lower_margin;
+	t->vbp = m->upper_margin;
+}
+
+static int omapfb_find_best_mode(struct omap_dss_device *display,
+		struct omap_video_timings *timings)
+{
+	struct fb_monspecs *specs;
+	u8 *edid;
+	int r, i, best_xres, best_idx, len;
+
+	if (!display->driver->read_edid)
+		return -ENODEV;
+
+	len = 0x80 * 2;
+	edid = kmalloc(len, GFP_KERNEL);
+
+	r = display->driver->read_edid(display, edid, len);
+	if (r < 0)
+		goto err1;
+
+	specs = kzalloc(sizeof(*specs), GFP_KERNEL);
+
+	fb_edid_to_monspecs(edid, specs);
+
+	if (edid[126] > 0)
+		fb_edid_add_monspecs(edid + 0x80, specs);
+
+	best_xres = 0;
+	best_idx = -1;
+
+	for (i = 0; i < specs->modedb_len; ++i) {
+		struct fb_videomode *m;
+		struct omap_video_timings t;
+
+		m = &specs->modedb[i];
+
+		if (m->pixclock == 0)
+			continue;
+
+		/* skip repeated pixel modes */
+		if (m->xres == 2880 || m->xres == 1440)
+			continue;
+
+		fb_videomode_to_omap_timings(m, &t);
+
+		r = display->driver->check_timings(display, &t);
+		if (r == 0 && best_xres < m->xres) {
+			best_xres = m->xres;
+			best_idx = i;
+		}
+	}
+
+	if (best_xres == 0) {
+		r = -ENOENT;
+		goto err2;
+	}
+
+	fb_videomode_to_omap_timings(&specs->modedb[best_idx], timings);
+
+	r = 0;
+
+err2:
+	fb_destroy_modedb(specs->modedb);
+	kfree(specs);
+err1:
+	kfree(edid);
+
+	return r;
+}
+
 static int omapfb_init_display(struct omapfb2_device *fbdev,
 		struct omap_dss_device *dssdev)
 {
@@ -2404,9 +2485,27 @@ static int omapfb_probe(struct platform_device *pdev)
 	for (i = 0; i < fbdev->num_managers; i++)
 		fbdev->managers[i] = omap_dss_get_overlay_manager(i);
 
+	/* gfx overlay should be the default one. find a display
+	 * connected to that, and use it as default display */
+	ovl = omap_dss_get_overlay(0);
+	if (ovl->manager && ovl->manager->device) {
+		def_display = ovl->manager->device;
+	} else {
+		dev_warn(&pdev->dev, "cannot find default display\n");
+		def_display = NULL;
+	}
+
 	if (def_mode && strlen(def_mode) > 0) {
 		if (omapfb_parse_def_modes(fbdev))
 			dev_warn(&pdev->dev, "cannot parse default modes\n");
+	} else if (def_display && def_display->driver->set_timings &&
+			def_display->driver->check_timings) {
+		struct omap_video_timings t;
+
+		r = omapfb_find_best_mode(def_display, &t);
+
+		if (r == 0)
+			def_display->driver->set_timings(def_display, &t);
 	}
 
 	r = omapfb_create_framebuffers(fbdev);
@@ -2423,16 +2522,6 @@ static int omapfb_probe(struct platform_device *pdev)
 
 	DBG("mgr->apply'ed\n");
 
-	/* gfx overlay should be the default one. find a display
-	 * connected to that, and use it as default display */
-	ovl = omap_dss_get_overlay(0);
-	if (ovl->manager && ovl->manager->device) {
-		def_display = ovl->manager->device;
-	} else {
-		dev_warn(&pdev->dev, "cannot find default display\n");
-		def_display = NULL;
-	}
-
 	if (def_display) {
 		r = omapfb_init_display(fbdev, def_display);
 		if (r) {
-- 
1.7.4.1

