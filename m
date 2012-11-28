From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH 7/7] OMAPDSS: DSI: Add FEAT_PARAM_DSS_FCK
Date: Wed, 28 Nov 2012 16:11:30 +0530
Message-ID: <d9e31947f5db35921002b7b3a57928fbc0b1630d.1354086150.git.cmahapatra@ti.com>
References: <cover.1354086150.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36941 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752629Ab2K1Kqy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Nov 2012 05:46:54 -0500
In-Reply-To: <cover.1354086150.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

The FEAT_PARAM_DSS_FCK is added and initialized in corresponding DSS Version
specific struct dsi_param_range. As, the struct dss_param_range is no longer
used all its references are thereby removed from omap_dss_features.

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
 drivers/video/omap2/dss/dsi.c          |    9 ++++++--
 drivers/video/omap2/dss/dss_features.c |   39 --------------------------------
 drivers/video/omap2/dss/dss_features.h |    6 -----
 3 files changed, 7 insertions(+), 47 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index f1f617c..3e0e9d7 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -352,6 +352,7 @@ enum dsi_feat_reg_field {
 };
 
 enum dsi_range_param {
+	FEAT_PARAM_DSS_FCK,
 	FEAT_PARAM_DSIPLL_REGN,
 	FEAT_PARAM_DSIPLL_REGM,
 	FEAT_PARAM_DSIPLL_REGM_DISPC,
@@ -1353,7 +1354,7 @@ int dsi_pll_calc_clock_div_pck(struct platform_device *dsidev,
 
 	dss_sys_clk = clk_get_rate(dsi->sys_clk);
 
-	max_dss_fck = dss_feat_get_param_max(FEAT_PARAM_DSS_FCK);
+	max_dss_fck = dsi_feat->params[FEAT_PARAM_DSS_FCK].max;
 
 	if (req_pck == dsi->cache_req_pck &&
 			dsi->cache_cinfo.clkin == dss_sys_clk) {
@@ -1547,7 +1548,7 @@ static int dsi_pll_calc_dispc_fck(struct platform_device *dsidev,
 	struct dispc_clock_info best_dispc;
 	bool match;
 
-	max_dss_fck = dss_feat_get_param_max(FEAT_PARAM_DSS_FCK);
+	max_dss_fck = dsi_feat->params[FEAT_PARAM_DSS_FCK].max;
 
 	min_fck_per_pck = CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK;
 
@@ -5254,6 +5255,7 @@ static struct register_field omap5_dsi_reg_fields[] = {
 };
 
 static struct param_range omap2_dsi_param_range[] = {
+	[FEAT_PARAM_DSS_FCK]			= { 0, 173000000 },
 	[FEAT_PARAM_DSIPLL_REGN]		= { 0, 0 },
 	[FEAT_PARAM_DSIPLL_REGM]		= { 0, 0 },
 	[FEAT_PARAM_DSIPLL_REGM_DISPC]		= { 0, 0 },
@@ -5263,6 +5265,7 @@ static struct param_range omap2_dsi_param_range[] = {
 };
 
 static struct param_range omap3_dsi_param_range[] = {
+	[FEAT_PARAM_DSS_FCK]			= { 0, 173000000 },
 	[FEAT_PARAM_DSIPLL_REGN]		= { 0, (1 << 7) - 1 },
 	[FEAT_PARAM_DSIPLL_REGM]		= { 0, (1 << 11) - 1 },
 	[FEAT_PARAM_DSIPLL_REGM_DISPC]		= { 0, (1 << 4) - 1 },
@@ -5273,6 +5276,7 @@ static struct param_range omap3_dsi_param_range[] = {
 };
 
 static struct param_range omap4_dsi_param_range[] = {
+	[FEAT_PARAM_DSS_FCK]			= { 0, 186000000 },
 	[FEAT_PARAM_DSIPLL_REGN]		= { 0, (1 << 8) - 1 },
 	[FEAT_PARAM_DSIPLL_REGM]		= { 0, (1 << 12) - 1 },
 	[FEAT_PARAM_DSIPLL_REGM_DISPC]		= { 0, (1 << 5) - 1 },
@@ -5283,6 +5287,7 @@ static struct param_range omap4_dsi_param_range[] = {
 };
 
 static struct param_range omap5_dsi_param_range[] = {
+	[FEAT_PARAM_DSS_FCK]			= { 0, 200000000 },
 	[FEAT_PARAM_DSIPLL_REGN]		= { 0, (1 << 8) - 1 },
 	[FEAT_PARAM_DSIPLL_REGM]		= { 0, (1 << 12) - 1 },
 	[FEAT_PARAM_DSIPLL_REGM_DISPC]		= { 0, (1 << 5) - 1 },
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 06c04f3..e7fca28 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -27,10 +27,6 @@
 #include "dss.h"
 #include "dss_features.h"
 
-struct dss_param_range {
-	int min, max;
-};
-
 struct omap_dss_features {
 	const enum dss_feat_id *features;
 	const int num_features;
@@ -43,7 +39,6 @@ struct omap_dss_features {
 	const enum omap_color_mode *supported_color_modes;
 	const enum omap_overlay_caps *overlay_caps;
 	const char * const *clksrc_names;
-	const struct dss_param_range *dss_params;
 
 	const enum omap_dss_rotation_type supported_rotation_types;
 };
@@ -343,22 +338,6 @@ static const char * const omap5_dss_clk_source_names[] = {
 	[OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DSI]	= "DPLL_DSI1_C_CLK2",
 };
 
-static const struct dss_param_range omap2_dss_param_range[] = {
-	[FEAT_PARAM_DSS_FCK]			= { 0, 173000000 },
-};
-
-static const struct dss_param_range omap3_dss_param_range[] = {
-	[FEAT_PARAM_DSS_FCK]			= { 0, 173000000 },
-};
-
-static const struct dss_param_range omap4_dss_param_range[] = {
-	[FEAT_PARAM_DSS_FCK]			= { 0, 186000000 },
-};
-
-static const struct dss_param_range omap5_dss_param_range[] = {
-	[FEAT_PARAM_DSS_FCK]			= { 0, 200000000 },
-};
-
 static const enum dss_feat_id omap2_dss_feat_list[] = {
 	FEAT_LCDENABLEPOL,
 	FEAT_LCDENABLESIGNAL,
@@ -513,7 +492,6 @@ static const struct omap_dss_features omap2_dss_features = {
 	.supported_color_modes = omap2_dss_supported_color_modes,
 	.overlay_caps = omap2_dss_overlay_caps,
 	.clksrc_names = omap2_dss_clk_source_names,
-	.dss_params = omap2_dss_param_range,
 	.supported_rotation_types = OMAP_DSS_ROT_DMA | OMAP_DSS_ROT_VRFB,
 };
 
@@ -529,7 +507,6 @@ static const struct omap_dss_features omap3430_dss_features = {
 	.supported_color_modes = omap3_dss_supported_color_modes,
 	.overlay_caps = omap3430_dss_overlay_caps,
 	.clksrc_names = omap3_dss_clk_source_names,
-	.dss_params = omap3_dss_param_range,
 	.supported_rotation_types = OMAP_DSS_ROT_DMA | OMAP_DSS_ROT_VRFB,
 };
 
@@ -548,7 +525,6 @@ static const struct omap_dss_features am35xx_dss_features = {
 	.supported_color_modes = omap3_dss_supported_color_modes,
 	.overlay_caps = omap3430_dss_overlay_caps,
 	.clksrc_names = omap3_dss_clk_source_names,
-	.dss_params = omap3_dss_param_range,
 	.supported_rotation_types = OMAP_DSS_ROT_DMA | OMAP_DSS_ROT_VRFB,
 };
 
@@ -563,7 +539,6 @@ static const struct omap_dss_features omap3630_dss_features = {
 	.supported_color_modes = omap3_dss_supported_color_modes,
 	.overlay_caps = omap3630_dss_overlay_caps,
 	.clksrc_names = omap3_dss_clk_source_names,
-	.dss_params = omap3_dss_param_range,
 	.supported_rotation_types = OMAP_DSS_ROT_DMA | OMAP_DSS_ROT_VRFB,
 };
 
@@ -581,7 +556,6 @@ static const struct omap_dss_features omap4430_es1_0_dss_features  = {
 	.supported_color_modes = omap4_dss_supported_color_modes,
 	.overlay_caps = omap4_dss_overlay_caps,
 	.clksrc_names = omap4_dss_clk_source_names,
-	.dss_params = omap4_dss_param_range,
 	.supported_rotation_types = OMAP_DSS_ROT_DMA | OMAP_DSS_ROT_TILER,
 };
 
@@ -598,7 +572,6 @@ static const struct omap_dss_features omap4430_es2_0_1_2_dss_features = {
 	.supported_color_modes = omap4_dss_supported_color_modes,
 	.overlay_caps = omap4_dss_overlay_caps,
 	.clksrc_names = omap4_dss_clk_source_names,
-	.dss_params = omap4_dss_param_range,
 	.supported_rotation_types = OMAP_DSS_ROT_DMA | OMAP_DSS_ROT_TILER,
 };
 
@@ -615,7 +588,6 @@ static const struct omap_dss_features omap4_dss_features = {
 	.supported_color_modes = omap4_dss_supported_color_modes,
 	.overlay_caps = omap4_dss_overlay_caps,
 	.clksrc_names = omap4_dss_clk_source_names,
-	.dss_params = omap4_dss_param_range,
 	.supported_rotation_types = OMAP_DSS_ROT_DMA | OMAP_DSS_ROT_TILER,
 };
 
@@ -631,7 +603,6 @@ static const struct omap_dss_features omap5_dss_features = {
 	.supported_color_modes = omap4_dss_supported_color_modes,
 	.overlay_caps = omap4_dss_overlay_caps,
 	.clksrc_names = omap5_dss_clk_source_names,
-	.dss_params = omap5_dss_param_range,
 	.supported_rotation_types = OMAP_DSS_ROT_DMA | OMAP_DSS_ROT_TILER,
 };
 
@@ -696,16 +667,6 @@ int dss_feat_get_num_wbs(void)
 	return omap_current_dss_features->num_wbs;
 }
 
-unsigned long dss_feat_get_param_min(enum dss_range_param param)
-{
-	return omap_current_dss_features->dss_params[param].min;
-}
-
-unsigned long dss_feat_get_param_max(enum dss_range_param param)
-{
-	return omap_current_dss_features->dss_params[param].max;
-}
-
 enum omap_display_type dss_feat_get_supported_displays(enum omap_channel channel)
 {
 	return omap_current_dss_features->supported_displays[channel];
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index 97aecf9..0b84484 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -70,16 +70,10 @@ enum dss_feat_id {
 	FEAT_DSI_PHY_DCC,
 };
 
-enum dss_range_param {
-	FEAT_PARAM_DSS_FCK,
-};
-
 /* DSS Feature Functions */
 int dss_feat_get_num_mgrs(void);
 int dss_feat_get_num_ovls(void);
 int dss_feat_get_num_wbs(void);
-unsigned long dss_feat_get_param_min(enum dss_range_param param);
-unsigned long dss_feat_get_param_max(enum dss_range_param param);
 enum omap_display_type dss_feat_get_supported_displays(enum omap_channel channel);
 enum omap_dss_output_id dss_feat_get_supported_outputs(enum omap_channel channel);
 enum omap_color_mode dss_feat_get_supported_color_modes(enum omap_plane plane);
-- 
1.7.10

