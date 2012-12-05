From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH V2 6/6] OMAPDSS: DSS: Add members fld_dispc_clk_switch and dss_fck_max
Date: Wed, 5 Dec 2012 15:46:08 +0530
Message-ID: <97061645d3d616f766094df66bc0740d4d918155.1354702077.git.cmahapatra@ti.com>
References: <cover.1354086150.git.cmahapatra@ti.com> <cover.1354702077.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45660 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753327Ab2LEKUL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Dec 2012 05:20:11 -0500
In-Reply-To: <cover.1354702077.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

The members fld_dispc_clk_switch and dss_fck_max are added to struct
dss_features and are initialized in corresponding dss_feats structure as per DSS
version. The reg_fields, num_reg_fields and dss_params entries are removed from
struct omap_dss_features as they are no longer referenced.

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
 drivers/video/omap2/dss/dss.c          |   22 ++++++--
 drivers/video/omap2/dss/dss_features.c |   96 --------------------------------
 drivers/video/omap2/dss/dss_features.h |   12 ----
 3 files changed, 16 insertions(+), 114 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 6ca69d5..ef005e2 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -69,6 +69,8 @@ struct dss_features {
 	u8 dss_fck_multiplier;
 	const char *clk_name;
 	int (*dpi_select_source)(enum omap_channel channel);
+	struct omapdss_reg_field fld_dispc_clk_switch;
+	int dss_fck_max;
 };
 
 static struct {
@@ -308,7 +310,6 @@ static void dss_select_dispc_clk_source(enum omap_dss_clk_source clk_src)
 {
 	struct platform_device *dsidev;
 	int b;
-	u8 start, end;
 
 	switch (clk_src) {
 	case OMAP_DSS_CLK_SRC_FCK:
@@ -329,9 +330,8 @@ static void dss_select_dispc_clk_source(enum omap_dss_clk_source clk_src)
 		return;
 	}
 
-	dss_feat_get_reg_field(FEAT_REG_DISPC_CLK_SWITCH, &start, &end);
-
-	REG_FLD_MOD(DSS_CONTROL, b, start, end);	/* DISPC_CLK_SWITCH */
+	REG_FLD_MOD(DSS_CONTROL, b, dss.feat->fld_dispc_clk_switch.start,
+		dss.feat->fld_dispc_clk_switch.end);  /* DISPC_CLK_SWITCH */
 
 	dss.dispc_clk_source = clk_src;
 }
@@ -497,7 +497,7 @@ static int dss_setup_default_clock(void)
 	if (dss.dpll4_m4_ck == NULL)
 		return 0;
 
-	max_dss_fck = dss_feat_get_param_max(FEAT_PARAM_DSS_FCK);
+	max_dss_fck = dss.feat->dss_fck_max;
 
 	prate = dss_get_dpll4_rate();
 
@@ -533,7 +533,7 @@ int dss_calc_clock_div(unsigned long req_pck, struct dss_clock_info *dss_cinfo,
 
 	prate = dss_get_dpll4_rate();
 
-	max_dss_fck = dss_feat_get_param_max(FEAT_PARAM_DSS_FCK);
+	max_dss_fck = dss.feat->dss_fck_max;
 
 	fck = clk_get_rate(dss.dss_clk);
 	if (req_pck == dss.cache_req_pck && prate == dss.cache_prate &&
@@ -822,6 +822,8 @@ static const struct dss_features omap24xx_dss_feats __initconst = {
 	.dss_fck_multiplier	=	2,
 	.clk_name		=	NULL,
 	.dpi_select_source	=	&dss_dpi_select_source_omap2_omap3,
+	.fld_dispc_clk_switch	=	{ 0, 0 },
+	.dss_fck_max		=	173000000,
 };
 
 static const struct dss_features omap34xx_dss_feats __initconst = {
@@ -829,6 +831,8 @@ static const struct dss_features omap34xx_dss_feats __initconst = {
 	.dss_fck_multiplier	=	2,
 	.clk_name		=	"dpll4_m4_ck",
 	.dpi_select_source	=	&dss_dpi_select_source_omap2_omap3,
+	.fld_dispc_clk_switch	=	{ 0, 0 },
+	.dss_fck_max		=	173000000,
 };
 
 static const struct dss_features omap3630_dss_feats __initconst = {
@@ -836,6 +840,8 @@ static const struct dss_features omap3630_dss_feats __initconst = {
 	.dss_fck_multiplier	=	1,
 	.clk_name		=	"dpll4_m4_ck",
 	.dpi_select_source	=	&dss_dpi_select_source_omap2_omap3,
+	.fld_dispc_clk_switch	=	{ 0, 0 },
+	.dss_fck_max		=	173000000,
 };
 
 static const struct dss_features omap44xx_dss_feats __initconst = {
@@ -843,6 +849,8 @@ static const struct dss_features omap44xx_dss_feats __initconst = {
 	.dss_fck_multiplier	=	1,
 	.clk_name		=	"dpll_per_m5x2_ck",
 	.dpi_select_source	=	&dss_dpi_select_source_omap4,
+	.fld_dispc_clk_switch	=	{ 9, 8 },
+	.dss_fck_max		=	186000000,
 };
 
 static const struct dss_features omap54xx_dss_feats __initconst = {
@@ -850,6 +858,8 @@ static const struct dss_features omap54xx_dss_feats __initconst = {
 	.dss_fck_multiplier	=	1,
 	.clk_name		=	"dpll_per_h12x2_ck",
 	.dpi_select_source	=	&dss_dpi_select_source_omap5,
+	.fld_dispc_clk_switch	=	{ 9, 7 },
+	.dss_fck_max		=	200000000,
 };
 
 static int __init dss_init_features(struct platform_device *pdev)
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 75dddb2..e7fca28 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -27,19 +27,7 @@
 #include "dss.h"
 #include "dss_features.h"
 
-/* Defines a generic omap register field */
-struct dss_reg_field {
-	u8 start, end;
-};
-
-struct dss_param_range {
-	int min, max;
-};
-
 struct omap_dss_features {
-	const struct dss_reg_field *reg_fields;
-	const int num_reg_fields;
-
 	const enum dss_feat_id *features;
 	const int num_features;
 
@@ -51,7 +39,6 @@ struct omap_dss_features {
 	const enum omap_color_mode *supported_color_modes;
 	const enum omap_overlay_caps *overlay_caps;
 	const char * const *clksrc_names;
-	const struct dss_param_range *dss_params;
 
 	const enum omap_dss_rotation_type supported_rotation_types;
 };
@@ -59,22 +46,6 @@ struct omap_dss_features {
 /* This struct is assigned to one of the below during initialization */
 static const struct omap_dss_features *omap_current_dss_features;
 
-static const struct dss_reg_field omap2_dss_reg_fields[] = {
-	[FEAT_REG_DISPC_CLK_SWITCH]		= { 0, 0 },
-};
-
-static const struct dss_reg_field omap3_dss_reg_fields[] = {
-	[FEAT_REG_DISPC_CLK_SWITCH]		= { 0, 0 },
-};
-
-static const struct dss_reg_field omap4_dss_reg_fields[] = {
-	[FEAT_REG_DISPC_CLK_SWITCH]		= { 9, 8 },
-};
-
-static const struct dss_reg_field omap5_dss_reg_fields[] = {
-	[FEAT_REG_DISPC_CLK_SWITCH]		= { 9, 7 },
-};
-
 static const enum omap_display_type omap2_dss_supported_displays[] = {
 	/* OMAP_DSS_CHANNEL_LCD */
 	OMAP_DISPLAY_TYPE_DPI | OMAP_DISPLAY_TYPE_DBI,
@@ -367,22 +338,6 @@ static const char * const omap5_dss_clk_source_names[] = {
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
@@ -527,9 +482,6 @@ static const enum dss_feat_id omap5_dss_feat_list[] = {
 
 /* OMAP2 DSS Features */
 static const struct omap_dss_features omap2_dss_features = {
-	.reg_fields = omap2_dss_reg_fields,
-	.num_reg_fields = ARRAY_SIZE(omap2_dss_reg_fields),
-
 	.features = omap2_dss_feat_list,
 	.num_features = ARRAY_SIZE(omap2_dss_feat_list),
 
@@ -540,15 +492,11 @@ static const struct omap_dss_features omap2_dss_features = {
 	.supported_color_modes = omap2_dss_supported_color_modes,
 	.overlay_caps = omap2_dss_overlay_caps,
 	.clksrc_names = omap2_dss_clk_source_names,
-	.dss_params = omap2_dss_param_range,
 	.supported_rotation_types = OMAP_DSS_ROT_DMA | OMAP_DSS_ROT_VRFB,
 };
 
 /* OMAP3 DSS Features */
 static const struct omap_dss_features omap3430_dss_features = {
-	.reg_fields = omap3_dss_reg_fields,
-	.num_reg_fields = ARRAY_SIZE(omap3_dss_reg_fields),
-
 	.features = omap3430_dss_feat_list,
 	.num_features = ARRAY_SIZE(omap3430_dss_feat_list),
 
@@ -559,7 +507,6 @@ static const struct omap_dss_features omap3430_dss_features = {
 	.supported_color_modes = omap3_dss_supported_color_modes,
 	.overlay_caps = omap3430_dss_overlay_caps,
 	.clksrc_names = omap3_dss_clk_source_names,
-	.dss_params = omap3_dss_param_range,
 	.supported_rotation_types = OMAP_DSS_ROT_DMA | OMAP_DSS_ROT_VRFB,
 };
 
@@ -568,9 +515,6 @@ static const struct omap_dss_features omap3430_dss_features = {
  * vdds_dsi regulator.
  */
 static const struct omap_dss_features am35xx_dss_features = {
-	.reg_fields = omap3_dss_reg_fields,
-	.num_reg_fields = ARRAY_SIZE(omap3_dss_reg_fields),
-
 	.features = am35xx_dss_feat_list,
 	.num_features = ARRAY_SIZE(am35xx_dss_feat_list),
 
@@ -581,14 +525,10 @@ static const struct omap_dss_features am35xx_dss_features = {
 	.supported_color_modes = omap3_dss_supported_color_modes,
 	.overlay_caps = omap3430_dss_overlay_caps,
 	.clksrc_names = omap3_dss_clk_source_names,
-	.dss_params = omap3_dss_param_range,
 	.supported_rotation_types = OMAP_DSS_ROT_DMA | OMAP_DSS_ROT_VRFB,
 };
 
 static const struct omap_dss_features omap3630_dss_features = {
-	.reg_fields = omap3_dss_reg_fields,
-	.num_reg_fields = ARRAY_SIZE(omap3_dss_reg_fields),
-
 	.features = omap3630_dss_feat_list,
 	.num_features = ARRAY_SIZE(omap3630_dss_feat_list),
 
@@ -599,16 +539,12 @@ static const struct omap_dss_features omap3630_dss_features = {
 	.supported_color_modes = omap3_dss_supported_color_modes,
 	.overlay_caps = omap3630_dss_overlay_caps,
 	.clksrc_names = omap3_dss_clk_source_names,
-	.dss_params = omap3_dss_param_range,
 	.supported_rotation_types = OMAP_DSS_ROT_DMA | OMAP_DSS_ROT_VRFB,
 };
 
 /* OMAP4 DSS Features */
 /* For OMAP4430 ES 1.0 revision */
 static const struct omap_dss_features omap4430_es1_0_dss_features  = {
-	.reg_fields = omap4_dss_reg_fields,
-	.num_reg_fields = ARRAY_SIZE(omap4_dss_reg_fields),
-
 	.features = omap4430_es1_0_dss_feat_list,
 	.num_features = ARRAY_SIZE(omap4430_es1_0_dss_feat_list),
 
@@ -620,15 +556,11 @@ static const struct omap_dss_features omap4430_es1_0_dss_features  = {
 	.supported_color_modes = omap4_dss_supported_color_modes,
 	.overlay_caps = omap4_dss_overlay_caps,
 	.clksrc_names = omap4_dss_clk_source_names,
-	.dss_params = omap4_dss_param_range,
 	.supported_rotation_types = OMAP_DSS_ROT_DMA | OMAP_DSS_ROT_TILER,
 };
 
 /* For OMAP4430 ES 2.0, 2.1 and 2.2 revisions */
 static const struct omap_dss_features omap4430_es2_0_1_2_dss_features = {
-	.reg_fields = omap4_dss_reg_fields,
-	.num_reg_fields = ARRAY_SIZE(omap4_dss_reg_fields),
-
 	.features = omap4430_es2_0_1_2_dss_feat_list,
 	.num_features = ARRAY_SIZE(omap4430_es2_0_1_2_dss_feat_list),
 
@@ -640,15 +572,11 @@ static const struct omap_dss_features omap4430_es2_0_1_2_dss_features = {
 	.supported_color_modes = omap4_dss_supported_color_modes,
 	.overlay_caps = omap4_dss_overlay_caps,
 	.clksrc_names = omap4_dss_clk_source_names,
-	.dss_params = omap4_dss_param_range,
 	.supported_rotation_types = OMAP_DSS_ROT_DMA | OMAP_DSS_ROT_TILER,
 };
 
 /* For all the other OMAP4 versions */
 static const struct omap_dss_features omap4_dss_features = {
-	.reg_fields = omap4_dss_reg_fields,
-	.num_reg_fields = ARRAY_SIZE(omap4_dss_reg_fields),
-
 	.features = omap4_dss_feat_list,
 	.num_features = ARRAY_SIZE(omap4_dss_feat_list),
 
@@ -660,15 +588,11 @@ static const struct omap_dss_features omap4_dss_features = {
 	.supported_color_modes = omap4_dss_supported_color_modes,
 	.overlay_caps = omap4_dss_overlay_caps,
 	.clksrc_names = omap4_dss_clk_source_names,
-	.dss_params = omap4_dss_param_range,
 	.supported_rotation_types = OMAP_DSS_ROT_DMA | OMAP_DSS_ROT_TILER,
 };
 
 /* OMAP5 DSS Features */
 static const struct omap_dss_features omap5_dss_features = {
-	.reg_fields = omap5_dss_reg_fields,
-	.num_reg_fields = ARRAY_SIZE(omap5_dss_reg_fields),
-
 	.features = omap5_dss_feat_list,
 	.num_features = ARRAY_SIZE(omap5_dss_feat_list),
 
@@ -679,7 +603,6 @@ static const struct omap_dss_features omap5_dss_features = {
 	.supported_color_modes = omap4_dss_supported_color_modes,
 	.overlay_caps = omap4_dss_overlay_caps,
 	.clksrc_names = omap5_dss_clk_source_names,
-	.dss_params = omap5_dss_param_range,
 	.supported_rotation_types = OMAP_DSS_ROT_DMA | OMAP_DSS_ROT_TILER,
 };
 
@@ -744,16 +667,6 @@ int dss_feat_get_num_wbs(void)
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
@@ -801,15 +714,6 @@ bool dss_has_feature(enum dss_feat_id id)
 	return false;
 }
 
-void dss_feat_get_reg_field(enum dss_feat_reg_field id, u8 *start, u8 *end)
-{
-	if (id >= omap_current_dss_features->num_reg_fields)
-		BUG();
-
-	*start = omap_current_dss_features->reg_fields[id].start;
-	*end = omap_current_dss_features->reg_fields[id].end;
-}
-
 bool dss_feat_rotation_type_supported(enum omap_dss_rotation_type rot_type)
 {
 	return omap_current_dss_features->supported_rotation_types & rot_type;
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index d9f69c7..0b84484 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -70,21 +70,10 @@ enum dss_feat_id {
 	FEAT_DSI_PHY_DCC,
 };
 
-/* DSS register field id */
-enum dss_feat_reg_field {
-	FEAT_REG_DISPC_CLK_SWITCH,
-};
-
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
@@ -96,7 +85,6 @@ const char *dss_feat_get_clk_source_name(enum omap_dss_clk_source id);
 bool dss_feat_rotation_type_supported(enum omap_dss_rotation_type rot_type);
 
 bool dss_has_feature(enum dss_feat_id id);
-void dss_feat_get_reg_field(enum dss_feat_reg_field id, u8 *start, u8 *end);
 void dss_features_init(enum omapdss_version version);
 #if defined(CONFIG_OMAP4_DSS_HDMI)
 void dss_init_hdmi_ip_ops(struct hdmi_ip_data *ip_data,
-- 
1.7.10

