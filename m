From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 45/65] OMAPDSS: APPLY: rewrite overlay enable/disable
Date: Tue, 22 Nov 2011 11:21:44 +0200
Message-ID: <1321953724-6350-46-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:55593 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757932Ab1KVJYQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:24:16 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Overlays are currently enabled and disabled with a boolean in the struct
omap_overlay_info. The overlay info is set with ovl->set_overlay_info(),
and made into use with mgr->apply().

This doesn't work properly, as the enable/disable status may affect also
other overlays, for example when using fifo-merge. Thus the enabling and
disabling of the overlay needs to be done outside the normal overlay
configuration.

This patch achieves that by doing the following things:

1) Add function pointers to struct omap_overlay: enable(), disable() and
is_enabled(). These are used to do the obvious. The functions may block.

2) Move the "enabled" field from struct omap_overlay to ovl_priv_data.

3) Add a new route for settings to be applied to the HW, called
"extra_info". The status of the normal info and extra_info are tracked
separately.

The point here is to allow the normal info to be changed and
applied in non-blocking matter, whereas the extra_info can only be
changed when holding the mutex. This makes it possible to, for example,
set the overlay enable flag, apply it, and wait until the HW has taken
the flag into use.

This is not possible if the enable flag would be in the normal info, as
a new value for the flag could be set at any time from the users of
omapdss.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/media/video/omap/omap_vout.c      |   33 +++---
 drivers/video/omap2/dss/apply.c           |  163 ++++++++++++++++++++++++-----
 drivers/video/omap2/dss/dss.h             |    3 +
 drivers/video/omap2/dss/overlay.c         |   20 ++--
 drivers/video/omap2/omapfb/omapfb-ioctl.c |   30 +++---
 drivers/video/omap2/omapfb/omapfb-main.c  |    2 +
 drivers/video/omap2/omapfb/omapfb-sysfs.c |    4 +-
 drivers/video/omap2/omapfb/omapfb.h       |   11 +--
 include/video/omapdss.h                   |    6 +-
 9 files changed, 190 insertions(+), 82 deletions(-)

diff --git a/drivers/media/video/omap/omap_vout.c b/drivers/media/video/omap/omap_vout.c
index 9c5c19f..27c19fe 100644
--- a/drivers/media/video/omap/omap_vout.c
+++ b/drivers/media/video/omap/omap_vout.c
@@ -423,7 +423,7 @@ static int omapvid_setup_overlay(struct omap_vout_device *vout,
 		"%s enable=%d addr=%x width=%d\n height=%d color_mode=%d\n"
 		"rotation=%d mirror=%d posx=%d posy=%d out_width = %d \n"
 		"out_height=%d rotation_type=%d screen_width=%d\n",
-		__func__, info.enabled, info.paddr, info.width, info.height,
+		__func__, ovl->is_enabled(ovl), info.paddr, info.width, info.height,
 		info.color_mode, info.rotation, info.mirror, info.pos_x,
 		info.pos_y, info.out_width, info.out_height, info.rotation_type,
 		info.screen_width);
@@ -942,12 +942,8 @@ static int omap_vout_release(struct file *file)
 	/* Disable all the overlay managers connected with this interface */
 	for (i = 0; i < ovid->num_overlays; i++) {
 		struct omap_overlay *ovl = ovid->overlays[i];
-		if (ovl->manager && ovl->manager->device) {
-			struct omap_overlay_info info;
-			ovl->get_overlay_info(ovl, &info);
-			info.enabled = 0;
-			ovl->set_overlay_info(ovl, &info);
-		}
+		if (ovl->manager && ovl->manager->device)
+			ovl->disable(ovl);
 	}
 	/* Turn off the pipeline */
 	ret = omapvid_apply_changes(vout);
@@ -1667,7 +1663,6 @@ static int vidioc_streamon(struct file *file, void *fh, enum v4l2_buf_type i)
 		if (ovl->manager && ovl->manager->device) {
 			struct omap_overlay_info info;
 			ovl->get_overlay_info(ovl, &info);
-			info.enabled = 1;
 			info.paddr = addr;
 			if (ovl->set_overlay_info(ovl, &info)) {
 				ret = -EINVAL;
@@ -1686,6 +1681,16 @@ static int vidioc_streamon(struct file *file, void *fh, enum v4l2_buf_type i)
 	if (ret)
 		v4l2_err(&vout->vid_dev->v4l2_dev, "failed to change mode\n");
 
+	for (j = 0; j < ovid->num_overlays; j++) {
+		struct omap_overlay *ovl = ovid->overlays[j];
+
+		if (ovl->manager && ovl->manager->device) {
+			ret = ovl->enable(ovl);
+			if (ret)
+				goto streamon_err1;
+		}
+	}
+
 	ret = 0;
 
 streamon_err1:
@@ -1715,16 +1720,8 @@ static int vidioc_streamoff(struct file *file, void *fh, enum v4l2_buf_type i)
 	for (j = 0; j < ovid->num_overlays; j++) {
 		struct omap_overlay *ovl = ovid->overlays[j];
 
-		if (ovl->manager && ovl->manager->device) {
-			struct omap_overlay_info info;
-
-			ovl->get_overlay_info(ovl, &info);
-			info.enabled = 0;
-			ret = ovl->set_overlay_info(ovl, &info);
-			if (ret)
-				v4l2_err(&vout->vid_dev->v4l2_dev,
-				"failed to update overlay info in streamoff\n");
-		}
+		if (ovl->manager && ovl->manager->device)
+			ovl->disable(ovl);
 	}
 
 	/* Turn of the pipeline */
diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 323cffa..2c60e77 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -63,14 +63,18 @@ struct ovl_priv_data {
 	 * VSYNC/EVSYNC */
 	bool shadow_dirty;
 
-	bool enabled;
-
 	struct omap_overlay_info info;
 
 	enum omap_channel channel;
 
 	u32 fifo_low;
 	u32 fifo_high;
+
+	bool extra_info_dirty;
+	bool shadow_extra_info_dirty;
+
+	bool enabled;
+
 };
 
 struct mgr_priv_data {
@@ -132,11 +136,6 @@ static bool mgr_manual_update(struct omap_overlay_manager *mgr)
 	return mgr->device->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE;
 }
 
-static int overlay_enabled(struct omap_overlay *ovl)
-{
-	return ovl->info.enabled && ovl->manager && ovl->manager->device;
-}
-
 int dss_mgr_wait_for_go(struct omap_overlay_manager *mgr)
 {
 	unsigned long timeout = msecs_to_jiffies(500);
@@ -270,10 +269,8 @@ static int dss_ovl_write_regs(struct omap_overlay *ovl)
 	op = get_ovl_priv(ovl);
 	oi = &op->info;
 
-	if (!op->enabled) {
-		dispc_ovl_enable(ovl->id, 0);
+	if (!op->enabled)
 		return 0;
-	}
 
 	replication = dss_use_replication(ovl->manager->device, oi->color_mode);
 
@@ -291,11 +288,21 @@ static int dss_ovl_write_regs(struct omap_overlay *ovl)
 
 	dispc_ovl_set_fifo_threshold(ovl->id, op->fifo_low, op->fifo_high);
 
-	dispc_ovl_enable(ovl->id, 1);
-
 	return 0;
 }
 
+static void dss_ovl_write_regs_extra(struct omap_overlay *ovl)
+{
+	struct ovl_priv_data *op = get_ovl_priv(ovl);
+
+	DSSDBGF("%d", ovl->id);
+
+	/* note: write also when op->enabled == false, so that the ovl gets
+	 * disabled */
+
+	dispc_ovl_enable(ovl->id, op->enabled);
+}
+
 static void dss_mgr_write_regs(struct omap_overlay_manager *mgr)
 {
 	struct mgr_priv_data *mp;
@@ -356,6 +363,30 @@ static int dss_write_regs(void)
 		mgr_go[op->channel] = true;
 	}
 
+	for (i = 0; i < num_ovls; ++i) {
+		ovl = omap_dss_get_overlay(i);
+		op = get_ovl_priv(ovl);
+
+		if (!op->extra_info_dirty)
+			continue;
+
+		mp = get_mgr_priv(ovl->manager);
+
+		if (mp->manual_update && !mp->do_manual_update)
+			continue;
+
+		if (mp->busy) {
+			busy = true;
+			continue;
+		}
+
+		dss_ovl_write_regs_extra(ovl);
+
+		op->extra_info_dirty = false;
+		op->shadow_extra_info_dirty = true;
+		mgr_go[op->channel] = true;
+	}
+
 	/* Commit manager settings */
 	for (i = 0; i < num_mgrs; ++i) {
 		mgr = omap_dss_get_overlay_manager(i);
@@ -419,6 +450,7 @@ void dss_start_update(struct omap_overlay_manager *mgr)
 	list_for_each_entry(ovl, &mgr->overlays, list) {
 		op = get_ovl_priv(ovl);
 		op->shadow_dirty = false;
+		op->shadow_extra_info_dirty = false;
 	}
 
 	mp->shadow_dirty = false;
@@ -490,8 +522,10 @@ static void dss_apply_irq_handler(void *data, u32 mask)
 
 		mp = get_mgr_priv(ovl->manager);
 
-		if (!mp->busy)
+		if (!mp->busy) {
 			op->shadow_dirty = false;
+			op->shadow_extra_info_dirty = false;
+		}
 	}
 
 	for (i = 0; i < num_mgrs; ++i) {
@@ -541,14 +575,6 @@ static void omap_dss_mgr_apply_ovl(struct omap_overlay *ovl)
 		ovl->info_dirty  = true;
 	}
 
-	if (!overlay_enabled(ovl)) {
-		if (op->enabled) {
-			op->enabled = false;
-			op->dirty = true;
-		}
-		return;
-	}
-
 	if (!ovl->info_dirty)
 		return;
 
@@ -557,8 +583,6 @@ static void omap_dss_mgr_apply_ovl(struct omap_overlay *ovl)
 	op->info = ovl->info;
 
 	op->channel = ovl->manager->id;
-
-	op->enabled = true;
 }
 
 static void omap_dss_mgr_apply_mgr(struct omap_overlay_manager *mgr)
@@ -593,9 +617,6 @@ static void omap_dss_mgr_apply_ovl_fifos(struct omap_overlay *ovl)
 
 	op = get_ovl_priv(ovl);
 
-	if (!op->enabled)
-		return;
-
 	dssdev = ovl->manager->device;
 
 	size = dispc_ovl_get_fifo_size(ovl->id);
@@ -828,6 +849,8 @@ void dss_ovl_get_info(struct omap_overlay *ovl,
 int dss_ovl_set_manager(struct omap_overlay *ovl,
 		struct omap_overlay_manager *mgr)
 {
+	struct ovl_priv_data *op = get_ovl_priv(ovl);
+	unsigned long flags;
 	int r;
 
 	if (!mgr)
@@ -842,7 +865,10 @@ int dss_ovl_set_manager(struct omap_overlay *ovl,
 		goto err;
 	}
 
-	if (ovl->info.enabled) {
+	spin_lock_irqsave(&data_lock, flags);
+
+	if (op->enabled) {
+		spin_unlock_irqrestore(&data_lock, flags);
 		DSSERR("overlay has to be disabled to change the manager\n");
 		r = -EINVAL;
 		goto err;
@@ -852,6 +878,8 @@ int dss_ovl_set_manager(struct omap_overlay *ovl,
 	list_add_tail(&ovl->list, &mgr->overlays);
 	ovl->manager_changed = true;
 
+	spin_unlock_irqrestore(&data_lock, flags);
+
 	/* XXX: When there is an overlay on a DSI manual update display, and
 	 * the overlay is first disabled, then moved to tv, and enabled, we
 	 * seem to get SYNC_LOST_DIGIT error.
@@ -875,6 +903,8 @@ err:
 
 int dss_ovl_unset_manager(struct omap_overlay *ovl)
 {
+	struct ovl_priv_data *op = get_ovl_priv(ovl);
+	unsigned long flags;
 	int r;
 
 	mutex_lock(&apply_lock);
@@ -885,7 +915,10 @@ int dss_ovl_unset_manager(struct omap_overlay *ovl)
 		goto err;
 	}
 
-	if (ovl->info.enabled) {
+	spin_lock_irqsave(&data_lock, flags);
+
+	if (op->enabled) {
+		spin_unlock_irqrestore(&data_lock, flags);
 		DSSERR("overlay has to be disabled to unset the manager\n");
 		r = -EINVAL;
 		goto err;
@@ -895,9 +928,83 @@ int dss_ovl_unset_manager(struct omap_overlay *ovl)
 	list_del(&ovl->list);
 	ovl->manager_changed = true;
 
+	spin_unlock_irqrestore(&data_lock, flags);
+
+	mutex_unlock(&apply_lock);
+
+	return 0;
+err:
+	mutex_unlock(&apply_lock);
+	return r;
+}
+
+bool dss_ovl_is_enabled(struct omap_overlay *ovl)
+{
+	struct ovl_priv_data *op = get_ovl_priv(ovl);
+	unsigned long flags;
+	bool e;
+
+	spin_lock_irqsave(&data_lock, flags);
+
+	e = op->enabled;
+
+	spin_unlock_irqrestore(&data_lock, flags);
+
+	return e;
+}
+
+int dss_ovl_enable(struct omap_overlay *ovl)
+{
+	struct ovl_priv_data *op = get_ovl_priv(ovl);
+	unsigned long flags;
+	int r;
+
+	mutex_lock(&apply_lock);
+
+	if (ovl->manager == NULL || ovl->manager->device == NULL) {
+		r = -EINVAL;
+		goto err;
+	}
+
+	spin_lock_irqsave(&data_lock, flags);
+
+	op->enabled = true;
+	op->extra_info_dirty = true;
+
+	spin_unlock_irqrestore(&data_lock, flags);
+
+	mutex_unlock(&apply_lock);
+
+	return 0;
+err:
+	mutex_unlock(&apply_lock);
+	return r;
+}
+
+int dss_ovl_disable(struct omap_overlay *ovl)
+{
+	struct ovl_priv_data *op = get_ovl_priv(ovl);
+	unsigned long flags;
+	int r;
+
+	mutex_lock(&apply_lock);
+
+	if (ovl->manager == NULL || ovl->manager->device == NULL) {
+		r = -EINVAL;
+		goto err;
+	}
+
+	spin_lock_irqsave(&data_lock, flags);
+
+	op->enabled = false;
+	op->extra_info_dirty = true;
+
+	spin_unlock_irqrestore(&data_lock, flags);
+
 	mutex_unlock(&apply_lock);
 
 	return 0;
+
 err:
 	mutex_unlock(&apply_lock);
 	return r;
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 0ef0e08..b597485 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -180,6 +180,9 @@ int dss_mgr_set_device(struct omap_overlay_manager *mgr,
 		struct omap_dss_device *dssdev);
 int dss_mgr_unset_device(struct omap_overlay_manager *mgr);
 
+bool dss_ovl_is_enabled(struct omap_overlay *ovl);
+int dss_ovl_enable(struct omap_overlay *ovl);
+int dss_ovl_disable(struct omap_overlay *ovl);
 int dss_ovl_set_info(struct omap_overlay *ovl,
 		struct omap_overlay_info *info);
 void dss_ovl_get_info(struct omap_overlay *ovl,
diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index 4dc6b92..7d7cdf6 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -205,7 +205,7 @@ static ssize_t overlay_output_size_store(struct omap_overlay *ovl,
 
 static ssize_t overlay_enabled_show(struct omap_overlay *ovl, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", ovl->info.enabled);
+	return snprintf(buf, PAGE_SIZE, "%d\n", ovl->is_enabled(ovl));
 }
 
 static ssize_t overlay_enabled_store(struct omap_overlay *ovl, const char *buf,
@@ -213,26 +213,19 @@ static ssize_t overlay_enabled_store(struct omap_overlay *ovl, const char *buf,
 {
 	int r;
 	bool enable;
-	struct omap_overlay_info info;
-
-	ovl->get_overlay_info(ovl, &info);
 
 	r = strtobool(buf, &enable);
 	if (r)
 		return r;
 
-	info.enabled = enable;
+	if (enable)
+		r = ovl->enable(ovl);
+	else
+		r = ovl->disable(ovl);
 
-	r = ovl->set_overlay_info(ovl, &info);
 	if (r)
 		return r;
 
-	if (ovl->manager) {
-		r = ovl->manager->apply(ovl->manager);
-		if (r)
-			return r;
-	}
-
 	return size;
 }
 
@@ -489,6 +482,9 @@ void dss_init_overlays(struct platform_device *pdev)
 			break;
 		}
 
+		ovl->is_enabled = &dss_ovl_is_enabled;
+		ovl->enable = &dss_ovl_enable;
+		ovl->disable = &dss_ovl_disable;
 		ovl->set_manager = &dss_ovl_set_manager;
 		ovl->unset_manager = &dss_ovl_unset_manager;
 		ovl->set_overlay_info = &dss_ovl_set_info;
diff --git a/drivers/video/omap2/omapfb/omapfb-ioctl.c b/drivers/video/omap2/omapfb/omapfb-ioctl.c
index df7bcce..562b5cc 100644
--- a/drivers/video/omap2/omapfb/omapfb-ioctl.c
+++ b/drivers/video/omap2/omapfb/omapfb-ioctl.c
@@ -111,28 +111,22 @@ static int omapfb_setup_plane(struct fb_info *fbi, struct omapfb_plane_info *pi)
 		set_fb_fix(fbi);
 	}
 
-	if (pi->enabled) {
-		struct omap_overlay_info info;
+	if (!pi->enabled) {
+		r = ovl->disable(ovl);
+		if (r)
+			goto undo;
+	}
 
+	if (pi->enabled) {
 		r = omapfb_setup_overlay(fbi, ovl, pi->pos_x, pi->pos_y,
 			pi->out_width, pi->out_height);
 		if (r)
 			goto undo;
-
-		ovl->get_overlay_info(ovl, &info);
-
-		if (!info.enabled) {
-			info.enabled = pi->enabled;
-			r = ovl->set_overlay_info(ovl, &info);
-			if (r)
-				goto undo;
-		}
 	} else {
 		struct omap_overlay_info info;
 
 		ovl->get_overlay_info(ovl, &info);
 
-		info.enabled = pi->enabled;
 		info.pos_x = pi->pos_x;
 		info.pos_y = pi->pos_y;
 		info.out_width = pi->out_width;
@@ -146,6 +140,12 @@ static int omapfb_setup_plane(struct fb_info *fbi, struct omapfb_plane_info *pi)
 	if (ovl->manager)
 		ovl->manager->apply(ovl->manager);
 
+	if (pi->enabled) {
+		r = ovl->enable(ovl);
+		if (r)
+			goto undo;
+	}
+
 	/* Release the locks in a specific order to keep lockdep happy */
 	if (old_rg->id > new_rg->id) {
 		omapfb_put_mem_region(old_rg);
@@ -196,7 +196,7 @@ static int omapfb_query_plane(struct fb_info *fbi, struct omapfb_plane_info *pi)
 
 		pi->pos_x = ovli->pos_x;
 		pi->pos_y = ovli->pos_y;
-		pi->enabled = ovli->enabled;
+		pi->enabled = ovl->is_enabled(ovl);
 		pi->channel_out = 0; /* xxx */
 		pi->mirror = 0;
 		pi->mem_idx = get_mem_idx(ofbi);
@@ -238,7 +238,9 @@ static int omapfb_setup_mem(struct fb_info *fbi, struct omapfb_mem_info *mi)
 			continue;
 
 		for (j = 0; j < ofbi2->num_overlays; j++) {
-			if (ofbi2->overlays[j]->info.enabled) {
+			struct omap_overlay *ovl;
+			ovl = ofbi2->overlays[j];
+			if (ovl->is_enabled(ovl)) {
 				r = -EBUSY;
 				goto out;
 			}
diff --git a/drivers/video/omap2/omapfb/omapfb-main.c b/drivers/video/omap2/omapfb/omapfb-main.c
index 70aa47d..91b49b5 100644
--- a/drivers/video/omap2/omapfb/omapfb-main.c
+++ b/drivers/video/omap2/omapfb/omapfb-main.c
@@ -2067,6 +2067,8 @@ static int omapfb_create_framebuffers(struct omapfb2_device *fbdev)
 		if (ofbi->num_overlays > 0) {
 			struct omap_overlay *ovl = ofbi->overlays[0];
 
+			ovl->manager->apply(ovl->manager);
+
 			r = omapfb_overlay_enable(ovl, 1);
 
 			if (r) {
diff --git a/drivers/video/omap2/omapfb/omapfb-sysfs.c b/drivers/video/omap2/omapfb/omapfb-sysfs.c
index 1694d51..e8d8cc7 100644
--- a/drivers/video/omap2/omapfb/omapfb-sysfs.c
+++ b/drivers/video/omap2/omapfb/omapfb-sysfs.c
@@ -473,7 +473,9 @@ static ssize_t store_size(struct device *dev, struct device_attribute *attr,
 			continue;
 
 		for (j = 0; j < ofbi2->num_overlays; j++) {
-			if (ofbi2->overlays[j]->info.enabled) {
+			struct omap_overlay *ovl;
+			ovl = ofbi2->overlays[j];
+			if (ovl->is_enabled(ovl)) {
 				r = -EBUSY;
 				goto out;
 			}
diff --git a/drivers/video/omap2/omapfb/omapfb.h b/drivers/video/omap2/omapfb/omapfb.h
index fdf0ede..b03fb13 100644
--- a/drivers/video/omap2/omapfb/omapfb.h
+++ b/drivers/video/omap2/omapfb/omapfb.h
@@ -181,13 +181,10 @@ static inline void omapfb_unlock(struct omapfb2_device *fbdev)
 static inline int omapfb_overlay_enable(struct omap_overlay *ovl,
 		int enable)
 {
-	struct omap_overlay_info info;
-
-	ovl->get_overlay_info(ovl, &info);
-	if (info.enabled == enable)
-		return 0;
-	info.enabled = enable;
-	return ovl->set_overlay_info(ovl, &info);
+	if (enable)
+		return ovl->enable(ovl);
+	else
+		return ovl->disable(ovl);
 }
 
 static inline struct omapfb2_mem_region *
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 6e3e7a7..9d01ff6 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -352,8 +352,6 @@ struct omap_dss_cpr_coefs {
 };
 
 struct omap_overlay_info {
-	bool enabled;
-
 	u32 paddr;
 	u32 p_uv_addr;  /* for NV12 format */
 	u16 screen_width;
@@ -391,6 +389,10 @@ struct omap_overlay {
 	/* if true, info has been changed, but not applied() yet */
 	bool info_dirty;
 
+	int (*enable)(struct omap_overlay *ovl);
+	int (*disable)(struct omap_overlay *ovl);
+	bool (*is_enabled)(struct omap_overlay *ovl);
+
 	int (*set_manager)(struct omap_overlay *ovl,
 		struct omap_overlay_manager *mgr);
 	int (*unset_manager)(struct omap_overlay *ovl);
-- 
1.7.4.1

