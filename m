From: Archit Taneja <archit@ti.com>
Subject: [PATCH 1/2] OMAPDSS: Features: Maintain dss_feats as a list
Date: Mon, 30 Jan 2012 10:52:39 +0530
Message-ID: <1327900959-29198-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38744 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467Ab2A3FWp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Jan 2012 00:22:45 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>

The number of dss_feat_id members has increased to a large value, the current
way of assigning a subset of these features (for a particular OMAP) as a mask
is no longer feasible.

Maintain the subset of features supported as lists. Make the function
dss_has_feature() traverse through this list.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dss_features.c |  140 +++++++++++++++++++++++---------
 drivers/video/omap2/dss/dss_features.h |   54 ++++++------
 2 files changed, 128 insertions(+), 66 deletions(-)

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 419419a..656cb69 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -41,7 +41,8 @@ struct omap_dss_features {
 	const struct dss_reg_field *reg_fields;
 	const int num_reg_fields;
 
-	const u32 has_feature;
+	const enum dss_feat_id *features;
+	const int num_features;
 
 	const int num_mgrs;
 	const int num_ovls;
@@ -337,15 +338,92 @@ static const struct dss_param_range omap4_dss_param_range[] = {
 	[FEAT_PARAM_LINEWIDTH]			= { 1, 2048 },
 };
 
+static const enum dss_feat_id omap2_dss_feat_list[] = {
+	FEAT_LCDENABLEPOL,
+	FEAT_LCDENABLESIGNAL,
+	FEAT_PCKFREEENABLE,
+	FEAT_FUNCGATED,
+	FEAT_ROWREPEATENABLE,
+	FEAT_RESIZECONF,
+};
+
+static const enum dss_feat_id omap3430_dss_feat_list[] = {
+	FEAT_LCDENABLEPOL,
+	FEAT_LCDENABLESIGNAL,
+	FEAT_PCKFREEENABLE,
+	FEAT_FUNCGATED,
+	FEAT_LINEBUFFERSPLIT,
+	FEAT_ROWREPEATENABLE,
+	FEAT_RESIZECONF,
+	FEAT_DSI_PLL_FREQSEL,
+	FEAT_DSI_REVERSE_TXCLKESC,
+	FEAT_VENC_REQUIRES_TV_DAC_CLK,
+	FEAT_CPR,
+	FEAT_PRELOAD,
+	FEAT_FIR_COEF_V,
+	FEAT_ALPHA_FIXED_ZORDER,
+	FEAT_FIFO_MERGE,
+	FEAT_OMAP3_DSI_FIFO_BUG,
+};
+
+static const enum dss_feat_id omap3630_dss_feat_list[] = {
+	FEAT_LCDENABLEPOL,
+	FEAT_LCDENABLESIGNAL,
+	FEAT_PCKFREEENABLE,
+	FEAT_FUNCGATED,
+	FEAT_LINEBUFFERSPLIT,
+	FEAT_ROWREPEATENABLE,
+	FEAT_RESIZECONF,
+	FEAT_DSI_PLL_PWR_BUG,
+	FEAT_DSI_PLL_FREQSEL,
+	FEAT_CPR,
+	FEAT_PRELOAD,
+	FEAT_FIR_COEF_V,
+	FEAT_ALPHA_FIXED_ZORDER,
+	FEAT_FIFO_MERGE,
+	FEAT_OMAP3_DSI_FIFO_BUG,
+};
+
+static const enum dss_feat_id omap4430_es1_0_dss_feat_list[] = {
+	FEAT_MGR_LCD2,
+	FEAT_CORE_CLK_DIV,
+	FEAT_LCD_CLK_SRC,
+	FEAT_DSI_DCS_CMD_CONFIG_VC,
+	FEAT_DSI_VC_OCP_WIDTH,
+	FEAT_DSI_GNQ,
+	FEAT_HANDLE_UV_SEPARATE,
+	FEAT_ATTR2,
+	FEAT_CPR,
+	FEAT_PRELOAD,
+	FEAT_FIR_COEF_V,
+	FEAT_ALPHA_FREE_ZORDER,
+	FEAT_FIFO_MERGE,
+};
+
+static const enum dss_feat_id omap4_dss_feat_list[] = {
+	FEAT_MGR_LCD2,
+	FEAT_CORE_CLK_DIV,
+	FEAT_LCD_CLK_SRC,
+	FEAT_DSI_DCS_CMD_CONFIG_VC,
+	FEAT_DSI_VC_OCP_WIDTH,
+	FEAT_DSI_GNQ,
+	FEAT_HDMI_CTS_SWMODE,
+	FEAT_HANDLE_UV_SEPARATE,
+	FEAT_ATTR2,
+	FEAT_CPR,
+	FEAT_PRELOAD,
+	FEAT_FIR_COEF_V,
+	FEAT_ALPHA_FREE_ZORDER,
+	FEAT_FIFO_MERGE,
+};
+
 /* OMAP2 DSS Features */
 static const struct omap_dss_features omap2_dss_features = {
 	.reg_fields = omap2_dss_reg_fields,
 	.num_reg_fields = ARRAY_SIZE(omap2_dss_reg_fields),
 
-	.has_feature	=
-		FEAT_LCDENABLEPOL | FEAT_LCDENABLESIGNAL |
-		FEAT_PCKFREEENABLE | FEAT_FUNCGATED |
-		FEAT_ROWREPEATENABLE | FEAT_RESIZECONF,
+	.features = omap2_dss_feat_list,
+	.num_features = ARRAY_SIZE(omap2_dss_feat_list),
 
 	.num_mgrs = 2,
 	.num_ovls = 3,
@@ -363,15 +441,8 @@ static const struct omap_dss_features omap3430_dss_features = {
 	.reg_fields = omap3_dss_reg_fields,
 	.num_reg_fields = ARRAY_SIZE(omap3_dss_reg_fields),
 
-	.has_feature	=
-		FEAT_LCDENABLEPOL |
-		FEAT_LCDENABLESIGNAL | FEAT_PCKFREEENABLE |
-		FEAT_FUNCGATED | FEAT_ROWREPEATENABLE |
-		FEAT_LINEBUFFERSPLIT | FEAT_RESIZECONF |
-		FEAT_DSI_PLL_FREQSEL | FEAT_DSI_REVERSE_TXCLKESC |
-		FEAT_VENC_REQUIRES_TV_DAC_CLK | FEAT_CPR | FEAT_PRELOAD |
-		FEAT_FIR_COEF_V | FEAT_ALPHA_FIXED_ZORDER | FEAT_FIFO_MERGE |
-		FEAT_OMAP3_DSI_FIFO_BUG,
+	.features = omap3430_dss_feat_list,
+	.num_features = ARRAY_SIZE(omap3430_dss_feat_list),
 
 	.num_mgrs = 2,
 	.num_ovls = 3,
@@ -388,15 +459,8 @@ static const struct omap_dss_features omap3630_dss_features = {
 	.reg_fields = omap3_dss_reg_fields,
 	.num_reg_fields = ARRAY_SIZE(omap3_dss_reg_fields),
 
-	.has_feature    =
-		FEAT_LCDENABLEPOL |
-		FEAT_LCDENABLESIGNAL | FEAT_PCKFREEENABLE |
-		FEAT_FUNCGATED |
-		FEAT_ROWREPEATENABLE | FEAT_LINEBUFFERSPLIT |
-		FEAT_RESIZECONF | FEAT_DSI_PLL_PWR_BUG |
-		FEAT_DSI_PLL_FREQSEL | FEAT_CPR | FEAT_PRELOAD |
-		FEAT_FIR_COEF_V | FEAT_ALPHA_FIXED_ZORDER | FEAT_FIFO_MERGE |
-		FEAT_OMAP3_DSI_FIFO_BUG,
+	.features = omap3630_dss_feat_list,
+	.num_features = ARRAY_SIZE(omap3630_dss_feat_list),
 
 	.num_mgrs = 2,
 	.num_ovls = 3,
@@ -415,13 +479,8 @@ static const struct omap_dss_features omap4430_es1_0_dss_features  = {
 	.reg_fields = omap4_dss_reg_fields,
 	.num_reg_fields = ARRAY_SIZE(omap4_dss_reg_fields),
 
-	.has_feature	=
-		FEAT_MGR_LCD2 |
-		FEAT_CORE_CLK_DIV | FEAT_LCD_CLK_SRC |
-		FEAT_DSI_DCS_CMD_CONFIG_VC | FEAT_DSI_VC_OCP_WIDTH |
-		FEAT_DSI_GNQ | FEAT_HANDLE_UV_SEPARATE | FEAT_ATTR2 |
-		FEAT_CPR | FEAT_PRELOAD | FEAT_FIR_COEF_V |
-		FEAT_ALPHA_FREE_ZORDER | FEAT_FIFO_MERGE,
+	.features = omap4430_es1_0_dss_feat_list,
+	.num_features = ARRAY_SIZE(omap4430_es1_0_dss_feat_list),
 
 	.num_mgrs = 3,
 	.num_ovls = 4,
@@ -439,14 +498,8 @@ static const struct omap_dss_features omap4_dss_features = {
 	.reg_fields = omap4_dss_reg_fields,
 	.num_reg_fields = ARRAY_SIZE(omap4_dss_reg_fields),
 
-	.has_feature	=
-		FEAT_MGR_LCD2 |
-		FEAT_CORE_CLK_DIV | FEAT_LCD_CLK_SRC |
-		FEAT_DSI_DCS_CMD_CONFIG_VC | FEAT_DSI_VC_OCP_WIDTH |
-		FEAT_DSI_GNQ | FEAT_HDMI_CTS_SWMODE |
-		FEAT_HANDLE_UV_SEPARATE | FEAT_ATTR2 | FEAT_CPR |
-		FEAT_PRELOAD | FEAT_FIR_COEF_V | FEAT_ALPHA_FREE_ZORDER |
-		FEAT_FIFO_MERGE,
+	.features = omap4_dss_feat_list,
+	.num_features = ARRAY_SIZE(omap4_dss_feat_list),
 
 	.num_mgrs = 3,
 	.num_ovls = 4,
@@ -550,7 +603,16 @@ u32 dss_feat_get_burst_size_unit(void)
 /* DSS has_feature check */
 bool dss_has_feature(enum dss_feat_id id)
 {
-	return omap_current_dss_features->has_feature & id;
+	int i;
+	const enum dss_feat_id *features = omap_current_dss_features->features;
+	const int num_features = omap_current_dss_features->num_features;
+
+	for (i = 0; i < num_features; i++) {
+		if (features[i] == id)
+			return true;
+	}
+
+	return false;
 }
 
 void dss_feat_get_reg_field(enum dss_feat_reg_field id, u8 *start, u8 *end)
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index 5f9b821..682f091 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -31,36 +31,36 @@
 
 /* DSS has feature id */
 enum dss_feat_id {
-	FEAT_LCDENABLEPOL		= 1 << 3,
-	FEAT_LCDENABLESIGNAL		= 1 << 4,
-	FEAT_PCKFREEENABLE		= 1 << 5,
-	FEAT_FUNCGATED			= 1 << 6,
-	FEAT_MGR_LCD2			= 1 << 7,
-	FEAT_LINEBUFFERSPLIT		= 1 << 8,
-	FEAT_ROWREPEATENABLE		= 1 << 9,
-	FEAT_RESIZECONF			= 1 << 10,
+	FEAT_LCDENABLEPOL,
+	FEAT_LCDENABLESIGNAL,
+	FEAT_PCKFREEENABLE,
+	FEAT_FUNCGATED,
+	FEAT_MGR_LCD2,
+	FEAT_LINEBUFFERSPLIT,
+	FEAT_ROWREPEATENABLE,
+	FEAT_RESIZECONF,
 	/* Independent core clk divider */
-	FEAT_CORE_CLK_DIV		= 1 << 11,
-	FEAT_LCD_CLK_SRC		= 1 << 12,
+	FEAT_CORE_CLK_DIV,
+	FEAT_LCD_CLK_SRC,
 	/* DSI-PLL power command 0x3 is not working */
-	FEAT_DSI_PLL_PWR_BUG		= 1 << 13,
-	FEAT_DSI_PLL_FREQSEL		= 1 << 14,
-	FEAT_DSI_DCS_CMD_CONFIG_VC	= 1 << 15,
-	FEAT_DSI_VC_OCP_WIDTH		= 1 << 16,
-	FEAT_DSI_REVERSE_TXCLKESC	= 1 << 17,
-	FEAT_DSI_GNQ			= 1 << 18,
-	FEAT_HDMI_CTS_SWMODE		= 1 << 19,
-	FEAT_HANDLE_UV_SEPARATE         = 1 << 20,
-	FEAT_ATTR2                      = 1 << 21,
-	FEAT_VENC_REQUIRES_TV_DAC_CLK	= 1 << 22,
-	FEAT_CPR			= 1 << 23,
-	FEAT_PRELOAD			= 1 << 24,
-	FEAT_FIR_COEF_V			= 1 << 25,
-	FEAT_ALPHA_FIXED_ZORDER		= 1 << 26,
-	FEAT_ALPHA_FREE_ZORDER		= 1 << 27,
-	FEAT_FIFO_MERGE			= 1 << 28,
+	FEAT_DSI_PLL_PWR_BUG,
+	FEAT_DSI_PLL_FREQSEL,
+	FEAT_DSI_DCS_CMD_CONFIG_VC,
+	FEAT_DSI_VC_OCP_WIDTH,
+	FEAT_DSI_REVERSE_TXCLKESC,
+	FEAT_DSI_GNQ,
+	FEAT_HDMI_CTS_SWMODE,
+	FEAT_HANDLE_UV_SEPARATE,
+	FEAT_ATTR2,
+	FEAT_VENC_REQUIRES_TV_DAC_CLK,
+	FEAT_CPR,
+	FEAT_PRELOAD,
+	FEAT_FIR_COEF_V,
+	FEAT_ALPHA_FIXED_ZORDER,
+	FEAT_ALPHA_FREE_ZORDER,
+	FEAT_FIFO_MERGE,
 	/* An unknown HW bug causing the normal FIFO thresholds not to work */
-	FEAT_OMAP3_DSI_FIFO_BUG		= 1 << 29,
+	FEAT_OMAP3_DSI_FIFO_BUG,
 };
 
 /* DSS register field id */
-- 
1.7.4.1

