From: Archit Taneja <archit@ti.com>
Subject: [RFC PATCH 10/29] OMAPDSS: APPLY: Calculate channel_in for writeback
Date: Tue, 27 Dec 2011 18:06:53 +0530
Message-ID: <1324989432-3625-11-git-send-email-archit@ti.com>
References: <1324989432-3625-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58030 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753621Ab1L0Mi7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Dec 2011 07:38:59 -0500
In-Reply-To: <1324989432-3625-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rohitkc@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Add channel_in as a parameter in writeback's private data. This sets the
extra_info_dirty flag as this parameter is configured when we set/unset the
dummy writeback panel's manager unlike the other parameter which are
configured through set/unset_wb_info ops by the DSS2 user.

Add a helper function dss_mgr_set_writeback() which is called by the manager
set/unset_device ops to configure the channel_in parameter and set the
extra_info_dirty flags. It returns an error if we try to unset writeback when
it is enabled.

Add a dummy dispc_wb_set_channel_in() function. This will be filled up later.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/apply.c     |   59 +++++++++++++++++++++++++++++-----
 drivers/video/omap2/dss/dispc.c     |    5 +++
 drivers/video/omap2/dss/dss.h       |   12 +++++++
 drivers/video/omap2/dss/writeback.c |   15 +++++++++
 4 files changed, 82 insertions(+), 9 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index aee0420..9f3c174 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -114,6 +114,8 @@ struct wb_priv_data {
 	bool extra_info_dirty;
 	bool shadow_extra_info_dirty;
 
+	enum dss_writeback_channel_in channel_in;
+
 	/* If true, GO bit is up and shadow registers cannot be written.
 	 * Never true for writeback in memory to memory mode */
 	bool busy;
@@ -137,6 +139,8 @@ static DEFINE_MUTEX(apply_lock);
 static DECLARE_COMPLETION(extra_updated_completion);
 
 static void dss_register_vsync_isr(void);
+static int dss_mgr_set_writeback(struct omap_overlay_manager *mgr,
+		struct omap_dss_writeback *wb, bool set);
 
 static struct ovl_priv_data *get_ovl_priv(struct omap_overlay *ovl)
 {
@@ -682,7 +686,7 @@ static void dss_wb_write_regs_extra(struct omap_dss_writeback *wb)
 	if (!wp->extra_info_dirty)
 		return;
 
-	/* Write extra registers here */
+	dispc_wb_set_channel_in(wb->id, wp->channel_in);
 
 	wp->extra_info_dirty = false;
 	wp->shadow_extra_info_dirty = true;
@@ -1282,6 +1286,7 @@ int dss_mgr_set_device(struct omap_overlay_manager *mgr,
 		struct omap_dss_device *dssdev)
 {
 	int r;
+	struct omap_dss_writeback *wb = dssdev->wbdev;
 
 	mutex_lock(&apply_lock);
 
@@ -1301,10 +1306,13 @@ int dss_mgr_set_device(struct omap_overlay_manager *mgr,
 
 	dssdev->manager = mgr;
 
-	if (dssdev->wbdev)
-		mgr->output->writeback = dssdev;
-	else
+	if (wb) {
+		r = dss_mgr_set_writeback(mgr, wb, true);
+		if (r)
+			goto err;
+	} else {
 		mgr->output->device = dssdev;
+	}
 
 	mutex_unlock(&apply_lock);
 
@@ -1319,11 +1327,11 @@ int dss_mgr_unset_device(struct omap_overlay_manager *mgr,
 {
 	int r;
 	struct omap_dss_device *curr_dssdev;
+	struct omap_dss_writeback *wb = dssdev->wbdev;
 
 	mutex_lock(&apply_lock);
 
-	curr_dssdev = dssdev->wbdev ? mgr->get_writeback(mgr) :
-			mgr->get_display(mgr);
+	curr_dssdev = wb ? mgr->get_writeback(mgr) : mgr->get_display(mgr);
 
 	if (!curr_dssdev) {
 		DSSERR("failed to unset device, device not set.\n");
@@ -1342,10 +1350,13 @@ int dss_mgr_unset_device(struct omap_overlay_manager *mgr,
 
 	curr_dssdev->manager = NULL;
 
-	if (dssdev->wbdev)
-		mgr->output->writeback = NULL;
-	else
+	if (wb) {
+		r = dss_mgr_set_writeback(mgr, wb, false);
+		if (r)
+			goto err;
+	} else {
 		mgr->output->device = NULL;
+	}
 
 	mutex_unlock(&apply_lock);
 
@@ -1593,6 +1604,36 @@ err:
 	return r;
 }
 
+static int dss_mgr_set_writeback(struct omap_overlay_manager *mgr,
+		struct omap_dss_writeback *wb, bool set)
+{
+	struct wb_priv_data *wp = get_wb_priv(wb);
+	unsigned long flags;
+
+	spin_lock_irqsave(&data_lock, flags);
+
+	if (set) {
+		wp->channel_in = dss_wb_calc_channel_in(wb);
+		wp->extra_info_dirty = true;
+		mgr->output->writeback = wb->dssdev;
+
+	} else {
+		if (wp->enabled) {
+			DSSERR("Failed to unset writeback%d from manager%d\n",
+				wb->id, mgr->id);
+			spin_unlock_irqrestore(&data_lock, flags);
+			return -EINVAL;
+		}
+
+		wp->channel_in = -1;
+		mgr->output->writeback = NULL;
+	}
+
+	spin_unlock_irqrestore(&data_lock, flags);
+
+	return 0;
+}
+
 int dss_wb_set_info(struct omap_dss_writeback *wb,
 		struct omap_dss_writeback_info *info)
 {
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 35ed6ca..a4d5504 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -899,6 +899,11 @@ static enum omap_channel dispc_ovl_get_channel_out(enum omap_plane plane)
 	return channel;
 }
 
+void dispc_wb_set_channel_in(int id, enum dss_writeback_channel_in ch_in)
+{
+	return;
+}
+
 static void dispc_ovl_set_burst_size(enum omap_plane plane,
 		enum omap_burst_size burst_size)
 {
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index b4b60fc..1b128f1 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -113,6 +113,16 @@ enum dss_dsi_content_type {
 	DSS_DSI_CONTENT_GENERIC,
 };
 
+enum dss_writeback_channel_in {
+	OMAP_DSS_WB_LCD1_MGR	= 0,
+	OMAP_DSS_WB_LCD2_MGR	= 1,
+	OMAP_DSS_WB_TV_MGR	= 2,
+	OMAP_DSS_WB_OVL0	= 3,
+	OMAP_DSS_WB_OVL1	= 4,
+	OMAP_DSS_WB_OVL2	= 5,
+	OMAP_DSS_WB_OVL3	= 6,
+};
+
 struct dss_clock_info {
 	/* rates that we get with dividers below */
 	unsigned long fck;
@@ -238,6 +248,7 @@ int dss_ovl_check(struct omap_overlay *ovl,
 void dss_init_writeback(void);
 void dss_uninit_writeback(void);
 int writeback_init_display(struct omap_dss_device *dssdev);
+enum dss_writeback_channel_in dss_wb_calc_channel_in(struct omap_dss_writeback *wb);
 int dss_wb_simple_check(struct omap_dss_writeback *wb,
 		const struct omap_dss_writeback_info *info);
 
@@ -483,6 +494,7 @@ bool dispc_wb_go_busy(int id);
 void dispc_wb_go(int id);
 int dispc_wb_setup(int id, struct omap_dss_writeback_info *wi);
 void dispc_wb_enable(int id, bool enable);
+void dispc_wb_set_channel_in(int id, enum dss_writeback_channel_in ch_in);
 
 /* VENC */
 #ifdef CONFIG_OMAP2_DSS_VENC
diff --git a/drivers/video/omap2/dss/writeback.c b/drivers/video/omap2/dss/writeback.c
index eefab4e..89738a4 100644
--- a/drivers/video/omap2/dss/writeback.c
+++ b/drivers/video/omap2/dss/writeback.c
@@ -122,6 +122,21 @@ int writeback_init_display(struct omap_dss_device *dssdev)
 	return 0;
 }
 
+enum dss_writeback_channel_in dss_wb_calc_channel_in(struct omap_dss_writeback *wb)
+{
+	struct omap_overlay_manager *mgr = wb->dssdev->manager;
+
+	switch (mgr->id) {
+	case OMAP_DSS_CHANNEL_LCD2:
+		return OMAP_DSS_WB_LCD2_MGR;
+	case OMAP_DSS_CHANNEL_DIGIT:
+		return OMAP_DSS_WB_TV_MGR;
+	case OMAP_DSS_CHANNEL_LCD:
+	default:
+		return OMAP_DSS_WB_LCD1_MGR;
+	}
+}
+
 int dss_wb_simple_check(struct omap_dss_writeback *wb,
 		const struct omap_dss_writeback_info *info)
 {
-- 
1.7.4.1

