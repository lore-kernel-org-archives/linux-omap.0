From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 59/65] OMAPDSS: APPLY: remove runtime_get
Date: Tue, 22 Nov 2011 11:21:58 +0200
Message-ID: <1321953724-6350-60-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:57716 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758231Ab1KVJYr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:24:47 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

apply.c no longer touches any registers if an output is not enabled.
This means that we don't need to do dispc_runtime_get() anymore, and the
calls can be removed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 75db522..6a50ee0 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -688,16 +688,11 @@ static void omap_dss_mgr_apply_mgr(struct omap_overlay_manager *mgr)
 
 int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 {
-	int r;
 	unsigned long flags;
 	struct omap_overlay *ovl;
 
 	DSSDBG("omap_dss_mgr_apply(%s)\n", mgr->name);
 
-	r = dispc_runtime_get();
-	if (r)
-		return r;
-
 	spin_lock_irqsave(&data_lock, flags);
 
 	/* Configure overlays */
@@ -711,9 +706,7 @@ int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 
 	spin_unlock_irqrestore(&data_lock, flags);
 
-	dispc_runtime_put();
-
-	return r;
+	return 0;
 }
 
 static void dss_apply_ovl_enable(struct omap_overlay *ovl, bool enable)
-- 
1.7.4.1

