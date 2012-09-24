From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 2/9] OMAPDSS: Add basic omap5 features to dss and dispc
Date: Mon, 24 Sep 2012 16:58:32 +0300
Message-ID: <1348495119-8262-3-git-send-email-tomi.valkeinen@ti.com>
References: <1348495119-8262-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:39380 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755503Ab2IXN64 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Sep 2012 09:58:56 -0400
Received: by lbbgj3 with SMTP id gj3so6750187lbb.19
        for <linux-omap@vger.kernel.org>; Mon, 24 Sep 2012 06:58:53 -0700 (PDT)
In-Reply-To: <1348495119-8262-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

From: Archit Taneja <archit@ti.com>

Add basic omap5 features for dss and dispc.

Signed-off-by: Archit Taneja <archit@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c        |    2 +
 drivers/video/omap2/dss/dss.c          |    8 +++
 drivers/video/omap2/dss/dss_features.c |   93 ++++++++++++++++++++++++++++++++
 3 files changed, 103 insertions(+)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index d512c38..e52c5778 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3829,6 +3829,8 @@ static int __init dispc_init_features(struct device *dev)
 			src = &omap34xx_rev3_0_dispc_feats;
 	} else if (cpu_is_omap44xx()) {
 		src = &omap44xx_dispc_feats;
+	} else if (soc_is_omap54xx()) {
+		src = &omap44xx_dispc_feats;
 	} else {
 		return -ENODEV;
 	}
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 759dbee..4524c17 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -123,6 +123,12 @@ static const struct dss_features omap44xx_dss_feats __initconst = {
 	.clk_name		=	"dpll_per_m5x2_ck",
 };
 
+static const struct dss_features omap54xx_dss_feats __initconst = {
+	.fck_div_max		=	64,
+	.dss_fck_multiplier	=	1,
+	.clk_name		=	"dpll_per_h12x2_ck",
+};
+
 static inline void dss_write_reg(const struct dss_reg idx, u32 val)
 {
 	__raw_writel(val, dss.base + idx.idx);
@@ -740,6 +746,8 @@ static int __init dss_init_features(struct device *dev)
 		src = &omap3630_dss_feats;
 	else if (cpu_is_omap44xx())
 		src = &omap44xx_dss_feats;
+	else if (soc_is_omap54xx())
+		src = &omap54xx_dss_feats;
 	else
 		return -ENODEV;
 
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index c26fc1f..af4775a 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -106,6 +106,21 @@ static const struct dss_reg_field omap4_dss_reg_fields[] = {
 	[FEAT_REG_DSIPLL_REGM_DSI]		= { 30, 26 },
 };
 
+static const struct dss_reg_field omap5_dss_reg_fields[] = {
+	[FEAT_REG_FIRHINC]			= { 12, 0 },
+	[FEAT_REG_FIRVINC]			= { 28, 16 },
+	[FEAT_REG_FIFOLOWTHRESHOLD]		= { 15, 0 },
+	[FEAT_REG_FIFOHIGHTHRESHOLD]		= { 31, 16 },
+	[FEAT_REG_FIFOSIZE]			= { 15, 0 },
+	[FEAT_REG_HORIZONTALACCU]		= { 10, 0 },
+	[FEAT_REG_VERTICALACCU]			= { 26, 16 },
+	[FEAT_REG_DISPC_CLK_SWITCH]		= { 9, 7 },
+	[FEAT_REG_DSIPLL_REGN]			= { 8, 1 },
+	[FEAT_REG_DSIPLL_REGM]			= { 20, 9 },
+	[FEAT_REG_DSIPLL_REGM_DISPC]		= { 25, 21 },
+	[FEAT_REG_DSIPLL_REGM_DSI]		= { 30, 26 },
+};
+
 static const enum omap_display_type omap2_dss_supported_displays[] = {
 	/* OMAP_DSS_CHANNEL_LCD */
 	OMAP_DISPLAY_TYPE_DPI | OMAP_DISPLAY_TYPE_DBI,
@@ -144,6 +159,19 @@ static const enum omap_display_type omap4_dss_supported_displays[] = {
 	OMAP_DISPLAY_TYPE_DSI,
 };
 
+static const enum omap_display_type omap5_dss_supported_displays[] = {
+	/* OMAP_DSS_CHANNEL_LCD */
+	OMAP_DISPLAY_TYPE_DPI | OMAP_DISPLAY_TYPE_DBI |
+	OMAP_DISPLAY_TYPE_DSI,
+
+	/* OMAP_DSS_CHANNEL_DIGIT */
+	OMAP_DISPLAY_TYPE_HDMI | OMAP_DISPLAY_TYPE_DPI,
+
+	/* OMAP_DSS_CHANNEL_LCD2 */
+	OMAP_DISPLAY_TYPE_DPI | OMAP_DISPLAY_TYPE_DBI |
+	OMAP_DISPLAY_TYPE_DSI,
+};
+
 static const enum omap_color_mode omap2_dss_supported_color_modes[] = {
 	/* OMAP_DSS_GFX */
 	OMAP_DSS_COLOR_CLUT1 | OMAP_DSS_COLOR_CLUT2 |
@@ -298,6 +326,14 @@ static const char * const omap4_dss_clk_source_names[] = {
 	[OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DSI]	= "PLL2_CLK2",
 };
 
+static const char * const omap5_dss_clk_source_names[] = {
+	[OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC]	= "DPLL_DSI1_A_CLK1",
+	[OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI]	= "DPLL_DSI1_A_CLK2",
+	[OMAP_DSS_CLK_SRC_FCK]			= "DSS_CLK",
+	[OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC]	= "DPLL_DSI1_C_CLK1",
+	[OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DSI]	= "DPLL_DSI1_C_CLK2",
+};
+
 static const struct dss_param_range omap2_dss_param_range[] = {
 	[FEAT_PARAM_DSS_FCK]			= { 0, 173000000 },
 	[FEAT_PARAM_DSS_PCD]			= { 2, 255 },
@@ -349,6 +385,22 @@ static const struct dss_param_range omap4_dss_param_range[] = {
 	[FEAT_PARAM_MGR_HEIGHT]			= { 1, 2048 },
 };
 
+static const struct dss_param_range omap5_dss_param_range[] = {
+	[FEAT_PARAM_DSS_FCK]			= { 0, 200000000 },
+	[FEAT_PARAM_DSS_PCD]			= { 1, 255 },
+	[FEAT_PARAM_DSIPLL_REGN]		= { 0, (1 << 8) - 1 },
+	[FEAT_PARAM_DSIPLL_REGM]		= { 0, (1 << 12) - 1 },
+	[FEAT_PARAM_DSIPLL_REGM_DISPC]		= { 0, (1 << 5) - 1 },
+	[FEAT_PARAM_DSIPLL_REGM_DSI]		= { 0, (1 << 5) - 1 },
+	[FEAT_PARAM_DSIPLL_FINT]		= { 500000, 2500000 },
+	[FEAT_PARAM_DSIPLL_LPDIV]		= { 0, (1 << 13) - 1 },
+	[FEAT_PARAM_DSI_FCK]			= { 0, 170000000 },
+	[FEAT_PARAM_DOWNSCALE]			= { 1, 4 },
+	[FEAT_PARAM_LINEWIDTH]			= { 1, 2048 },
+	[FEAT_PARAM_MGR_WIDTH]			= { 1, 2048 },
+	[FEAT_PARAM_MGR_HEIGHT]			= { 1, 2048 },
+};
+
 static const enum dss_feat_id omap2_dss_feat_list[] = {
 	FEAT_LCDENABLEPOL,
 	FEAT_LCDENABLESIGNAL,
@@ -450,6 +502,25 @@ static const enum dss_feat_id omap4_dss_feat_list[] = {
 	FEAT_BURST_2D,
 };
 
+static const enum dss_feat_id omap5_dss_feat_list[] = {
+	FEAT_MGR_LCD2,
+	FEAT_CORE_CLK_DIV,
+	FEAT_LCD_CLK_SRC,
+	FEAT_DSI_DCS_CMD_CONFIG_VC,
+	FEAT_DSI_VC_OCP_WIDTH,
+	FEAT_DSI_GNQ,
+	FEAT_HDMI_CTS_SWMODE,
+	FEAT_HDMI_AUDIO_USE_MCLK,
+	FEAT_HANDLE_UV_SEPARATE,
+	FEAT_ATTR2,
+	FEAT_CPR,
+	FEAT_PRELOAD,
+	FEAT_FIR_COEF_V,
+	FEAT_ALPHA_FREE_ZORDER,
+	FEAT_FIFO_MERGE,
+	FEAT_BURST_2D,
+};
+
 /* OMAP2 DSS Features */
 static const struct omap_dss_features omap2_dss_features = {
 	.reg_fields = omap2_dss_reg_fields,
@@ -570,6 +641,26 @@ static const struct omap_dss_features omap4_dss_features = {
 	.burst_size_unit = 16,
 };
 
+/* OMAP5 DSS Features */
+static const struct omap_dss_features omap5_dss_features = {
+	.reg_fields = omap5_dss_reg_fields,
+	.num_reg_fields = ARRAY_SIZE(omap5_dss_reg_fields),
+
+	.features = omap5_dss_feat_list,
+	.num_features = ARRAY_SIZE(omap5_dss_feat_list),
+
+	.num_mgrs = 3,
+	.num_ovls = 4,
+	.supported_displays = omap5_dss_supported_displays,
+	.supported_color_modes = omap4_dss_supported_color_modes,
+	.overlay_caps = omap4_dss_overlay_caps,
+	.clksrc_names = omap5_dss_clk_source_names,
+	.dss_params = omap5_dss_param_range,
+	.supported_rotation_types = OMAP_DSS_ROT_DMA | OMAP_DSS_ROT_TILER,
+	.buffer_size_unit = 16,
+	.burst_size_unit = 16,
+};
+
 #if defined(CONFIG_OMAP4_DSS_HDMI)
 /* HDMI OMAP4 Functions*/
 static const struct ti_hdmi_ip_ops omap4_hdmi_functions = {
@@ -707,6 +798,8 @@ void dss_features_init(void)
 		omap_current_dss_features = &omap4430_es2_0_1_2_dss_features;
 	else if (cpu_is_omap44xx())
 		omap_current_dss_features = &omap4_dss_features;
+	else if (soc_is_omap54xx())
+		omap_current_dss_features = &omap5_dss_features;
 	else
 		DSSWARN("Unsupported OMAP version");
 }
-- 
1.7.9.5

