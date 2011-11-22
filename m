From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 50/65] OMAPDSS: APPLY: move mgr->info to apply.c
Date: Tue, 22 Nov 2011 11:21:49 +0200
Message-ID: <1321953724-6350-51-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:60940 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758155Ab1KVJY1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:24:27 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

struct omap_overlay_manager contains info and info_dirty fields, both of
which should be internal to apply.c.

This patch moves those fields into mgr_priv data, and names them
user_info and user_info_dirty.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c   |   20 +++++++++++++-------
 drivers/video/omap2/dss/manager.c |   35 +++++++++++++++++++++++++++++------
 include/video/omapdss.h           |    3 ---
 3 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 601dbc7..de1ac24 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -78,6 +78,10 @@ struct ovl_priv_data {
 };
 
 struct mgr_priv_data {
+
+	bool user_info_dirty;
+	struct omap_overlay_manager_info user_info;
+
 	/* If true, cache changed, but not written to shadow registers. Set
 	 * in apply(), cleared when registers written. */
 	bool dirty;
@@ -592,15 +596,15 @@ static void omap_dss_mgr_apply_mgr(struct omap_overlay_manager *mgr)
 
 	if (mgr->device_changed) {
 		mgr->device_changed = false;
-		mgr->info_dirty  = true;
+		mp->user_info_dirty  = true;
 	}
 
-	if (!mgr->info_dirty)
+	if (!mp->user_info_dirty)
 		return;
 
-	mgr->info_dirty = false;
+	mp->user_info_dirty = false;
 	mp->dirty = true;
-	mp->info = mgr->info;
+	mp->info = mp->user_info;
 }
 
 static void omap_dss_mgr_apply_ovl_fifos(struct omap_overlay *ovl)
@@ -720,12 +724,13 @@ void dss_mgr_disable(struct omap_overlay_manager *mgr)
 int dss_mgr_set_info(struct omap_overlay_manager *mgr,
 		struct omap_overlay_manager_info *info)
 {
+	struct mgr_priv_data *mp = get_mgr_priv(mgr);
 	unsigned long flags;
 
 	spin_lock_irqsave(&data_lock, flags);
 
-	mgr->info = *info;
-	mgr->info_dirty = true;
+	mp->user_info = *info;
+	mp->user_info_dirty = true;
 
 	spin_unlock_irqrestore(&data_lock, flags);
 
@@ -735,11 +740,12 @@ int dss_mgr_set_info(struct omap_overlay_manager *mgr,
 void dss_mgr_get_info(struct omap_overlay_manager *mgr,
 		struct omap_overlay_manager_info *info)
 {
+	struct mgr_priv_data *mp = get_mgr_priv(mgr);
 	unsigned long flags;
 
 	spin_lock_irqsave(&data_lock, flags);
 
-	*info = mgr->info;
+	*info = mp->user_info;
 
 	spin_unlock_irqrestore(&data_lock, flags);
 }
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index d7fd494..8c967ef 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -104,7 +104,11 @@ put_device:
 static ssize_t manager_default_color_show(struct omap_overlay_manager *mgr,
 					  char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%#x\n", mgr->info.default_color);
+	struct omap_overlay_manager_info info;
+
+	mgr->get_manager_info(mgr, &info);
+
+	return snprintf(buf, PAGE_SIZE, "%#x\n", info.default_color);
 }
 
 static ssize_t manager_default_color_store(struct omap_overlay_manager *mgr,
@@ -142,8 +146,11 @@ static ssize_t manager_trans_key_type_show(struct omap_overlay_manager *mgr,
 					   char *buf)
 {
 	enum omap_dss_trans_key_type key_type;
+	struct omap_overlay_manager_info info;
+
+	mgr->get_manager_info(mgr, &info);
 
-	key_type = mgr->info.trans_key_type;
+	key_type = info.trans_key_type;
 	BUG_ON(key_type >= ARRAY_SIZE(trans_key_type_str));
 
 	return snprintf(buf, PAGE_SIZE, "%s\n", trans_key_type_str[key_type]);
@@ -183,7 +190,11 @@ static ssize_t manager_trans_key_type_store(struct omap_overlay_manager *mgr,
 static ssize_t manager_trans_key_value_show(struct omap_overlay_manager *mgr,
 					    char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%#x\n", mgr->info.trans_key);
+	struct omap_overlay_manager_info info;
+
+	mgr->get_manager_info(mgr, &info);
+
+	return snprintf(buf, PAGE_SIZE, "%#x\n", info.trans_key);
 }
 
 static ssize_t manager_trans_key_value_store(struct omap_overlay_manager *mgr,
@@ -215,7 +226,11 @@ static ssize_t manager_trans_key_value_store(struct omap_overlay_manager *mgr,
 static ssize_t manager_trans_key_enabled_show(struct omap_overlay_manager *mgr,
 					      char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", mgr->info.trans_enabled);
+	struct omap_overlay_manager_info info;
+
+	mgr->get_manager_info(mgr, &info);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", info.trans_enabled);
 }
 
 static ssize_t manager_trans_key_enabled_store(struct omap_overlay_manager *mgr,
@@ -247,10 +262,14 @@ static ssize_t manager_trans_key_enabled_store(struct omap_overlay_manager *mgr,
 static ssize_t manager_alpha_blending_enabled_show(
 		struct omap_overlay_manager *mgr, char *buf)
 {
+	struct omap_overlay_manager_info info;
+
+	mgr->get_manager_info(mgr, &info);
+
 	WARN_ON(!dss_has_feature(FEAT_ALPHA_FIXED_ZORDER));
 
 	return snprintf(buf, PAGE_SIZE, "%d\n",
-		mgr->info.partial_alpha_enabled);
+		info.partial_alpha_enabled);
 }
 
 static ssize_t manager_alpha_blending_enabled_store(
@@ -285,7 +304,11 @@ static ssize_t manager_alpha_blending_enabled_store(
 static ssize_t manager_cpr_enable_show(struct omap_overlay_manager *mgr,
 		char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", mgr->info.cpr_enable);
+	struct omap_overlay_manager_info info;
+
+	mgr->get_manager_info(mgr, &info);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", info.cpr_enable);
 }
 
 static ssize_t manager_cpr_enable_store(struct omap_overlay_manager *mgr,
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 9d01ff6..0d5333f 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -430,11 +430,8 @@ struct omap_overlay_manager {
 
 	/* dynamic fields */
 	struct omap_dss_device *device;
-	struct omap_overlay_manager_info info;
 
 	bool device_changed;
-	/* if true, info has been changed but not applied() yet */
-	bool info_dirty;
 
 	int (*set_device)(struct omap_overlay_manager *mgr,
 		struct omap_dss_device *dssdev);
-- 
1.7.4.1

