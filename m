From: Archit Taneja <archit@ti.com>
Subject: [PATCH 5/6] OMAPDSS: MANAGER: Check validity of manager timings
Date: Mon, 16 Apr 2012 12:53:46 +0530
Message-ID: <1334561027-28569-6-git-send-email-archit@ti.com>
References: <1334561027-28569-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56350 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751432Ab2DPHYn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Apr 2012 03:24:43 -0400
In-Reply-To: <1334561027-28569-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The manager timings is a member of the overlay_manager_info struct. We can now
check it's validity in dss_mgr_check(). Add a function dss_mgr_check_timings()
which checks if the timings are correct.

Currently, the manager timings are initialized in an interface's enable call.
Since a mgr_apply() can happen before the connected display is enabled, we
initialize the manager timings to a dummy valid value in apply_init().

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/apply.c   |   22 ++++++++++++++++++++++
 drivers/video/omap2/dss/dpi.c     |    2 +-
 drivers/video/omap2/dss/dss.h     |    2 ++
 drivers/video/omap2/dss/manager.c |   15 +++++++++++++++
 4 files changed, 40 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index b10b3bc..53a198f 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -132,10 +132,32 @@ static struct mgr_priv_data *get_mgr_priv(struct omap_overlay_manager *mgr)
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
+		mp->info.timings = timings;
+
+		mp->user_info = mp->info;
+	}
+
 	for (i = 0; i < num_ovls; ++i) {
 		struct ovl_priv_data *op;
 
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 76e2cae..a1bdbf7 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -314,7 +314,7 @@ int dpi_check_timings(struct omap_dss_device *dssdev,
 	unsigned long pck;
 	struct dispc_clock_info dispc_cinfo;
 
-	if (!dispc_mgr_timings_ok(dssdev->manager->id, timings))
+	if (!dss_mgr_check_timings(dssdev->manager, timings))
 		return -EINVAL;
 
 	if (timings->pixel_clock == 0)
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 0bff325..9e47bdf 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -206,6 +206,8 @@ int dss_init_overlay_managers(struct platform_device *pdev);
 void dss_uninit_overlay_managers(struct platform_device *pdev);
 int dss_mgr_simple_check(struct omap_overlay_manager *mgr,
 		const struct omap_overlay_manager_info *info);
+int dss_mgr_check_timings(struct omap_overlay_manager *mgr,
+		struct omap_video_timings *timings);
 int dss_mgr_check(struct omap_overlay_manager *mgr,
 		struct omap_dss_device *dssdev,
 		struct omap_overlay_manager_info *info,
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index 2c85988..fb61b76 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -654,6 +654,17 @@ static int dss_mgr_check_zorder(struct omap_overlay_manager *mgr,
 	return 0;
 }
 
+int dss_mgr_check_timings(struct omap_overlay_manager *mgr,
+		struct omap_video_timings *timings)
+{
+	if (!dispc_mgr_timings_ok(mgr->id, timings)) {
+		DSSERR("check_manager: invalid timings\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 int dss_mgr_check(struct omap_overlay_manager *mgr,
 		struct omap_dss_device *dssdev,
 		struct omap_overlay_manager_info *info,
@@ -668,6 +679,10 @@ int dss_mgr_check(struct omap_overlay_manager *mgr,
 			return r;
 	}
 
+	r = dss_mgr_check_timings(mgr, &info->timings);
+	if (r)
+		return r;
+
 	list_for_each_entry(ovl, &mgr->overlays, list) {
 		struct omap_overlay_info *oi;
 		int r;
-- 
1.7.5.4

