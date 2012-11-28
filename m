From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH 1/7] OMAPDSS: DISPC: Move burst_size and buffer_size to dispc_features
Date: Wed, 28 Nov 2012 16:11:24 +0530
Message-ID: <c40e58eec3b2100368c696db05a68d49d49f1f0d.1354086150.git.cmahapatra@ti.com>
References: <cover.1354086150.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47803 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754232Ab2K1KqV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Nov 2012 05:46:21 -0500
In-Reply-To: <cover.1354086150.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

The burst_size and buffer_size being local data to DISPC are moved to
dispc_features and so removed from struct omap_dss_features. The functions
referring to burst and buffer size are also removed from dss_features.c as they
are now accessed locally in dispc.c.

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
 drivers/video/omap2/dss/dispc.c        |   21 +++++++++++++++++----
 drivers/video/omap2/dss/dss_features.c |   29 -----------------------------
 drivers/video/omap2/dss/dss_features.h |    3 ---
 3 files changed, 17 insertions(+), 36 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 3d0ff5b..9f259ba 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -104,6 +104,9 @@ struct dispc_features {
 
 	/* swap GFX & WB fifos */
 	bool gfx_fifo_workaround:1;
+
+	u32 buffer_size_unit;
+	u32 burst_size_unit;
 };
 
 #define DISPC_MAX_NR_FIFOS 5
@@ -1056,7 +1059,7 @@ static void dispc_configure_burst_sizes(void)
 
 static u32 dispc_ovl_get_burst_size(enum omap_plane plane)
 {
-	unsigned unit = dss_feat_get_burst_size_unit();
+	unsigned unit = dispc.feat->burst_size_unit;
 	/* burst multiplier is always x8 (see dispc_configure_burst_sizes()) */
 	return unit * 8;
 }
@@ -1145,7 +1148,7 @@ static void dispc_init_fifos(void)
 	u8 start, end;
 	u32 unit;
 
-	unit = dss_feat_get_buffer_size_unit();
+	unit = dispc.feat->buffer_size_unit;
 
 	dss_feat_get_reg_field(FEAT_REG_FIFOSIZE, &start, &end);
 
@@ -1203,7 +1206,7 @@ void dispc_ovl_set_fifo_threshold(enum omap_plane plane, u32 low, u32 high)
 	u8 hi_start, hi_end, lo_start, lo_end;
 	u32 unit;
 
-	unit = dss_feat_get_buffer_size_unit();
+	unit = dispc.feat->buffer_size_unit;
 
 	WARN_ON(low % unit != 0);
 	WARN_ON(high % unit != 0);
@@ -1247,7 +1250,7 @@ void dispc_ovl_compute_fifo_thresholds(enum omap_plane plane,
 	 * buffer_units, and the fifo thresholds must be buffer_unit aligned.
 	 */
 
-	unsigned buf_unit = dss_feat_get_buffer_size_unit();
+	unsigned buf_unit = dispc.feat->buffer_size_unit;
 	unsigned ovl_fifo_size, total_fifo_size, burst_size;
 	int i;
 
@@ -4095,6 +4098,8 @@ static const struct dispc_features omap24xx_dispc_feats __initconst = {
 	.calc_scaling		=	dispc_ovl_calc_scaling_24xx,
 	.calc_core_clk		=	calc_core_clk_24xx,
 	.num_fifos		=	3,
+	.buffer_size_unit	=	1,
+	.burst_size_unit	=	8,
 };
 
 static const struct dispc_features omap34xx_rev1_0_dispc_feats __initconst = {
@@ -4111,6 +4116,8 @@ static const struct dispc_features omap34xx_rev1_0_dispc_feats __initconst = {
 	.calc_scaling		=	dispc_ovl_calc_scaling_34xx,
 	.calc_core_clk		=	calc_core_clk_34xx,
 	.num_fifos		=	3,
+	.buffer_size_unit	=	1,
+	.burst_size_unit	=	8,
 };
 
 static const struct dispc_features omap34xx_rev3_0_dispc_feats __initconst = {
@@ -4127,6 +4134,8 @@ static const struct dispc_features omap34xx_rev3_0_dispc_feats __initconst = {
 	.calc_scaling		=	dispc_ovl_calc_scaling_34xx,
 	.calc_core_clk		=	calc_core_clk_34xx,
 	.num_fifos		=	3,
+	.buffer_size_unit	=	1,
+	.burst_size_unit	=	8,
 };
 
 static const struct dispc_features omap44xx_dispc_feats __initconst = {
@@ -4144,6 +4153,8 @@ static const struct dispc_features omap44xx_dispc_feats __initconst = {
 	.calc_core_clk		=	calc_core_clk_44xx,
 	.num_fifos		=	5,
 	.gfx_fifo_workaround	=	true,
+	.buffer_size_unit	=	16,
+	.burst_size_unit	=	16,
 };
 
 static const struct dispc_features omap54xx_dispc_feats __initconst = {
@@ -4161,6 +4172,8 @@ static const struct dispc_features omap54xx_dispc_feats __initconst = {
 	.calc_core_clk		=	calc_core_clk_44xx,
 	.num_fifos		=	5,
 	.gfx_fifo_workaround	=	true,
+	.buffer_size_unit	=	16,
+	.burst_size_unit	=	16,
 };
 
 static int __init dispc_init_features(struct platform_device *pdev)
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 1d125c6..092e21b 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -54,9 +54,6 @@ struct omap_dss_features {
 	const struct dss_param_range *dss_params;
 
 	const enum omap_dss_rotation_type supported_rotation_types;
-
-	const u32 buffer_size_unit;
-	const u32 burst_size_unit;
 };
 
 /* This struct is assigned to one of the below during initialization */
@@ -632,8 +629,6 @@ static const struct omap_dss_features omap2_dss_features = {
 	.clksrc_names = omap2_dss_clk_source_names,
 	.dss_params = omap2_dss_param_range,
 	.supported_rotation_types = OMAP_DSS_ROT_DMA | OMAP_DSS_ROT_VRFB,
-	.buffer_size_unit = 1,
-	.burst_size_unit = 8,
 };
 
 /* OMAP3 DSS Features */
@@ -653,8 +648,6 @@ static const struct omap_dss_features omap3430_dss_features = {
 	.clksrc_names = omap3_dss_clk_source_names,
 	.dss_params = omap3_dss_param_range,
 	.supported_rotation_types = OMAP_DSS_ROT_DMA | OMAP_DSS_ROT_VRFB,
-	.buffer_size_unit = 1,
-	.burst_size_unit = 8,
 };
 
 /*
@@ -677,8 +670,6 @@ static const struct omap_dss_features am35xx_dss_features = {
 	.clksrc_names = omap3_dss_clk_source_names,
 	.dss_params = omap3_dss_param_range,
 	.supported_rotation_types = OMAP_DSS_ROT_DMA | OMAP_DSS_ROT_VRFB,
-	.buffer_size_unit = 1,
-	.burst_size_unit = 8,
 };
 
 static const struct omap_dss_features omap3630_dss_features = {
@@ -697,8 +688,6 @@ static const struct omap_dss_features omap3630_dss_features = {
 	.clksrc_names = omap3_dss_clk_source_names,
 	.dss_params = omap3_dss_param_range,
 	.supported_rotation_types = OMAP_DSS_ROT_DMA | OMAP_DSS_ROT_VRFB,
-	.buffer_size_unit = 1,
-	.burst_size_unit = 8,
 };
 
 /* OMAP4 DSS Features */
@@ -720,8 +709,6 @@ static const struct omap_dss_features omap4430_es1_0_dss_features  = {
 	.clksrc_names = omap4_dss_clk_source_names,
 	.dss_params = omap4_dss_param_range,
 	.supported_rotation_types = OMAP_DSS_ROT_DMA | OMAP_DSS_ROT_TILER,
-	.buffer_size_unit = 16,
-	.burst_size_unit = 16,
 };
 
 /* For OMAP4430 ES 2.0, 2.1 and 2.2 revisions */
@@ -742,8 +729,6 @@ static const struct omap_dss_features omap4430_es2_0_1_2_dss_features = {
 	.clksrc_names = omap4_dss_clk_source_names,
 	.dss_params = omap4_dss_param_range,
 	.supported_rotation_types = OMAP_DSS_ROT_DMA | OMAP_DSS_ROT_TILER,
-	.buffer_size_unit = 16,
-	.burst_size_unit = 16,
 };
 
 /* For all the other OMAP4 versions */
@@ -764,8 +749,6 @@ static const struct omap_dss_features omap4_dss_features = {
 	.clksrc_names = omap4_dss_clk_source_names,
 	.dss_params = omap4_dss_param_range,
 	.supported_rotation_types = OMAP_DSS_ROT_DMA | OMAP_DSS_ROT_TILER,
-	.buffer_size_unit = 16,
-	.burst_size_unit = 16,
 };
 
 /* OMAP5 DSS Features */
@@ -785,8 +768,6 @@ static const struct omap_dss_features omap5_dss_features = {
 	.clksrc_names = omap5_dss_clk_source_names,
 	.dss_params = omap5_dss_param_range,
 	.supported_rotation_types = OMAP_DSS_ROT_DMA | OMAP_DSS_ROT_TILER,
-	.buffer_size_unit = 16,
-	.burst_size_unit = 16,
 };
 
 #if defined(CONFIG_OMAP4_DSS_HDMI)
@@ -892,16 +873,6 @@ const char *dss_feat_get_clk_source_name(enum omap_dss_clk_source id)
 	return omap_current_dss_features->clksrc_names[id];
 }
 
-u32 dss_feat_get_buffer_size_unit(void)
-{
-	return omap_current_dss_features->buffer_size_unit;
-}
-
-u32 dss_feat_get_burst_size_unit(void)
-{
-	return omap_current_dss_features->burst_size_unit;
-}
-
 /* DSS has_feature check */
 bool dss_has_feature(enum dss_feat_id id)
 {
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index 385b0af..16658e1 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -114,9 +114,6 @@ bool dss_feat_color_mode_supported(enum omap_plane plane,
 		enum omap_color_mode color_mode);
 const char *dss_feat_get_clk_source_name(enum omap_dss_clk_source id);
 
-u32 dss_feat_get_buffer_size_unit(void);	/* in bytes */
-u32 dss_feat_get_burst_size_unit(void);		/* in bytes */
-
 bool dss_feat_rotation_type_supported(enum omap_dss_rotation_type rot_type);
 
 bool dss_has_feature(enum dss_feat_id id);
-- 
1.7.10

