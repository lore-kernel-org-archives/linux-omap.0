From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 18/32] OMAPDSS: move ovl-mgr function setup to apply.c
Date: Thu, 15 Nov 2012 17:58:26 +0200
Message-ID: <1352995120-3288-19-git-send-email-tomi.valkeinen@ti.com>
References: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56258 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1768251Ab2KOP7j (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Nov 2012 10:59:39 -0500
In-Reply-To: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, Rob Clark <rob@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

Most of the functions that are assigned to the fields in ovl-mgr struct
are in apply.c. By moving the function pointer setup into apply.c we can
make these functions static.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c   |   58 +++++++++++++++++++++++++++++++++----
 drivers/video/omap2/dss/dss.h     |   10 -------
 drivers/video/omap2/dss/manager.c |   39 -------------------------
 3 files changed, 52 insertions(+), 55 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 97e9b32..d103d11 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -416,7 +416,37 @@ static void wait_pending_extra_info_updates(void)
 		DSSWARN("timeout in wait_pending_extra_info_updates\n");
 }
 
-int dss_mgr_wait_for_go(struct omap_overlay_manager *mgr)
+static inline struct omap_dss_device *dss_mgr_get_device(struct omap_overlay_manager *mgr)
+{
+	return mgr->output ? mgr->output->device : NULL;
+}
+
+static int dss_mgr_wait_for_vsync(struct omap_overlay_manager *mgr)
+{
+	unsigned long timeout = msecs_to_jiffies(500);
+	struct omap_dss_device *dssdev = mgr->get_device(mgr);
+	u32 irq;
+	int r;
+
+	r = dispc_runtime_get();
+	if (r)
+		return r;
+
+	if (dssdev->type == OMAP_DISPLAY_TYPE_VENC)
+		irq = DISPC_IRQ_EVSYNC_ODD;
+	else if (dssdev->type == OMAP_DISPLAY_TYPE_HDMI)
+		irq = DISPC_IRQ_EVSYNC_EVEN;
+	else
+		irq = dispc_mgr_get_vsync_irq(mgr->id);
+
+	r = omap_dispc_wait_for_irq_interruptible_timeout(irq, timeout);
+
+	dispc_runtime_put();
+
+	return r;
+}
+
+static int dss_mgr_wait_for_go(struct omap_overlay_manager *mgr)
 {
 	unsigned long timeout = msecs_to_jiffies(500);
 	struct mgr_priv_data *mp = get_mgr_priv(mgr);
@@ -885,7 +915,7 @@ static void omap_dss_mgr_apply_mgr(struct omap_overlay_manager *mgr)
 	mp->info = mp->user_info;
 }
 
-int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
+static int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 {
 	unsigned long flags;
 	struct omap_overlay *ovl;
@@ -1058,7 +1088,7 @@ out:
 	mutex_unlock(&apply_lock);
 }
 
-int dss_mgr_set_info(struct omap_overlay_manager *mgr,
+static int dss_mgr_set_info(struct omap_overlay_manager *mgr,
 		struct omap_overlay_manager_info *info)
 {
 	struct mgr_priv_data *mp = get_mgr_priv(mgr);
@@ -1079,7 +1109,7 @@ int dss_mgr_set_info(struct omap_overlay_manager *mgr,
 	return 0;
 }
 
-void dss_mgr_get_info(struct omap_overlay_manager *mgr,
+static void dss_mgr_get_info(struct omap_overlay_manager *mgr,
 		struct omap_overlay_manager_info *info)
 {
 	struct mgr_priv_data *mp = get_mgr_priv(mgr);
@@ -1092,7 +1122,7 @@ void dss_mgr_get_info(struct omap_overlay_manager *mgr,
 	spin_unlock_irqrestore(&data_lock, flags);
 }
 
-int dss_mgr_set_output(struct omap_overlay_manager *mgr,
+static int dss_mgr_set_output(struct omap_overlay_manager *mgr,
 		struct omap_dss_output *output)
 {
 	int r;
@@ -1124,7 +1154,7 @@ err:
 	return r;
 }
 
-int dss_mgr_unset_output(struct omap_overlay_manager *mgr)
+static int dss_mgr_unset_output(struct omap_overlay_manager *mgr)
 {
 	int r;
 	struct mgr_priv_data *mp = get_mgr_priv(mgr);
@@ -1469,6 +1499,7 @@ static int compat_refcnt;
 int omapdss_compat_init(void)
 {
 	struct platform_device *pdev = dss_get_core_pdev();
+	int i;
 
 	mutex_lock(&apply_lock);
 
@@ -1480,6 +1511,21 @@ int omapdss_compat_init(void)
 	dss_init_overlay_managers(pdev);
 	dss_init_overlays(pdev);
 
+	for (i = 0; i < omap_dss_get_num_overlay_managers(); i++) {
+		struct omap_overlay_manager *mgr;
+
+		mgr = omap_dss_get_overlay_manager(i);
+
+		mgr->set_output = &dss_mgr_set_output;
+		mgr->unset_output = &dss_mgr_unset_output;
+		mgr->apply = &omap_dss_mgr_apply;
+		mgr->set_manager_info = &dss_mgr_set_info;
+		mgr->get_manager_info = &dss_mgr_get_info;
+		mgr->wait_for_go = &dss_mgr_wait_for_go;
+		mgr->wait_for_vsync = &dss_mgr_wait_for_vsync;
+		mgr->get_device = &dss_mgr_get_device;
+	}
+
 out:
 	mutex_unlock(&apply_lock);
 
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 9cbcd8e..4a8f2bb 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -179,20 +179,10 @@ void dss_copy_device_pdata(struct omap_dss_device *dst,
 		const struct omap_dss_device *src);
 
 /* apply */
-int dss_mgr_wait_for_go(struct omap_overlay_manager *mgr);
 int dss_mgr_wait_for_go_ovl(struct omap_overlay *ovl);
 void dss_mgr_start_update(struct omap_overlay_manager *mgr);
-int omap_dss_mgr_apply(struct omap_overlay_manager *mgr);
-
 int dss_mgr_enable(struct omap_overlay_manager *mgr);
 void dss_mgr_disable(struct omap_overlay_manager *mgr);
-int dss_mgr_set_info(struct omap_overlay_manager *mgr,
-		struct omap_overlay_manager_info *info);
-void dss_mgr_get_info(struct omap_overlay_manager *mgr,
-		struct omap_overlay_manager_info *info);
-int dss_mgr_set_output(struct omap_overlay_manager *mgr,
-		struct omap_dss_output *output);
-int dss_mgr_unset_output(struct omap_overlay_manager *mgr);
 void dss_mgr_set_timings(struct omap_overlay_manager *mgr,
 		const struct omap_video_timings *timings);
 void dss_mgr_set_lcd_config(struct omap_overlay_manager *mgr,
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index c54d2f6..2551eaa 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -36,36 +36,6 @@
 static int num_managers;
 static struct omap_overlay_manager *managers;
 
-static inline struct omap_dss_device *dss_mgr_get_device(struct omap_overlay_manager *mgr)
-{
-	return mgr->output ? mgr->output->device : NULL;
-}
-
-static int dss_mgr_wait_for_vsync(struct omap_overlay_manager *mgr)
-{
-	unsigned long timeout = msecs_to_jiffies(500);
-	struct omap_dss_device *dssdev = mgr->get_device(mgr);
-	u32 irq;
-	int r;
-
-	r = dispc_runtime_get();
-	if (r)
-		return r;
-
-	if (dssdev->type == OMAP_DISPLAY_TYPE_VENC)
-		irq = DISPC_IRQ_EVSYNC_ODD;
-	else if (dssdev->type == OMAP_DISPLAY_TYPE_HDMI)
-		irq = DISPC_IRQ_EVSYNC_EVEN;
-	else
-		irq = dispc_mgr_get_vsync_irq(mgr->id);
-
-	r = omap_dispc_wait_for_irq_interruptible_timeout(irq, timeout);
-
-	dispc_runtime_put();
-
-	return r;
-}
-
 int dss_init_overlay_managers(struct platform_device *pdev)
 {
 	int i, r;
@@ -99,15 +69,6 @@ int dss_init_overlay_managers(struct platform_device *pdev)
 			break;
 		}
 
-		mgr->set_output = &dss_mgr_set_output;
-		mgr->unset_output = &dss_mgr_unset_output;
-		mgr->apply = &omap_dss_mgr_apply;
-		mgr->set_manager_info = &dss_mgr_set_info;
-		mgr->get_manager_info = &dss_mgr_get_info;
-		mgr->wait_for_go = &dss_mgr_wait_for_go;
-		mgr->wait_for_vsync = &dss_mgr_wait_for_vsync;
-		mgr->get_device = &dss_mgr_get_device;
-
 		mgr->caps = 0;
 		mgr->supported_displays =
 			dss_feat_get_supported_displays(mgr->id);
-- 
1.7.10.4

