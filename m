From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH V2 5/6] OMAPDSS: DSI: Move DSI specific dss_params to dsi_feats
Date: Wed, 5 Dec 2012 15:46:07 +0530
Message-ID: <a7e8228ad4ae44b30b24648a491b5e64db4cf8fe.1354702077.git.cmahapatra@ti.com>
References: <cover.1354086150.git.cmahapatra@ti.com> <cover.1354702077.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46447 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753327Ab2LEKUH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Dec 2012 05:20:07 -0500
In-Reply-To: <cover.1354702077.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

The DSI specific dss_param_range are moved from struct omap_dss_features to
corresponding struct dsi_param_range, which is initialized in struct dsi_feats
thereby enabling local access.

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
 drivers/video/omap2/dss/dsi.c          |   80 +++++++++++++++++++++++++++-----
 drivers/video/omap2/dss/dss_features.c |   27 -----------
 drivers/video/omap2/dss/dss_features.h |    7 ---
 3 files changed, 69 insertions(+), 45 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 472cdb4..a1ea5ac 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -351,8 +351,20 @@ struct dsi_reg_fields {
 	struct omapdss_reg_field regm_dsi;
 };
 
+struct dsi_param_ranges {
+	struct omapdss_param_range regn;
+	struct omapdss_param_range regm;
+	struct omapdss_param_range regm_dispc;
+	struct omapdss_param_range regm_dsi;
+	struct omapdss_param_range fint;
+	struct omapdss_param_range lpdiv;
+	struct omapdss_param_range dsi_fck;
+	struct omapdss_param_range dss_fck;
+};
+
 struct feats {
 	const struct dsi_reg_fields *reg_fields;
+	const struct dsi_param_ranges *params;
 };
 
 static const struct feats *dsi_feat;
@@ -1342,7 +1354,7 @@ int dsi_pll_calc_clock_div_pck(struct platform_device *dsidev,
 
 	dss_sys_clk = clk_get_rate(dsi->sys_clk);
 
-	max_dss_fck = dss_feat_get_param_max(FEAT_PARAM_DSS_FCK);
+	max_dss_fck = dsi_feat->params->dss_fck.max;
 
 	if (req_pck == dsi->cache_req_pck &&
 			dsi->cache_cinfo.clkin == dss_sys_clk) {
@@ -1518,7 +1530,7 @@ static void dsi_pll_calc_dsi_fck(struct platform_device *dsidev,
 {
 	unsigned long max_dsi_fck;
 
-	max_dsi_fck = dss_feat_get_param_max(FEAT_PARAM_DSI_FCK);
+	max_dsi_fck = dsi_feat->params->dsi_fck.max;
 
 	cinfo->regm_dsi = DIV_ROUND_UP(cinfo->clkin4ddr, max_dsi_fck);
 	cinfo->dsi_pll_hsdiv_dsi_clk = cinfo->clkin4ddr / cinfo->regm_dsi;
@@ -1536,7 +1548,7 @@ static int dsi_pll_calc_dispc_fck(struct platform_device *dsidev,
 	struct dispc_clock_info best_dispc;
 	bool match;
 
-	max_dss_fck = dss_feat_get_param_max(FEAT_PARAM_DSS_FCK);
+	max_dss_fck = dsi_feat->params->dss_fck.max;
 
 	min_fck_per_pck = CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK;
 
@@ -5077,14 +5089,13 @@ static void dsi_calc_clock_param_ranges(struct platform_device *dsidev)
 {
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
-	dsi->regn_max = dss_feat_get_param_max(FEAT_PARAM_DSIPLL_REGN);
-	dsi->regm_max = dss_feat_get_param_max(FEAT_PARAM_DSIPLL_REGM);
-	dsi->regm_dispc_max =
-		dss_feat_get_param_max(FEAT_PARAM_DSIPLL_REGM_DISPC);
-	dsi->regm_dsi_max = dss_feat_get_param_max(FEAT_PARAM_DSIPLL_REGM_DSI);
-	dsi->fint_min = dss_feat_get_param_min(FEAT_PARAM_DSIPLL_FINT);
-	dsi->fint_max = dss_feat_get_param_max(FEAT_PARAM_DSIPLL_FINT);
-	dsi->lpdiv_max = dss_feat_get_param_max(FEAT_PARAM_DSIPLL_LPDIV);
+	dsi->regn_max = dsi_feat->params->regn.max;
+	dsi->regm_max = dsi_feat->params->regm.max;
+	dsi->regm_dispc_max = dsi_feat->params->regm_dispc.max;
+	dsi->regm_dsi_max = dsi_feat->params->regm_dsi.max;
+	dsi->fint_min = dsi_feat->params->fint.min;
+	dsi->fint_max = dsi_feat->params->fint.max;
+	dsi->lpdiv_max = dsi_feat->params->lpdiv.max;
 }
 
 static int dsi_get_clocks(struct platform_device *dsidev)
@@ -5237,20 +5248,67 @@ static struct dsi_reg_fields omap5_dsi_reg_fields = {
 	.regm_dsi		=	{ 30, 26 },
 };
 
+static struct dsi_param_ranges omap2_dsi_param_ranges = {
+	.regn			=	{ 0, 0 },
+	.regm			=	{ 0, 0 },
+	.regm_dispc		=	{ 0, 0 },
+	.regm_dsi		=	{ 0, 0 },
+	.fint			=	{ 0, 0 },
+	.lpdiv			=	{ 0, 0 },
+	.dss_fck		=	{ 0, 173000000 },
+};
+
+static struct dsi_param_ranges omap3_dsi_param_ranges = {
+	.regn			=	{ 0, (1 << 7) - 1 },
+	.regm			=	{ 0, (1 << 11) - 1 },
+	.regm_dispc		=	{ 0, (1 << 4) - 1 },
+	.regm_dsi		=	{ 0, (1 << 4) - 1 },
+	.fint			=	{ 750000, 2100000 },
+	.lpdiv			=	{ 1, (1 << 13) - 1},
+	.dsi_fck		=	{ 0, 173000000 },
+	.dss_fck		=	{ 0, 173000000 },
+};
+
+static struct dsi_param_ranges omap4_dsi_param_ranges = {
+	.regn			=	{ 0, (1 << 8) - 1 },
+	.regm			=	{ 0, (1 << 12) - 1 },
+	.regm_dispc		=	{ 0, (1 << 5) - 1 },
+	.regm_dsi		=	{ 0, (1 << 5) - 1 },
+	.fint			=	{ 500000, 2500000 },
+	.lpdiv			=	{ 0, (1 << 13) - 1 },
+	.dsi_fck		=	{ 0, 170000000 },
+	.dss_fck		=	{ 0, 186000000 },
+};
+
+static struct dsi_param_ranges omap5_dsi_param_ranges = {
+	.regn			=	{ 0, (1 << 8) - 1 },
+	.regm			=	{ 0, (1 << 12) - 1 },
+	.regm_dispc		=	{ 0, (1 << 5) - 1 },
+	.regm_dsi		=	{ 0, (1 << 5) - 1 },
+	.fint			=	{ 500000, 2500000 },
+	.lpdiv			=	{ 0, (1 << 13) - 1 },
+	.dsi_fck		=	{ 0, 170000000 },
+	.dss_fck		=	{ 0, 200000000 },
+};
+
 static const struct feats omap24xx_dsi_feats __initconst = {
 	.reg_fields		=	&omap2_dsi_reg_fields,
+	.params			=	&omap2_dsi_param_ranges,
 };
 
 static const struct feats omap34xx_dsi_feats __initconst = {
 	.reg_fields		=	&omap3_dsi_reg_fields,
+	.params			=	&omap3_dsi_param_ranges,
 };
 
 static const struct feats omap44xx_dsi_feats __initconst = {
 	.reg_fields		=	&omap4_dsi_reg_fields,
+	.params			=	&omap4_dsi_param_ranges,
 };
 
 static const struct feats omap54xx_dsi_feats __initconst = {
 	.reg_fields		=	&omap5_dsi_reg_fields,
+	.params			=	&omap5_dsi_param_ranges,
 };
 
 static int __init dsi_init_features(struct platform_device *dsidev)
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 8e6defb..75dddb2 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -369,45 +369,18 @@ static const char * const omap5_dss_clk_source_names[] = {
 
 static const struct dss_param_range omap2_dss_param_range[] = {
 	[FEAT_PARAM_DSS_FCK]			= { 0, 173000000 },
-	[FEAT_PARAM_DSIPLL_REGN]		= { 0, 0 },
-	[FEAT_PARAM_DSIPLL_REGM]		= { 0, 0 },
-	[FEAT_PARAM_DSIPLL_REGM_DISPC]		= { 0, 0 },
-	[FEAT_PARAM_DSIPLL_REGM_DSI]		= { 0, 0 },
-	[FEAT_PARAM_DSIPLL_FINT]		= { 0, 0 },
-	[FEAT_PARAM_DSIPLL_LPDIV]		= { 0, 0 },
 };
 
 static const struct dss_param_range omap3_dss_param_range[] = {
 	[FEAT_PARAM_DSS_FCK]			= { 0, 173000000 },
-	[FEAT_PARAM_DSIPLL_REGN]		= { 0, (1 << 7) - 1 },
-	[FEAT_PARAM_DSIPLL_REGM]		= { 0, (1 << 11) - 1 },
-	[FEAT_PARAM_DSIPLL_REGM_DISPC]		= { 0, (1 << 4) - 1 },
-	[FEAT_PARAM_DSIPLL_REGM_DSI]		= { 0, (1 << 4) - 1 },
-	[FEAT_PARAM_DSIPLL_FINT]		= { 750000, 2100000 },
-	[FEAT_PARAM_DSIPLL_LPDIV]		= { 1, (1 << 13) - 1},
-	[FEAT_PARAM_DSI_FCK]			= { 0, 173000000 },
 };
 
 static const struct dss_param_range omap4_dss_param_range[] = {
 	[FEAT_PARAM_DSS_FCK]			= { 0, 186000000 },
-	[FEAT_PARAM_DSIPLL_REGN]		= { 0, (1 << 8) - 1 },
-	[FEAT_PARAM_DSIPLL_REGM]		= { 0, (1 << 12) - 1 },
-	[FEAT_PARAM_DSIPLL_REGM_DISPC]		= { 0, (1 << 5) - 1 },
-	[FEAT_PARAM_DSIPLL_REGM_DSI]		= { 0, (1 << 5) - 1 },
-	[FEAT_PARAM_DSIPLL_FINT]		= { 500000, 2500000 },
-	[FEAT_PARAM_DSIPLL_LPDIV]		= { 0, (1 << 13) - 1 },
-	[FEAT_PARAM_DSI_FCK]			= { 0, 170000000 },
 };
 
 static const struct dss_param_range omap5_dss_param_range[] = {
 	[FEAT_PARAM_DSS_FCK]			= { 0, 200000000 },
-	[FEAT_PARAM_DSIPLL_REGN]		= { 0, (1 << 8) - 1 },
-	[FEAT_PARAM_DSIPLL_REGM]		= { 0, (1 << 12) - 1 },
-	[FEAT_PARAM_DSIPLL_REGM_DISPC]		= { 0, (1 << 5) - 1 },
-	[FEAT_PARAM_DSIPLL_REGM_DSI]		= { 0, (1 << 5) - 1 },
-	[FEAT_PARAM_DSIPLL_FINT]		= { 500000, 2500000 },
-	[FEAT_PARAM_DSIPLL_LPDIV]		= { 0, (1 << 13) - 1 },
-	[FEAT_PARAM_DSI_FCK]			= { 0, 170000000 },
 };
 
 static const enum dss_feat_id omap2_dss_feat_list[] = {
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index 3e82404..d9f69c7 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -77,13 +77,6 @@ enum dss_feat_reg_field {
 
 enum dss_range_param {
 	FEAT_PARAM_DSS_FCK,
-	FEAT_PARAM_DSIPLL_REGN,
-	FEAT_PARAM_DSIPLL_REGM,
-	FEAT_PARAM_DSIPLL_REGM_DISPC,
-	FEAT_PARAM_DSIPLL_REGM_DSI,
-	FEAT_PARAM_DSIPLL_FINT,
-	FEAT_PARAM_DSIPLL_LPDIV,
-	FEAT_PARAM_DSI_FCK,
 };
 
 /* DSS Feature Functions */
-- 
1.7.10

