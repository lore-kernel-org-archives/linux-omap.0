From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH V2 3/6] OMAPDSS: DISPC: Move DISPC specific dss_params to dispc_features
Date: Wed, 5 Dec 2012 15:46:05 +0530
Message-ID: <8696421a5bd4032ce250a550e07a75c1b63a0867.1354702077.git.cmahapatra@ti.com>
References: <cover.1354086150.git.cmahapatra@ti.com> <cover.1354702077.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45646 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752101Ab2LEKT5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Dec 2012 05:19:57 -0500
In-Reply-To: <cover.1354702077.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

The DISPC specific dss_param_range are moved from struct omap_dss_features to
corresponding DSS version specific dispc_param_range struct, initialized in
dispc_features thereby enabling local access. The mgr_width_max and
mgr_height_max, members of dispc_features, are also moved to dispc_param_range.

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
 drivers/video/omap2/dss/dispc.c        |   83 +++++++++++++++++++++++---------
 drivers/video/omap2/dss/dss.h          |    4 ++
 drivers/video/omap2/dss/dss_features.c |   16 ------
 drivers/video/omap2/dss/dss_features.h |    3 --
 4 files changed, 63 insertions(+), 43 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index ee4b152..6a449a5 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -90,6 +90,14 @@ struct dispc_reg_fields {
 	struct omapdss_reg_field vert_accu;
 };
 
+struct dispc_param_ranges {
+	struct omapdss_param_range pcd;
+	struct omapdss_param_range downscale;
+	struct omapdss_param_range linewidth;
+	struct omapdss_param_range mgr_width;
+	struct omapdss_param_range mgr_height;
+};
+
 struct dispc_features {
 	u8 sw_start;
 	u8 fp_start;
@@ -99,8 +107,6 @@ struct dispc_features {
 	u16 hp_max;
 	u8 mgr_width_start;
 	u8 mgr_height_start;
-	u16 mgr_width_max;
-	u16 mgr_height_max;
 	int (*calc_scaling) (unsigned long pclk, unsigned long lclk,
 		const struct omap_video_timings *mgr_timings,
 		u16 width, u16 height, u16 out_width, u16 out_height,
@@ -122,6 +128,7 @@ struct dispc_features {
 	u32 burst_size_unit; /* in bytes */
 
 	struct dispc_reg_fields *reg_fields;
+	struct dispc_param_ranges *params;
 };
 
 #define DISPC_MAX_NR_FIFOS 5
@@ -2159,8 +2166,7 @@ static int dispc_ovl_calc_scaling_24xx(unsigned long pclk, unsigned long lclk,
 	int error;
 	u16 in_width, in_height;
 	int min_factor = min(*decim_x, *decim_y);
-	const int maxsinglelinewidth =
-			dss_feat_get_param_max(FEAT_PARAM_LINEWIDTH);
+	const int maxsinglelinewidth = dispc.feat->params->linewidth.max;
 
 	*five_taps = false;
 
@@ -2200,8 +2206,7 @@ static int dispc_ovl_calc_scaling_34xx(unsigned long pclk, unsigned long lclk,
 	int error;
 	u16 in_width, in_height;
 	int min_factor = min(*decim_x, *decim_y);
-	const int maxsinglelinewidth =
-			dss_feat_get_param_max(FEAT_PARAM_LINEWIDTH);
+	const int maxsinglelinewidth = dispc.feat->params->linewidth.max;
 
 	do {
 		in_height = DIV_ROUND_UP(height, *decim_y);
@@ -2266,9 +2271,8 @@ static int dispc_ovl_calc_scaling_44xx(unsigned long pclk, unsigned long lclk,
 	u16 in_width, in_width_max;
 	int decim_x_min = *decim_x;
 	u16 in_height = DIV_ROUND_UP(height, *decim_y);
-	const int maxsinglelinewidth =
-				dss_feat_get_param_max(FEAT_PARAM_LINEWIDTH);
-	const int maxdownscale = dss_feat_get_param_max(FEAT_PARAM_DOWNSCALE);
+	const int maxsinglelinewidth = dispc.feat->params->linewidth.max;
+	const int maxdownscale = dispc.feat->params->downscale.max;
 
 	if (mem_to_mem) {
 		in_width_max = out_width * maxdownscale;
@@ -2306,7 +2310,7 @@ static int dispc_ovl_calc_scaling(unsigned long pclk, unsigned long lclk,
 		int *x_predecim, int *y_predecim, u16 pos_x,
 		enum omap_dss_rotation_type rotation_type, bool mem_to_mem)
 {
-	const int maxdownscale = dss_feat_get_param_max(FEAT_PARAM_DOWNSCALE);
+	const int maxdownscale = dispc.feat->params->downscale.max;
 	const int max_decim_limit = 16;
 	unsigned long core_clk = 0;
 	int decim_x, decim_y, ret;
@@ -2974,8 +2978,8 @@ void dispc_mgr_set_lcd_config(enum omap_channel channel,
 
 static bool _dispc_mgr_size_ok(u16 width, u16 height)
 {
-	return width <= dispc.feat->mgr_width_max &&
-		height <= dispc.feat->mgr_height_max;
+	return width <= dispc.feat->params->mgr_width.max &&
+		height <= dispc.feat->params->mgr_height.max;
 }
 
 static bool _dispc_lcd_timings_ok(int hsw, int hfp, int hbp,
@@ -3547,8 +3551,8 @@ void dispc_find_clk_divs(unsigned long req_pck, unsigned long fck,
 	u16 best_ld, cur_ld;
 	u16 best_pd, cur_pd;
 
-	pcd_min = dss_feat_get_param_min(FEAT_PARAM_DSS_PCD);
-	pcd_max = dss_feat_get_param_max(FEAT_PARAM_DSS_PCD);
+	pcd_min = dispc.feat->params->pcd.min;
+	pcd_max = dispc.feat->params->pcd.max;
 
 	best_pck = 0;
 	best_ld = 0;
@@ -4099,6 +4103,42 @@ static struct dispc_reg_fields omap5_dispc_reg_fields = {
 	.vert_accu		=	{ 26, 16 },
 };
 
+static struct dispc_param_ranges omap2_dispc_param_ranges = {
+	.pcd			=	{ 2,  255 },
+	.downscale		=	{ 1,    2 },
+	/*
+	 * Assuming the line width buffer to be 768 pixels as OMAP2 DISPC
+	 * scaler cannot scale a image with width more than 768.
+	 */
+	.linewidth		=	{ 1,  768 },
+	.mgr_width		=	{ 1, 2048 },
+	.mgr_height		=	{ 1, 2048 },
+};
+
+static struct dispc_param_ranges omap3_dispc_param_ranges = {
+	.pcd			=	{ 1,  255 },
+	.downscale		=	{ 1,    4 },
+	.linewidth		=	{ 1, 1024 },
+	.mgr_width		=	{ 1, 2048 },
+	.mgr_height		=	{ 1, 2048 },
+};
+
+static struct dispc_param_ranges omap4_dispc_param_ranges = {
+	.pcd			=	{ 1,  255 },
+	.downscale		=	{ 1,    4 },
+	.linewidth		=	{ 1, 2048 },
+	.mgr_width		=	{ 1, 2048 },
+	.mgr_height		=	{ 1, 2048 },
+};
+
+static struct dispc_param_ranges omap5_dispc_param_ranges = {
+	.pcd			=	{ 1,  255 },
+	.downscale		=	{ 1,    4 },
+	.linewidth		=	{ 1, 2048 },
+	.mgr_width		=	{ 1, 2048 },
+	.mgr_height		=	{ 1, 2048 },
+};
+
 static const struct dispc_features omap24xx_dispc_feats __initconst = {
 	.sw_start		=	5,
 	.fp_start		=	15,
@@ -4108,8 +4148,6 @@ static const struct dispc_features omap24xx_dispc_feats __initconst = {
 	.hp_max			=	256,
 	.mgr_width_start	=	10,
 	.mgr_height_start	=	26,
-	.mgr_width_max		=	2048,
-	.mgr_height_max		=	2048,
 	.calc_scaling		=	dispc_ovl_calc_scaling_24xx,
 	.calc_core_clk		=	calc_core_clk_24xx,
 	.num_fifos		=	3,
@@ -4117,6 +4155,7 @@ static const struct dispc_features omap24xx_dispc_feats __initconst = {
 	.buffer_size_unit	=	1,
 	.burst_size_unit	=	8,
 	.reg_fields		=	&omap2_dispc_reg_fields,
+	.params			=	&omap2_dispc_param_ranges,
 };
 
 static const struct dispc_features omap34xx_rev1_0_dispc_feats __initconst = {
@@ -4128,8 +4167,6 @@ static const struct dispc_features omap34xx_rev1_0_dispc_feats __initconst = {
 	.hp_max			=	256,
 	.mgr_width_start	=	10,
 	.mgr_height_start	=	26,
-	.mgr_width_max		=	2048,
-	.mgr_height_max		=	2048,
 	.calc_scaling		=	dispc_ovl_calc_scaling_34xx,
 	.calc_core_clk		=	calc_core_clk_34xx,
 	.num_fifos		=	3,
@@ -4137,6 +4174,7 @@ static const struct dispc_features omap34xx_rev1_0_dispc_feats __initconst = {
 	.buffer_size_unit	=	1,
 	.burst_size_unit	=	8,
 	.reg_fields		=	&omap3_dispc_reg_fields,
+	.params			=	&omap3_dispc_param_ranges,
 };
 
 static const struct dispc_features omap34xx_rev3_0_dispc_feats __initconst = {
@@ -4148,8 +4186,6 @@ static const struct dispc_features omap34xx_rev3_0_dispc_feats __initconst = {
 	.hp_max			=	4096,
 	.mgr_width_start	=	10,
 	.mgr_height_start	=	26,
-	.mgr_width_max		=	2048,
-	.mgr_height_max		=	2048,
 	.calc_scaling		=	dispc_ovl_calc_scaling_34xx,
 	.calc_core_clk		=	calc_core_clk_34xx,
 	.num_fifos		=	3,
@@ -4157,6 +4193,7 @@ static const struct dispc_features omap34xx_rev3_0_dispc_feats __initconst = {
 	.buffer_size_unit	=	1,
 	.burst_size_unit	=	8,
 	.reg_fields		=	&omap3_dispc_reg_fields,
+	.params			=	&omap3_dispc_param_ranges,
 };
 
 static const struct dispc_features omap44xx_dispc_feats __initconst = {
@@ -4168,8 +4205,6 @@ static const struct dispc_features omap44xx_dispc_feats __initconst = {
 	.hp_max			=	4096,
 	.mgr_width_start	=	10,
 	.mgr_height_start	=	26,
-	.mgr_width_max		=	2048,
-	.mgr_height_max		=	2048,
 	.calc_scaling		=	dispc_ovl_calc_scaling_44xx,
 	.calc_core_clk		=	calc_core_clk_44xx,
 	.num_fifos		=	5,
@@ -4177,6 +4212,7 @@ static const struct dispc_features omap44xx_dispc_feats __initconst = {
 	.buffer_size_unit	=	16,
 	.burst_size_unit	=	16,
 	.reg_fields		=	&omap4_dispc_reg_fields,
+	.params			=	&omap4_dispc_param_ranges,
 };
 
 static const struct dispc_features omap54xx_dispc_feats __initconst = {
@@ -4188,8 +4224,6 @@ static const struct dispc_features omap54xx_dispc_feats __initconst = {
 	.hp_max			=	4096,
 	.mgr_width_start	=	11,
 	.mgr_height_start	=	27,
-	.mgr_width_max		=	4096,
-	.mgr_height_max		=	4096,
 	.calc_scaling		=	dispc_ovl_calc_scaling_44xx,
 	.calc_core_clk		=	calc_core_clk_44xx,
 	.num_fifos		=	5,
@@ -4197,6 +4231,7 @@ static const struct dispc_features omap54xx_dispc_feats __initconst = {
 	.buffer_size_unit	=	16,
 	.burst_size_unit	=	16,
 	.reg_fields		=	&omap5_dispc_reg_fields,
+	.params			=	&omap5_dispc_param_ranges,
 };
 
 static int __init dispc_init_features(struct platform_device *pdev)
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 18842e2..0b68001 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -147,6 +147,10 @@ struct omapdss_reg_field {
 	u8 start, end;
 };
 
+struct omapdss_param_range {
+	int min, max;
+};
+
 struct dss_lcd_mgr_config {
 	enum dss_io_pad_mode io_pad_mode;
 
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index defdfc0..3a9d1df 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -385,24 +385,16 @@ static const char * const omap5_dss_clk_source_names[] = {
 
 static const struct dss_param_range omap2_dss_param_range[] = {
 	[FEAT_PARAM_DSS_FCK]			= { 0, 173000000 },
-	[FEAT_PARAM_DSS_PCD]			= { 2, 255 },
 	[FEAT_PARAM_DSIPLL_REGN]		= { 0, 0 },
 	[FEAT_PARAM_DSIPLL_REGM]		= { 0, 0 },
 	[FEAT_PARAM_DSIPLL_REGM_DISPC]		= { 0, 0 },
 	[FEAT_PARAM_DSIPLL_REGM_DSI]		= { 0, 0 },
 	[FEAT_PARAM_DSIPLL_FINT]		= { 0, 0 },
 	[FEAT_PARAM_DSIPLL_LPDIV]		= { 0, 0 },
-	[FEAT_PARAM_DOWNSCALE]			= { 1, 2 },
-	/*
-	 * Assuming the line width buffer to be 768 pixels as OMAP2 DISPC
-	 * scaler cannot scale a image with width more than 768.
-	 */
-	[FEAT_PARAM_LINEWIDTH]			= { 1, 768 },
 };
 
 static const struct dss_param_range omap3_dss_param_range[] = {
 	[FEAT_PARAM_DSS_FCK]			= { 0, 173000000 },
-	[FEAT_PARAM_DSS_PCD]			= { 1, 255 },
 	[FEAT_PARAM_DSIPLL_REGN]		= { 0, (1 << 7) - 1 },
 	[FEAT_PARAM_DSIPLL_REGM]		= { 0, (1 << 11) - 1 },
 	[FEAT_PARAM_DSIPLL_REGM_DISPC]		= { 0, (1 << 4) - 1 },
@@ -410,13 +402,10 @@ static const struct dss_param_range omap3_dss_param_range[] = {
 	[FEAT_PARAM_DSIPLL_FINT]		= { 750000, 2100000 },
 	[FEAT_PARAM_DSIPLL_LPDIV]		= { 1, (1 << 13) - 1},
 	[FEAT_PARAM_DSI_FCK]			= { 0, 173000000 },
-	[FEAT_PARAM_DOWNSCALE]			= { 1, 4 },
-	[FEAT_PARAM_LINEWIDTH]			= { 1, 1024 },
 };
 
 static const struct dss_param_range omap4_dss_param_range[] = {
 	[FEAT_PARAM_DSS_FCK]			= { 0, 186000000 },
-	[FEAT_PARAM_DSS_PCD]			= { 1, 255 },
 	[FEAT_PARAM_DSIPLL_REGN]		= { 0, (1 << 8) - 1 },
 	[FEAT_PARAM_DSIPLL_REGM]		= { 0, (1 << 12) - 1 },
 	[FEAT_PARAM_DSIPLL_REGM_DISPC]		= { 0, (1 << 5) - 1 },
@@ -424,13 +413,10 @@ static const struct dss_param_range omap4_dss_param_range[] = {
 	[FEAT_PARAM_DSIPLL_FINT]		= { 500000, 2500000 },
 	[FEAT_PARAM_DSIPLL_LPDIV]		= { 0, (1 << 13) - 1 },
 	[FEAT_PARAM_DSI_FCK]			= { 0, 170000000 },
-	[FEAT_PARAM_DOWNSCALE]			= { 1, 4 },
-	[FEAT_PARAM_LINEWIDTH]			= { 1, 2048 },
 };
 
 static const struct dss_param_range omap5_dss_param_range[] = {
 	[FEAT_PARAM_DSS_FCK]			= { 0, 200000000 },
-	[FEAT_PARAM_DSS_PCD]			= { 1, 255 },
 	[FEAT_PARAM_DSIPLL_REGN]		= { 0, (1 << 8) - 1 },
 	[FEAT_PARAM_DSIPLL_REGM]		= { 0, (1 << 12) - 1 },
 	[FEAT_PARAM_DSIPLL_REGM_DISPC]		= { 0, (1 << 5) - 1 },
@@ -438,8 +424,6 @@ static const struct dss_param_range omap5_dss_param_range[] = {
 	[FEAT_PARAM_DSIPLL_FINT]		= { 500000, 2500000 },
 	[FEAT_PARAM_DSIPLL_LPDIV]		= { 0, (1 << 13) - 1 },
 	[FEAT_PARAM_DSI_FCK]			= { 0, 170000000 },
-	[FEAT_PARAM_DOWNSCALE]			= { 1, 4 },
-	[FEAT_PARAM_LINEWIDTH]			= { 1, 2048 },
 };
 
 static const enum dss_feat_id omap2_dss_feat_list[] = {
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index 42a1bd1..40b98ff 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -81,7 +81,6 @@ enum dss_feat_reg_field {
 
 enum dss_range_param {
 	FEAT_PARAM_DSS_FCK,
-	FEAT_PARAM_DSS_PCD,
 	FEAT_PARAM_DSIPLL_REGN,
 	FEAT_PARAM_DSIPLL_REGM,
 	FEAT_PARAM_DSIPLL_REGM_DISPC,
@@ -89,8 +88,6 @@ enum dss_range_param {
 	FEAT_PARAM_DSIPLL_FINT,
 	FEAT_PARAM_DSIPLL_LPDIV,
 	FEAT_PARAM_DSI_FCK,
-	FEAT_PARAM_DOWNSCALE,
-	FEAT_PARAM_LINEWIDTH,
 };
 
 /* DSS Feature Functions */
-- 
1.7.10

