From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 25/65] OMAPDSS: APPLY: cleanup dss_start_update
Date: Tue, 22 Nov 2011 11:21:24 +0200
Message-ID: <1321953724-6350-26-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:51992 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757681Ab1KVJXc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:23:32 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

dss_start_update() has a loop, of which sole purpose is to find the
manager used for this update. The whole loop is extra, as we already
know the manager.

Remove the loop.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index cf68c9e..cfcf816 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -399,7 +399,6 @@ void dss_start_update(struct omap_overlay_manager *mgr)
 	struct manager_cache_data *mc;
 	struct overlay_cache_data *oc;
 	const int num_ovls = dss_feat_get_num_ovls();
-	const int num_mgrs = dss_feat_get_num_mgrs();
 	int i;
 
 	mc = &dss_cache.manager_cache[mgr->id];
@@ -416,13 +415,8 @@ void dss_start_update(struct omap_overlay_manager *mgr)
 		oc->shadow_dirty = false;
 	}
 
-	for (i = 0; i < num_mgrs; ++i) {
-		mc = &dss_cache.manager_cache[i];
-		if (mgr->id != i)
-			continue;
-
-		mc->shadow_dirty = false;
-	}
+	mc = &dss_cache.manager_cache[mgr->id];
+	mc->shadow_dirty = false;
 
 	dispc_mgr_enable(mgr->id, true);
 }
-- 
1.7.4.1

