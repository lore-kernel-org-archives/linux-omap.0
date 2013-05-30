From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 08/32] OMAPDSS: clean up dss_[ovl|mgr]_get_device()
Date: Thu, 30 May 2013 12:34:29 +0300
Message-ID: <1369906493-27538-9-git-send-email-tomi.valkeinen@ti.com>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49807 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030308Ab3E3Jfc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 May 2013 05:35:32 -0400
In-Reply-To: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Minor cleanup for the dss_[ovl|mgr]_get_device() functions to make them
more readable.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index a4b356a..b84bd99 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -420,16 +420,14 @@ static void wait_pending_extra_info_updates(void)
 		DSSWARN("timeout in wait_pending_extra_info_updates\n");
 }
 
-static inline struct omap_dss_device *dss_ovl_get_device(struct omap_overlay *ovl)
+static struct omap_dss_device *dss_mgr_get_device(struct omap_overlay_manager *mgr)
 {
-	return ovl->manager ?
-		(ovl->manager->output ? ovl->manager->output->device : NULL) :
-		NULL;
+	return mgr->output ? mgr->output->device : NULL;
 }
 
-static inline struct omap_dss_device *dss_mgr_get_device(struct omap_overlay_manager *mgr)
+static struct omap_dss_device *dss_ovl_get_device(struct omap_overlay *ovl)
 {
-	return mgr->output ? mgr->output->device : NULL;
+	return ovl->manager ? dss_mgr_get_device(ovl->manager) : NULL;
 }
 
 static int dss_mgr_wait_for_vsync(struct omap_overlay_manager *mgr)
-- 
1.8.1.2

