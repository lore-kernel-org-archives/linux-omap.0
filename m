From: Archit Taneja <archit@ti.com>
Subject: [PATCH v4 5/9] OMAPDSS: APPLY: Remove display dependency from overlay and manager checks
Date: Wed, 9 May 2012 15:40:52 +0530
Message-ID: <1336558256-26140-6-git-send-email-archit@ti.com>
References: <1334561027-28569-1-git-send-email-archit@ti.com>
 <1336558256-26140-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44787 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754227Ab2EIKMC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 06:12:02 -0400
In-Reply-To: <1336558256-26140-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

In order to check the validity of overlay and manager info, there was a need to
use the omap_dss_device struct to get the panel resolution. The manager's
private data in APPLY now contains the manager timings. Hence, we don't need to
rely on the display resolution any more.

Pass the manager's timings in private data to dss_mgr_check(). Remove the need
to pass omap_dss_device structs in the functions which check for the validity
of overlay and manager parameters.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/apply.c   |   24 +++++++++++-------------
 drivers/video/omap2/dss/dss.h     |    7 ++++---
 drivers/video/omap2/dss/manager.c |    6 +++---
 drivers/video/omap2/dss/overlay.c |   10 ++++------
 4 files changed, 22 insertions(+), 25 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index ad349b3..0ffe4e1 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -181,7 +181,7 @@ static bool mgr_manual_update(struct omap_overlay_manager *mgr)
 }
 
 static int dss_check_settings_low(struct omap_overlay_manager *mgr,
-		struct omap_dss_device *dssdev, bool applying)
+		bool applying)
 {
 	struct omap_overlay_info *oi;
 	struct omap_overlay_manager_info *mi;
@@ -214,26 +214,24 @@ static int dss_check_settings_low(struct omap_overlay_manager *mgr,
 		ois[ovl->id] = oi;
 	}
 
-	return dss_mgr_check(mgr, dssdev, mi, ois);
+	return dss_mgr_check(mgr, mi, &mp->timings, ois);
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
@@ -687,7 +685,7 @@ static void dss_write_regs(void)
 		if (!mp->enabled || mgr_manual_update(mgr) || mp->busy)
 			continue;
 
-		r = dss_check_settings(mgr, mgr->device);
+		r = dss_check_settings(mgr);
 		if (r) {
 			DSSERR("cannot write registers for manager %s: "
 					"illegal configuration\n", mgr->name);
@@ -754,7 +752,7 @@ void dss_mgr_start_update(struct omap_overlay_manager *mgr)
 
 	WARN_ON(mp->updating);
 
-	r = dss_check_settings(mgr, mgr->device);
+	r = dss_check_settings(mgr);
 	if (r) {
 		DSSERR("cannot start manual update: illegal configuration\n");
 		spin_unlock_irqrestore(&data_lock, flags);
@@ -901,7 +899,7 @@ int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 
 	spin_lock_irqsave(&data_lock, flags);
 
-	r = dss_check_settings_apply(mgr, mgr->device);
+	r = dss_check_settings_apply(mgr);
 	if (r) {
 		spin_unlock_irqrestore(&data_lock, flags);
 		DSSERR("failed to apply settings: illegal configuration.\n");
@@ -1094,7 +1092,7 @@ int dss_mgr_enable(struct omap_overlay_manager *mgr)
 
 	mp->enabled = true;
 
-	r = dss_check_settings(mgr, mgr->device);
+	r = dss_check_settings(mgr);
 	if (r) {
 		DSSERR("failed to enable manager %d: check_settings failed\n",
 				mgr->id);
@@ -1466,7 +1464,7 @@ int dss_ovl_enable(struct omap_overlay *ovl)
 
 	op->enabling = true;
 
-	r = dss_check_settings(ovl->manager, ovl->manager->device);
+	r = dss_check_settings(ovl->manager);
 	if (r) {
 		DSSERR("failed to enable overlay %d: check_settings failed\n",
 				ovl->id);
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index a13b305..f3fa445 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -179,6 +179,7 @@ int dss_mgr_set_device(struct omap_overlay_manager *mgr,
 int dss_mgr_unset_device(struct omap_overlay_manager *mgr);
 void dss_mgr_set_timings(struct omap_overlay_manager *mgr,
 		struct omap_video_timings *timings);
+const struct omap_video_timings *dss_mgr_get_timings(struct omap_overlay_manager *mgr);
 
 bool dss_ovl_is_enabled(struct omap_overlay *ovl);
 int dss_ovl_enable(struct omap_overlay *ovl);
@@ -211,8 +212,8 @@ int dss_mgr_simple_check(struct omap_overlay_manager *mgr,
 int dss_mgr_check_timings(struct omap_overlay_manager *mgr,
 		const struct omap_video_timings *timings);
 int dss_mgr_check(struct omap_overlay_manager *mgr,
-		struct omap_dss_device *dssdev,
 		struct omap_overlay_manager_info *info,
+		const struct omap_video_timings *mgr_timings,
 		struct omap_overlay_info **overlay_infos);
 
 /* overlay */
@@ -222,8 +223,8 @@ void dss_overlay_setup_dispc_manager(struct omap_overlay_manager *mgr);
 void dss_recheck_connections(struct omap_dss_device *dssdev, bool force);
 int dss_ovl_simple_check(struct omap_overlay *ovl,
 		const struct omap_overlay_info *info);
-int dss_ovl_check(struct omap_overlay *ovl,
-		struct omap_overlay_info *info, struct omap_dss_device *dssdev);
+int dss_ovl_check(struct omap_overlay *ovl, struct omap_overlay_info *info,
+		const struct omap_video_timings *mgr_timings);
 
 /* DSS */
 int dss_init_platform_driver(void);
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index 566fbba..0cbcde4 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -666,8 +666,8 @@ int dss_mgr_check_timings(struct omap_overlay_manager *mgr,
 }
 
 int dss_mgr_check(struct omap_overlay_manager *mgr,
-		struct omap_dss_device *dssdev,
 		struct omap_overlay_manager_info *info,
+		const struct omap_video_timings *mgr_timings,
 		struct omap_overlay_info **overlay_infos)
 {
 	struct omap_overlay *ovl;
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
+		r = dss_ovl_check(ovl, oi, mgr_timings);
 		if (r)
 			return r;
 	}
diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index 6e82181..0da5eb6 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -631,16 +631,14 @@ int dss_ovl_simple_check(struct omap_overlay *ovl,
 	return 0;
 }
 
-int dss_ovl_check(struct omap_overlay *ovl,
-		struct omap_overlay_info *info, struct omap_dss_device *dssdev)
+int dss_ovl_check(struct omap_overlay *ovl, struct omap_overlay_info *info,
+		const struct omap_video_timings *mgr_timings)
 {
 	u16 outw, outh;
 	u16 dw, dh;
 
-	if (dssdev == NULL)
-		return 0;
-
-	dssdev->driver->get_resolution(dssdev, &dw, &dh);
+	dw = mgr_timings->x_res;
+	dh = mgr_timings->y_res;
 
 	if ((ovl->caps & OMAP_DSS_OVL_CAP_SCALE) == 0) {
 		outw = info->width;
-- 
1.7.5.4

