From: Archit Taneja <archit@ti.com>
Subject: [PATCH v3 3/5] OMAPDSS: MANAGER: Create a function to check manager timings
Date: Tue, 8 May 2012 15:28:14 +0530
Message-ID: <1336471096-21096-4-git-send-email-archit@ti.com>
References: <1334561027-28569-1-git-send-email-archit@ti.com>
 <1336471096-21096-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59138 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752874Ab2EHJ7N (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 May 2012 05:59:13 -0400
In-Reply-To: <1336471096-21096-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Create a function dss_mgr_check_timings() which wraps around the function
dispc_mgr_timings_ok(). This is mainly a clean up to hide dispc functions
from interface drivers.

dss_mgr_check_timings() is added in the function dss_mgr_check(), it currently
takes the timings maintained in the omap_dss_device struct. This would be later
replaced by the timings stored in the manager's private data.

Make dss_mgr_check_timings() and dispc_mgr_timings_ok() take a const
omap_video_timings pointer since these functions just check the timings.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c   |    2 +-
 drivers/video/omap2/dss/dpi.c     |    2 +-
 drivers/video/omap2/dss/dss.h     |    4 +++-
 drivers/video/omap2/dss/manager.c |   15 +++++++++++++++
 4 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 49015b8..2829a92 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2479,7 +2479,7 @@ static bool _dispc_lcd_timings_ok(int hsw, int hfp, int hbp,
 }
 
 bool dispc_mgr_timings_ok(enum omap_channel channel,
-		struct omap_video_timings *timings)
+		const struct omap_video_timings *timings)
 {
 	bool timings_ok;
 
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 5d84ab0..8127f46 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -312,7 +312,7 @@ int dpi_check_timings(struct omap_dss_device *dssdev,
 	unsigned long pck;
 	struct dispc_clock_info dispc_cinfo;
 
-	if (!dispc_mgr_timings_ok(dssdev->manager->id, timings))
+	if (!dss_mgr_check_timings(dssdev->manager, timings))
 		return -EINVAL;
 
 	if (timings->pixel_clock == 0)
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index ca59481..7c9b9bc 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -208,6 +208,8 @@ int dss_init_overlay_managers(struct platform_device *pdev);
 void dss_uninit_overlay_managers(struct platform_device *pdev);
 int dss_mgr_simple_check(struct omap_overlay_manager *mgr,
 		const struct omap_overlay_manager_info *info);
+int dss_mgr_check_timings(struct omap_overlay_manager *mgr,
+		const struct omap_video_timings *timings);
 int dss_mgr_check(struct omap_overlay_manager *mgr,
 		struct omap_dss_device *dssdev,
 		struct omap_overlay_manager_info *info,
@@ -414,7 +416,7 @@ void dispc_enable_gamma_table(bool enable);
 void dispc_set_loadmode(enum omap_dss_load_mode mode);
 
 bool dispc_mgr_timings_ok(enum omap_channel channel,
-		struct omap_video_timings *timings);
+		const struct omap_video_timings *timings);
 unsigned long dispc_fclk_rate(void);
 void dispc_find_clk_divs(bool is_tft, unsigned long req_pck, unsigned long fck,
 		struct dispc_clock_info *cinfo);
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index e736460..566fbba 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -654,6 +654,17 @@ static int dss_mgr_check_zorder(struct omap_overlay_manager *mgr,
 	return 0;
 }
 
+int dss_mgr_check_timings(struct omap_overlay_manager *mgr,
+		const struct omap_video_timings *timings)
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
 
+	r = dss_mgr_check_timings(mgr, &dssdev->panel.timings);
+	if (r)
+		return r;
+
 	list_for_each_entry(ovl, &mgr->overlays, list) {
 		struct omap_overlay_info *oi;
 		int r;
-- 
1.7.5.4

