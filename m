From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 19/32] OMAPDSS: move ovl function setup to apply.c
Date: Thu, 15 Nov 2012 17:58:27 +0200
Message-ID: <1352995120-3288-20-git-send-email-tomi.valkeinen@ti.com>
References: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59139 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1768286Ab2KOP7l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Nov 2012 10:59:41 -0500
In-Reply-To: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, Rob Clark <rob@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Most of the functions that are assigned to the fields in ovl struct are
in apply.c. By moving the function pointer setup into apply.c we can
make these functions static.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c   |   37 +++++++++++++++++++++++++++++--------
 drivers/video/omap2/dss/dss.h     |   12 ------------
 drivers/video/omap2/dss/overlay.c |   17 -----------------
 3 files changed, 29 insertions(+), 37 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index d103d11..91d02db 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -416,6 +416,13 @@ static void wait_pending_extra_info_updates(void)
 		DSSWARN("timeout in wait_pending_extra_info_updates\n");
 }
 
+static inline struct omap_dss_device *dss_ovl_get_device(struct omap_overlay *ovl)
+{
+	return ovl->manager ?
+		(ovl->manager->output ? ovl->manager->output->device : NULL) :
+		NULL;
+}
+
 static inline struct omap_dss_device *dss_mgr_get_device(struct omap_overlay_manager *mgr)
 {
 	return mgr->output ? mgr->output->device : NULL;
@@ -516,7 +523,7 @@ static int dss_mgr_wait_for_go(struct omap_overlay_manager *mgr)
 	return r;
 }
 
-int dss_mgr_wait_for_go_ovl(struct omap_overlay *ovl)
+static int dss_mgr_wait_for_go_ovl(struct omap_overlay *ovl)
 {
 	unsigned long timeout = msecs_to_jiffies(500);
 	struct ovl_priv_data *op;
@@ -1248,7 +1255,7 @@ out:
 	spin_unlock_irqrestore(&data_lock, flags);
 }
 
-int dss_ovl_set_info(struct omap_overlay *ovl,
+static int dss_ovl_set_info(struct omap_overlay *ovl,
 		struct omap_overlay_info *info)
 {
 	struct ovl_priv_data *op = get_ovl_priv(ovl);
@@ -1269,7 +1276,7 @@ int dss_ovl_set_info(struct omap_overlay *ovl,
 	return 0;
 }
 
-void dss_ovl_get_info(struct omap_overlay *ovl,
+static void dss_ovl_get_info(struct omap_overlay *ovl,
 		struct omap_overlay_info *info)
 {
 	struct ovl_priv_data *op = get_ovl_priv(ovl);
@@ -1282,7 +1289,7 @@ void dss_ovl_get_info(struct omap_overlay *ovl,
 	spin_unlock_irqrestore(&data_lock, flags);
 }
 
-int dss_ovl_set_manager(struct omap_overlay *ovl,
+static int dss_ovl_set_manager(struct omap_overlay *ovl,
 		struct omap_overlay_manager *mgr)
 {
 	struct ovl_priv_data *op = get_ovl_priv(ovl);
@@ -1334,7 +1341,7 @@ err:
 	return r;
 }
 
-int dss_ovl_unset_manager(struct omap_overlay *ovl)
+static int dss_ovl_unset_manager(struct omap_overlay *ovl)
 {
 	struct ovl_priv_data *op = get_ovl_priv(ovl);
 	unsigned long flags;
@@ -1394,7 +1401,7 @@ err:
 	return r;
 }
 
-bool dss_ovl_is_enabled(struct omap_overlay *ovl)
+static bool dss_ovl_is_enabled(struct omap_overlay *ovl)
 {
 	struct ovl_priv_data *op = get_ovl_priv(ovl);
 	unsigned long flags;
@@ -1409,7 +1416,7 @@ bool dss_ovl_is_enabled(struct omap_overlay *ovl)
 	return e;
 }
 
-int dss_ovl_enable(struct omap_overlay *ovl)
+static int dss_ovl_enable(struct omap_overlay *ovl)
 {
 	struct ovl_priv_data *op = get_ovl_priv(ovl);
 	unsigned long flags;
@@ -1459,7 +1466,7 @@ err1:
 	return r;
 }
 
-int dss_ovl_disable(struct omap_overlay *ovl)
+static int dss_ovl_disable(struct omap_overlay *ovl)
 {
 	struct ovl_priv_data *op = get_ovl_priv(ovl);
 	unsigned long flags;
@@ -1526,6 +1533,20 @@ int omapdss_compat_init(void)
 		mgr->get_device = &dss_mgr_get_device;
 	}
 
+	for (i = 0; i < omap_dss_get_num_overlays(); i++) {
+		struct omap_overlay *ovl = omap_dss_get_overlay(i);
+
+		ovl->is_enabled = &dss_ovl_is_enabled;
+		ovl->enable = &dss_ovl_enable;
+		ovl->disable = &dss_ovl_disable;
+		ovl->set_manager = &dss_ovl_set_manager;
+		ovl->unset_manager = &dss_ovl_unset_manager;
+		ovl->set_overlay_info = &dss_ovl_set_info;
+		ovl->get_overlay_info = &dss_ovl_get_info;
+		ovl->wait_for_go = &dss_mgr_wait_for_go_ovl;
+		ovl->get_device = &dss_ovl_get_device;
+	}
+
 out:
 	mutex_unlock(&apply_lock);
 
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 4a8f2bb..2cd126c 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -179,7 +179,6 @@ void dss_copy_device_pdata(struct omap_dss_device *dst,
 		const struct omap_dss_device *src);
 
 /* apply */
-int dss_mgr_wait_for_go_ovl(struct omap_overlay *ovl);
 void dss_mgr_start_update(struct omap_overlay_manager *mgr);
 int dss_mgr_enable(struct omap_overlay_manager *mgr);
 void dss_mgr_disable(struct omap_overlay_manager *mgr);
@@ -188,17 +187,6 @@ void dss_mgr_set_timings(struct omap_overlay_manager *mgr,
 void dss_mgr_set_lcd_config(struct omap_overlay_manager *mgr,
 		const struct dss_lcd_mgr_config *config);
 
-bool dss_ovl_is_enabled(struct omap_overlay *ovl);
-int dss_ovl_enable(struct omap_overlay *ovl);
-int dss_ovl_disable(struct omap_overlay *ovl);
-int dss_ovl_set_info(struct omap_overlay *ovl,
-		struct omap_overlay_info *info);
-void dss_ovl_get_info(struct omap_overlay *ovl,
-		struct omap_overlay_info *info);
-int dss_ovl_set_manager(struct omap_overlay *ovl,
-		struct omap_overlay_manager *mgr);
-int dss_ovl_unset_manager(struct omap_overlay *ovl);
-
 /* output */
 void dss_register_output(struct omap_dss_output *out);
 void dss_unregister_output(struct omap_dss_output *out);
diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index 45f4994..eccde32 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -38,13 +38,6 @@
 static int num_overlays;
 static struct omap_overlay *overlays;
 
-static inline struct omap_dss_device *dss_ovl_get_device(struct omap_overlay *ovl)
-{
-	return ovl->manager ?
-		(ovl->manager->output ? ovl->manager->output->device : NULL) :
-		NULL;
-}
-
 int omap_dss_get_num_overlays(void)
 {
 	return num_overlays;
@@ -93,16 +86,6 @@ void dss_init_overlays(struct platform_device *pdev)
 			break;
 		}
 
-		ovl->is_enabled = &dss_ovl_is_enabled;
-		ovl->enable = &dss_ovl_enable;
-		ovl->disable = &dss_ovl_disable;
-		ovl->set_manager = &dss_ovl_set_manager;
-		ovl->unset_manager = &dss_ovl_unset_manager;
-		ovl->set_overlay_info = &dss_ovl_set_info;
-		ovl->get_overlay_info = &dss_ovl_get_info;
-		ovl->wait_for_go = &dss_mgr_wait_for_go_ovl;
-		ovl->get_device = &dss_ovl_get_device;
-
 		ovl->caps = dss_feat_get_overlay_caps(ovl->id);
 		ovl->supported_modes =
 			dss_feat_get_supported_color_modes(ovl->id);
-- 
1.7.10.4

