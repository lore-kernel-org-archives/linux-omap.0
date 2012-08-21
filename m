From: Archit Taneja <archit@ti.com>
Subject: [PATCH 06/23] OMAP_VOUT: Remove manager->device references
Date: Tue, 21 Aug 2012 11:28:13 +0530
Message-ID: <1345528711-27801-7-git-send-email-archit@ti.com>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57146 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753252Ab2HUGAd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Aug 2012 02:00:33 -0400
In-Reply-To: <1345528711-27801-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, rob@ti.com, sumit.semwal@ti.com, Archit Taneja <archit@ti.com>

With the introduction of output entities, managers will now connect to outputs.
Use the helper op for managers named get_device. This will abstract away the
information on how to get the device from an overlay manager.

Using the helper function will reduce the number of pointer dereferences a user
of OMAPDSS needs to do and reduce risk of a NULL dereference.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/media/video/omap/omap_vout.c |   81 ++++++++++++++++++++++++----------
 1 file changed, 57 insertions(+), 24 deletions(-)

diff --git a/drivers/media/video/omap/omap_vout.c b/drivers/media/video/omap/omap_vout.c
index 88cf9d9..0ebf87e 100644
--- a/drivers/media/video/omap/omap_vout.c
+++ b/drivers/media/video/omap/omap_vout.c
@@ -454,11 +454,16 @@ static int omapvid_init(struct omap_vout_device *vout, u32 addr)
 
 	win = &vout->win;
 	for (i = 0; i < ovid->num_overlays; i++) {
+		struct omap_dss_device *dssdev;
+
 		ovl = ovid->overlays[i];
-		if (!ovl->manager || !ovl->manager->device)
+		dssdev = ovl->manager ?
+			ovl->manager->get_device(ovl->manager) : NULL;
+
+		if (!dssdev)
 			return -EINVAL;
 
-		timing = &ovl->manager->device->panel.timings;
+		timing = &dssdev->panel.timings;
 
 		outw = win->w.width;
 		outh = win->w.height;
@@ -515,8 +520,12 @@ static int omapvid_apply_changes(struct omap_vout_device *vout)
 	struct omapvideo_info *ovid = &vout->vid_info;
 
 	for (i = 0; i < ovid->num_overlays; i++) {
+		struct omap_dss_device *dssdev;
+
 		ovl = ovid->overlays[i];
-		if (!ovl->manager || !ovl->manager->device)
+		dssdev = ovl->manager ?
+			ovl->manager->get_device(ovl->manager) : NULL;
+		if (!dssdev)
 			return -EINVAL;
 		ovl->manager->apply(ovl->manager);
 	}
@@ -579,12 +588,15 @@ static void omap_vout_isr(void *arg, unsigned int irqstatus)
 
 	ovid = &vout->vid_info;
 	ovl = ovid->overlays[0];
-	/* get the display device attached to the overlay */
-	if (!ovl->manager || !ovl->manager->device)
-		return;
 
 	mgr_id = ovl->manager->id;
-	cur_display = ovl->manager->device;
+
+	/* get the display device attached to the overlay */
+	cur_display = ovl->manager ?
+		ovl->manager->get_device(ovl->manager) : NULL;
+
+	if (!cur_display)
+		return;
 
 	spin_lock(&vout->vbq_lock);
 	do_gettimeofday(&timevalue);
@@ -948,7 +960,10 @@ static int omap_vout_release(struct file *file)
 	/* Disable all the overlay managers connected with this interface */
 	for (i = 0; i < ovid->num_overlays; i++) {
 		struct omap_overlay *ovl = ovid->overlays[i];
-		if (ovl->manager && ovl->manager->device)
+		struct omap_dss_device *dssdev = ovl->manager ?
+			ovl->manager->get_device(ovl->manager) : NULL;
+
+		if (dssdev)
 			ovl->disable(ovl);
 	}
 	/* Turn off the pipeline */
@@ -1081,14 +1096,17 @@ static int vidioc_try_fmt_vid_out(struct file *file, void *fh,
 	struct omapvideo_info *ovid;
 	struct omap_video_timings *timing;
 	struct omap_vout_device *vout = fh;
+	struct omap_dss_device *dssdev;
 
 	ovid = &vout->vid_info;
 	ovl = ovid->overlays[0];
+	/* get the display device attached to the overlay */
+	dssdev = ovl->manager ? ovl->manager->get_device(ovl->manager) : NULL;
 
-	if (!ovl->manager || !ovl->manager->device)
+	if (!dssdev)
 		return -EINVAL;
-	/* get the display device attached to the overlay */
-	timing = &ovl->manager->device->panel.timings;
+
+	timing = &dssdev->panel.timings;
 
 	vout->fbuf.fmt.height = timing->y_res;
 	vout->fbuf.fmt.width = timing->x_res;
@@ -1105,6 +1123,7 @@ static int vidioc_s_fmt_vid_out(struct file *file, void *fh,
 	struct omapvideo_info *ovid;
 	struct omap_video_timings *timing;
 	struct omap_vout_device *vout = fh;
+	struct omap_dss_device *dssdev;
 
 	if (vout->streaming)
 		return -EBUSY;
@@ -1113,13 +1132,14 @@ static int vidioc_s_fmt_vid_out(struct file *file, void *fh,
 
 	ovid = &vout->vid_info;
 	ovl = ovid->overlays[0];
+	dssdev = ovl->manager ? ovl->manager->get_device(ovl->manager) : NULL;
 
 	/* get the display device attached to the overlay */
-	if (!ovl->manager || !ovl->manager->device) {
+	if (!dssdev) {
 		ret = -EINVAL;
 		goto s_fmt_vid_out_exit;
 	}
-	timing = &ovl->manager->device->panel.timings;
+	timing = &dssdev->panel.timings;
 
 	/* We dont support RGB24-packed mode if vrfb rotation
 	 * is enabled*/
@@ -1298,6 +1318,7 @@ static int vidioc_s_crop(struct file *file, void *fh, struct v4l2_crop *crop)
 	struct omapvideo_info *ovid;
 	struct omap_overlay *ovl;
 	struct omap_video_timings *timing;
+	struct omap_dss_device *dssdev;
 
 	if (vout->streaming)
 		return -EBUSY;
@@ -1305,13 +1326,15 @@ static int vidioc_s_crop(struct file *file, void *fh, struct v4l2_crop *crop)
 	mutex_lock(&vout->lock);
 	ovid = &vout->vid_info;
 	ovl = ovid->overlays[0];
+	/* get the display device attached to the overlay */
+	dssdev = ovl->manager ? ovl->manager->get_device(ovl->manager) : NULL;
 
-	if (!ovl->manager || !ovl->manager->device) {
+	if (!dssdev) {
 		ret = -EINVAL;
 		goto s_crop_err;
 	}
-	/* get the display device attached to the overlay */
-	timing = &ovl->manager->device->panel.timings;
+
+	timing = &dssdev->panel.timings;
 
 	if (is_rotation_90_or_270(vout)) {
 		vout->fbuf.fmt.height = timing->x_res;
@@ -1666,8 +1689,9 @@ static int vidioc_streamon(struct file *file, void *fh, enum v4l2_buf_type i)
 
 	for (j = 0; j < ovid->num_overlays; j++) {
 		struct omap_overlay *ovl = ovid->overlays[j];
+		struct omap_overlay_manager *mgr = ovl->manager;
 
-		if (ovl->manager && ovl->manager->device) {
+		if (mgr && mgr->get_device(mgr)) {
 			struct omap_overlay_info info;
 			ovl->get_overlay_info(ovl, &info);
 			info.paddr = addr;
@@ -1690,8 +1714,10 @@ static int vidioc_streamon(struct file *file, void *fh, enum v4l2_buf_type i)
 
 	for (j = 0; j < ovid->num_overlays; j++) {
 		struct omap_overlay *ovl = ovid->overlays[j];
+		struct omap_dss_device *dssdev = ovl->manager ?
+			ovl->manager->get_device(ovl->manager) : NULL;
 
-		if (ovl->manager && ovl->manager->device) {
+		if (dssdev) {
 			ret = ovl->enable(ovl);
 			if (ret)
 				goto streamon_err1;
@@ -1726,8 +1752,10 @@ static int vidioc_streamoff(struct file *file, void *fh, enum v4l2_buf_type i)
 
 	for (j = 0; j < ovid->num_overlays; j++) {
 		struct omap_overlay *ovl = ovid->overlays[j];
+		struct omap_dss_device *dssdev = ovl->manager ?
+			ovl->manager->get_device(ovl->manager) : NULL;
 
-		if (ovl->manager && ovl->manager->device)
+		if (dssdev)
 			ovl->disable(ovl);
 	}
 
@@ -1890,8 +1918,9 @@ static int __init omap_vout_setup_video_data(struct omap_vout_device *vout)
 	struct video_device *vfd;
 	struct v4l2_pix_format *pix;
 	struct v4l2_control *control;
+	struct omap_overlay *ovl = vout->vid_info.overlays[0];
 	struct omap_dss_device *display =
-		vout->vid_info.overlays[0]->manager->device;
+		ovl->manager->get_device(ovl->manager);
 
 	/* set the default pix */
 	pix = &vout->pix;
@@ -2205,8 +2234,10 @@ static int __init omap_vout_probe(struct platform_device *pdev)
 	 */
 	for (i = 1; i < vid_dev->num_overlays; i++) {
 		ovl = omap_dss_get_overlay(i);
-		if (ovl->manager && ovl->manager->device) {
-			def_display = ovl->manager->device;
+		dssdev = ovl->manager ? ovl->manager->get_device(ovl->manager) :
+				NULL;
+		if (dssdev) {
+			def_display = dssdev;
 		} else {
 			dev_warn(&pdev->dev, "cannot find display\n");
 			def_display = NULL;
@@ -2253,8 +2284,10 @@ probe_err1:
 	for (i = 1; i < vid_dev->num_overlays; i++) {
 		def_display = NULL;
 		ovl = omap_dss_get_overlay(i);
-		if (ovl->manager && ovl->manager->device)
-			def_display = ovl->manager->device;
+		dssdev = ovl->manager ? ovl->manager->get_device(ovl->manager) :
+				NULL;
+		if (dssdev)
+			def_display = dssdev;
 
 		if (def_display && def_display->driver)
 			def_display->driver->disable(def_display);
-- 
1.7.9.5

