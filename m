From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 43/65] OMAPDSS: APPLY: move mgr->enabled to mgr_priv_data
Date: Tue, 22 Nov 2011 11:21:42 +0200
Message-ID: <1321953724-6350-44-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:47147 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757693Ab1KVJYK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:24:10 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

struct omap_overlay_manager contains "enabled"-field, used to track if
the manager is enabled or not. This field should be internal to apply.c.

This patch moves the field to mgr_priv_data, and applies the necessary
locking when accessing the field.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |   26 +++++++++++++++++++++++---
 include/video/omapdss.h         |    2 --
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 66f4c56..c38bd76 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -86,6 +86,9 @@ struct mgr_priv_data {
 
 	bool manual_update;
 	bool do_manual_update;
+
+	/* If true, a display is enabled using this manager */
+	bool enabled;
 };
 
 static struct {
@@ -609,6 +612,7 @@ int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 	int r;
 	unsigned long flags;
 	struct omap_overlay *ovl;
+	struct mgr_priv_data *mp = get_mgr_priv(mgr);
 
 	DSSDBG("omap_dss_mgr_apply(%s)\n", mgr->name);
 
@@ -630,7 +634,7 @@ int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 		omap_dss_mgr_apply_ovl_fifos(ovl);
 
 	r = 0;
-	if (mgr->enabled && !mgr_manual_update(mgr)) {
+	if (mp->enabled && !mgr_manual_update(mgr)) {
 		if (!dss_data.irq_enabled)
 			dss_register_vsync_isr();
 
@@ -646,22 +650,38 @@ int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 
 void dss_mgr_enable(struct omap_overlay_manager *mgr)
 {
+	struct mgr_priv_data *mp = get_mgr_priv(mgr);
+	unsigned long flags;
+
 	mutex_lock(&apply_lock);
 
 	if (!mgr_manual_update(mgr))
 		dispc_mgr_enable(mgr->id, true);
-	mgr->enabled = true;
+
+	spin_lock_irqsave(&data_lock, flags);
+
+	mp->enabled = true;
+
+	spin_unlock_irqrestore(&data_lock, flags);
 
 	mutex_unlock(&apply_lock);
 }
 
 void dss_mgr_disable(struct omap_overlay_manager *mgr)
 {
+	struct mgr_priv_data *mp = get_mgr_priv(mgr);
+	unsigned long flags;
+
 	mutex_lock(&apply_lock);
 
 	if (!mgr_manual_update(mgr))
 		dispc_mgr_enable(mgr->id, false);
-	mgr->enabled = false;
+
+	spin_lock_irqsave(&data_lock, flags);
+
+	mp->enabled = false;
+
+	spin_unlock_irqrestore(&data_lock, flags);
 
 	mutex_unlock(&apply_lock);
 }
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 25ef771..6e3e7a7 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -430,8 +430,6 @@ struct omap_overlay_manager {
 	struct omap_dss_device *device;
 	struct omap_overlay_manager_info info;
 
-	bool enabled;
-
 	bool device_changed;
 	/* if true, info has been changed but not applied() yet */
 	bool info_dirty;
-- 
1.7.4.1

