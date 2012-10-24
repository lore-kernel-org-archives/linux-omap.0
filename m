From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 19/20] OMAPDSS: DISPC: remove dssdev depependency from error handler
Date: Wed, 24 Oct 2012 12:29:10 +0300
Message-ID: <1351070951-18616-20-git-send-email-tomi.valkeinen@ti.com>
References: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35492 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934527Ab2JXJ3y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Oct 2012 05:29:54 -0400
In-Reply-To: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The dispc error handler tries to "fix" issues by disabling and enabling
panel. This is problematic, as we're trying to remove the dependency
from omapdss to the omap_dss_devices. It's also racy, and doesn't really
fix anything.

This patch removes the use of omap_dss_device from the error handler,
and just disables and enables the associated overlay manager. This
should produce similar results as the previous solution, without using
dssdev.

However, the error handling is still horrible. But the problem boils
down to one question, to which I don't have a clear answer: what to do
when a HW error happens?

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 070ce30..61b48ca 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3902,15 +3902,12 @@ static void dispc_error_worker(struct work_struct *work)
 
 		if (bit & errors) {
 			int j;
-			struct omap_dss_device *dssdev = mgr->get_device(mgr);
-			bool enable;
 
 			DSSERR("SYNC_LOST on channel %s, restarting the output "
 					"with video overlays disabled\n",
 					mgr->name);
 
-			enable = dssdev->state == OMAP_DSS_DISPLAY_ACTIVE;
-			dssdev->driver->disable(dssdev);
+			dss_mgr_disable(mgr);
 
 			for (j = 0; j < omap_dss_get_num_overlays(); ++j) {
 				struct omap_overlay *ovl;
@@ -3918,14 +3915,10 @@ static void dispc_error_worker(struct work_struct *work)
 
 				if (ovl->id != OMAP_DSS_GFX &&
 						ovl->manager == mgr)
-					dispc_ovl_enable(ovl->id, false);
+					dss_ovl_disable(ovl);
 			}
 
-			dispc_mgr_go(mgr->id);
-			msleep(50);
-
-			if (enable)
-				dssdev->driver->enable(dssdev);
+			dss_mgr_enable(mgr);
 		}
 	}
 
@@ -3933,13 +3926,9 @@ static void dispc_error_worker(struct work_struct *work)
 		DSSERR("OCP_ERR\n");
 		for (i = 0; i < omap_dss_get_num_overlay_managers(); ++i) {
 			struct omap_overlay_manager *mgr;
-			struct omap_dss_device *dssdev;
 
 			mgr = omap_dss_get_overlay_manager(i);
-			dssdev = mgr->get_device(mgr);
-
-			if (dssdev && dssdev->driver)
-				dssdev->driver->disable(dssdev);
+			dss_mgr_disable(mgr);
 		}
 	}
 
-- 
1.7.9.5

