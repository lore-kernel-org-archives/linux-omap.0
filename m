From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 44/65] OMAPDSS: APPLY: add busy field to mgr_priv_data
Date: Tue, 22 Nov 2011 11:21:43 +0200
Message-ID: <1321953724-6350-45-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:36819 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757932Ab1KVJYN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:24:13 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add a new field to mgr_priv data, "busy", which is used to track the
status of GO bit with the manager. As manual update displays never use
the GO bit, the field is always false for managers used for manual
update displays.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |   55 +++++++++++++++++++++++++-------------
 1 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index c38bd76..323cffa 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -87,6 +87,10 @@ struct mgr_priv_data {
 	bool manual_update;
 	bool do_manual_update;
 
+	/* If true, GO bit is up and shadow registers cannot be written.
+	 * Never true for manual update displays */
+	bool busy;
+
 	/* If true, a display is enabled using this manager */
 	bool enabled;
 };
@@ -319,18 +323,12 @@ static int dss_write_regs(void)
 	const int num_mgrs = dss_feat_get_num_mgrs();
 	int i;
 	int r;
-	bool mgr_busy[MAX_DSS_MANAGERS];
-	bool mgr_go[MAX_DSS_MANAGERS];
+	bool mgr_go[MAX_DSS_MANAGERS] = { false };
 	bool busy;
 
 	r = 0;
 	busy = false;
 
-	for (i = 0; i < num_mgrs; i++) {
-		mgr_busy[i] = dispc_mgr_go_busy(i);
-		mgr_go[i] = false;
-	}
-
 	/* Commit overlay settings */
 	for (i = 0; i < num_ovls; ++i) {
 		ovl = omap_dss_get_overlay(i);
@@ -344,7 +342,7 @@ static int dss_write_regs(void)
 		if (mp->manual_update && !mp->do_manual_update)
 			continue;
 
-		if (mgr_busy[op->channel]) {
+		if (mp->busy) {
 			busy = true;
 			continue;
 		}
@@ -369,7 +367,7 @@ static int dss_write_regs(void)
 		if (mp->manual_update && !mp->do_manual_update)
 			continue;
 
-		if (mgr_busy[i]) {
+		if (mp->busy) {
 			busy = true;
 			continue;
 		}
@@ -391,8 +389,10 @@ static int dss_write_regs(void)
 		/* We don't need GO with manual update display. LCD iface will
 		 * always be turned off after frame, and new settings will be
 		 * taken in to use at next update */
-		if (!mp->manual_update)
+		if (!mp->manual_update) {
+			mp->busy = true;
 			dispc_mgr_go(i);
+		}
 	}
 
 	if (busy)
@@ -471,24 +471,34 @@ static void dss_apply_irq_handler(void *data, u32 mask)
 	const int num_ovls = dss_feat_get_num_ovls();
 	const int num_mgrs = dss_feat_get_num_mgrs();
 	int i, r;
-	bool mgr_busy[MAX_DSS_MANAGERS];
-
-	for (i = 0; i < num_mgrs; i++)
-		mgr_busy[i] = dispc_mgr_go_busy(i);
 
 	spin_lock(&data_lock);
 
+	for (i = 0; i < num_mgrs; i++) {
+		mgr = omap_dss_get_overlay_manager(i);
+		mp = get_mgr_priv(mgr);
+
+		mp->busy = dispc_mgr_go_busy(i);
+	}
+
 	for (i = 0; i < num_ovls; ++i) {
 		ovl = omap_dss_get_overlay(i);
 		op = get_ovl_priv(ovl);
-		if (!mgr_busy[op->channel])
+
+		if (!op->enabled)
+			continue;
+
+		mp = get_mgr_priv(ovl->manager);
+
+		if (!mp->busy)
 			op->shadow_dirty = false;
 	}
 
 	for (i = 0; i < num_mgrs; ++i) {
 		mgr = omap_dss_get_overlay_manager(i);
 		mp = get_mgr_priv(mgr);
-		if (!mgr_busy[i])
+
+		if (!mp->busy)
 			mp->shadow_dirty = false;
 	}
 
@@ -497,13 +507,20 @@ static void dss_apply_irq_handler(void *data, u32 mask)
 		goto end;
 
 	/* re-read busy flags */
-	for (i = 0; i < num_mgrs; i++)
-		mgr_busy[i] = dispc_mgr_go_busy(i);
+	for (i = 0; i < num_mgrs; i++) {
+		mgr = omap_dss_get_overlay_manager(i);
+		mp = get_mgr_priv(mgr);
+
+		mp->busy = dispc_mgr_go_busy(i);
+	}
 
 	/* keep running as long as there are busy managers, so that
 	 * we can collect overlay-applied information */
 	for (i = 0; i < num_mgrs; ++i) {
-		if (mgr_busy[i])
+		mgr = omap_dss_get_overlay_manager(i);
+		mp = get_mgr_priv(mgr);
+
+		if (mp->busy)
 			goto end;
 	}
 
-- 
1.7.4.1

