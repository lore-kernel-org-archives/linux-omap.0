From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 19/65] OMAPDSS: apply affects only one overlay manager
Date: Tue, 22 Nov 2011 11:21:18 +0200
Message-ID: <1321953724-6350-20-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:33220 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757556Ab1KVJXS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:23:18 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

omap_dss_mgr_apply currently applies settings to all overlays and
overlay managers. The reason for this was to support cases where
configuration changes affecting multiple managers are made. However, the
current code doesn't support changing such configurations, so the
functionality is not needed.

Change the apply to affect only the manager given as an argument, and
the overlays attached to that manager.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/manager.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index 3aca2b4..5c120ac 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -1114,23 +1114,28 @@ static int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 	spin_lock_irqsave(&dss_cache.lock, flags);
 
 	/* Configure overlays */
-	for (i = 0; i < omap_dss_get_num_overlays(); ++i) {
+	for (i = 0; i < mgr->num_overlays; ++i) {
 		struct omap_overlay *ovl;
 
-		ovl = omap_dss_get_overlay(i);
+		ovl = mgr->overlays[i];
+
+		if (ovl->manager != mgr)
+			continue;
 
 		omap_dss_mgr_apply_ovl(ovl);
 	}
 
-	/* Configure managers */
-	list_for_each_entry(mgr, &manager_list, list)
-		omap_dss_mgr_apply_mgr(mgr);
+	/* Configure manager */
+	omap_dss_mgr_apply_mgr(mgr);
 
 	/* Configure overlay fifos */
-	for (i = 0; i < omap_dss_get_num_overlays(); ++i) {
+	for (i = 0; i < mgr->num_overlays; ++i) {
 		struct omap_overlay *ovl;
 
-		ovl = omap_dss_get_overlay(i);
+		ovl = mgr->overlays[i];
+
+		if (ovl->manager != mgr)
+			continue;
 
 		omap_dss_mgr_apply_ovl_fifos(ovl);
 	}
-- 
1.7.4.1

