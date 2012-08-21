From: Archit Taneja <archit@ti.com>
Subject: [PATCH 04/23] OMAPDSS: APPLY: Add manager set/unset output ops for omap_overlay_manager
Date: Tue, 21 Aug 2012 11:28:11 +0530
Message-ID: <1345528711-27801-5-git-send-email-archit@ti.com>
References: <1345528711-27801-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34793 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753081Ab2HUGAZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Aug 2012 02:00:25 -0400
In-Reply-To: <1345528711-27801-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, rob@ti.com, sumit.semwal@ti.com, Archit Taneja <archit@ti.com>

Add set_output/unset_output ops for overlay managers, these form links between
managers and outputs. Create a function in dss features which tell all the
output instances that connect to a manager, use it when a manager tries to set
an output. Add a constraint of not unsetting an output when the manager is
enabled.

Keep the omap_dss_device pointer and set/unset_device ops in overlay_manager for
now to not break things. Keep the dss feature function get_supported_displays
as it's used in some places. These will be removed later.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/apply.c        |   70 ++++++++++++++++++++++++++++++++
 drivers/video/omap2/dss/dss.h          |    3 ++
 drivers/video/omap2/dss/dss_features.c |   52 ++++++++++++++++++++++++
 drivers/video/omap2/dss/dss_features.h |    1 +
 drivers/video/omap2/dss/manager.c      |    4 ++
 include/video/omapdss.h                |    5 +++
 6 files changed, 135 insertions(+)

diff --git a/drivers/video/omap2/dss/apply.c b/drivers/video/omap2/dss/apply.c
index 74f1a58..d241407 100644
--- a/drivers/video/omap2/dss/apply.c
+++ b/drivers/video/omap2/dss/apply.c
@@ -1311,6 +1311,76 @@ err:
 	return r;
 }
 
+int dss_mgr_set_output(struct omap_overlay_manager *mgr,
+		struct omap_dss_output *output)
+{
+	int r;
+
+	mutex_lock(&apply_lock);
+
+	if (mgr->output) {
+		DSSERR("manager %s is already connected to an output\n",
+			mgr->name);
+		r = -EINVAL;
+		goto err;
+	}
+
+	if ((mgr->supported_outputs & output->id) == 0) {
+		DSSERR("output does not support manager %s\n",
+			mgr->name);
+		r = -EINVAL;
+		goto err;
+	}
+
+	output->manager = mgr;
+	mgr->output = output;
+
+	mutex_unlock(&apply_lock);
+
+	return 0;
+err:
+	mutex_unlock(&apply_lock);
+	return r;
+}
+
+int dss_mgr_unset_output(struct omap_overlay_manager *mgr)
+{
+	int r;
+	struct mgr_priv_data *mp = get_mgr_priv(mgr);
+	unsigned long flags;
+
+	mutex_lock(&apply_lock);
+
+	if (!mgr->output) {
+		DSSERR("failed to unset output, output not set\n");
+		r = -EINVAL;
+		goto err;
+	}
+
+	spin_lock_irqsave(&data_lock, flags);
+
+	if (mp->enabled) {
+		DSSERR("output can't be unset when manager is enabled\n");
+		r = -EINVAL;
+		goto err1;
+	}
+
+	spin_unlock_irqrestore(&data_lock, flags);
+
+	mgr->output->manager = NULL;
+	mgr->output = NULL;
+
+	mutex_unlock(&apply_lock);
+
+	return 0;
+err1:
+	spin_unlock_irqrestore(&data_lock, flags);
+err:
+	mutex_unlock(&apply_lock);
+
+	return r;
+}
+
 static void dss_apply_mgr_timings(struct omap_overlay_manager *mgr,
 		const struct omap_video_timings *timings)
 {
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 8a7c94c..a119506 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -205,6 +205,9 @@ void dss_mgr_get_info(struct omap_overlay_manager *mgr,
 int dss_mgr_set_device(struct omap_overlay_manager *mgr,
 		struct omap_dss_device *dssdev);
 int dss_mgr_unset_device(struct omap_overlay_manager *mgr);
+int dss_mgr_set_output(struct omap_overlay_manager *mgr,
+		struct omap_dss_output *output);
+int dss_mgr_unset_output(struct omap_overlay_manager *mgr);
 void dss_mgr_set_timings(struct omap_overlay_manager *mgr,
 		const struct omap_video_timings *timings);
 void dss_mgr_set_lcd_config(struct omap_overlay_manager *mgr,
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 9387097..43f8491 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -47,6 +47,7 @@ struct omap_dss_features {
 	const int num_mgrs;
 	const int num_ovls;
 	const enum omap_display_type *supported_displays;
+	const enum omap_dss_output_id *supported_outputs;
 	const enum omap_color_mode *supported_color_modes;
 	const enum omap_overlay_caps *overlay_caps;
 	const char * const *clksrc_names;
@@ -144,6 +145,46 @@ static const enum omap_display_type omap4_dss_supported_displays[] = {
 	OMAP_DISPLAY_TYPE_DSI,
 };
 
+static const enum omap_dss_output_id omap2_dss_supported_outputs[] = {
+	/* OMAP_DSS_CHANNEL_LCD */
+	OMAP_DSS_OUTPUT_DPI | OMAP_DSS_OUTPUT_DBI,
+
+	/* OMAP_DSS_CHANNEL_DIGIT */
+	OMAP_DSS_OUTPUT_VENC,
+};
+
+static const enum omap_dss_output_id omap3430_dss_supported_outputs[] = {
+	/* OMAP_DSS_CHANNEL_LCD */
+	OMAP_DSS_OUTPUT_DPI | OMAP_DSS_OUTPUT_DBI |
+	OMAP_DSS_OUTPUT_SDI | OMAP_DSS_OUTPUT_DSI1,
+
+	/* OMAP_DSS_CHANNEL_DIGIT */
+	OMAP_DSS_OUTPUT_VENC,
+};
+
+static const enum omap_dss_output_id omap3630_dss_supported_outputs[] = {
+	/* OMAP_DSS_CHANNEL_LCD */
+	OMAP_DSS_OUTPUT_DPI | OMAP_DSS_OUTPUT_DBI |
+	OMAP_DSS_OUTPUT_DSI1,
+
+	/* OMAP_DSS_CHANNEL_DIGIT */
+	OMAP_DSS_OUTPUT_VENC,
+};
+
+static const enum omap_dss_output_id omap4_dss_supported_outputs[] = {
+	/* OMAP_DSS_CHANNEL_LCD */
+	OMAP_DSS_OUTPUT_DPI | OMAP_DSS_OUTPUT_DBI |
+	OMAP_DSS_OUTPUT_DSI1,
+
+	/* OMAP_DSS_CHANNEL_DIGIT */
+	OMAP_DSS_OUTPUT_VENC | OMAP_DSS_OUTPUT_HDMI |
+	OMAP_DSS_OUTPUT_DPI,
+
+	/* OMAP_DSS_CHANNEL_LCD2 */
+	OMAP_DSS_OUTPUT_DPI | OMAP_DSS_OUTPUT_DBI |
+	OMAP_DSS_OUTPUT_DSI2,
+};
+
 static const enum omap_color_mode omap2_dss_supported_color_modes[] = {
 	/* OMAP_DSS_GFX */
 	OMAP_DSS_COLOR_CLUT1 | OMAP_DSS_COLOR_CLUT2 |
@@ -458,6 +499,7 @@ static const struct omap_dss_features omap2_dss_features = {
 	.num_mgrs = 2,
 	.num_ovls = 3,
 	.supported_displays = omap2_dss_supported_displays,
+	.supported_outputs = omap2_dss_supported_outputs,
 	.supported_color_modes = omap2_dss_supported_color_modes,
 	.overlay_caps = omap2_dss_overlay_caps,
 	.clksrc_names = omap2_dss_clk_source_names,
@@ -478,6 +520,7 @@ static const struct omap_dss_features omap3430_dss_features = {
 	.num_mgrs = 2,
 	.num_ovls = 3,
 	.supported_displays = omap3430_dss_supported_displays,
+	.supported_outputs = omap3430_dss_supported_outputs,
 	.supported_color_modes = omap3_dss_supported_color_modes,
 	.overlay_caps = omap3430_dss_overlay_caps,
 	.clksrc_names = omap3_dss_clk_source_names,
@@ -497,6 +540,7 @@ static const struct omap_dss_features omap3630_dss_features = {
 	.num_mgrs = 2,
 	.num_ovls = 3,
 	.supported_displays = omap3630_dss_supported_displays,
+	.supported_outputs = omap3630_dss_supported_outputs,
 	.supported_color_modes = omap3_dss_supported_color_modes,
 	.overlay_caps = omap3630_dss_overlay_caps,
 	.clksrc_names = omap3_dss_clk_source_names,
@@ -518,6 +562,7 @@ static const struct omap_dss_features omap4430_es1_0_dss_features  = {
 	.num_mgrs = 3,
 	.num_ovls = 4,
 	.supported_displays = omap4_dss_supported_displays,
+	.supported_outputs = omap4_dss_supported_outputs,
 	.supported_color_modes = omap4_dss_supported_color_modes,
 	.overlay_caps = omap4_dss_overlay_caps,
 	.clksrc_names = omap4_dss_clk_source_names,
@@ -538,6 +583,7 @@ static const struct omap_dss_features omap4430_es2_0_1_2_dss_features = {
 	.num_mgrs = 3,
 	.num_ovls = 4,
 	.supported_displays = omap4_dss_supported_displays,
+	.supported_outputs = omap4_dss_supported_outputs,
 	.supported_color_modes = omap4_dss_supported_color_modes,
 	.overlay_caps = omap4_dss_overlay_caps,
 	.clksrc_names = omap4_dss_clk_source_names,
@@ -558,6 +604,7 @@ static const struct omap_dss_features omap4_dss_features = {
 	.num_mgrs = 3,
 	.num_ovls = 4,
 	.supported_displays = omap4_dss_supported_displays,
+	.supported_outputs = omap4_dss_supported_outputs,
 	.supported_color_modes = omap4_dss_supported_color_modes,
 	.overlay_caps = omap4_dss_overlay_caps,
 	.clksrc_names = omap4_dss_clk_source_names,
@@ -627,6 +674,11 @@ enum omap_display_type dss_feat_get_supported_displays(enum omap_channel channel
 	return omap_current_dss_features->supported_displays[channel];
 }
 
+enum omap_dss_output_id dss_feat_get_supported_outputs(enum omap_channel channel)
+{
+	return omap_current_dss_features->supported_outputs[channel];
+}
+
 enum omap_color_mode dss_feat_get_supported_color_modes(enum omap_plane plane)
 {
 	return omap_current_dss_features->supported_color_modes[plane];
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index 996ffcb..89a71d1 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -103,6 +103,7 @@ int dss_feat_get_num_ovls(void);
 unsigned long dss_feat_get_param_min(enum dss_range_param param);
 unsigned long dss_feat_get_param_max(enum dss_range_param param);
 enum omap_display_type dss_feat_get_supported_displays(enum omap_channel channel);
+enum omap_dss_output_id dss_feat_get_supported_outputs(enum omap_channel channel);
 enum omap_color_mode dss_feat_get_supported_color_modes(enum omap_plane plane);
 enum omap_overlay_caps dss_feat_get_overlay_caps(enum omap_plane plane);
 bool dss_feat_color_mode_supported(enum omap_plane plane,
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index 53710fa..e15fa5f 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -549,6 +549,8 @@ int dss_init_overlay_managers(struct platform_device *pdev)
 
 		mgr->set_device = &dss_mgr_set_device;
 		mgr->unset_device = &dss_mgr_unset_device;
+		mgr->set_output = &dss_mgr_set_output;
+		mgr->unset_output = &dss_mgr_unset_output;
 		mgr->apply = &omap_dss_mgr_apply;
 		mgr->set_manager_info = &dss_mgr_set_info;
 		mgr->get_manager_info = &dss_mgr_get_info;
@@ -558,6 +560,8 @@ int dss_init_overlay_managers(struct platform_device *pdev)
 		mgr->caps = 0;
 		mgr->supported_displays =
 			dss_feat_get_supported_displays(mgr->id);
+		mgr->supported_outputs =
+			dss_feat_get_supported_outputs(mgr->id);
 
 		INIT_LIST_HEAD(&mgr->overlays);
 
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index 2e40f27..813672b 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -458,9 +458,11 @@ struct omap_overlay_manager {
 	enum omap_overlay_manager_caps caps;
 	struct list_head overlays;
 	enum omap_display_type supported_displays;
+	enum omap_dss_output_id supported_outputs;
 
 	/* dynamic fields */
 	struct omap_dss_device *device;
+	struct omap_dss_output *output;
 
 	/*
 	 * The following functions do not block:
@@ -476,6 +478,9 @@ struct omap_overlay_manager {
 	int (*set_device)(struct omap_overlay_manager *mgr,
 		struct omap_dss_device *dssdev);
 	int (*unset_device)(struct omap_overlay_manager *mgr);
+	int (*set_output)(struct omap_overlay_manager *mgr,
+		struct omap_dss_output *output);
+	int (*unset_output)(struct omap_overlay_manager *mgr);
 
 	int (*set_manager_info)(struct omap_overlay_manager *mgr,
 			struct omap_overlay_manager_info *info);
-- 
1.7.9.5

