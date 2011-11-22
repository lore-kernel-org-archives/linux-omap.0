From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 57/65] OMAPDSS: APPLY: skip enable/disable if already enabled/disabled
Date: Tue, 22 Nov 2011 11:21:56 +0200
Message-ID: <1321953724-6350-58-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:52609 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758216Ab1KVJYm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:24:42 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add checks to dss_mgr_enable, dss_mgr_disable, dss_ovl_enable,
dss_ovl_disable that check if the state is already the same as given in
the parameters, and exit if so.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index cfc17c0..76b5b02 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -724,6 +724,9 @@ void dss_mgr_enable(struct omap_overlay_manager *mgr)
 
 	mutex_lock(&apply_lock);
 
+	if (mp->enabled)
+		goto out;
+
 	spin_lock_irqsave(&data_lock, flags);
 
 	mp->enabled = true;
@@ -740,6 +743,7 @@ void dss_mgr_enable(struct omap_overlay_manager *mgr)
 	if (!mgr_manual_update(mgr))
 		dispc_mgr_enable(mgr->id, true);
 
+out:
 	mutex_unlock(&apply_lock);
 }
 
@@ -750,6 +754,9 @@ void dss_mgr_disable(struct omap_overlay_manager *mgr)
 
 	mutex_lock(&apply_lock);
 
+	if (!mp->enabled)
+		goto out;
+
 	if (!mgr_manual_update(mgr))
 		dispc_mgr_enable(mgr->id, false);
 
@@ -760,6 +767,7 @@ void dss_mgr_disable(struct omap_overlay_manager *mgr)
 
 	spin_unlock_irqrestore(&data_lock, flags);
 
+out:
 	mutex_unlock(&apply_lock);
 }
 
@@ -1005,6 +1013,11 @@ int dss_ovl_enable(struct omap_overlay *ovl)
 
 	mutex_lock(&apply_lock);
 
+	if (op->enabled) {
+		r = 0;
+		goto err;
+	}
+
 	if (ovl->manager == NULL || ovl->manager->device == NULL) {
 		r = -EINVAL;
 		goto err;
@@ -1036,6 +1049,11 @@ int dss_ovl_disable(struct omap_overlay *ovl)
 
 	mutex_lock(&apply_lock);
 
+	if (!op->enabled) {
+		r = 0;
+		goto err;
+	}
+
 	if (ovl->manager == NULL || ovl->manager->device == NULL) {
 		r = -EINVAL;
 		goto err;
-- 
1.7.4.1

