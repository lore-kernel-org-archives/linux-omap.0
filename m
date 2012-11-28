From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH 6/7] OMAPDSS: DSS: Add members fld_dispc_clk_switch and dss_fck_max
Date: Wed, 28 Nov 2012 16:11:29 +0530
Message-ID: <66df7240baa284481325c16fbdea21bd68d3ad07.1354086150.git.cmahapatra@ti.com>
References: <cover.1354086150.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47933 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754341Ab2K1Kqt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Nov 2012 05:46:49 -0500
In-Reply-To: <cover.1354086150.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

The members fld_dispc_clk_switch and dss_fck_max are added to struct
dss_features and are initialized in corresponding dss_feats structure as per DSS
version. The reg_fields and num_reg_fields entries are removed from struct
omap_dss_features as they are no longer referenced.

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
 drivers/video/omap2/dss/dss.c          |   22 ++++++++----
 drivers/video/omap2/dss/dss_features.c |   57 --------------------------------
 drivers/video/omap2/dss/dss_features.h |    6 ----
 3 files changed, 16 insertions(+), 69 deletions(-)

diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 6ca69d5..4d74fbe 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -69,6 +69,8 @@ struct dss_features {
 	u8 dss_fck_multiplier;
 	const char *clk_name;
 	int (*dpi_select_source)(enum omap_channel channel);
+	struct register_field fld_dispc_clk_switch;
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
index 75dddb2..06c04f3 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -27,19 +27,11 @@
 #include "dss.h"
 #include "dss_features.h"
 
-/* Defines a generic omap register field */
-struct dss_reg_field {
-	u8 start, end;
-};
-
 struct dss_param_range {
 	int min, max;
 };
 
 struct omap_dss_features {
-	const struct dss_reg_field *reg_fields;
-	const int num_reg_fields;
-
 	const enum dss_feat_id *features;
 	const int num_features;
 
@@ -59,22 +51,6 @@ struct omap_dss_features {
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
@@ -527,9 +503,6 @@ static const enum dss_feat_id omap5_dss_feat_list[] = {
 
 /* OMAP2 DSS Features */
 static const struct omap_dss_features omap2_dss_features = {
-	.reg_fields = omap2_dss_reg_fields,
-	.num_reg_fields = ARRAY_SIZE(omap2_dss_reg_fields),
-
 	.features = omap2_dss_feat_list,
 	.num_features = ARRAY_SIZE(omap2_dss_feat_list),
 
@@ -546,9 +519,6 @@ static const struct omap_dss_features omap2_dss_features = {
 
 /* OMAP3 DSS Features */
 static const struct omap_dss_features omap3430_dss_features = {
-	.reg_fields = omap3_dss_reg_fields,
-	.num_reg_fields = ARRAY_SIZE(omap3_dss_reg_fields),
-
 	.features = omap3430_dss_feat_list,
 	.num_features = ARRAY_SIZE(omap3430_dss_feat_list),
 
@@ -568,9 +538,6 @@ static const struct omap_dss_features omap3430_dss_features = {
  * vdds_dsi regulator.
  */
 static const struct omap_dss_features am35xx_dss_features = {
-	.reg_fields = omap3_dss_reg_fields,
-	.num_reg_fields = ARRAY_SIZE(omap3_dss_reg_fields),
-
 	.features = am35xx_dss_feat_list,
 	.num_features = ARRAY_SIZE(am35xx_dss_feat_list),
 
@@ -586,9 +553,6 @@ static const struct omap_dss_features am35xx_dss_features = {
 };
 
 static const struct omap_dss_features omap3630_dss_features = {
-	.reg_fields = omap3_dss_reg_fields,
-	.num_reg_fields = ARRAY_SIZE(omap3_dss_reg_fields),
-
 	.features = omap3630_dss_feat_list,
 	.num_features = ARRAY_SIZE(omap3630_dss_feat_list),
 
@@ -606,9 +570,6 @@ static const struct omap_dss_features omap3630_dss_features = {
 /* OMAP4 DSS Features */
 /* For OMAP4430 ES 1.0 revision */
 static const struct omap_dss_features omap4430_es1_0_dss_features  = {
-	.reg_fields = omap4_dss_reg_fields,
-	.num_reg_fields = ARRAY_SIZE(omap4_dss_reg_fields),
-
 	.features = omap4430_es1_0_dss_feat_list,
 	.num_features = ARRAY_SIZE(omap4430_es1_0_dss_feat_list),
 
@@ -626,9 +587,6 @@ static const struct omap_dss_features omap4430_es1_0_dss_features  = {
 
 /* For OMAP4430 ES 2.0, 2.1 and 2.2 revisions */
 static const struct omap_dss_features omap4430_es2_0_1_2_dss_features = {
-	.reg_fields = omap4_dss_reg_fields,
-	.num_reg_fields = ARRAY_SIZE(omap4_dss_reg_fields),
-
 	.features = omap4430_es2_0_1_2_dss_feat_list,
 	.num_features = ARRAY_SIZE(omap4430_es2_0_1_2_dss_feat_list),
 
@@ -646,9 +604,6 @@ static const struct omap_dss_features omap4430_es2_0_1_2_dss_features = {
 
 /* For all the other OMAP4 versions */
 static const struct omap_dss_features omap4_dss_features = {
-	.reg_fields = omap4_dss_reg_fields,
-	.num_reg_fields = ARRAY_SIZE(omap4_dss_reg_fields),
-
 	.features = omap4_dss_feat_list,
 	.num_features = ARRAY_SIZE(omap4_dss_feat_list),
 
@@ -666,9 +621,6 @@ static const struct omap_dss_features omap4_dss_features = {
 
 /* OMAP5 DSS Features */
 static const struct omap_dss_features omap5_dss_features = {
-	.reg_fields = omap5_dss_reg_fields,
-	.num_reg_fields = ARRAY_SIZE(omap5_dss_reg_fields),
-
 	.features = omap5_dss_feat_list,
 	.num_features = ARRAY_SIZE(omap5_dss_feat_list),
 
@@ -801,15 +753,6 @@ bool dss_has_feature(enum dss_feat_id id)
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
index d9f69c7..97aecf9 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -70,11 +70,6 @@ enum dss_feat_id {
 	FEAT_DSI_PHY_DCC,
 };
 
-/* DSS register field id */
-enum dss_feat_reg_field {
-	FEAT_REG_DISPC_CLK_SWITCH,
-};
-
 enum dss_range_param {
 	FEAT_PARAM_DSS_FCK,
 };
@@ -96,7 +91,6 @@ const char *dss_feat_get_clk_source_name(enum omap_dss_clk_source id);
 bool dss_feat_rotation_type_supported(enum omap_dss_rotation_type rot_type);
 
 bool dss_has_feature(enum dss_feat_id id);
-void dss_feat_get_reg_field(enum dss_feat_reg_field id, u8 *start, u8 *end);
 void dss_features_init(enum omapdss_version version);
 #if defined(CONFIG_OMAP4_DSS_HDMI)
 void dss_init_hdmi_ip_ops(struct hdmi_ip_data *ip_data,
-- 
1.7.10

