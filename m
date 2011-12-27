From: Archit Taneja <archit@ti.com>
Subject: [RFC PATCH 04/29] OMAPDSS: APPLY/Writeback: Add writeback_info
Date: Tue, 27 Dec 2011 18:06:47 +0530
Message-ID: <1324989432-3625-5-git-send-email-archit@ti.com>
References: <1324989432-3625-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52188 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753612Ab1L0Mig (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Dec 2011 07:38:36 -0500
In-Reply-To: <1324989432-3625-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rohitkc@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

Create a struct called omap_dss_writeback_info. This contains 'overlay like'
parameters of the writeback pipeline. These parameters are expected to be
configured via get/set_info ops by the DSS2 user similar to how overlay and
manager parameters are configured. These will also be configurable via sysfs
attributes of the dummy writeback panel.

Add get_wb_info/set_wb_info ops in omap_dss_writeback struct. Create a minimal
wb_priv_data structure and a writeback simple_check function used for
dss_wb_get_info and dss_wb_set_info functions in apply.c

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/apply.c        |   45 ++++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/dss.h          |    7 +++++
 drivers/video/omap2/dss/dss_features.h |    1 +
 drivers/video/omap2/dss/writeback.c    |   27 +++++++++++++++++++
 include/video/omapdss.h                |   18 ++++++++++++
 5 files changed, 98 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index d529664..19120c1 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -101,9 +101,16 @@ struct mgr_priv_data {
 	bool enabled;
 };
 
+struct wb_priv_data {
+
+	bool user_info_dirty;
+	struct omap_dss_writeback_info user_info;
+};
+
 static struct {
 	struct ovl_priv_data ovl_priv_data_array[MAX_DSS_OVERLAYS];
 	struct mgr_priv_data mgr_priv_data_array[MAX_DSS_MANAGERS];
+	struct wb_priv_data wb_priv_data_array[MAX_DSS_WB];
 
 	bool irq_enabled;
 } dss_data;
@@ -126,6 +133,11 @@ static struct mgr_priv_data *get_mgr_priv(struct omap_overlay_manager *mgr)
 	return &dss_data.mgr_priv_data_array[mgr->id];
 }
 
+static struct wb_priv_data *get_wb_priv(struct omap_dss_writeback *wb)
+{
+	return &dss_data.wb_priv_data_array[wb->id];
+}
+
 void dss_apply_init(void)
 {
 	const int num_ovls = dss_feat_get_num_ovls();
@@ -1351,3 +1363,36 @@ err:
 	return r;
 }
 
+int dss_wb_set_info(struct omap_dss_writeback *wb,
+		struct omap_dss_writeback_info *info)
+{
+	struct wb_priv_data *wp = get_wb_priv(wb);
+	unsigned long flags;
+	int r;
+
+	r = dss_wb_simple_check(wb, info);
+	if (r)
+		return r;
+
+	spin_lock_irqsave(&data_lock, flags);
+
+	wp->user_info = *info;
+	wp->user_info_dirty = true;
+
+	spin_unlock_irqrestore(&data_lock, flags);
+
+	return 0;
+}
+
+void dss_wb_get_info(struct omap_dss_writeback *wb,
+		struct omap_dss_writeback_info *info)
+{
+	struct wb_priv_data *wp = get_wb_priv(wb);
+	unsigned long flags;
+
+	spin_lock_irqsave(&data_lock, flags);
+
+	*info = wp->user_info;
+
+	spin_unlock_irqrestore(&data_lock, flags);
+}
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 607e730..9b3b93c 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -191,6 +191,11 @@ int dss_ovl_set_manager(struct omap_overlay *ovl,
 		struct omap_overlay_manager *mgr);
 int dss_ovl_unset_manager(struct omap_overlay *ovl);
 
+int dss_wb_set_info(struct omap_dss_writeback *wb,
+		struct omap_dss_writeback_info *info);
+void dss_wb_get_info(struct omap_dss_writeback *wb,
+		struct omap_dss_writeback_info *info);
+
 /* display */
 int dss_suspend_all_devices(void);
 int dss_resume_all_devices(void);
@@ -230,6 +235,8 @@ int dss_ovl_check(struct omap_overlay *ovl,
 void dss_init_writeback(void);
 void dss_uninit_writeback(void);
 int writeback_init_display(struct omap_dss_device *dssdev);
+int dss_wb_simple_check(struct omap_dss_writeback *wb,
+		const struct omap_dss_writeback_info *info);
 
 /* DSS */
 int dss_init_platform_driver(void);
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index 75ee1f1..b3486da 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -28,6 +28,7 @@
 #define MAX_DSS_OVERLAYS	4
 #define MAX_DSS_LCD_MANAGERS	2
 #define MAX_NUM_DSI		2
+#define MAX_DSS_WB		1
 
 /* DSS has feature id */
 enum dss_feat_id {
diff --git a/drivers/video/omap2/dss/writeback.c b/drivers/video/omap2/dss/writeback.c
index ac5d3ba..5e54221 100644
--- a/drivers/video/omap2/dss/writeback.c
+++ b/drivers/video/omap2/dss/writeback.c
@@ -78,6 +78,9 @@ void dss_init_writeback(void)
 		struct omap_dss_writeback *wb = &writeback[i];
 
 		wb->id = i;
+
+		wb->set_wb_info = &dss_wb_set_info;
+		wb->get_wb_info = &dss_wb_get_info;
 	}
 
 	omap_dss_register_driver(&writeback_panel_driver);
@@ -109,6 +112,30 @@ int writeback_init_display(struct omap_dss_device *dssdev)
 	return 0;
 }
 
+int dss_wb_simple_check(struct omap_dss_writeback *wb,
+		const struct omap_dss_writeback_info *info)
+{
+	if (info->paddr == 0) {
+		DSSERR("wb_simple_check: paddr cannot be 0\n");
+		return -EINVAL;
+	}
+
+	if (info->color_mode == OMAP_DSS_COLOR_NV12 &&
+			info->p_uv_addr == 0) {
+		DSSERR("wb_simple_check: p_uv_addr cannot be 0 for NV12"
+			" format\n");
+		return -EINVAL;
+	}
+
+	if (info->capture_rate < 0 || info->capture_rate > 7) {
+		DSSERR("wb_simple_check: capture rate cannot be %d\n",
+			info->capture_rate);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /* Dummy Writeback Panel driver */
 
 static int writeback_panel_probe(struct omap_dss_device *dssdev)
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 77e2ca4..01092e4 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -472,11 +472,29 @@ struct omap_overlay_manager {
 	struct omap_dss_device *(*get_writeback)(struct omap_overlay_manager *mgr);
 };
 
+struct omap_dss_writeback_info {
+	u32 paddr;
+	u32 p_uv_addr;
+	u16 buf_width;
+	u16 buf_height;
+	enum omap_color_mode color_mode;
+	u8 rotation;
+	enum omap_dss_rotation_type rotation_type;
+	bool mirror;
+	u8 pre_mult_alpha;
+	int capture_rate;
+};
+
 struct omap_dss_writeback {
 	int id;
 
 	/* dummy panel we are connected to */
 	struct omap_dss_device *dssdev;
+
+	int (*set_wb_info)(struct omap_dss_writeback *wb,
+		struct omap_dss_writeback_info *info);
+	void (*get_wb_info)(struct omap_dss_writeback *wb,
+		struct omap_dss_writeback_info *info);
 };
 
 struct omap_dss_device {
-- 
1.7.4.1

