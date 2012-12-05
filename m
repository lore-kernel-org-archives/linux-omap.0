From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH V2 4/6] OMAPDSS: DSI: Move DSI specific reg_fields to dsi_feats
Date: Wed, 5 Dec 2012 15:46:06 +0530
Message-ID: <55965d940f45ecaf56f5145d7dcc8c28e4c9586f.1354702077.git.cmahapatra@ti.com>
References: <cover.1354086150.git.cmahapatra@ti.com> <cover.1354702077.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45621 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030Ab2LEKUD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Dec 2012 05:20:03 -0500
In-Reply-To: <cover.1354702077.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

The DSI specific dss_reg_fields are moved to corresponding dsi_reg_fields
initialized in dsi_feats. The dsi_feats structure is initialized as per
corresponding DSS version in dsi_init_features().

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
 drivers/video/omap2/dss/dsi.c          |  126 +++++++++++++++++++++++++++++---
 drivers/video/omap2/dss/dss_features.c |   16 ----
 drivers/video/omap2/dss/dss_features.h |    4 -
 3 files changed, 114 insertions(+), 32 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index cf32dc7..472cdb4 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -344,6 +344,19 @@ struct dsi_packet_sent_handler_data {
 	struct completion *completion;
 };
 
+struct dsi_reg_fields {
+	struct omapdss_reg_field regn;
+	struct omapdss_reg_field regm;
+	struct omapdss_reg_field regm_dispc;
+	struct omapdss_reg_field regm_dsi;
+};
+
+struct feats {
+	const struct dsi_reg_fields *reg_fields;
+};
+
+static const struct feats *dsi_feat;
+
 #ifdef DEBUG
 static bool dsi_perf;
 module_param(dsi_perf, bool, 0644);
@@ -1602,8 +1615,8 @@ int dsi_pll_set_clock_div(struct platform_device *dsidev,
 	int r = 0;
 	u32 l;
 	int f = 0;
-	u8 regn_start, regn_end, regm_start, regm_end;
-	u8 regm_dispc_start, regm_dispc_end, regm_dsi_start, regm_dsi_end;
+	const struct omapdss_reg_field *regn_field, *regm_field;
+	const struct omapdss_reg_field *regm_dispc_field, *regm_dsi_field;
 
 	DSSDBG("DSI PLL clock config starts");
 
@@ -1645,12 +1658,10 @@ int dsi_pll_set_clock_div(struct platform_device *dsidev,
 		dss_feat_get_clk_source_name(OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI),
 		cinfo->dsi_pll_hsdiv_dsi_clk);
 
-	dss_feat_get_reg_field(FEAT_REG_DSIPLL_REGN, &regn_start, &regn_end);
-	dss_feat_get_reg_field(FEAT_REG_DSIPLL_REGM, &regm_start, &regm_end);
-	dss_feat_get_reg_field(FEAT_REG_DSIPLL_REGM_DISPC, &regm_dispc_start,
-			&regm_dispc_end);
-	dss_feat_get_reg_field(FEAT_REG_DSIPLL_REGM_DSI, &regm_dsi_start,
-			&regm_dsi_end);
+	regn_field = &dsi_feat->reg_fields->regn;
+	regm_field = &dsi_feat->reg_fields->regm;
+	regm_dispc_field = &dsi_feat->reg_fields->regm_dispc;
+	regm_dsi_field = &dsi_feat->reg_fields->regm_dsi;
 
 	/* DSI_PLL_AUTOMODE = manual */
 	REG_FLD_MOD(dsidev, DSI_PLL_CONTROL, 0, 0, 0);
@@ -1658,15 +1669,15 @@ int dsi_pll_set_clock_div(struct platform_device *dsidev,
 	l = dsi_read_reg(dsidev, DSI_PLL_CONFIGURATION1);
 	l = FLD_MOD(l, 1, 0, 0);		/* DSI_PLL_STOPMODE */
 	/* DSI_PLL_REGN */
-	l = FLD_MOD(l, cinfo->regn - 1, regn_start, regn_end);
+	l = FLD_MOD(l, cinfo->regn - 1, regn_field->start, regn_field->end);
 	/* DSI_PLL_REGM */
-	l = FLD_MOD(l, cinfo->regm, regm_start, regm_end);
+	l = FLD_MOD(l, cinfo->regm, regm_field->start, regm_field->end);
 	/* DSI_CLOCK_DIV */
 	l = FLD_MOD(l, cinfo->regm_dispc > 0 ? cinfo->regm_dispc - 1 : 0,
-			regm_dispc_start, regm_dispc_end);
+			regm_dispc_field->start, regm_dispc_field->end);
 	/* DSIPROTO_CLOCK_DIV */
 	l = FLD_MOD(l, cinfo->regm_dsi > 0 ? cinfo->regm_dsi - 1 : 0,
-			regm_dsi_start, regm_dsi_end);
+			regm_dsi_field->start, regm_dsi_field->end);
 	dsi_write_reg(dsidev, DSI_PLL_CONFIGURATION1, l);
 
 	BUG_ON(cinfo->fint < dsi->fint_min || cinfo->fint > dsi->fint_max);
@@ -5198,6 +5209,93 @@ static void __exit dsi_uninit_output(struct platform_device *dsidev)
 	dss_unregister_output(out);
 }
 
+static struct dsi_reg_fields omap2_dsi_reg_fields = {
+	.regn			=	{ 0, 0 },
+	.regm			=	{ 0, 0 },
+	.regm_dispc		=	{ 0, 0 },
+	.regm_dsi		=	{ 0, 0 },
+};
+
+static struct dsi_reg_fields omap3_dsi_reg_fields = {
+	.regn			=	{  7,  1 },
+	.regm			=	{ 18,  8 },
+	.regm_dispc		=	{ 22, 19 },
+	.regm_dsi		=	{ 26, 23 },
+};
+
+static struct dsi_reg_fields omap4_dsi_reg_fields = {
+	.regn			=	{  8,  1 },
+	.regm			=	{ 20,  9 },
+	.regm_dispc		=	{ 25, 21 },
+	.regm_dsi		=	{ 30, 26 },
+};
+
+static struct dsi_reg_fields omap5_dsi_reg_fields = {
+	.regn			=	{  8,  1 },
+	.regm			=	{ 20,  9 },
+	.regm_dispc		=	{ 25, 21 },
+	.regm_dsi		=	{ 30, 26 },
+};
+
+static const struct feats omap24xx_dsi_feats __initconst = {
+	.reg_fields		=	&omap2_dsi_reg_fields,
+};
+
+static const struct feats omap34xx_dsi_feats __initconst = {
+	.reg_fields		=	&omap3_dsi_reg_fields,
+};
+
+static const struct feats omap44xx_dsi_feats __initconst = {
+	.reg_fields		=	&omap4_dsi_reg_fields,
+};
+
+static const struct feats omap54xx_dsi_feats __initconst = {
+	.reg_fields		=	&omap5_dsi_reg_fields,
+};
+
+static int __init dsi_init_features(struct platform_device *dsidev)
+{
+	const struct feats *src;
+	struct feats *dst;
+
+	dst = devm_kzalloc(&dsidev->dev, sizeof(*dst), GFP_KERNEL);
+	if (!dst) {
+		dev_err(&dsidev->dev, "Failed to allocate DISPC Features\n");
+		return -ENOMEM;
+	}
+
+	switch (omapdss_get_version()) {
+	case OMAPDSS_VER_OMAP24xx:
+		src = &omap24xx_dsi_feats;
+		break;
+
+	case OMAPDSS_VER_OMAP34xx_ES1:
+	case OMAPDSS_VER_OMAP34xx_ES3:
+	case OMAPDSS_VER_OMAP3630:
+	case OMAPDSS_VER_AM35xx:
+		src = &omap34xx_dsi_feats;
+		break;
+
+	case OMAPDSS_VER_OMAP4430_ES1:
+	case OMAPDSS_VER_OMAP4430_ES2:
+	case OMAPDSS_VER_OMAP4:
+		src = &omap44xx_dsi_feats;
+		break;
+
+	case OMAPDSS_VER_OMAP5:
+		src = &omap54xx_dsi_feats;
+		break;
+
+	default:
+		return -ENODEV;
+	}
+
+	memcpy(dst, src, sizeof(*dst));
+	dsi_feat = dst;
+
+	return 0;
+}
+
 /* DSI1 HW IP initialisation */
 static int __init omap_dsihw_probe(struct platform_device *dsidev)
 {
@@ -5206,6 +5304,10 @@ static int __init omap_dsihw_probe(struct platform_device *dsidev)
 	struct resource *dsi_mem;
 	struct dsi_data *dsi;
 
+	r = dsi_init_features(dsidev);
+	if (r)
+		return r;
+
 	dsi = devm_kzalloc(&dsidev->dev, sizeof(*dsi), GFP_KERNEL);
 	if (!dsi)
 		return -ENOMEM;
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 3a9d1df..8e6defb 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -61,34 +61,18 @@ static const struct omap_dss_features *omap_current_dss_features;
 
 static const struct dss_reg_field omap2_dss_reg_fields[] = {
 	[FEAT_REG_DISPC_CLK_SWITCH]		= { 0, 0 },
-	[FEAT_REG_DSIPLL_REGN]			= { 0, 0 },
-	[FEAT_REG_DSIPLL_REGM]			= { 0, 0 },
-	[FEAT_REG_DSIPLL_REGM_DISPC]		= { 0, 0 },
-	[FEAT_REG_DSIPLL_REGM_DSI]		= { 0, 0 },
 };
 
 static const struct dss_reg_field omap3_dss_reg_fields[] = {
 	[FEAT_REG_DISPC_CLK_SWITCH]		= { 0, 0 },
-	[FEAT_REG_DSIPLL_REGN]			= { 7, 1 },
-	[FEAT_REG_DSIPLL_REGM]			= { 18, 8 },
-	[FEAT_REG_DSIPLL_REGM_DISPC]		= { 22, 19 },
-	[FEAT_REG_DSIPLL_REGM_DSI]		= { 26, 23 },
 };
 
 static const struct dss_reg_field omap4_dss_reg_fields[] = {
 	[FEAT_REG_DISPC_CLK_SWITCH]		= { 9, 8 },
-	[FEAT_REG_DSIPLL_REGN]			= { 8, 1 },
-	[FEAT_REG_DSIPLL_REGM]			= { 20, 9 },
-	[FEAT_REG_DSIPLL_REGM_DISPC]		= { 25, 21 },
-	[FEAT_REG_DSIPLL_REGM_DSI]		= { 30, 26 },
 };
 
 static const struct dss_reg_field omap5_dss_reg_fields[] = {
 	[FEAT_REG_DISPC_CLK_SWITCH]		= { 9, 7 },
-	[FEAT_REG_DSIPLL_REGN]			= { 8, 1 },
-	[FEAT_REG_DSIPLL_REGM]			= { 20, 9 },
-	[FEAT_REG_DSIPLL_REGM_DISPC]		= { 25, 21 },
-	[FEAT_REG_DSIPLL_REGM_DSI]		= { 30, 26 },
 };
 
 static const enum omap_display_type omap2_dss_supported_displays[] = {
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index 40b98ff..3e82404 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -73,10 +73,6 @@ enum dss_feat_id {
 /* DSS register field id */
 enum dss_feat_reg_field {
 	FEAT_REG_DISPC_CLK_SWITCH,
-	FEAT_REG_DSIPLL_REGN,
-	FEAT_REG_DSIPLL_REGM,
-	FEAT_REG_DSIPLL_REGM_DISPC,
-	FEAT_REG_DSIPLL_REGM_DSI,
 };
 
 enum dss_range_param {
-- 
1.7.10

