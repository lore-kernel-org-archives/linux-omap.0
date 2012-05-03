From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 1/4] OMAPDSS: APPLY: Add manager timings as extra_info in private data
Date: Thu, 3 May 2012 12:37:41 +0530
Message-ID: <1336028864-13895-2-git-send-email-archit@ti.com>
References: <1334561027-28569-1-git-send-email-archit@ti.com>
 <1336028864-13895-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38761 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752459Ab2ECHId (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 May 2012 03:08:33 -0400
In-Reply-To: <1336028864-13895-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

DISPC manager size and DISPC manager blanking parameters(for LCD managers)
follow the shadow register programming model. Currently, they are programmed
directly by the interface drivers.

To configure manager timings using APPLY, there is a need to introduce extra
info flags for managers, similar to what is done for overlays. This is needed
because timings aren't a part of overlay_manager_info struct configured by a
user of DSS, they are configured internally by the interface or panel drivers.

Add dirty and shadow_dirty extra_info flags for managers, update these flags
at the appropriate places. Rewrite the function extra_info_update_ongoing()
slightly as checking for manager's extra_info flags can simplify the code a bit.

Create function dss_mgr_set_timings() which applies the new manager timings to
extra_info.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/apply.c |   91 +++++++++++++++++++++++++++++++++------
 drivers/video/omap2/dss/dss.h   |    2 +
 2 files changed, 80 insertions(+), 13 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index b10b3bc..42c3854 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -99,6 +99,11 @@ struct mgr_priv_data {
 
 	/* If true, a display is enabled using this manager */
 	bool enabled;
+
+	bool extra_info_dirty;
+	bool shadow_extra_info_dirty;
+
+	struct omap_video_timings timings;
 };
 
 static struct {
@@ -261,6 +266,20 @@ static bool need_isr(void)
 			if (mp->shadow_info_dirty)
 				return true;
 
+			/*
+			 * NOTE: we don't check extra_info flags for disabled
+			 * managers, once the manager is enabled, the extra_info
+			 * related manager changes will be taken in by HW.
+			 */
+
+			/* to write new values to registers */
+			if (mp->extra_info_dirty)
+				return true;
+
+			/* to set GO bit */
+			if (mp->shadow_extra_info_dirty)
+				return true;
+
 			list_for_each_entry(ovl, &mgr->overlays, list) {
 				struct ovl_priv_data *op;
 
@@ -305,7 +324,7 @@ static bool need_go(struct omap_overlay_manager *mgr)
 
 	mp = get_mgr_priv(mgr);
 
-	if (mp->shadow_info_dirty)
+	if (mp->shadow_info_dirty || mp->shadow_extra_info_dirty)
 		return true;
 
 	list_for_each_entry(ovl, &mgr->overlays, list) {
@@ -320,20 +339,16 @@ static bool need_go(struct omap_overlay_manager *mgr)
 /* returns true if an extra_info field is currently being updated */
 static bool extra_info_update_ongoing(void)
 {
-	const int num_ovls = omap_dss_get_num_overlays();
-	struct ovl_priv_data *op;
-	struct omap_overlay *ovl;
-	struct mgr_priv_data *mp;
+	const int num_mgrs = dss_feat_get_num_mgrs();
 	int i;
 
-	for (i = 0; i < num_ovls; ++i) {
-		ovl = omap_dss_get_overlay(i);
-		op = get_ovl_priv(ovl);
-
-		if (!ovl->manager)
-			continue;
+	for (i = 0; i < num_mgrs; ++i) {
+		struct omap_overlay_manager *mgr;
+		struct omap_overlay *ovl;
+		struct mgr_priv_data *mp;
 
-		mp = get_mgr_priv(ovl->manager);
+		mgr = omap_dss_get_overlay_manager(i);
+		mp = get_mgr_priv(mgr);
 
 		if (!mp->enabled)
 			continue;
@@ -341,8 +356,15 @@ static bool extra_info_update_ongoing(void)
 		if (!mp->updating)
 			continue;
 
-		if (op->extra_info_dirty || op->shadow_extra_info_dirty)
+		if (mp->extra_info_dirty || mp->shadow_extra_info_dirty)
 			return true;
+
+		list_for_each_entry(ovl, &mgr->overlays, list) {
+			struct ovl_priv_data *op = get_ovl_priv(ovl);
+
+			if (op->extra_info_dirty || op->shadow_extra_info_dirty)
+				return true;
+		}
 	}
 
 	return false;
@@ -601,6 +623,22 @@ static void dss_mgr_write_regs(struct omap_overlay_manager *mgr)
 	}
 }
 
+static void dss_mgr_write_regs_extra(struct omap_overlay_manager *mgr)
+{
+	struct mgr_priv_data *mp = get_mgr_priv(mgr);
+
+	DSSDBGF("%d", mgr->id);
+
+	if (!mp->extra_info_dirty)
+		return;
+
+	dispc_mgr_set_timings(mgr->id, &mp->timings);
+
+	mp->extra_info_dirty = false;
+	if (mp->updating)
+		mp->shadow_extra_info_dirty = true;
+}
+
 static void dss_write_regs_common(void)
 {
 	const int num_mgrs = omap_dss_get_num_overlay_managers();
@@ -654,6 +692,7 @@ static void dss_write_regs(void)
 		}
 
 		dss_mgr_write_regs(mgr);
+		dss_mgr_write_regs_extra(mgr);
 	}
 }
 
@@ -693,6 +732,7 @@ static void mgr_clear_shadow_dirty(struct omap_overlay_manager *mgr)
 
 	mp = get_mgr_priv(mgr);
 	mp->shadow_info_dirty = false;
+	mp->shadow_extra_info_dirty = false;
 
 	list_for_each_entry(ovl, &mgr->overlays, list) {
 		op = get_ovl_priv(ovl);
@@ -719,6 +759,7 @@ void dss_mgr_start_update(struct omap_overlay_manager *mgr)
 	}
 
 	dss_mgr_write_regs(mgr);
+	dss_mgr_write_regs_extra(mgr);
 
 	dss_write_regs_common();
 
@@ -1225,6 +1266,30 @@ err:
 	return r;
 }
 
+static void dss_apply_mgr_timings(struct omap_overlay_manager *mgr,
+		struct omap_video_timings *timings)
+{
+	struct mgr_priv_data *mp = get_mgr_priv(mgr);
+
+	mp->timings = *timings;
+	mp->extra_info_dirty = true;
+}
+
+void dss_mgr_set_timings(struct omap_overlay_manager *mgr,
+		struct omap_video_timings *timings)
+{
+	unsigned long flags;
+
+	mutex_lock(&apply_lock);
+
+	spin_lock_irqsave(&data_lock, flags);
+
+	dss_apply_mgr_timings(mgr, timings);
+
+	spin_unlock_irqrestore(&data_lock, flags);
+
+	mutex_unlock(&apply_lock);
+}
 
 int dss_ovl_set_info(struct omap_overlay *ovl,
 		struct omap_overlay_info *info)
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 5ca67f1..ca59481 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -177,6 +177,8 @@ void dss_mgr_get_info(struct omap_overlay_manager *mgr,
 int dss_mgr_set_device(struct omap_overlay_manager *mgr,
 		struct omap_dss_device *dssdev);
 int dss_mgr_unset_device(struct omap_overlay_manager *mgr);
+void dss_mgr_set_timings(struct omap_overlay_manager *mgr,
+		struct omap_video_timings *timings);
 
 bool dss_ovl_is_enabled(struct omap_overlay *ovl);
 int dss_ovl_enable(struct omap_overlay *ovl);
-- 
1.7.5.4

