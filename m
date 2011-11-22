From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 58/65] OMAPDSS: APPLY: add wait_pending_extra_info_updates()
Date: Tue, 22 Nov 2011 11:21:57 +0200
Message-ID: <1321953724-6350-59-git-send-email-tomi.valkeinen@ti.com>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:56289 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758222Ab1KVJYn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Nov 2011 04:24:43 -0500
In-Reply-To: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: archit@ti.com, Tomi Valkeinen <tomi.valkeinen@ti.com>

Add wait_pending_extra_info_updates() function which can be used to wait
until any extra_info changes have been taken into use by the hardware.
This can be only called when holding the apply mutex, so that other
threads cannot insert new extra_info changes.

This will be used to handle fifo-configurations.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/apply.c |   70 +++++++++++++++++++++++++++++++++++++++
 1 files changed, 70 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 76b5b02..75db522 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -106,6 +106,7 @@ static struct {
 static spinlock_t data_lock;
 /* lock for blocking functions */
 static DEFINE_MUTEX(apply_lock);
+static DECLARE_COMPLETION(extra_updated_completion);
 
 static void dss_register_vsync_isr(void);
 
@@ -232,6 +233,70 @@ static bool need_go(struct omap_overlay_manager *mgr)
 	return false;
 }
 
+/* returns true if an extra_info field is currently being updated */
+static bool extra_info_update_ongoing(void)
+{
+	const int num_ovls = omap_dss_get_num_overlays();
+	struct ovl_priv_data *op;
+	struct omap_overlay *ovl;
+	struct mgr_priv_data *mp;
+	int i;
+	bool eid;
+
+	for (i = 0; i < num_ovls; ++i) {
+		ovl = omap_dss_get_overlay(i);
+		op = get_ovl_priv(ovl);
+
+		if (!op->enabled)
+			continue;
+
+		mp = get_mgr_priv(ovl->manager);
+
+		if (!mp->enabled)
+			continue;
+
+		eid = op->extra_info_dirty || op->shadow_extra_info_dirty;
+
+		if (!eid)
+			continue;
+
+		if (ovl_manual_update(ovl) && !mp->updating)
+			continue;
+
+		return true;
+	}
+
+	return false;
+}
+
+/* wait until no extra_info updates are pending */
+static void wait_pending_extra_info_updates(void)
+{
+	bool updating;
+	unsigned long flags;
+	unsigned long t;
+
+	spin_lock_irqsave(&data_lock, flags);
+
+	updating = extra_info_update_ongoing();
+
+	if (!updating) {
+		spin_unlock_irqrestore(&data_lock, flags);
+		return;
+	}
+
+	init_completion(&extra_updated_completion);
+
+	spin_unlock_irqrestore(&data_lock, flags);
+
+	t = msecs_to_jiffies(500);
+	wait_for_completion_timeout(&extra_updated_completion, t);
+
+	updating = extra_info_update_ongoing();
+
+	WARN_ON(updating);
+}
+
 int dss_mgr_wait_for_go(struct omap_overlay_manager *mgr)
 {
 	unsigned long timeout = msecs_to_jiffies(500);
@@ -553,6 +618,7 @@ static void dss_apply_irq_handler(void *data, u32 mask)
 {
 	const int num_mgrs = dss_feat_get_num_mgrs();
 	int i;
+	bool extra_updating;
 
 	spin_lock(&data_lock);
 
@@ -582,6 +648,10 @@ static void dss_apply_irq_handler(void *data, u32 mask)
 
 	dss_write_regs();
 
+	extra_updating = extra_info_update_ongoing();
+	if (!extra_updating)
+		complete_all(&extra_updated_completion);
+
 	if (!need_isr())
 		dss_unregister_vsync_isr();
 
-- 
1.7.4.1

