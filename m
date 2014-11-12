From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 09/22] OMAPDSS: DSI: turn hsdivs fields to arrays
Date: Wed, 12 Nov 2014 13:52:11 +0200
Message-ID: <1415793144-11723-10-git-send-email-tomi.valkeinen@ti.com>
References: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53609 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751547AbaKLLw6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Nov 2014 06:52:58 -0500
In-Reply-To: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

We are creating a common DSS PLL code, so having fixed DSI specific
hsdiv fields in the clock information is not ok.

This patch changes the hsdiv fields to arrays, so that we can use all
the 4 possible hsdiv outputs (DSI only usees 2), and we have generic way
to access the hsdivs.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dpi.c | 10 +++---
 drivers/video/fbdev/omap2/dss/dsi.c | 64 ++++++++++++++++++++-----------------
 drivers/video/fbdev/omap2/dss/dss.h | 10 ++----
 3 files changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dpi.c b/drivers/video/fbdev/omap2/dss/dpi.c
index f6a14c80bd0b..0b9af5d3e650 100644
--- a/drivers/video/fbdev/omap2/dss/dpi.c
+++ b/drivers/video/fbdev/omap2/dss/dpi.c
@@ -37,6 +37,8 @@
 #include "dss.h"
 #include "dss_features.h"
 
+#define HSDIV_DISPC	0
+
 struct dpi_data {
 	struct platform_device *pdev;
 
@@ -178,8 +180,8 @@ static bool dpi_calc_hsdiv_cb(int regm_dispc, unsigned long dispc,
 	if (regm_dispc > 1 && regm_dispc % 2 != 0 && ctx->pck_min >= 100000000)
 		return false;
 
-	ctx->dsi_cinfo.regm_dispc = regm_dispc;
-	ctx->dsi_cinfo.dsi_pll_hsdiv_dispc_clk = dispc;
+	ctx->dsi_cinfo.regm_hsdiv[HSDIV_DISPC] = regm_dispc;
+	ctx->dsi_cinfo.clkout[HSDIV_DISPC] = dispc;
 
 	return dispc_div_calc(dispc, ctx->pck_min, ctx->pck_max,
 			dpi_calc_dispc_cb, ctx);
@@ -284,7 +286,7 @@ static int dpi_set_dsi_clk(struct dpi_data *dpi, enum omap_channel channel,
 
 	dpi->mgr_config.clock_info = ctx.dispc_cinfo;
 
-	*fck = ctx.dsi_cinfo.dsi_pll_hsdiv_dispc_clk;
+	*fck = ctx.dsi_cinfo.clkout[HSDIV_DISPC];
 	*lck_div = ctx.dispc_cinfo.lck_div;
 	*pck_div = ctx.dispc_cinfo.pck_div;
 
@@ -516,7 +518,7 @@ static int dpi_check_timings(struct omap_dss_device *dssdev,
 		if (!ok)
 			return -EINVAL;
 
-		fck = ctx.dsi_cinfo.dsi_pll_hsdiv_dispc_clk;
+		fck = ctx.dsi_cinfo.clkout[HSDIV_DISPC];
 	} else {
 		ok = dpi_dss_clk_calc(timings->pixelclock, &ctx);
 		if (!ok)
diff --git a/drivers/video/fbdev/omap2/dss/dsi.c b/drivers/video/fbdev/omap2/dss/dsi.c
index 5996ffd6dff1..406af309f8ff 100644
--- a/drivers/video/fbdev/omap2/dss/dsi.c
+++ b/drivers/video/fbdev/omap2/dss/dsi.c
@@ -219,6 +219,10 @@ static void dsi_display_uninit_dispc(struct platform_device *dsidev,
 
 static int dsi_vc_send_null(struct omap_dss_device *dssdev, int channel);
 
+/* DSI PLL HSDIV indices */
+#define HSDIV_DISPC	0
+#define HSDIV_DSI	1
+
 #define DSI_MAX_NR_ISRS                2
 #define DSI_MAX_NR_LANES	5
 
@@ -1261,14 +1265,14 @@ unsigned long dsi_get_pll_hsdiv_dispc_rate(struct platform_device *dsidev)
 {
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
-	return dsi->current_cinfo.dsi_pll_hsdiv_dispc_clk;
+	return dsi->current_cinfo.clkout[HSDIV_DISPC];
 }
 
 static unsigned long dsi_get_pll_hsdiv_dsi_rate(struct platform_device *dsidev)
 {
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
-	return dsi->current_cinfo.dsi_pll_hsdiv_dsi_clk;
+	return dsi->current_cinfo.clkout[HSDIV_DSI];
 }
 
 static unsigned long dsi_get_txbyteclkhs(struct platform_device *dsidev)
@@ -1473,10 +1477,10 @@ static int dsi_calc_clock_rates(struct platform_device *dsidev,
 	if (cinfo->regm == 0 || cinfo->regm > dsi->regm_max)
 		return -EINVAL;
 
-	if (cinfo->regm_dispc > dsi->regm_dispc_max)
+	if (cinfo->regm_hsdiv[HSDIV_DISPC] > dsi->regm_dispc_max)
 		return -EINVAL;
 
-	if (cinfo->regm_dsi > dsi->regm_dsi_max)
+	if (cinfo->regm_hsdiv[HSDIV_DSI] > dsi->regm_dsi_max)
 		return -EINVAL;
 
 	cinfo->fint = clk_get_rate(dsi->sys_clk) / cinfo->regn;
@@ -1489,17 +1493,17 @@ static int dsi_calc_clock_rates(struct platform_device *dsidev,
 	if (cinfo->clkdco > 1800 * 1000 * 1000)
 		return -EINVAL;
 
-	if (cinfo->regm_dispc > 0)
-		cinfo->dsi_pll_hsdiv_dispc_clk =
-			cinfo->clkdco / cinfo->regm_dispc;
+	if (cinfo->regm_hsdiv[HSDIV_DISPC])
+		cinfo->clkout[HSDIV_DISPC] =
+			cinfo->clkdco / cinfo->regm_hsdiv[HSDIV_DISPC];
 	else
-		cinfo->dsi_pll_hsdiv_dispc_clk = 0;
+		cinfo->clkout[HSDIV_DISPC] = 0;
 
-	if (cinfo->regm_dsi > 0)
-		cinfo->dsi_pll_hsdiv_dsi_clk =
-			cinfo->clkdco / cinfo->regm_dsi;
+	if (cinfo->regm_hsdiv[HSDIV_DSI])
+		cinfo->clkout[HSDIV_DSI] =
+			cinfo->clkdco / cinfo->regm_hsdiv[HSDIV_DSI];
 	else
-		cinfo->dsi_pll_hsdiv_dsi_clk = 0;
+		cinfo->clkout[HSDIV_DSI] = 0;
 
 	return 0;
 }
@@ -1510,8 +1514,8 @@ static void dsi_pll_calc_dsi_fck(struct dsi_clock_info *cinfo)
 
 	max_dsi_fck = dss_feat_get_param_max(FEAT_PARAM_DSI_FCK);
 
-	cinfo->regm_dsi = DIV_ROUND_UP(cinfo->clkdco, max_dsi_fck);
-	cinfo->dsi_pll_hsdiv_dsi_clk = cinfo->clkdco / cinfo->regm_dsi;
+	cinfo->regm_hsdiv[HSDIV_DSI] = DIV_ROUND_UP(cinfo->clkdco, max_dsi_fck);
+	cinfo->clkout[HSDIV_DSI] = cinfo->clkdco / cinfo->regm_hsdiv[HSDIV_DSI];
 }
 
 static int dsi_wait_hsdiv_ack(struct platform_device *dsidev, u32 hsdiv_ack_mask)
@@ -1558,14 +1562,14 @@ int dsi_pll_set_clock_div(struct platform_device *dsidev,
 
 	DSSDBG("Clock lane freq %ld Hz\n", cinfo->clkdco / 4);
 
-	DSSDBG("regm_dispc = %d, %s (%s) = %lu\n", cinfo->regm_dispc,
+	DSSDBG("regm_dispc = %d, %s (%s) = %lu\n", cinfo->regm_hsdiv[HSDIV_DISPC],
 		dss_get_generic_clk_source_name(OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC),
 		dss_feat_get_clk_source_name(OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC),
-		cinfo->dsi_pll_hsdiv_dispc_clk);
-	DSSDBG("regm_dsi = %d, %s (%s) = %lu\n", cinfo->regm_dsi,
+		cinfo->clkout[HSDIV_DISPC]);
+	DSSDBG("regm_dsi = %d, %s (%s) = %lu\n", cinfo->regm_hsdiv[HSDIV_DSI],
 		dss_get_generic_clk_source_name(OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI),
 		dss_feat_get_clk_source_name(OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI),
-		cinfo->dsi_pll_hsdiv_dsi_clk);
+		cinfo->clkout[HSDIV_DSI]);
 
 	dss_feat_get_reg_field(FEAT_REG_DSIPLL_REGN, &regn_start, &regn_end);
 	dss_feat_get_reg_field(FEAT_REG_DSIPLL_REGM, &regm_start, &regm_end);
@@ -1584,10 +1588,10 @@ int dsi_pll_set_clock_div(struct platform_device *dsidev,
 	/* DSI_PLL_REGM */
 	l = FLD_MOD(l, cinfo->regm, regm_start, regm_end);
 	/* DSI_CLOCK_DIV */
-	l = FLD_MOD(l, cinfo->regm_dispc > 0 ? cinfo->regm_dispc - 1 : 0,
+	l = FLD_MOD(l, cinfo->regm_hsdiv[HSDIV_DISPC] > 0 ? cinfo->regm_hsdiv[HSDIV_DISPC] - 1 : 0,
 			regm_dispc_start, regm_dispc_end);
 	/* DSIPROTO_CLOCK_DIV */
-	l = FLD_MOD(l, cinfo->regm_dsi > 0 ? cinfo->regm_dsi - 1 : 0,
+	l = FLD_MOD(l, cinfo->regm_hsdiv[HSDIV_DSI] > 0 ? cinfo->regm_hsdiv[HSDIV_DSI] - 1 : 0,
 			regm_dsi_start, regm_dsi_end);
 	dsi_write_reg(dsidev, DSI_PLL_CONFIGURATION1, l);
 
@@ -1760,8 +1764,8 @@ static void dsi_dump_dsidev_clocks(struct platform_device *dsidev,
 			dss_feat_get_clk_source_name(dsi_module == 0 ?
 				OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC :
 				OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC),
-			cinfo->dsi_pll_hsdiv_dispc_clk,
-			cinfo->regm_dispc,
+			cinfo->clkout[HSDIV_DISPC],
+			cinfo->regm_hsdiv[HSDIV_DISPC],
 			dispc_clk_src == OMAP_DSS_CLK_SRC_FCK ?
 			"off" : "on");
 
@@ -1769,8 +1773,8 @@ static void dsi_dump_dsidev_clocks(struct platform_device *dsidev,
 			dss_feat_get_clk_source_name(dsi_module == 0 ?
 				OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI :
 				OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DSI),
-			cinfo->dsi_pll_hsdiv_dsi_clk,
-			cinfo->regm_dsi,
+			cinfo->clkout[HSDIV_DSI],
+			cinfo->regm_hsdiv[HSDIV_DSI],
 			dsi_clk_src == OMAP_DSS_CLK_SRC_FCK ?
 			"off" : "on");
 
@@ -3720,7 +3724,7 @@ static void dsi_config_cmd_mode_interleaving(struct platform_device *dsidev)
 	struct omap_video_timings *timings = &dsi->timings;
 	int bpp = dsi_get_pixel_size(dsi->pix_fmt);
 	int ndl = dsi->num_lanes_used - 1;
-	int dsi_fclk_hsdiv = dsi->user_dsi_cinfo.regm_dsi + 1;
+	int dsi_fclk_hsdiv = dsi->user_dsi_cinfo.regm_hsdiv[HSDIV_DSI] + 1;
 	int hsa_interleave_hs = 0, hsa_interleave_lp = 0;
 	int hfp_interleave_hs = 0, hfp_interleave_lp = 0;
 	int hbp_interleave_hs = 0, hbp_interleave_lp = 0;
@@ -4708,8 +4712,8 @@ static bool dsi_cm_calc_hsdiv_cb(int regm_dispc, unsigned long dispc,
 {
 	struct dsi_clk_calc_ctx *ctx = data;
 
-	ctx->dsi_cinfo.regm_dispc = regm_dispc;
-	ctx->dsi_cinfo.dsi_pll_hsdiv_dispc_clk = dispc;
+	ctx->dsi_cinfo.regm_hsdiv[HSDIV_DISPC] = regm_dispc;
+	ctx->dsi_cinfo.clkout[HSDIV_DISPC] = dispc;
 
 	return dispc_div_calc(dispc, ctx->req_pck_min, ctx->req_pck_max,
 			dsi_cm_calc_dispc_cb, ctx);
@@ -4994,8 +4998,8 @@ static bool dsi_vm_calc_hsdiv_cb(int regm_dispc, unsigned long dispc,
 	struct dsi_clk_calc_ctx *ctx = data;
 	unsigned long pck_max;
 
-	ctx->dsi_cinfo.regm_dispc = regm_dispc;
-	ctx->dsi_cinfo.dsi_pll_hsdiv_dispc_clk = dispc;
+	ctx->dsi_cinfo.regm_hsdiv[HSDIV_DISPC] = regm_dispc;
+	ctx->dsi_cinfo.clkout[HSDIV_DISPC] = dispc;
 
 	/*
 	 * In burst mode we can let the dispc pck be arbitrarily high, but it
@@ -5093,7 +5097,7 @@ static int dsi_set_config(struct omap_dss_device *dssdev,
 
 	dsi_pll_calc_dsi_fck(&ctx.dsi_cinfo);
 
-	r = dsi_lp_clock_calc(ctx.dsi_cinfo.dsi_pll_hsdiv_dsi_clk,
+	r = dsi_lp_clock_calc(ctx.dsi_cinfo.clkout[HSDIV_DSI],
 		config->lp_clk_min, config->lp_clk_max, &dsi->user_lp_cinfo);
 	if (r) {
 		DSSERR("failed to find suitable DSI LP clock settings\n");
diff --git a/drivers/video/fbdev/omap2/dss/dss.h b/drivers/video/fbdev/omap2/dss/dss.h
index e2f0196a083b..e14a75b743a4 100644
--- a/drivers/video/fbdev/omap2/dss/dss.h
+++ b/drivers/video/fbdev/omap2/dss/dss.h
@@ -114,18 +114,12 @@ struct dsi_clock_info {
 	/* rates that we get with dividers below */
 	unsigned long fint;
 	unsigned long clkdco;
-	unsigned long dsi_pll_hsdiv_dispc_clk;	/* OMAP3: DSI1_PLL_CLK
-						 * OMAP4: PLLx_CLK1 */
-	unsigned long dsi_pll_hsdiv_dsi_clk;	/* OMAP3: DSI2_PLL_CLK
-						 * OMAP4: PLLx_CLK2 */
+	unsigned long clkout[4];
 
 	/* dividers */
 	u16 regn;
 	u16 regm;
-	u16 regm_dispc;	/* OMAP3: REGM3
-			 * OMAP4: REGM4 */
-	u16 regm_dsi;	/* OMAP3: REGM4
-			 * OMAP4: REGM5 */
+	u16 regm_hsdiv[4];
 };
 
 struct dss_lcd_mgr_config {
-- 
2.1.3

