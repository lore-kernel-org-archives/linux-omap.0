From: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Subject: [PATCH 4/7] OMAPDSS: DSI: Move DSI specific reg_fields to dsi_feats
Date: Wed, 28 Nov 2012 16:11:27 +0530
Message-ID: <3fa82b3ce69b597fc85f0ce7f4611a923082dee1.1354086150.git.cmahapatra@ti.com>
References: <cover.1354086150.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36882 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754399Ab2K1Kqk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Nov 2012 05:46:40 -0500
In-Reply-To: <cover.1354086150.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Chandrabhanu Mahapatra <cmahapatra@ti.com>

The DSI specific dss_reg_fields are moved to corresponding dsi_reg_fields
initialized in dsi_feats. The dsi_feats structure is initialized as per
corresponding DSS version in dsi_init_features().

Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
---
 drivers/video/omap2/dss/dsi.c          |  119 ++++++++++++++++++++++++++++++--
 drivers/video/omap2/dss/dss_features.c |   16 -----
 drivers/video/omap2/dss/dss_features.h |    4 --
 3 files changed, 113 insertions(+), 26 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index cf32dc7..2d387cb 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -344,6 +344,19 @@ struct dsi_packet_sent_handler_data {
 	struct completion *completion;
 };
 
+enum dsi_feat_reg_field {
+	FEAT_REG_DSIPLL_REGN,
+	FEAT_REG_DSIPLL_REGM,
+	FEAT_REG_DSIPLL_REGM_DISPC,
+	FEAT_REG_DSIPLL_REGM_DSI,
+};
+
+struct feats {
+	const struct register_field *reg_fields;
+};
+
+static const struct feats *dsi_feat;
+
 #ifdef DEBUG
 static bool dsi_perf;
 module_param(dsi_perf, bool, 0644);
@@ -1645,12 +1658,15 @@ int dsi_pll_set_clock_div(struct platform_device *dsidev,
 		dss_feat_get_clk_source_name(OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI),
 		cinfo->dsi_pll_hsdiv_dsi_clk);
 
-	dss_feat_get_reg_field(FEAT_REG_DSIPLL_REGN, &regn_start, &regn_end);
-	dss_feat_get_reg_field(FEAT_REG_DSIPLL_REGM, &regm_start, &regm_end);
-	dss_feat_get_reg_field(FEAT_REG_DSIPLL_REGM_DISPC, &regm_dispc_start,
-			&regm_dispc_end);
-	dss_feat_get_reg_field(FEAT_REG_DSIPLL_REGM_DSI, &regm_dsi_start,
-			&regm_dsi_end);
+	regn_start = dsi_feat->reg_fields[FEAT_REG_DSIPLL_REGN].start;
+	regn_end = dsi_feat->reg_fields[FEAT_REG_DSIPLL_REGN].end;
+	regm_start = dsi_feat->reg_fields[FEAT_REG_DSIPLL_REGM].start;
+	regm_end = dsi_feat->reg_fields[FEAT_REG_DSIPLL_REGM].end;
+	regm_dispc_start =
+			dsi_feat->reg_fields[FEAT_REG_DSIPLL_REGM_DISPC].start;
+	regm_dispc_end = dsi_feat->reg_fields[FEAT_REG_DSIPLL_REGM_DISPC].end;
+	regm_dsi_start = dsi_feat->reg_fields[FEAT_REG_DSIPLL_REGM_DSI].start;
+	regm_dsi_end = dsi_feat->reg_fields[FEAT_REG_DSIPLL_REGM_DSI].end;
 
 	/* DSI_PLL_AUTOMODE = manual */
 	REG_FLD_MOD(dsidev, DSI_PLL_CONTROL, 0, 0, 0);
@@ -5198,6 +5214,93 @@ static void __exit dsi_uninit_output(struct platform_device *dsidev)
 	dss_unregister_output(out);
 }
 
+static struct register_field omap2_dsi_reg_fields[] = {
+	[FEAT_REG_DSIPLL_REGN]			= { 0, 0 },
+	[FEAT_REG_DSIPLL_REGM]			= { 0, 0 },
+	[FEAT_REG_DSIPLL_REGM_DISPC]		= { 0, 0 },
+	[FEAT_REG_DSIPLL_REGM_DSI]		= { 0, 0 },
+};
+
+static struct register_field omap3_dsi_reg_fields[] = {
+	[FEAT_REG_DSIPLL_REGN]			= {  7,  1 },
+	[FEAT_REG_DSIPLL_REGM]			= { 18,  8 },
+	[FEAT_REG_DSIPLL_REGM_DISPC]		= { 22, 19 },
+	[FEAT_REG_DSIPLL_REGM_DSI]		= { 26, 23 },
+};
+
+static struct register_field omap4_dsi_reg_fields[] = {
+	[FEAT_REG_DSIPLL_REGN]			= {  8,  1 },
+	[FEAT_REG_DSIPLL_REGM]			= { 20,  9 },
+	[FEAT_REG_DSIPLL_REGM_DISPC]		= { 25, 21 },
+	[FEAT_REG_DSIPLL_REGM_DSI]		= { 30, 26 },
+};
+
+static struct register_field omap5_dsi_reg_fields[] = {
+	[FEAT_REG_DSIPLL_REGN]			= {  8,  1 },
+	[FEAT_REG_DSIPLL_REGM]			= { 20,  9 },
+	[FEAT_REG_DSIPLL_REGM_DISPC]		= { 25, 21 },
+	[FEAT_REG_DSIPLL_REGM_DSI]		= { 30, 26 },
+};
+
+static const struct feats omap24xx_dsi_feats __initconst = {
+	.reg_fields		=	omap2_dsi_reg_fields,
+};
+
+static const struct feats omap34xx_dsi_feats __initconst = {
+	.reg_fields		=	omap3_dsi_reg_fields,
+};
+
+static const struct feats omap44xx_dsi_feats __initconst = {
+	.reg_fields		=	omap4_dsi_reg_fields,
+};
+
+static const struct feats omap54xx_dsi_feats __initconst = {
+	.reg_fields		=	omap5_dsi_reg_fields,
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
@@ -5206,6 +5309,10 @@ static int __init omap_dsihw_probe(struct platform_device *dsidev)
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

