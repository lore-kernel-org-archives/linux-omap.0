From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 4/4] OMAPDSS: APPLY: Remove display dependency from overlay and manager checks
Date: Thu, 3 May 2012 12:37:44 +0530
Message-ID: <1336028864-13895-5-git-send-email-archit@ti.com>
References: <1334561027-28569-1-git-send-email-archit@ti.com>
 <1336028864-13895-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53527 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753863Ab2ECHIq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 May 2012 03:08:46 -0400
In-Reply-To: <1336028864-13895-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

In order to check the validity of overlay and manager info, there was a need to
use the omap_dss_device struct to get the panel resolution. The manager's
private data in APPLY now contains the manager timings. Hence, we don't need to
rely on the display resolution any more.

Create a function dss_mgr_get_timings() which returns the timings in manager's
private data. Remove the need of passing omap_dss_device structs in the
functions which check for overlay and managers.

Have some initial values for manager timings in apply_init(), these would ensure
that manager checks don't fail if an interface driver or a panel driver hasn't
set the manager timings yet.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/apply.c   |   51 +++++++++++++++++++++++++++---------
 drivers/video/omap2/dss/dss.h     |    5 +--
 drivers/video/omap2/dss/manager.c |    6 ++--
 drivers/video/omap2/dss/overlay.c |   20 +++++++-------
 4 files changed, 53 insertions(+), 29 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 42c3854..052d9a2 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -137,10 +137,30 @@ static struct mgr_priv_data *get_mgr_priv(struct omap_overlay_manager *mgr)
 void dss_apply_init(void)
 {
 	const int num_ovls = dss_feat_get_num_ovls();
+	const int num_mgrs = dss_feat_get_num_ovls();
 	int i;
+	/* Use dummy manager timings during initialization */
+	struct omap_video_timings timings = {
+		.hsw		= 1,
+		.hfp		= 1,
+		.hbp		= 1,
+		.vsw		= 1,
+		.vfp		= 0,
+		.vbp		= 0,
+		.x_res	= dss_feat_get_param_max(FEAT_PARAM_MGR_WIDTH),
+		.y_res	= dss_feat_get_param_max(FEAT_PARAM_MGR_HEIGHT),
+	};
 
 	spin_lock_init(&data_lock);
 
+	for (i = 0; i < num_mgrs; i++) {
+		struct mgr_priv_data *mp;
+
+		mp = &dss_data.mgr_priv_data_array[i];
+
+		mp->timings = timings;
+	}
+
 	for (i = 0; i < num_ovls; ++i) {
 		struct ovl_priv_data *op;
 
@@ -181,7 +201,7 @@ static bool mgr_manual_update(struct omap_overlay_manager *mgr)
 }
 
 static int dss_check_settings_low(struct omap_overlay_manager *mgr,
-		struct omap_dss_device *dssdev, bool applying)
+		bool applying)
 {
 	struct omap_overlay_info *oi;
 	struct omap_overlay_manager_info *mi;
@@ -211,26 +231,24 @@ static int dss_check_settings_low(struct omap_overlay_manager *mgr,
 		ois[ovl->id] = oi;
 	}
 
-	return dss_mgr_check(mgr, dssdev, mi, ois);
+	return dss_mgr_check(mgr, mi, ois);
 }
 
 /*
  * check manager and overlay settings using overlay_info from data->info
  */
-static int dss_check_settings(struct omap_overlay_manager *mgr,
-		struct omap_dss_device *dssdev)
+static int dss_check_settings(struct omap_overlay_manager *mgr)
 {
-	return dss_check_settings_low(mgr, dssdev, false);
+	return dss_check_settings_low(mgr, false);
 }
 
 /*
  * check manager and overlay settings using overlay_info from ovl->info if
  * dirty and from data->info otherwise
  */
-static int dss_check_settings_apply(struct omap_overlay_manager *mgr,
-		struct omap_dss_device *dssdev)
+static int dss_check_settings_apply(struct omap_overlay_manager *mgr)
 {
-	return dss_check_settings_low(mgr, dssdev, true);
+	return dss_check_settings_low(mgr, true);
 }
 
 static bool need_isr(void)
@@ -684,7 +702,7 @@ static void dss_write_regs(void)
 		if (!mp->enabled || mgr_manual_update(mgr) || mp->busy)
 			continue;
 
-		r = dss_check_settings(mgr, mgr->device);
+		r = dss_check_settings(mgr);
 		if (r) {
 			DSSERR("cannot write registers for manager %s: "
 					"illegal configuration\n", mgr->name);
@@ -751,7 +769,7 @@ void dss_mgr_start_update(struct omap_overlay_manager *mgr)
 
 	WARN_ON(mp->updating);
 
-	r = dss_check_settings(mgr, mgr->device);
+	r = dss_check_settings(mgr);
 	if (r) {
 		DSSERR("cannot start manual update: illegal configuration\n");
 		spin_unlock_irqrestore(&data_lock, flags);
@@ -898,7 +916,7 @@ int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 
 	spin_lock_irqsave(&data_lock, flags);
 
-	r = dss_check_settings_apply(mgr, mgr->device);
+	r = dss_check_settings_apply(mgr);
 	if (r) {
 		spin_unlock_irqrestore(&data_lock, flags);
 		DSSERR("failed to apply settings: illegal configuration.\n");
@@ -1091,7 +1109,7 @@ int dss_mgr_enable(struct omap_overlay_manager *mgr)
 
 	mp->enabled = true;
 
-	r = dss_check_settings(mgr, mgr->device);
+	r = dss_check_settings(mgr);
 	if (r) {
 		DSSERR("failed to enable manager %d: check_settings failed\n",
 				mgr->id);
@@ -1291,6 +1309,13 @@ void dss_mgr_set_timings(struct omap_overlay_manager *mgr,
 	mutex_unlock(&apply_lock);
 }
 
+struct omap_video_timings *dss_mgr_get_timings(struct omap_overlay_manager *mgr)
+{
+	struct mgr_priv_data *mp = get_mgr_priv(mgr);
+
+	return &mp->timings;
+}
+
 int dss_ovl_set_info(struct omap_overlay *ovl,
 		struct omap_overlay_info *info)
 {
@@ -1458,7 +1483,7 @@ int dss_ovl_enable(struct omap_overlay *ovl)
 
 	op->enabling = true;
 
-	r = dss_check_settings(ovl->manager, ovl->manager->device);
+	r = dss_check_settings(ovl->manager);
 	if (r) {
 		DSSERR("failed to enable overlay %d: check_settings failed\n",
 				ovl->id);
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index a148712..f2a51c6 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -179,6 +179,7 @@ int dss_mgr_set_device(struct omap_overlay_manager *mgr,
 int dss_mgr_unset_device(struct omap_overlay_manager *mgr);
 void dss_mgr_set_timings(struct omap_overlay_manager *mgr,
 		struct omap_video_timings *timings);
+struct omap_video_timings *dss_mgr_get_timings(struct omap_overlay_manager *mgr);
 
 bool dss_ovl_is_enabled(struct omap_overlay *ovl);
 int dss_ovl_enable(struct omap_overlay *ovl);
@@ -211,7 +212,6 @@ int dss_mgr_simple_check(struct omap_overlay_manager *mgr,
 int dss_mgr_check_timings(struct omap_overlay_manager *mgr,
 		struct omap_video_timings *timings);
 int dss_mgr_check(struct omap_overlay_manager *mgr,
-		struct omap_dss_device *dssdev,
 		struct omap_overlay_manager_info *info,
 		struct omap_overlay_info **overlay_infos);
 
@@ -222,8 +222,7 @@ void dss_overlay_setup_dispc_manager(struct omap_overlay_manager *mgr);
 void dss_recheck_connections(struct omap_dss_device *dssdev, bool force);
 int dss_ovl_simple_check(struct omap_overlay *ovl,
 		const struct omap_overlay_info *info);
-int dss_ovl_check(struct omap_overlay *ovl,
-		struct omap_overlay_info *info, struct omap_dss_device *dssdev);
+int dss_ovl_check(struct omap_overlay *ovl, struct omap_overlay_info *info);
 
 /* DSS */
 int dss_init_platform_driver(void);
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index 264ad7c..1fd339b 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -666,11 +666,11 @@ int dss_mgr_check_timings(struct omap_overlay_manager *mgr,
 }
 
 int dss_mgr_check(struct omap_overlay_manager *mgr,
-		struct omap_dss_device *dssdev,
 		struct omap_overlay_manager_info *info,
 		struct omap_overlay_info **overlay_infos)
 {
 	struct omap_overlay *ovl;
+	struct omap_video_timings *mgr_timings = dss_mgr_get_timings(mgr);
 	int r;
 
 	if (dss_has_feature(FEAT_ALPHA_FREE_ZORDER)) {
@@ -679,7 +679,7 @@ int dss_mgr_check(struct omap_overlay_manager *mgr,
 			return r;
 	}
 
-	r = dss_mgr_check_timings(mgr, &dssdev->panel.timings);
+	r = dss_mgr_check_timings(mgr, mgr_timings);
 	if (r)
 		return r;
 
@@ -692,7 +692,7 @@ int dss_mgr_check(struct omap_overlay_manager *mgr,
 		if (oi == NULL)
 			continue;
 
-		r = dss_ovl_check(ovl, oi, dssdev);
+		r = dss_ovl_check(ovl, oi);
 		if (r)
 			return r;
 	}
diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index 6e82181..8629e1a 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -631,16 +631,16 @@ int dss_ovl_simple_check(struct omap_overlay *ovl,
 	return 0;
 }
 
-int dss_ovl_check(struct omap_overlay *ovl,
-		struct omap_overlay_info *info, struct omap_dss_device *dssdev)
+int dss_ovl_check(struct omap_overlay *ovl, struct omap_overlay_info *info)
 {
 	u16 outw, outh;
-	u16 dw, dh;
+	struct omap_video_timings *mgr_timings;
+	u16 mgr_width, mgr_height;
 
-	if (dssdev == NULL)
-		return 0;
+	mgr_timings = dss_mgr_get_timings(ovl->manager);
 
-	dssdev->driver->get_resolution(dssdev, &dw, &dh);
+	mgr_width = mgr_timings->x_res;
+	mgr_height = mgr_timings->y_res;
 
 	if ((ovl->caps & OMAP_DSS_OVL_CAP_SCALE) == 0) {
 		outw = info->width;
@@ -657,17 +657,17 @@ int dss_ovl_check(struct omap_overlay *ovl,
 			outh = info->out_height;
 	}
 
-	if (dw < info->pos_x + outw) {
+	if (mgr_width < info->pos_x + outw) {
 		DSSERR("overlay %d horizontally not inside the display area "
 				"(%d + %d >= %d)\n",
-				ovl->id, info->pos_x, outw, dw);
+				ovl->id, info->pos_x, outw, mgr_width);
 		return -EINVAL;
 	}
 
-	if (dh < info->pos_y + outh) {
+	if (mgr_height < info->pos_y + outh) {
 		DSSERR("overlay %d vertically not inside the display area "
 				"(%d + %d >= %d)\n",
-				ovl->id, info->pos_y, outh, dh);
+				ovl->id, info->pos_y, outh, mgr_height);
 		return -EINVAL;
 	}
 
-- 
1.7.5.4

