From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 3/3] OMAP: DSS2: remove update_mode from omapdss
Date: Mon, 13 Jun 2011 12:12:54 +0300
Message-ID: <1307956374-1107-4-git-send-email-tomi.valkeinen@ti.com>
References: <1307956374-1107-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:43368 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754971Ab1FMJNK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Jun 2011 05:13:10 -0400
In-Reply-To: <1307956374-1107-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Remove the whole update_mode stuff from omapdss driver. If automatic
update for manual update displays is needed, it's better implemented in
higher layers.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays/panel-taal.c |   17 --------
 drivers/video/omap2/dss/display.c         |   45 ----------------------
 drivers/video/omap2/dss/manager.c         |   59 +++++++----------------------
 drivers/video/omap2/dss/venc.c            |   17 --------
 include/video/omapdss.h                   |   11 -----
 5 files changed, 14 insertions(+), 135 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-taal.c b/drivers/video/omap2/displays/panel-taal.c
index fdd5d4ae..221579f 100644
--- a/drivers/video/omap2/displays/panel-taal.c
+++ b/drivers/video/omap2/displays/panel-taal.c
@@ -1897,20 +1897,6 @@ err:
 	mutex_unlock(&td->lock);
 }
 
-static int taal_set_update_mode(struct omap_dss_device *dssdev,
-		enum omap_dss_update_mode mode)
-{
-	if (mode != OMAP_DSS_UPDATE_MANUAL)
-		return -EINVAL;
-	return 0;
-}
-
-static enum omap_dss_update_mode taal_get_update_mode(
-		struct omap_dss_device *dssdev)
-{
-	return OMAP_DSS_UPDATE_MANUAL;
-}
-
 static struct omap_dss_driver taal_driver = {
 	.probe		= taal_probe,
 	.remove		= __exit_p(taal_remove),
@@ -1920,9 +1906,6 @@ static struct omap_dss_driver taal_driver = {
 	.suspend	= taal_suspend,
 	.resume		= taal_resume,
 
-	.set_update_mode = taal_set_update_mode,
-	.get_update_mode = taal_get_update_mode,
-
 	.update		= taal_update,
 	.sync		= taal_sync,
 
diff --git a/drivers/video/omap2/dss/display.c b/drivers/video/omap2/dss/display.c
index c2dfc8c..a0bbdf6 100644
--- a/drivers/video/omap2/dss/display.c
+++ b/drivers/video/omap2/dss/display.c
@@ -65,48 +65,6 @@ static ssize_t display_enabled_store(struct device *dev,
 	return size;
 }
 
-static ssize_t display_upd_mode_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct omap_dss_device *dssdev = to_dss_device(dev);
-	enum omap_dss_update_mode mode = OMAP_DSS_UPDATE_AUTO;
-	if (dssdev->driver->get_update_mode)
-		mode = dssdev->driver->get_update_mode(dssdev);
-	return snprintf(buf, PAGE_SIZE, "%d\n", mode);
-}
-
-static ssize_t display_upd_mode_store(struct device *dev,
-		struct device_attribute *attr,
-		const char *buf, size_t size)
-{
-	struct omap_dss_device *dssdev = to_dss_device(dev);
-	int val, r;
-	enum omap_dss_update_mode mode;
-
-	if (!dssdev->driver->set_update_mode)
-		return -EINVAL;
-
-	r = kstrtoint(buf, 0, &val);
-	if (r)
-		return r;
-
-	switch (val) {
-	case OMAP_DSS_UPDATE_DISABLED:
-	case OMAP_DSS_UPDATE_AUTO:
-	case OMAP_DSS_UPDATE_MANUAL:
-		mode = (enum omap_dss_update_mode)val;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	r = dssdev->driver->set_update_mode(dssdev, mode);
-	if (r)
-		return r;
-
-	return size;
-}
-
 static ssize_t display_tear_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -294,8 +252,6 @@ static ssize_t display_wss_store(struct device *dev,
 
 static DEVICE_ATTR(enabled, S_IRUGO|S_IWUSR,
 		display_enabled_show, display_enabled_store);
-static DEVICE_ATTR(update_mode, S_IRUGO|S_IWUSR,
-		display_upd_mode_show, display_upd_mode_store);
 static DEVICE_ATTR(tear_elim, S_IRUGO|S_IWUSR,
 		display_tear_show, display_tear_store);
 static DEVICE_ATTR(timings, S_IRUGO|S_IWUSR,
@@ -309,7 +265,6 @@ static DEVICE_ATTR(wss, S_IRUGO|S_IWUSR,
 
 static struct device_attribute *display_sysfs_attrs[] = {
 	&dev_attr_enabled,
-	&dev_attr_update_mode,
 	&dev_attr_tear_elim,
 	&dev_attr_timings,
 	&dev_attr_rotate,
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index 9aeea50..18a1b92 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -416,8 +416,6 @@ struct overlay_cache_data {
 	enum omap_burst_size burst_size;
 	u32 fifo_low;
 	u32 fifo_high;
-
-	bool manual_update;
 };
 
 struct manager_cache_data {
@@ -437,7 +435,6 @@ struct manager_cache_data {
 
 	bool alpha_enabled;
 
-	bool manual_upd_display;
 	bool manual_update;
 	bool do_manual_update;
 
@@ -539,24 +536,15 @@ static int dss_mgr_wait_for_go(struct omap_overlay_manager *mgr)
 	if (!dssdev || dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
 		return 0;
 
+	if (dssdev->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE)
+		return 0;
+
 	if (dssdev->type == OMAP_DISPLAY_TYPE_VENC
 			|| dssdev->type == OMAP_DISPLAY_TYPE_HDMI) {
 		irq = DISPC_IRQ_EVSYNC_ODD | DISPC_IRQ_EVSYNC_EVEN;
 	} else {
-		if (dssdev->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE) {
-			enum omap_dss_update_mode mode;
-			mode = dssdev->driver->get_update_mode(dssdev);
-			if (mode != OMAP_DSS_UPDATE_AUTO)
-				return 0;
-
-			irq = (dssdev->manager->id == OMAP_DSS_CHANNEL_LCD) ?
-				DISPC_IRQ_FRAMEDONE
-				: DISPC_IRQ_FRAMEDONE2;
-		} else {
-			irq = (dssdev->manager->id == OMAP_DSS_CHANNEL_LCD) ?
-				DISPC_IRQ_VSYNC
-				: DISPC_IRQ_VSYNC2;
-		}
+		irq = (dssdev->manager->id == OMAP_DSS_CHANNEL_LCD) ?
+			DISPC_IRQ_VSYNC : DISPC_IRQ_VSYNC2;
 	}
 
 	mc = &dss_cache.manager_cache[mgr->id];
@@ -617,24 +605,15 @@ int dss_mgr_wait_for_go_ovl(struct omap_overlay *ovl)
 	if (!dssdev || dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
 		return 0;
 
+	if (dssdev->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE)
+		return 0;
+
 	if (dssdev->type == OMAP_DISPLAY_TYPE_VENC
 			|| dssdev->type == OMAP_DISPLAY_TYPE_HDMI) {
 		irq = DISPC_IRQ_EVSYNC_ODD | DISPC_IRQ_EVSYNC_EVEN;
 	} else {
-		if (dssdev->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE) {
-			enum omap_dss_update_mode mode;
-			mode = dssdev->driver->get_update_mode(dssdev);
-			if (mode != OMAP_DSS_UPDATE_AUTO)
-				return 0;
-
-			irq = (dssdev->manager->id == OMAP_DSS_CHANNEL_LCD) ?
-				DISPC_IRQ_FRAMEDONE
-				: DISPC_IRQ_FRAMEDONE2;
-		} else {
-			irq = (dssdev->manager->id == OMAP_DSS_CHANNEL_LCD) ?
-				DISPC_IRQ_VSYNC
-				: DISPC_IRQ_VSYNC2;
-		}
+		irq = (dssdev->manager->id == OMAP_DSS_CHANNEL_LCD) ?
+			DISPC_IRQ_VSYNC : DISPC_IRQ_VSYNC2;
 	}
 
 	oc = &dss_cache.overlay_cache[ovl->id];
@@ -763,7 +742,7 @@ static int configure_overlay(enum omap_plane plane)
 	orig_outw = outw;
 	orig_outh = outh;
 
-	if (c->manual_update && mc->do_manual_update) {
+	if (mc->manual_update && mc->do_manual_update) {
 		unsigned bpp;
 		unsigned scale_x_m = w, scale_x_d = outw;
 		unsigned scale_y_m = h, scale_y_d = outh;
@@ -928,7 +907,7 @@ static int configure_dispc(void)
 		if (!oc->dirty)
 			continue;
 
-		if (oc->manual_update && !mc->do_manual_update)
+		if (mc->manual_update && !mc->do_manual_update)
 			continue;
 
 		if (mgr_busy[oc->channel]) {
@@ -976,7 +955,7 @@ static int configure_dispc(void)
 		/* We don't need GO with manual update display. LCD iface will
 		 * always be turned off after frame, and new settings will be
 		 * taken in to use at next update */
-		if (!mc->manual_upd_display)
+		if (!mc->manual_update)
 			dispc_go(i);
 	}
 
@@ -1302,11 +1281,6 @@ static int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 
 		oc->enabled = true;
 
-		oc->manual_update =
-			dssdev->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE &&
-			dssdev->driver->get_update_mode(dssdev) !=
-				OMAP_DSS_UPDATE_AUTO;
-
 		++num_planes_enabled;
 	}
 
@@ -1341,13 +1315,8 @@ static int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 		mc->trans_enabled = mgr->info.trans_enabled;
 		mc->alpha_enabled = mgr->info.alpha_enabled;
 
-		mc->manual_upd_display =
-			dssdev->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE;
-
 		mc->manual_update =
-			dssdev->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE &&
-			dssdev->driver->get_update_mode(dssdev) !=
-				OMAP_DSS_UPDATE_AUTO;
+			dssdev->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE;
 	}
 
 	/* XXX TODO: Try to get fifomerge working. The problem is that it
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 980f919..e7485fc 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -538,20 +538,6 @@ static int venc_panel_resume(struct omap_dss_device *dssdev)
 	return venc_panel_enable(dssdev);
 }
 
-static enum omap_dss_update_mode venc_get_update_mode(
-		struct omap_dss_device *dssdev)
-{
-	return OMAP_DSS_UPDATE_AUTO;
-}
-
-static int venc_set_update_mode(struct omap_dss_device *dssdev,
-		enum omap_dss_update_mode mode)
-{
-	if (mode != OMAP_DSS_UPDATE_AUTO)
-		return -EINVAL;
-	return 0;
-}
-
 static void venc_get_timings(struct omap_dss_device *dssdev,
 			struct omap_video_timings *timings)
 {
@@ -632,9 +618,6 @@ static struct omap_dss_driver venc_driver = {
 	.get_resolution	= omapdss_default_get_resolution,
 	.get_recommended_bpp = omapdss_default_get_recommended_bpp,
 
-	.set_update_mode = venc_set_update_mode,
-	.get_update_mode = venc_get_update_mode,
-
 	.get_timings	= venc_get_timings,
 	.set_timings	= venc_set_timings,
 	.check_timings	= venc_check_timings,
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index bb39738..388577d 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -134,12 +134,6 @@ enum omap_display_caps {
 	OMAP_DSS_DISPLAY_CAP_TEAR_ELIM		= 1 << 1,
 };
 
-enum omap_dss_update_mode {
-	OMAP_DSS_UPDATE_DISABLED = 0,
-	OMAP_DSS_UPDATE_AUTO,
-	OMAP_DSS_UPDATE_MANUAL,
-};
-
 enum omap_dss_display_state {
 	OMAP_DSS_DISPLAY_DISABLED = 0,
 	OMAP_DSS_DISPLAY_ACTIVE,
@@ -524,11 +518,6 @@ struct omap_dss_driver {
 	int (*resume)(struct omap_dss_device *display);
 	int (*run_test)(struct omap_dss_device *display, int test);
 
-	int (*set_update_mode)(struct omap_dss_device *dssdev,
-			enum omap_dss_update_mode);
-	enum omap_dss_update_mode (*get_update_mode)(
-			struct omap_dss_device *dssdev);
-
 	int (*update)(struct omap_dss_device *dssdev,
 			       u16 x, u16 y, u16 w, u16 h);
 	int (*sync)(struct omap_dss_device *dssdev);
-- 
1.7.4.1

