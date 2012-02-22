From: Archit Taneja <archit@ti.com>
Subject: [PATCH v2 3/3] OMAPDSS: MANAGER/APPLY: Add runtime_pm protection around wait_for_go/vsync functions
Date: Wed, 22 Feb 2012 12:23:16 +0530
Message-ID: <1329893596-4287-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42298 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751676Ab2BVGxa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Feb 2012 01:53:30 -0500
Received: from dlep26.itg.ti.com ([157.170.170.121])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id q1M6rU3B003362
	for <linux-omap@vger.kernel.org>; Wed, 22 Feb 2012 00:53:30 -0600
Received: from DLEE74.ent.ti.com (localhost [127.0.0.1])
	by dlep26.itg.ti.com (8.13.8/8.13.8) with ESMTP id q1M6rUko015929
	for <linux-omap@vger.kernel.org>; Wed, 22 Feb 2012 00:53:30 -0600 (CST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: lajos@ti.com, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

From: Lajos Molnar <lajos@ti.com>

If DSS suspends within the functions dss_mgr_wait_for_go(),
dss_mgr_wait_for_go_ovl() or dss_mgr_wait_for_vsync(). It may lose it's clock
and lead to a register access failure.

Request runtime_pm around these functions.

[archit@ti.com: Moved runtime_pm calls to wait_for_go/vsync functions rather
then calling them from omap_dispc_wait_for_irq_interruptible_timeout()]

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/apply.c   |   12 ++++++++++++
 drivers/video/omap2/dss/manager.c |   12 +++++++++++-
 2 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index b0264a1..f145e9c 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -391,6 +391,10 @@ int dss_mgr_wait_for_go(struct omap_overlay_manager *mgr)
 	if (mgr_manual_update(mgr))
 		return 0;
 
+	r = dispc_runtime_get();
+	if (r)
+		return r;
+
 	irq = dispc_mgr_get_vsync_irq(mgr->id);
 
 	mp = get_mgr_priv(mgr);
@@ -431,6 +435,8 @@ int dss_mgr_wait_for_go(struct omap_overlay_manager *mgr)
 		}
 	}
 
+	dispc_runtime_put();
+
 	return r;
 }
 
@@ -454,6 +460,10 @@ int dss_mgr_wait_for_go_ovl(struct omap_overlay *ovl)
 	if (ovl_manual_update(ovl))
 		return 0;
 
+	r = dispc_runtime_get();
+	if (r)
+		return r;
+
 	irq = dispc_mgr_get_vsync_irq(ovl->manager->id);
 
 	op = get_ovl_priv(ovl);
@@ -494,6 +504,8 @@ int dss_mgr_wait_for_go_ovl(struct omap_overlay *ovl)
 		}
 	}
 
+	dispc_runtime_put();
+
 	return r;
 }
 
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index d1858e7..e736460 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -494,6 +494,11 @@ static int dss_mgr_wait_for_vsync(struct omap_overlay_manager *mgr)
 {
 	unsigned long timeout = msecs_to_jiffies(500);
 	u32 irq;
+	int r;
+
+	r = dispc_runtime_get();
+	if (r)
+		return r;
 
 	if (mgr->device->type == OMAP_DISPLAY_TYPE_VENC) {
 		irq = DISPC_IRQ_EVSYNC_ODD;
@@ -505,7 +510,12 @@ static int dss_mgr_wait_for_vsync(struct omap_overlay_manager *mgr)
 		else
 			irq = DISPC_IRQ_VSYNC2;
 	}
-	return omap_dispc_wait_for_irq_interruptible_timeout(irq, timeout);
+
+	r = omap_dispc_wait_for_irq_interruptible_timeout(irq, timeout);
+
+	dispc_runtime_put();
+
+	return r;
 }
 
 int dss_init_overlay_managers(struct platform_device *pdev)
-- 
1.7.5.4

