From: Archit Taneja <archit@ti.com>
Subject: [RFC PATCH 06/29] OMAPDSS: APPLY: Add writeback enable/disable functions
Date: Tue, 27 Dec 2011 18:06:49 +0530
Message-ID: <1324989432-3625-7-git-send-email-archit@ti.com>
References: <1324989432-3625-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35272 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753612Ab1L0Mio (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Dec 2011 07:38:44 -0500
In-Reply-To: <1324989432-3625-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rohitkc@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

In writeback capture mode, enabling writeback is similar to enabling an overlay
manager. It leads to an immediate copy of shadow registers to main registers and
starts DISPC DMA for frame transfer to the destination base addresses.

Hence, 'enabled' parameter for writeback is not a part of the writeback_info
struct. Its is maintained as a separate parameter like it's done for an overlay
manager.

Add dss_wb_enable/disable functions. Since we need to be connected to an enabled
manager when enabling writeback. Add checks to ensure that the connected manager
is enabled, add a check in dss_mgr_disable to issue a warning if writeback is in
use.

Call dss_setup_fifos() in dss_wb_enable(), this would be used to configure
writeback FIFOs in the future. Create a dummy dispc_wb_enable() function which
will be later filled up. Call dss_mgr_enable/disable through the dummy writeback
panel's enable/disable ops.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/apply.c     |   92 +++++++++++++++++++++++++++++++++-
 drivers/video/omap2/dss/dispc.c     |    5 ++
 drivers/video/omap2/dss/dss.h       |    3 +
 drivers/video/omap2/dss/writeback.c |   12 ++++-
 4 files changed, 108 insertions(+), 4 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index f40f58c..5263ae7 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -114,6 +114,9 @@ struct wb_priv_data {
 	/* If true, GO bit is up and shadow registers cannot be written.
 	 * Never true for writeback in memory to memory mode */
 	bool busy;
+
+	/* If true, someone is using writeback */
+	bool enabled;
 };
 
 static struct {
@@ -320,6 +323,9 @@ static bool need_isr(void)
 				struct omap_dss_writeback *wb = dssdev->wbdev;
 				struct wb_priv_data *wp = get_wb_priv(wb);
 
+				if (!wp->enabled)
+					continue;
+
 				if (wp->busy)
 					return true;
 
@@ -621,7 +627,7 @@ static void dss_wb_write_regs(struct omap_dss_writeback *wb)
 	struct omap_dss_writeback_info *wi;
 	int r;
 
-	if (!wp->info_dirty)
+	if (!wp->enabled || !wp->info_dirty)
 		return;
 
 	WARN_ON(wp->busy);
@@ -703,7 +709,7 @@ static void dss_write_regs(void)
 		wp = get_wb_priv(wb);
 		mp = get_mgr_priv(wb->dssdev->manager);
 
-		if (!mp->enabled)
+		if (!mp->enabled || !wp->enabled)
 			continue;
 
 		if (wp->busy)
@@ -752,7 +758,7 @@ static void dss_set_go_bits(void)
 		if (!mp->enabled)
 			continue;
 
-		if (wp->busy)
+		if (!wp->enabled || wp->busy)
 			continue;
 
 		if (!need_wb_go(wb))
@@ -1163,6 +1169,7 @@ err:
 void dss_mgr_disable(struct omap_overlay_manager *mgr)
 {
 	struct mgr_priv_data *mp = get_mgr_priv(mgr);
+	struct omap_dss_device *dssdev = mgr->get_writeback(mgr);
 	unsigned long flags;
 
 	mutex_lock(&apply_lock);
@@ -1170,6 +1177,13 @@ void dss_mgr_disable(struct omap_overlay_manager *mgr)
 	if (!mp->enabled)
 		goto out;
 
+	if (dssdev) {
+		/* if writeback is connected to the manager, issue a warning
+		 * if it is enabled */
+		struct wb_priv_data *wp = get_wb_priv(dssdev->wbdev);
+		WARN_ON(wp->enabled);
+	}
+
 	if (!mgr_manual_update(mgr))
 		dispc_mgr_enable(mgr->id, false);
 
@@ -1556,3 +1570,75 @@ void dss_wb_get_info(struct omap_dss_writeback *wb,
 
 	spin_unlock_irqrestore(&data_lock, flags);
 }
+
+int dss_wb_enable(struct omap_dss_writeback *wb)
+{
+	struct wb_priv_data *wp = get_wb_priv(wb);
+	struct mgr_priv_data *mp;
+	unsigned long flags;
+	int r = 0;
+
+	mutex_lock(&apply_lock);
+
+	/* don't enable if it isn't connected to any manager */
+	if (!wb->dssdev->manager) {
+		r = -EINVAL;
+		goto out;
+	}
+
+	mp = get_mgr_priv(wb->dssdev->manager);
+
+	/* don't enable if the manager WB is connected to is disabled */
+	if (!mp->enabled) {
+		r = -EINVAL;
+		goto out;
+	}
+
+	if (wp->enabled)
+		goto out;
+
+	/* use a simple check for now */
+	r = dss_wb_simple_check(wb, &wp->info);
+	if (r)
+		goto out;
+
+	spin_lock_irqsave(&data_lock, flags);
+
+	wp->enabled = true;
+
+	dss_setup_fifos();
+
+	dss_write_regs();
+	dss_set_go_bits();
+
+	spin_unlock_irqrestore(&data_lock, flags);
+
+	dispc_wb_enable(wb->id, true);
+
+out:
+	mutex_unlock(&apply_lock);
+
+	return r;
+}
+
+void dss_wb_disable(struct omap_dss_writeback *wb)
+{
+	struct wb_priv_data *wp = get_wb_priv(wb);
+	unsigned long flags;
+
+	mutex_lock(&apply_lock);
+
+	if (!wp->enabled)
+		goto out;
+
+	dispc_wb_enable(wb->id, false);
+
+	spin_lock_irqsave(&data_lock, flags);
+
+	wp->enabled = false;
+
+	spin_unlock_irqrestore(&data_lock, flags);
+
+out:
+	mutex_unlock(&apply_lock);
+}
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index d98905f..35ed6ca 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2070,6 +2070,11 @@ void dispc_mgr_enable(enum omap_channel channel, bool enable)
 		BUG();
 }
 
+void dispc_wb_enable(int id, bool enable)
+{
+	return;
+}
+
 void dispc_lcd_enable_signal_polarity(bool act_high)
 {
 	if (!dss_has_feature(FEAT_LCDENABLEPOL))
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 556bc7c..bb25d96 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -195,6 +195,8 @@ int dss_wb_set_info(struct omap_dss_writeback *wb,
 		struct omap_dss_writeback_info *info);
 void dss_wb_get_info(struct omap_dss_writeback *wb,
 		struct omap_dss_writeback_info *info);
+int dss_wb_enable(struct omap_dss_writeback *wb);
+void dss_wb_disable(struct omap_dss_writeback *wb);
 
 /* display */
 int dss_suspend_all_devices(void);
@@ -479,6 +481,7 @@ void dispc_mgr_setup(enum omap_channel channel,
 bool dispc_wb_go_busy(int id);
 void dispc_wb_go(int id);
 int dispc_wb_setup(int id, struct omap_dss_writeback_info *wi);
+void dispc_wb_enable(int id, bool enable);
 
 /* VENC */
 #ifdef CONFIG_OMAP2_DSS_VENC
diff --git a/drivers/video/omap2/dss/writeback.c b/drivers/video/omap2/dss/writeback.c
index 5e54221..eefab4e 100644
--- a/drivers/video/omap2/dss/writeback.c
+++ b/drivers/video/omap2/dss/writeback.c
@@ -38,13 +38,23 @@ static int dss_writeback_enable(struct omap_dss_writeback *wb)
 
 	r = dispc_runtime_get();
 	if (r)
-		return r;
+		goto err0;
+
+	r = dss_wb_enable(wb);
+	if (r)
+		goto err1;
 
 	return 0;
+err1:
+	dispc_runtime_put();
+err0:
+	return r;
 }
 
 static void dss_writeback_disable(struct omap_dss_writeback *wb)
 {
+	dss_wb_disable(wb);
+
 	dispc_runtime_put();
 }
 
-- 
1.7.4.1

