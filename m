From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 02/65] OMAPDSS: Remove old fifomerge hacks
Date: Tue, 22 Nov 2011 11:21:01 +0200
Message-ID: <1321953724-6350-3-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:51211 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755482Ab1KVJWh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:22:37 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Once in a time omapdss had basic support for fifomerge. Fifomerge was
removed as the implementation didn't work properly, and a proper
implementation is a complex problem.

However, some unused fifo-merge related code was left behind. This patch
removes those.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/manager.c |   26 +-------------------------
 1 files changed, 1 insertions(+), 25 deletions(-)

diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index 6e63845..1be5f47 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -1313,8 +1313,6 @@ static int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 	struct manager_cache_data *mc;
 	int i;
 	struct omap_overlay *ovl;
-	int num_planes_enabled = 0;
-	bool use_fifomerge;
 	unsigned long flags;
 	int r;
 
@@ -1347,11 +1345,8 @@ static int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 			continue;
 		}
 
-		if (!ovl->info_dirty) {
-			if (oc->enabled)
-				++num_planes_enabled;
+		if (!ovl->info_dirty)
 			continue;
-		}
 
 		dssdev = ovl->manager->device;
 
@@ -1375,8 +1370,6 @@ static int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 		oc->channel = ovl->manager->id;
 
 		oc->enabled = true;
-
-		++num_planes_enabled;
 	}
 
 	/* Configure managers */
@@ -1406,21 +1399,6 @@ static int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 			dssdev->caps & OMAP_DSS_DISPLAY_CAP_MANUAL_UPDATE;
 	}
 
-	/* XXX TODO: Try to get fifomerge working. The problem is that it
-	 * affects both managers, not individually but at the same time. This
-	 * means the change has to be well synchronized. I guess the proper way
-	 * is to have a two step process for fifo merge:
-	 *        fifomerge enable:
-	 *             1. disable other planes, leaving one plane enabled
-	 *             2. wait until the planes are disabled on HW
-	 *             3. config merged fifo thresholds, enable fifomerge
-	 *        fifomerge disable:
-	 *             1. config unmerged fifo thresholds, disable fifomerge
-	 *             2. wait until fifo changes are in HW
-	 *             3. enable planes
-	 */
-	use_fifomerge = false;
-
 	/* Configure overlay fifos */
 	for (i = 0; i < omap_dss_get_num_overlays(); ++i) {
 		struct omap_dss_device *dssdev;
@@ -1436,8 +1414,6 @@ static int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 		dssdev = ovl->manager->device;
 
 		size = dispc_ovl_get_fifo_size(ovl->id);
-		if (use_fifomerge)
-			size *= 3;
 
 		burst_size = dispc_ovl_get_burst_size(ovl->id);
 
-- 
1.7.4.1

