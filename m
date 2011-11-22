From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 52/65] OMAPDSS: APPLY: move channel-field to extra_info set
Date: Tue, 22 Nov 2011 11:21:51 +0200
Message-ID: <1321953724-6350-53-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:47634 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758183Ab1KVJYe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:24:34 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Setting overlay's output channel is currently handled at the same time
as other overlay attributes. This is not right, as the normal attributes
should only affect one overlay and manager, but changing the channel
affects two managers.

This patch moves the channel field into the "extra_info" set, handled
together with enabled-status.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |   21 +++++++--------------
 include/video/omapdss.h         |    2 --
 2 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index eac0041..3e345d7 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -69,8 +69,6 @@ struct ovl_priv_data {
 
 	struct omap_overlay_info info;
 
-	enum omap_channel channel;
-
 	u32 fifo_low;
 	u32 fifo_high;
 
@@ -78,7 +76,7 @@ struct ovl_priv_data {
 	bool shadow_extra_info_dirty;
 
 	bool enabled;
-
+	enum omap_channel channel;
 };
 
 struct mgr_priv_data {
@@ -384,8 +382,6 @@ static void dss_ovl_write_regs(struct omap_overlay *ovl)
 
 	ilace = ovl->manager->device->type == OMAP_DISPLAY_TYPE_VENC;
 
-	dispc_ovl_set_channel_out(ovl->id, op->channel);
-
 	r = dispc_ovl_setup(ovl->id, oi, ilace, replication);
 	if (r) {
 		/*
@@ -423,6 +419,7 @@ static void dss_ovl_write_regs_extra(struct omap_overlay *ovl)
 	 * disabled */
 
 	dispc_ovl_enable(ovl->id, op->enabled);
+	dispc_ovl_set_channel_out(ovl->id, op->channel);
 
 	mp = get_mgr_priv(ovl->manager);
 
@@ -608,19 +605,12 @@ static void omap_dss_mgr_apply_ovl(struct omap_overlay *ovl)
 
 	op = get_ovl_priv(ovl);
 
-	if (ovl->manager_changed) {
-		ovl->manager_changed = false;
-		op->user_info_dirty  = true;
-	}
-
 	if (!op->user_info_dirty)
 		return;
 
 	op->user_info_dirty = false;
 	op->dirty = true;
 	op->info = op->user_info;
-
-	op->channel = ovl->manager->id;
 }
 
 static void omap_dss_mgr_apply_mgr(struct omap_overlay_manager *mgr)
@@ -910,9 +900,11 @@ int dss_ovl_set_manager(struct omap_overlay *ovl,
 		goto err;
 	}
 
+	op->channel = mgr->id;
+	op->extra_info_dirty = true;
+
 	ovl->manager = mgr;
 	list_add_tail(&ovl->list, &mgr->overlays);
-	ovl->manager_changed = true;
 
 	spin_unlock_irqrestore(&data_lock, flags);
 
@@ -960,9 +952,10 @@ int dss_ovl_unset_manager(struct omap_overlay *ovl)
 		goto err;
 	}
 
+	op->channel = -1;
+
 	ovl->manager = NULL;
 	list_del(&ovl->list);
-	ovl->manager_changed = true;
 
 	spin_unlock_irqrestore(&data_lock, flags);
 
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 2e2c53f..e629b0d 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -384,8 +384,6 @@ struct omap_overlay {
 	/* dynamic fields */
 	struct omap_overlay_manager *manager;
 
-	bool manager_changed;
-
 	int (*enable)(struct omap_overlay *ovl);
 	int (*disable)(struct omap_overlay *ovl);
 	bool (*is_enabled)(struct omap_overlay *ovl);
-- 
1.7.4.1

