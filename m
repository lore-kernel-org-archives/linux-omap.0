From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 22/65] OMAPDSS: APPLY: track whether a manager is enabled
Date: Tue, 22 Nov 2011 11:21:21 +0200
Message-ID: <1321953724-6350-23-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:39396 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757605Ab1KVJXY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:23:24 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add "enabled" field to struct omap_overlay_manager, which tells if the
output is enabled or not. This will be used in apply.c in the following
patches.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |    2 ++
 include/video/omapdss.h         |    2 ++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index ebc0ae1..9af5809 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -657,10 +657,12 @@ int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 void dss_mgr_enable(struct omap_overlay_manager *mgr)
 {
 	dispc_mgr_enable(mgr->id, true);
+	mgr->enabled = true;
 }
 
 void dss_mgr_disable(struct omap_overlay_manager *mgr)
 {
 	dispc_mgr_enable(mgr->id, false);
+	mgr->enabled = false;
 }
 
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 04741cd..d61efc3 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -432,6 +432,8 @@ struct omap_overlay_manager {
 	struct omap_dss_device *device;
 	struct omap_overlay_manager_info info;
 
+	bool enabled;
+
 	bool device_changed;
 	/* if true, info has been changed but not applied() yet */
 	bool info_dirty;
-- 
1.7.4.1

