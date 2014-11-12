From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 22/22] OMAPDSS: features: remove unused DSI PLL features
Date: Wed, 12 Nov 2014 13:52:24 +0200
Message-ID: <1415793144-11723-23-git-send-email-tomi.valkeinen@ti.com>
References: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38581 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752554AbaKLLxR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Nov 2014 06:53:17 -0500
In-Reply-To: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Now that the DSS has the common DSS PLL, we no longer use the DSI PLL
feature flags from dss_features.c.

Remove all the unused feature flags.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dss_features.c | 38 ----------------------------
 drivers/video/fbdev/omap2/dss/dss_features.h | 11 --------
 2 files changed, 49 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dss_features.c b/drivers/video/fbdev/omap2/dss/dss_features.c
index 7e7fcf450342..0e3da809473c 100644
--- a/drivers/video/fbdev/omap2/dss/dss_features.c
+++ b/drivers/video/fbdev/omap2/dss/dss_features.c
@@ -72,10 +72,6 @@ static const struct dss_reg_field omap2_dss_reg_fields[] = {
 	[FEAT_REG_HORIZONTALACCU]		= { 9, 0 },
 	[FEAT_REG_VERTICALACCU]			= { 25, 16 },
 	[FEAT_REG_DISPC_CLK_SWITCH]		= { 0, 0 },
-	[FEAT_REG_DSIPLL_REGN]			= { 0, 0 },
-	[FEAT_REG_DSIPLL_REGM]			= { 0, 0 },
-	[FEAT_REG_DSIPLL_REGM_DISPC]		= { 0, 0 },
-	[FEAT_REG_DSIPLL_REGM_DSI]		= { 0, 0 },
 };
 
 static const struct dss_reg_field omap3_dss_reg_fields[] = {
@@ -87,10 +83,6 @@ static const struct dss_reg_field omap3_dss_reg_fields[] = {
 	[FEAT_REG_HORIZONTALACCU]		= { 9, 0 },
 	[FEAT_REG_VERTICALACCU]			= { 25, 16 },
 	[FEAT_REG_DISPC_CLK_SWITCH]		= { 0, 0 },
-	[FEAT_REG_DSIPLL_REGN]			= { 7, 1 },
-	[FEAT_REG_DSIPLL_REGM]			= { 18, 8 },
-	[FEAT_REG_DSIPLL_REGM_DISPC]		= { 22, 19 },
-	[FEAT_REG_DSIPLL_REGM_DSI]		= { 26, 23 },
 };
 
 static const struct dss_reg_field am43xx_dss_reg_fields[] = {
@@ -113,10 +105,6 @@ static const struct dss_reg_field omap4_dss_reg_fields[] = {
 	[FEAT_REG_HORIZONTALACCU]		= { 10, 0 },
 	[FEAT_REG_VERTICALACCU]			= { 26, 16 },
 	[FEAT_REG_DISPC_CLK_SWITCH]		= { 9, 8 },
-	[FEAT_REG_DSIPLL_REGN]			= { 8, 1 },
-	[FEAT_REG_DSIPLL_REGM]			= { 20, 9 },
-	[FEAT_REG_DSIPLL_REGM_DISPC]		= { 25, 21 },
-	[FEAT_REG_DSIPLL_REGM_DSI]		= { 30, 26 },
 };
 
 static const struct dss_reg_field omap5_dss_reg_fields[] = {
@@ -128,10 +116,6 @@ static const struct dss_reg_field omap5_dss_reg_fields[] = {
 	[FEAT_REG_HORIZONTALACCU]		= { 10, 0 },
 	[FEAT_REG_VERTICALACCU]			= { 26, 16 },
 	[FEAT_REG_DISPC_CLK_SWITCH]		= { 9, 7 },
-	[FEAT_REG_DSIPLL_REGN]			= { 8, 1 },
-	[FEAT_REG_DSIPLL_REGM]			= { 20, 9 },
-	[FEAT_REG_DSIPLL_REGM_DISPC]		= { 25, 21 },
-	[FEAT_REG_DSIPLL_REGM_DSI]		= { 30, 26 },
 };
 
 static const enum omap_display_type omap2_dss_supported_displays[] = {
@@ -437,11 +421,6 @@ static const char * const omap5_dss_clk_source_names[] = {
 static const struct dss_param_range omap2_dss_param_range[] = {
 	[FEAT_PARAM_DSS_FCK]			= { 0, 133000000 },
 	[FEAT_PARAM_DSS_PCD]			= { 2, 255 },
-	[FEAT_PARAM_DSIPLL_REGN]		= { 0, 0 },
-	[FEAT_PARAM_DSIPLL_REGM]		= { 0, 0 },
-	[FEAT_PARAM_DSIPLL_REGM_HSDIV]		= { 0, 0 },
-	[FEAT_PARAM_DSIPLL_FINT]		= { 0, 0 },
-	[FEAT_PARAM_DSIPLL_LPDIV]		= { 0, 0 },
 	[FEAT_PARAM_DOWNSCALE]			= { 1, 2 },
 	/*
 	 * Assuming the line width buffer to be 768 pixels as OMAP2 DISPC
@@ -453,10 +432,6 @@ static const struct dss_param_range omap2_dss_param_range[] = {
 static const struct dss_param_range omap3_dss_param_range[] = {
 	[FEAT_PARAM_DSS_FCK]			= { 0, 173000000 },
 	[FEAT_PARAM_DSS_PCD]			= { 1, 255 },
-	[FEAT_PARAM_DSIPLL_REGN]		= { 0, (1 << 7) - 1 },
-	[FEAT_PARAM_DSIPLL_REGM]		= { 0, (1 << 11) - 1 },
-	[FEAT_PARAM_DSIPLL_REGM_HSDIV]		= { 0, (1 << 4) - 1 },
-	[FEAT_PARAM_DSIPLL_FINT]		= { 750000, 2100000 },
 	[FEAT_PARAM_DSIPLL_LPDIV]		= { 1, (1 << 13) - 1},
 	[FEAT_PARAM_DSI_FCK]			= { 0, 173000000 },
 	[FEAT_PARAM_DOWNSCALE]			= { 1, 4 },
@@ -473,10 +448,6 @@ static const struct dss_param_range am43xx_dss_param_range[] = {
 static const struct dss_param_range omap4_dss_param_range[] = {
 	[FEAT_PARAM_DSS_FCK]			= { 0, 186000000 },
 	[FEAT_PARAM_DSS_PCD]			= { 1, 255 },
-	[FEAT_PARAM_DSIPLL_REGN]		= { 0, (1 << 8) - 1 },
-	[FEAT_PARAM_DSIPLL_REGM]		= { 0, (1 << 12) - 1 },
-	[FEAT_PARAM_DSIPLL_REGM_HSDIV]		= { 0, (1 << 5) - 1 },
-	[FEAT_PARAM_DSIPLL_FINT]		= { 500000, 2500000 },
 	[FEAT_PARAM_DSIPLL_LPDIV]		= { 0, (1 << 13) - 1 },
 	[FEAT_PARAM_DSI_FCK]			= { 0, 170000000 },
 	[FEAT_PARAM_DOWNSCALE]			= { 1, 4 },
@@ -486,10 +457,6 @@ static const struct dss_param_range omap4_dss_param_range[] = {
 static const struct dss_param_range omap5_dss_param_range[] = {
 	[FEAT_PARAM_DSS_FCK]			= { 0, 209250000 },
 	[FEAT_PARAM_DSS_PCD]			= { 1, 255 },
-	[FEAT_PARAM_DSIPLL_REGN]		= { 0, (1 << 8) - 1 },
-	[FEAT_PARAM_DSIPLL_REGM]		= { 0, (1 << 12) - 1 },
-	[FEAT_PARAM_DSIPLL_REGM_HSDIV]		= { 0, (1 << 5) - 1 },
-	[FEAT_PARAM_DSIPLL_FINT]		= { 150000, 52000000 },
 	[FEAT_PARAM_DSIPLL_LPDIV]		= { 0, (1 << 13) - 1 },
 	[FEAT_PARAM_DSI_FCK]			= { 0, 209250000 },
 	[FEAT_PARAM_DOWNSCALE]			= { 1, 4 },
@@ -513,7 +480,6 @@ static const enum dss_feat_id omap3430_dss_feat_list[] = {
 	FEAT_LINEBUFFERSPLIT,
 	FEAT_ROWREPEATENABLE,
 	FEAT_RESIZECONF,
-	FEAT_DSI_PLL_FREQSEL,
 	FEAT_DSI_REVERSE_TXCLKESC,
 	FEAT_VENC_REQUIRES_TV_DAC_CLK,
 	FEAT_CPR,
@@ -533,7 +499,6 @@ static const enum dss_feat_id am35xx_dss_feat_list[] = {
 	FEAT_LINEBUFFERSPLIT,
 	FEAT_ROWREPEATENABLE,
 	FEAT_RESIZECONF,
-	FEAT_DSI_PLL_FREQSEL,
 	FEAT_DSI_REVERSE_TXCLKESC,
 	FEAT_VENC_REQUIRES_TV_DAC_CLK,
 	FEAT_CPR,
@@ -568,7 +533,6 @@ static const enum dss_feat_id omap3630_dss_feat_list[] = {
 	FEAT_ROWREPEATENABLE,
 	FEAT_RESIZECONF,
 	FEAT_DSI_PLL_PWR_BUG,
-	FEAT_DSI_PLL_FREQSEL,
 	FEAT_CPR,
 	FEAT_PRELOAD,
 	FEAT_FIR_COEF_V,
@@ -650,8 +614,6 @@ static const enum dss_feat_id omap5_dss_feat_list[] = {
 	FEAT_ALPHA_FREE_ZORDER,
 	FEAT_FIFO_MERGE,
 	FEAT_BURST_2D,
-	FEAT_DSI_PLL_SELFREQDCO,
-	FEAT_DSI_PLL_REFSEL,
 	FEAT_DSI_PHY_DCC,
 	FEAT_MFLAG,
 };
diff --git a/drivers/video/fbdev/omap2/dss/dss_features.h b/drivers/video/fbdev/omap2/dss/dss_features.h
index 05e8127d36b0..100f7a2d0638 100644
--- a/drivers/video/fbdev/omap2/dss/dss_features.h
+++ b/drivers/video/fbdev/omap2/dss/dss_features.h
@@ -41,7 +41,6 @@ enum dss_feat_id {
 	FEAT_LCD_CLK_SRC,
 	/* DSI-PLL power command 0x3 is not working */
 	FEAT_DSI_PLL_PWR_BUG,
-	FEAT_DSI_PLL_FREQSEL,
 	FEAT_DSI_DCS_CMD_CONFIG_VC,
 	FEAT_DSI_VC_OCP_WIDTH,
 	FEAT_DSI_REVERSE_TXCLKESC,
@@ -61,8 +60,6 @@ enum dss_feat_id {
 	/* An unknown HW bug causing the normal FIFO thresholds not to work */
 	FEAT_OMAP3_DSI_FIFO_BUG,
 	FEAT_BURST_2D,
-	FEAT_DSI_PLL_SELFREQDCO,
-	FEAT_DSI_PLL_REFSEL,
 	FEAT_DSI_PHY_DCC,
 	FEAT_MFLAG,
 };
@@ -77,19 +74,11 @@ enum dss_feat_reg_field {
 	FEAT_REG_HORIZONTALACCU,
 	FEAT_REG_VERTICALACCU,
 	FEAT_REG_DISPC_CLK_SWITCH,
-	FEAT_REG_DSIPLL_REGN,
-	FEAT_REG_DSIPLL_REGM,
-	FEAT_REG_DSIPLL_REGM_DISPC,
-	FEAT_REG_DSIPLL_REGM_DSI,
 };
 
 enum dss_range_param {
 	FEAT_PARAM_DSS_FCK,
 	FEAT_PARAM_DSS_PCD,
-	FEAT_PARAM_DSIPLL_REGN,
-	FEAT_PARAM_DSIPLL_REGM,
-	FEAT_PARAM_DSIPLL_REGM_HSDIV,
-	FEAT_PARAM_DSIPLL_FINT,
 	FEAT_PARAM_DSIPLL_LPDIV,
 	FEAT_PARAM_DSI_FCK,
 	FEAT_PARAM_DOWNSCALE,
-- 
2.1.3

