From: Archit Taneja <archit@ti.com>
Subject: [RFC PATCH 01/29] omapdss/omapfb/omap_vout: Introduce manager output struct
Date: Tue, 27 Dec 2011 18:06:44 +0530
Message-ID: <1324989432-3625-2-git-send-email-archit@ti.com>
References: <1324989432-3625-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45055 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753483Ab1L0MiJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Dec 2011 07:38:09 -0500
In-Reply-To: <1324989432-3625-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rohitkc@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Introduce struct omap_dss_mgr_output, this describes the output connected to the
manager. This has been introduced as the output of a manager may not be just a
a display device, it could be connected to writeback or both.

The output struct will act as a container for 2 omap_dss_device pointers, one
for the display attached, and one for the writeback panel if that manager is
using writeback pipeline. The mode of operation(only displaying on a panel,
writeback capture mode, writeback memory to memory mode) is configured within
DSS2 based on how the user sets these outputs.

The omap_dss_device pointer connected to a manager is accessed by a omap_overlay
or a omap_overlay_manager pointer by references like manager->device and
ovl->manager->device. Replace such accesses by creating a helper function
get_output() in the overlay_manager struct.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/media/video/omap/omap_vout.c     |   78 +++++++++++++++++++++---------
 drivers/video/omap2/dss/apply.c          |   73 +++++++++++++++++++--------
 drivers/video/omap2/dss/dispc.c          |   11 +++--
 drivers/video/omap2/dss/manager.c        |   29 +++++++++--
 drivers/video/omap2/dss/overlay.c        |   12 ++--
 drivers/video/omap2/omapfb/omapfb-main.c |    7 ++-
 drivers/video/omap2/omapfb/omapfb.h      |    5 +-
 include/video/omapdss.h                  |    8 +++-
 8 files changed, 158 insertions(+), 65 deletions(-)

diff --git a/drivers/media/video/omap/omap_vout.c b/drivers/media/video/omap/omap_vout.c
index 27c19fe..b9cdb1e 100644
--- a/drivers/media/video/omap/omap_vout.c
+++ b/drivers/media/video/omap/omap_vout.c
@@ -453,11 +453,16 @@ static int omapvid_init(struct omap_vout_device *vout, u32 addr)
 
 	win = &vout->win;
 	for (i = 0; i < ovid->num_overlays; i++) {
+		struct omap_dss_device *dssdev;
+
 		ovl = ovid->overlays[i];
-		if (!ovl->manager || !ovl->manager->device)
+		dssdev = ovl->manager ?
+			ovl->manager->get_output(ovl->manager) : NULL;
+
+		if (!dssdev)
 			return -EINVAL;
 
-		timing = &ovl->manager->device->panel.timings;
+		timing = &dssdev->panel.timings;
 
 		outw = win->w.width;
 		outh = win->w.height;
@@ -514,8 +519,12 @@ static int omapvid_apply_changes(struct omap_vout_device *vout)
 	struct omapvideo_info *ovid = &vout->vid_info;
 
 	for (i = 0; i < ovid->num_overlays; i++) {
+		struct omap_dss_device *dssdev;
+
 		ovl = ovid->overlays[i];
-		if (!ovl->manager || !ovl->manager->device)
+		dssdev = ovl->manager ?
+			ovl->manager->get_output(ovl->manager) : NULL;
+		if (!dssdev)
 			return -EINVAL;
 		ovl->manager->apply(ovl->manager);
 	}
@@ -539,10 +548,11 @@ static void omap_vout_isr(void *arg, unsigned int irqstatus)
 	ovid = &vout->vid_info;
 	ovl = ovid->overlays[0];
 	/* get the display device attached to the overlay */
-	if (!ovl->manager || !ovl->manager->device)
-		return;
+	cur_display = ovl->manager ?
+		ovl->manager->get_output(ovl->manager) : NULL;
 
-	cur_display = ovl->manager->device;
+	if (!cur_display)
+		return;
 
 	spin_lock(&vout->vbq_lock);
 	do_gettimeofday(&timevalue);
@@ -942,7 +952,10 @@ static int omap_vout_release(struct file *file)
 	/* Disable all the overlay managers connected with this interface */
 	for (i = 0; i < ovid->num_overlays; i++) {
 		struct omap_overlay *ovl = ovid->overlays[i];
-		if (ovl->manager && ovl->manager->device)
+		struct omap_dss_device *dssdev = ovl->manager ?
+			ovl->manager->get_output(ovl->manager) : NULL;
+
+		if (dssdev)
 			ovl->disable(ovl);
 	}
 	/* Turn off the pipeline */
@@ -1074,14 +1087,17 @@ static int vidioc_try_fmt_vid_out(struct file *file, void *fh,
 	struct omapvideo_info *ovid;
 	struct omap_video_timings *timing;
 	struct omap_vout_device *vout = fh;
+	struct omap_dss_device *dssdev;
 
 	ovid = &vout->vid_info;
 	ovl = ovid->overlays[0];
+	/* get the display device attached to the overlay */
+	dssdev = ovl->manager ? ovl->manager->get_output(ovl->manager) : NULL;
 
-	if (!ovl->manager || !ovl->manager->device)
+	if (!dssdev)
 		return -EINVAL;
-	/* get the display device attached to the overlay */
-	timing = &ovl->manager->device->panel.timings;
+
+	timing = &dssdev->panel.timings;
 
 	vout->fbuf.fmt.height = timing->y_res;
 	vout->fbuf.fmt.width = timing->x_res;
@@ -1098,6 +1114,7 @@ static int vidioc_s_fmt_vid_out(struct file *file, void *fh,
 	struct omapvideo_info *ovid;
 	struct omap_video_timings *timing;
 	struct omap_vout_device *vout = fh;
+	struct omap_dss_device *dssdev;
 
 	if (vout->streaming)
 		return -EBUSY;
@@ -1106,13 +1123,14 @@ static int vidioc_s_fmt_vid_out(struct file *file, void *fh,
 
 	ovid = &vout->vid_info;
 	ovl = ovid->overlays[0];
+	dssdev = ovl->manager ? ovl->manager->get_output(ovl->manager) : NULL;
 
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
@@ -1291,6 +1309,7 @@ static int vidioc_s_crop(struct file *file, void *fh, struct v4l2_crop *crop)
 	struct omapvideo_info *ovid;
 	struct omap_overlay *ovl;
 	struct omap_video_timings *timing;
+	struct omap_dss_device *dssdev;
 
 	if (vout->streaming)
 		return -EBUSY;
@@ -1298,13 +1317,15 @@ static int vidioc_s_crop(struct file *file, void *fh, struct v4l2_crop *crop)
 	mutex_lock(&vout->lock);
 	ovid = &vout->vid_info;
 	ovl = ovid->overlays[0];
+	/* get the display device attached to the overlay */
+	dssdev = ovl->manager ? ovl->manager->get_output(ovl->manager) : NULL;
 
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
@@ -1659,8 +1680,10 @@ static int vidioc_streamon(struct file *file, void *fh, enum v4l2_buf_type i)
 
 	for (j = 0; j < ovid->num_overlays; j++) {
 		struct omap_overlay *ovl = ovid->overlays[j];
+		struct omap_dss_device *dssdev = ovl->manager ?
+			ovl->manager->get_output(ovl->manager) : NULL;
 
-		if (ovl->manager && ovl->manager->device) {
+		if (dssdev) {
 			struct omap_overlay_info info;
 			ovl->get_overlay_info(ovl, &info);
 			info.paddr = addr;
@@ -1683,8 +1706,10 @@ static int vidioc_streamon(struct file *file, void *fh, enum v4l2_buf_type i)
 
 	for (j = 0; j < ovid->num_overlays; j++) {
 		struct omap_overlay *ovl = ovid->overlays[j];
+		struct omap_dss_device *dssdev = ovl->manager ?
+			ovl->manager->get_output(ovl->manager) : NULL;
 
-		if (ovl->manager && ovl->manager->device) {
+		if (dssdev) {
 			ret = ovl->enable(ovl);
 			if (ret)
 				goto streamon_err1;
@@ -1719,8 +1744,10 @@ static int vidioc_streamoff(struct file *file, void *fh, enum v4l2_buf_type i)
 
 	for (j = 0; j < ovid->num_overlays; j++) {
 		struct omap_overlay *ovl = ovid->overlays[j];
+		struct omap_dss_device *dssdev = ovl->manager ?
+			ovl->manager->get_output(ovl->manager) : NULL;
 
-		if (ovl->manager && ovl->manager->device)
+		if (dssdev)
 			ovl->disable(ovl);
 	}
 
@@ -1881,8 +1908,9 @@ static int __init omap_vout_setup_video_data(struct omap_vout_device *vout)
 	struct video_device *vfd;
 	struct v4l2_pix_format *pix;
 	struct v4l2_control *control;
+	struct omap_overlay *ovl = vout->vid_info.overlays[0];
 	struct omap_dss_device *display =
-		vout->vid_info.overlays[0]->manager->device;
+		ovl->manager->get_output(ovl->manager);
 
 	/* set the default pix */
 	pix = &vout->pix;
@@ -2188,8 +2216,10 @@ static int __init omap_vout_probe(struct platform_device *pdev)
 	 */
 	for (i = 1; i < vid_dev->num_overlays; i++) {
 		ovl = omap_dss_get_overlay(i);
-		if (ovl->manager && ovl->manager->device) {
-			def_display = ovl->manager->device;
+		dssdev = ovl->manager ? ovl->manager->get_output(ovl->manager) :
+				NULL;
+		if (dssdev) {
+			def_display = dssdev;
 		} else {
 			dev_warn(&pdev->dev, "cannot find display\n");
 			def_display = NULL;
@@ -2236,8 +2266,10 @@ probe_err1:
 	for (i = 1; i < vid_dev->num_overlays; i++) {
 		def_display = NULL;
 		ovl = omap_dss_get_overlay(i);
-		if (ovl->manager && ovl->manager->device)
-			def_display = ovl->manager->device;
+		dssdev = ovl->manager ? ovl->manager->get_output(ovl->manager) :
+				NULL;
+		if (dssdev)
+			def_display = dssdev;
 
 		if (def_display && def_display->driver)
 			def_display->driver->disable(def_display);
diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 052dc87..d529664 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -164,12 +164,16 @@ void dss_apply_init(void)
 
 static bool ovl_manual_update(struct omap_overlay *ovl)
 {
-	return ovl->manager->device->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE;
+	struct omap_dss_device *dssdev = ovl->manager->get_output(ovl->manager);
+
+	return dssdev->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE;
 }
 
 static bool mgr_manual_update(struct omap_overlay_manager *mgr)
 {
-	return mgr->device->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE;
+	struct omap_dss_device *dssdev = mgr->get_output(mgr);
+
+	return dssdev->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE;
 }
 
 static int dss_check_settings_low(struct omap_overlay_manager *mgr,
@@ -380,7 +384,7 @@ int dss_mgr_wait_for_go(struct omap_overlay_manager *mgr)
 	u32 irq;
 	int r;
 	int i;
-	struct omap_dss_device *dssdev = mgr->device;
+	struct omap_dss_device *dssdev = mgr->get_output(mgr);
 
 	if (!dssdev || dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
 		return 0;
@@ -443,7 +447,7 @@ int dss_mgr_wait_for_go_ovl(struct omap_overlay *ovl)
 	if (!ovl->manager)
 		return 0;
 
-	dssdev = ovl->manager->device;
+	dssdev = ovl->manager->get_output(ovl->manager);
 
 	if (!dssdev || dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
 		return 0;
@@ -500,18 +504,21 @@ static void dss_ovl_write_regs(struct omap_overlay *ovl)
 	struct omap_overlay_info *oi;
 	bool ilace, replication;
 	struct mgr_priv_data *mp;
+	struct omap_dss_device *dssdev;
 	int r;
 
 	DSSDBGF("%d", ovl->id);
 
+	dssdev = ovl->manager->get_output(ovl->manager);
+
 	if (!op->enabled || !op->info_dirty)
 		return;
 
 	oi = &op->info;
 
-	replication = dss_use_replication(ovl->manager->device, oi->color_mode);
+	replication = dss_use_replication(dssdev, oi->color_mode);
 
-	ilace = ovl->manager->device->type == OMAP_DISPLAY_TYPE_VENC;
+	ilace = dssdev->type == OMAP_DISPLAY_TYPE_VENC;
 
 	r = dispc_ovl_setup(ovl->id, oi, ilace, replication);
 	if (r) {
@@ -593,15 +600,17 @@ static void dss_write_regs(void)
 	for (i = 0; i < num_mgrs; ++i) {
 		struct omap_overlay_manager *mgr;
 		struct mgr_priv_data *mp;
+		struct omap_dss_device *dssdev;
 		int r;
 
 		mgr = omap_dss_get_overlay_manager(i);
 		mp = get_mgr_priv(mgr);
+		dssdev = mgr->get_output(mgr);
 
 		if (!mp->enabled || mgr_manual_update(mgr) || mp->busy)
 			continue;
 
-		r = dss_check_settings(mgr, mgr->device);
+		r = dss_check_settings(mgr, dssdev);
 		if (r) {
 			DSSERR("cannot write registers for manager %s: "
 					"illegal configuration\n", mgr->name);
@@ -643,6 +652,7 @@ static void dss_set_go_bits(void)
 void dss_mgr_start_update(struct omap_overlay_manager *mgr)
 {
 	struct mgr_priv_data *mp = get_mgr_priv(mgr);
+	struct omap_dss_device *dssdev;
 	unsigned long flags;
 	int r;
 
@@ -650,7 +660,9 @@ void dss_mgr_start_update(struct omap_overlay_manager *mgr)
 
 	WARN_ON(mp->updating);
 
-	r = dss_check_settings(mgr, mgr->device);
+	dssdev = mgr->get_output(mgr);
+
+	r = dss_check_settings(mgr, dssdev);
 	if (r) {
 		DSSERR("cannot start manual update: illegal configuration\n");
 		spin_unlock_irqrestore(&data_lock, flags);
@@ -805,13 +817,16 @@ int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 {
 	unsigned long flags;
 	struct omap_overlay *ovl;
+	struct omap_dss_device *dssdev;
 	int r;
 
 	DSSDBG("omap_dss_mgr_apply(%s)\n", mgr->name);
 
 	spin_lock_irqsave(&data_lock, flags);
 
-	r = dss_check_settings_apply(mgr, mgr->device);
+	dssdev = mgr->get_output(mgr);
+
+	r = dss_check_settings_apply(mgr, dssdev);
 	if (r) {
 		spin_unlock_irqrestore(&data_lock, flags);
 		DSSERR("failed to apply settings: illegal configuration.\n");
@@ -869,7 +884,7 @@ static void dss_ovl_setup_fifo(struct omap_overlay *ovl)
 	if (!op->enabled && !op->enabling)
 		return;
 
-	dssdev = ovl->manager->device;
+	dssdev = ovl->manager->get_output(ovl->manager);
 
 	size = dispc_ovl_get_fifo_size(ovl->id);
 
@@ -926,6 +941,7 @@ static void dss_setup_fifos(void)
 int dss_mgr_enable(struct omap_overlay_manager *mgr)
 {
 	struct mgr_priv_data *mp = get_mgr_priv(mgr);
+	struct omap_dss_device *dssdev;
 	unsigned long flags;
 	int r;
 
@@ -938,7 +954,9 @@ int dss_mgr_enable(struct omap_overlay_manager *mgr)
 
 	mp->enabled = true;
 
-	r = dss_check_settings(mgr, mgr->device);
+	dssdev = mgr->get_output(mgr);
+
+	r = dss_check_settings(mgr, dssdev);
 	if (r) {
 		DSSERR("failed to enable manager %d: check_settings failed\n",
 				mgr->id);
@@ -1036,21 +1054,21 @@ int dss_mgr_set_device(struct omap_overlay_manager *mgr,
 	mutex_lock(&apply_lock);
 
 	if (dssdev->manager) {
-		DSSERR("display '%s' already has a manager '%s'\n",
+		DSSERR("device '%s' already has a manager '%s'\n",
 			       dssdev->name, dssdev->manager->name);
 		r = -EINVAL;
 		goto err;
 	}
 
 	if ((mgr->supported_displays & dssdev->type) == 0) {
-		DSSERR("display '%s' does not support manager '%s'\n",
+		DSSERR("device '%s' does not support manager '%s'\n",
 			       dssdev->name, mgr->name);
 		r = -EINVAL;
 		goto err;
 	}
 
 	dssdev->manager = mgr;
-	mgr->device = dssdev;
+	mgr->output->device = dssdev;
 
 	mutex_unlock(&apply_lock);
 
@@ -1063,11 +1081,14 @@ err:
 int dss_mgr_unset_device(struct omap_overlay_manager *mgr)
 {
 	int r;
+	struct omap_dss_device *curr_dssdev;
 
 	mutex_lock(&apply_lock);
 
-	if (!mgr->device) {
-		DSSERR("failed to unset display, display not set.\n");
+	curr_dssdev = mgr->output->device;
+
+	if (!curr_dssdev) {
+		DSSERR("failed to unset device, device not set.\n");
 		r = -EINVAL;
 		goto err;
 	}
@@ -1076,13 +1097,13 @@ int dss_mgr_unset_device(struct omap_overlay_manager *mgr)
 	 * Don't allow currently enabled displays to have the overlay manager
 	 * pulled out from underneath them
 	 */
-	if (mgr->device->state != OMAP_DSS_DISPLAY_DISABLED) {
+	if (curr_dssdev->state != OMAP_DSS_DISPLAY_DISABLED) {
 		r = -EINVAL;
 		goto err;
 	}
 
-	mgr->device->manager = NULL;
-	mgr->device = NULL;
+	curr_dssdev->manager = NULL;
+	mgr->output->device = NULL;
 
 	mutex_unlock(&apply_lock);
 
@@ -1240,6 +1261,7 @@ bool dss_ovl_is_enabled(struct omap_overlay *ovl)
 int dss_ovl_enable(struct omap_overlay *ovl)
 {
 	struct ovl_priv_data *op = get_ovl_priv(ovl);
+	struct omap_dss_device *dssdev;
 	unsigned long flags;
 	int r;
 
@@ -1250,7 +1272,10 @@ int dss_ovl_enable(struct omap_overlay *ovl)
 		goto err1;
 	}
 
-	if (ovl->manager == NULL || ovl->manager->device == NULL) {
+	dssdev = ovl->manager ?
+		ovl->manager->get_output(ovl->manager) : NULL;
+
+	if (!dssdev) {
 		r = -EINVAL;
 		goto err1;
 	}
@@ -1259,7 +1284,7 @@ int dss_ovl_enable(struct omap_overlay *ovl)
 
 	op->enabling = true;
 
-	r = dss_check_settings(ovl->manager, ovl->manager->device);
+	r = dss_check_settings(ovl->manager, dssdev);
 	if (r) {
 		DSSERR("failed to enable overlay %d: check_settings failed\n",
 				ovl->id);
@@ -1290,6 +1315,7 @@ err1:
 int dss_ovl_disable(struct omap_overlay *ovl)
 {
 	struct ovl_priv_data *op = get_ovl_priv(ovl);
+	struct omap_dss_device *dssdev;
 	unsigned long flags;
 	int r;
 
@@ -1300,7 +1326,10 @@ int dss_ovl_disable(struct omap_overlay *ovl)
 		goto err;
 	}
 
-	if (ovl->manager == NULL || ovl->manager->device == NULL) {
+	dssdev = ovl->manager ?
+		ovl->manager->get_output(ovl->manager) : NULL;
+
+	if (!dssdev) {
 		r = -EINVAL;
 		goto err;
 	}
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index a5ec7f3..b228e05 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -419,7 +419,7 @@ static struct omap_dss_device *dispc_mgr_get_device(enum omap_channel channel)
 	struct omap_overlay_manager *mgr =
 		omap_dss_get_overlay_manager(channel);
 
-	return mgr ? mgr->device : NULL;
+	return mgr ? mgr->get_output(mgr) : NULL;
 }
 
 u32 dispc_mgr_get_vsync_irq(enum omap_channel channel)
@@ -3096,7 +3096,7 @@ static void dispc_error_worker(struct work_struct *work)
 		bit = sync_lost_bits[i];
 
 		if (bit & errors) {
-			struct omap_dss_device *dssdev = mgr->device;
+			struct omap_dss_device *dssdev = mgr->get_output(mgr);
 			bool enable;
 
 			DSSERR("SYNC_LOST on channel %s, restarting the output "
@@ -3127,9 +3127,12 @@ static void dispc_error_worker(struct work_struct *work)
 		DSSERR("OCP_ERR\n");
 		for (i = 0; i < omap_dss_get_num_overlay_managers(); ++i) {
 			struct omap_overlay_manager *mgr;
+			struct omap_dss_device *dssdev;
+
 			mgr = omap_dss_get_overlay_manager(i);
-			if (mgr->device && mgr->device->driver)
-				mgr->device->driver->disable(mgr->device);
+			dssdev = mgr->get_output(mgr);
+			if (dssdev && dssdev->driver)
+				dssdev->driver->disable(dssdev);
 		}
 	}
 
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index d1858e7..094c96c 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -43,8 +43,10 @@ static ssize_t manager_name_show(struct omap_overlay_manager *mgr, char *buf)
 
 static ssize_t manager_display_show(struct omap_overlay_manager *mgr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%s\n",
-			mgr->device ? mgr->device->name : "<none>");
+	struct omap_dss_device *dssdev = mgr->get_output(mgr);
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", dssdev ?
+			dssdev->name : "<none>");
 }
 
 static ssize_t manager_display_store(struct omap_overlay_manager *mgr,
@@ -72,7 +74,7 @@ static ssize_t manager_display_store(struct omap_overlay_manager *mgr,
 	if (dssdev)
 		DSSDBG("display %s found\n", dssdev->name);
 
-	if (mgr->device) {
+	if (mgr->get_output(mgr)) {
 		r = mgr->unset_device(mgr);
 		if (r) {
 			DSSERR("failed to unset display\n");
@@ -490,14 +492,23 @@ static struct kobj_type manager_ktype = {
 	.default_attrs = manager_sysfs_attrs,
 };
 
+static inline struct omap_dss_device *dss_mgr_get_output(struct omap_overlay_manager *mgr)
+{
+	return mgr->output->device;
+}
+
 static int dss_mgr_wait_for_vsync(struct omap_overlay_manager *mgr)
 {
 	unsigned long timeout = msecs_to_jiffies(500);
+	struct omap_dss_device *dssdev = mgr->get_output(mgr);
 	u32 irq;
 
-	if (mgr->device->type == OMAP_DISPLAY_TYPE_VENC) {
+	if (!dssdev)
+		return 0;
+
+	if (dssdev->type == OMAP_DISPLAY_TYPE_VENC) {
 		irq = DISPC_IRQ_EVSYNC_ODD;
-	} else if (mgr->device->type == OMAP_DISPLAY_TYPE_HDMI) {
+	} else if (dssdev->type == OMAP_DISPLAY_TYPE_HDMI) {
 		irq = DISPC_IRQ_EVSYNC_EVEN;
 	} else {
 		if (mgr->id == OMAP_DSS_CHANNEL_LCD)
@@ -522,6 +533,11 @@ int dss_init_overlay_managers(struct platform_device *pdev)
 	for (i = 0; i < num_managers; ++i) {
 		struct omap_overlay_manager *mgr = &managers[i];
 
+		mgr->output = kzalloc(sizeof(struct omap_dss_mgr_output *),
+				GFP_KERNEL);
+
+		BUG_ON(mgr->output == NULL);
+
 		switch (i) {
 		case 0:
 			mgr->name = "lcd";
@@ -545,6 +561,8 @@ int dss_init_overlay_managers(struct platform_device *pdev)
 		mgr->wait_for_go = &dss_mgr_wait_for_go;
 		mgr->wait_for_vsync = &dss_mgr_wait_for_vsync;
 
+		mgr->get_output = &dss_mgr_get_output;
+
 		mgr->caps = 0;
 		mgr->supported_displays =
 			dss_feat_get_supported_displays(mgr->id);
@@ -568,6 +586,7 @@ void dss_uninit_overlay_managers(struct platform_device *pdev)
 	for (i = 0; i < num_managers; ++i) {
 		struct omap_overlay_manager *mgr = &managers[i];
 
+		kfree(mgr->output);
 		kobject_del(&mgr->kobj);
 		kobject_put(&mgr->kobj);
 	}
diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index 6e82181..c72275e 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -536,16 +536,16 @@ void dss_recheck_connections(struct omap_dss_device *dssdev, bool force)
 		lcd2_mgr = omap_dss_get_overlay_manager(OMAP_DSS_OVL_MGR_LCD2);
 
 	if (dssdev->channel == OMAP_DSS_CHANNEL_LCD2) {
-		if (!lcd2_mgr->device || force) {
-			if (lcd2_mgr->device)
+		if (!lcd2_mgr->output->device || force) {
+			if (lcd2_mgr->output->device)
 				lcd2_mgr->unset_device(lcd2_mgr);
 			lcd2_mgr->set_device(lcd2_mgr, dssdev);
 			mgr = lcd2_mgr;
 		}
 	} else if (dssdev->type != OMAP_DISPLAY_TYPE_VENC
 			&& dssdev->type != OMAP_DISPLAY_TYPE_HDMI) {
-		if (!lcd_mgr->device || force) {
-			if (lcd_mgr->device)
+		if (!lcd_mgr->output->device || force) {
+			if (lcd_mgr->output->device)
 				lcd_mgr->unset_device(lcd_mgr);
 			lcd_mgr->set_device(lcd_mgr, dssdev);
 			mgr = lcd_mgr;
@@ -554,8 +554,8 @@ void dss_recheck_connections(struct omap_dss_device *dssdev, bool force)
 
 	if (dssdev->type == OMAP_DISPLAY_TYPE_VENC
 			|| dssdev->type == OMAP_DISPLAY_TYPE_HDMI) {
-		if (!tv_mgr->device || force) {
-			if (tv_mgr->device)
+		if (!tv_mgr->output->device || force) {
+			if (tv_mgr->output->device)
 				tv_mgr->unset_device(tv_mgr);
 			tv_mgr->set_device(tv_mgr, dssdev);
 			mgr = tv_mgr;
diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 46024ab..fe0aa98 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2412,6 +2412,7 @@ static int omapfb_probe(struct platform_device *pdev)
 	struct omap_overlay *ovl;
 	struct omap_dss_device *def_display;
 	struct omap_dss_device *dssdev;
+	struct omap_dss_device *mgr_device;
 
 	DBG("omapfb_probe\n");
 
@@ -2485,8 +2486,10 @@ static int omapfb_probe(struct platform_device *pdev)
 	/* gfx overlay should be the default one. find a display
 	 * connected to that, and use it as default display */
 	ovl = omap_dss_get_overlay(0);
-	if (ovl->manager && ovl->manager->device) {
-		def_display = ovl->manager->device;
+	mgr_device = ovl->manager ?
+		ovl->manager->get_output(ovl->manager) : NULL;
+	if (mgr_device) {
+		def_display = mgr_device;
 	} else {
 		dev_warn(&pdev->dev, "cannot find default display\n");
 		def_display = NULL;
diff --git a/drivers/video/omap2/omapfb/omapfb.h b/drivers/video/omap2/omapfb/omapfb.h
index b03fb13..45b1f81 100644
--- a/drivers/video/omap2/omapfb/omapfb.h
+++ b/drivers/video/omap2/omapfb/omapfb.h
@@ -148,8 +148,9 @@ static inline struct omap_dss_device *fb2display(struct fb_info *fbi)
 
 	/* XXX: returns the display connected to first attached overlay */
 	for (i = 0; i < ofbi->num_overlays; i++) {
-		if (ofbi->overlays[i]->manager)
-			return ofbi->overlays[i]->manager->device;
+		struct omap_overlay_manager *mgr = ofbi->overlays[i]->manager;
+		if (mgr)
+			return mgr->get_output(mgr);
 	}
 
 	return NULL;
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 39862b8..1b968bb 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -411,6 +411,10 @@ struct omap_overlay {
 	int (*wait_for_go)(struct omap_overlay *ovl);
 };
 
+struct omap_dss_mgr_output {
+	struct omap_dss_device *device;
+};
+
 struct omap_overlay_manager_info {
 	u32 default_color;
 
@@ -435,7 +439,7 @@ struct omap_overlay_manager {
 	enum omap_display_type supported_displays;
 
 	/* dynamic fields */
-	struct omap_dss_device *device;
+	struct omap_dss_mgr_output *output;
 
 	/*
 	 * The following functions do not block:
@@ -460,6 +464,8 @@ struct omap_overlay_manager {
 	int (*apply)(struct omap_overlay_manager *mgr);
 	int (*wait_for_go)(struct omap_overlay_manager *mgr);
 	int (*wait_for_vsync)(struct omap_overlay_manager *mgr);
+
+	struct omap_dss_device *(*get_output)(struct omap_overlay_manager *mgr);
 };
 
 struct omap_dss_device {
-- 
1.7.4.1

