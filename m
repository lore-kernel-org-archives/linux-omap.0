From: Archit Taneja <archit@ti.com>
Subject: [PATCH 08/12] OMAPDSS: MANAGER: Check LCD related overlay manager parameters
Date: Thu, 28 Jun 2012 20:00:38 +0530
Message-ID: <1340893842-10626-10-git-send-email-archit@ti.com>
References: <1340893842-10626-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60907 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752066Ab2F1Och (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Jun 2012 10:32:37 -0400
In-Reply-To: <1340893842-10626-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

The LCD related manager configurations are a part of the manager's private data
in APPLY. Pass this to dss_lcd_mgr_config to dss_mgr_check and create a function
to check the validity of some of the configurations.

To check some of the configurations, we require information of interface to
which the manager output is connected. These can be added once interfaces are
represented as an entity.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/apply.c   |    2 +-
 drivers/video/omap2/dss/dss.h     |    1 +
 drivers/video/omap2/dss/manager.c |   35 +++++++++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index bb4ec63..95a6713 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -226,7 +226,7 @@ static int dss_check_settings_low(struct omap_overlay_manager *mgr,
 		ois[ovl->id] = oi;
 	}
 
-	return dss_mgr_check(mgr, mi, &mp->timings, ois);
+	return dss_mgr_check(mgr, mi, &mp->timings, &mp->lcd_config, ois);
 }
 
 /*
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index b4c52ec..cb859e3 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -235,6 +235,7 @@ int dss_mgr_check_timings(struct omap_overlay_manager *mgr,
 int dss_mgr_check(struct omap_overlay_manager *mgr,
 		struct omap_overlay_manager_info *info,
 		const struct omap_video_timings *mgr_timings,
+		const struct dss_lcd_mgr_config *config,
 		struct omap_overlay_info **overlay_infos);
 
 static inline bool dss_mgr_is_lcd(enum omap_channel id)
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index 0cbcde4..09540bc 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -665,9 +665,40 @@ int dss_mgr_check_timings(struct omap_overlay_manager *mgr,
 	return 0;
 }
 
+static int dss_mgr_check_lcd_config(struct omap_overlay_manager *mgr,
+		const struct dss_lcd_mgr_config *config)
+{
+	struct dispc_clock_info cinfo = config->clock_info;
+	int dl = config->video_port_width;
+	bool stallmode = config->stallmode;
+	bool fifohandcheck = config->fifohandcheck;
+
+	if (cinfo.lck_div < 1 || cinfo.lck_div > 255)
+		return -EINVAL;
+
+	if (cinfo.pck_div < 1 || cinfo.pck_div > 255)
+		return -EINVAL;
+
+	if (dl != 12 && dl != 16 && dl != 18 && dl != 24)
+		return -EINVAL;
+
+	/* fifohandcheck should be used only with stallmode */
+	if (stallmode == false && fifohandcheck == true)
+		return -EINVAL;
+
+	/*
+	 * io pad mode can be only checked by using dssdev connected to the
+	 * manager. Ignore checking these for now, add checks when manager
+	 * is capable of holding information related to the connected interface
+	 */
+
+	return 0;
+}
+
 int dss_mgr_check(struct omap_overlay_manager *mgr,
 		struct omap_overlay_manager_info *info,
 		const struct omap_video_timings *mgr_timings,
+		const struct dss_lcd_mgr_config *lcd_config,
 		struct omap_overlay_info **overlay_infos)
 {
 	struct omap_overlay *ovl;
@@ -683,6 +714,10 @@ int dss_mgr_check(struct omap_overlay_manager *mgr,
 	if (r)
 		return r;
 
+	r = dss_mgr_check_lcd_config(mgr, lcd_config);
+	if (r)
+		return r;
+
 	list_for_each_entry(ovl, &mgr->overlays, list) {
 		struct omap_overlay_info *oi;
 		int r;
-- 
1.7.9.5

