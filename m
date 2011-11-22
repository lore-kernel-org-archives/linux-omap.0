From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 29/65] OMAPDSS: APPLY: separate vsync isr register/unregister
Date: Tue, 22 Nov 2011 11:21:28 +0200
Message-ID: <1321953724-6350-30-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:58376 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757742Ab1KVJXk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:23:40 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Create separate functions for the vsync isr register/unregister code for
cleaner code.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |   61 +++++++++++++++++++++++---------------
 1 files changed, 37 insertions(+), 24 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index cca5732..6aad0fd 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -417,6 +417,40 @@ void dss_start_update(struct omap_overlay_manager *mgr)
 	dispc_mgr_enable(mgr->id, true);
 }
 
+static void dss_apply_irq_handler(void *data, u32 mask);
+
+static void dss_register_vsync_isr(void)
+{
+	u32 mask;
+	int r;
+
+	mask = DISPC_IRQ_VSYNC	| DISPC_IRQ_EVSYNC_ODD |
+		DISPC_IRQ_EVSYNC_EVEN;
+	if (dss_has_feature(FEAT_MGR_LCD2))
+		mask |= DISPC_IRQ_VSYNC2;
+
+	r = omap_dispc_register_isr(dss_apply_irq_handler, NULL, mask);
+	WARN_ON(r);
+
+	dss_cache.irq_enabled = true;
+}
+
+static void dss_unregister_vsync_isr(void)
+{
+	u32 mask;
+	int r;
+
+	mask = DISPC_IRQ_VSYNC | DISPC_IRQ_EVSYNC_ODD |
+			DISPC_IRQ_EVSYNC_EVEN;
+	if (dss_has_feature(FEAT_MGR_LCD2))
+		mask |= DISPC_IRQ_VSYNC2;
+
+	r = omap_dispc_unregister_isr(dss_apply_irq_handler, NULL, mask);
+	WARN_ON(r);
+
+	dss_cache.irq_enabled = false;
+}
+
 static void dss_apply_irq_handler(void *data, u32 mask)
 {
 	struct manager_cache_data *mc;
@@ -425,7 +459,6 @@ static void dss_apply_irq_handler(void *data, u32 mask)
 	const int num_mgrs = dss_feat_get_num_mgrs();
 	int i, r;
 	bool mgr_busy[MAX_DSS_MANAGERS];
-	u32 irq_mask;
 
 	for (i = 0; i < num_mgrs; i++)
 		mgr_busy[i] = dispc_mgr_go_busy(i);
@@ -459,13 +492,7 @@ static void dss_apply_irq_handler(void *data, u32 mask)
 			goto end;
 	}
 
-	irq_mask = DISPC_IRQ_VSYNC | DISPC_IRQ_EVSYNC_ODD |
-			DISPC_IRQ_EVSYNC_EVEN;
-	if (dss_has_feature(FEAT_MGR_LCD2))
-		irq_mask |= DISPC_IRQ_VSYNC2;
-
-	omap_dispc_unregister_isr(dss_apply_irq_handler, NULL, irq_mask);
-	dss_cache.irq_enabled = false;
+	dss_unregister_vsync_isr();
 
 end:
 	spin_unlock(&dss_cache.lock);
@@ -605,22 +632,8 @@ int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 
 	r = 0;
 	if (mgr->enabled && !mgr_manual_update(mgr)) {
-		if (!dss_cache.irq_enabled) {
-			u32 mask;
-
-			mask = DISPC_IRQ_VSYNC	| DISPC_IRQ_EVSYNC_ODD |
-				DISPC_IRQ_EVSYNC_EVEN;
-			if (dss_has_feature(FEAT_MGR_LCD2))
-				mask |= DISPC_IRQ_VSYNC2;
-
-			r = omap_dispc_register_isr(dss_apply_irq_handler,
-					NULL, mask);
-
-			if (r)
-				DSSERR("failed to register apply isr\n");
-
-			dss_cache.irq_enabled = true;
-		}
+		if (!dss_cache.irq_enabled)
+			dss_register_vsync_isr();
 
 		configure_dispc();
 	}
-- 
1.7.4.1

