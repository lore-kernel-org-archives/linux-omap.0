From: Archit Taneja <archit@ti.com>
Subject: [PATCH 2/3] OMAPDSS: APPLY: Remove omap_dss_device references in wait_for_go functions
Date: Fri, 17 Aug 2012 16:19:10 +0530
Message-ID: <1345200551-28712-3-git-send-email-archit@ti.com>
References: <343817088-29645-1-git-send-email-archit@ti.com>
 <1345200551-28712-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52276 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757824Ab2HQKux (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Aug 2012 06:50:53 -0400
In-Reply-To: <1345200551-28712-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The functions dss_mgr_wait_for_go() and dss_mgr_wait_for_go_ovl() check if there
is an enabled display connected to the manager before trying to see the state of
the GO bit.

The checks related to the display can be replaced by checking the state of the
manager, i.e, whether the manager is enabled or not. This makes more sense than
checking with the connected display as the GO bit behaviour is more connected
with the manager state rather than the display state. A GO bit can only be set
if the manager is enabled. If a manager isn't enabled, we can safely assume that
the GO bit is not set.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/apply.c |   32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 52a5940..74f1a58 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -424,17 +424,23 @@ static void wait_pending_extra_info_updates(void)
 int dss_mgr_wait_for_go(struct omap_overlay_manager *mgr)
 {
 	unsigned long timeout = msecs_to_jiffies(500);
-	struct mgr_priv_data *mp;
+	struct mgr_priv_data *mp = get_mgr_priv(mgr);
 	u32 irq;
+	unsigned long flags;
 	int r;
 	int i;
-	struct omap_dss_device *dssdev = mgr->device;
 
-	if (!dssdev || dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
+	if (mgr_manual_update(mgr))
 		return 0;
 
-	if (mgr_manual_update(mgr))
+	spin_lock_irqsave(&data_lock, flags);
+
+	if (!mp->enabled) {
+		spin_unlock_irqrestore(&data_lock, flags);
 		return 0;
+	}
+
+	spin_unlock_irqrestore(&data_lock, flags);
 
 	r = dispc_runtime_get();
 	if (r)
@@ -442,10 +448,8 @@ int dss_mgr_wait_for_go(struct omap_overlay_manager *mgr)
 
 	irq = dispc_mgr_get_vsync_irq(mgr->id);
 
-	mp = get_mgr_priv(mgr);
 	i = 0;
 	while (1) {
-		unsigned long flags;
 		bool shadow_dirty, dirty;
 
 		spin_lock_irqsave(&data_lock, flags);
@@ -489,21 +493,28 @@ int dss_mgr_wait_for_go_ovl(struct omap_overlay *ovl)
 {
 	unsigned long timeout = msecs_to_jiffies(500);
 	struct ovl_priv_data *op;
-	struct omap_dss_device *dssdev;
+	struct mgr_priv_data *mp;
 	u32 irq;
+	unsigned long flags;
 	int r;
 	int i;
 
 	if (!ovl->manager)
 		return 0;
 
-	dssdev = ovl->manager->device;
+	mp = get_mgr_priv(ovl->manager);
 
-	if (!dssdev || dssdev->state != OMAP_DSS_DISPLAY_ACTIVE)
+	if (ovl_manual_update(ovl))
 		return 0;
 
-	if (ovl_manual_update(ovl))
+	spin_lock_irqsave(&data_lock, flags);
+
+	if (!mp->enabled) {
+		spin_unlock_irqrestore(&data_lock, flags);
 		return 0;
+	}
+
+	spin_unlock_irqrestore(&data_lock, flags);
 
 	r = dispc_runtime_get();
 	if (r)
@@ -514,7 +525,6 @@ int dss_mgr_wait_for_go_ovl(struct omap_overlay *ovl)
 	op = get_ovl_priv(ovl);
 	i = 0;
 	while (1) {
-		unsigned long flags;
 		bool shadow_dirty, dirty;
 
 		spin_lock_irqsave(&data_lock, flags);
-- 
1.7.9.5

