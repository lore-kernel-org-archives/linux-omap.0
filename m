From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 10/22] OMAPDSS: DSI: features: combine dsi & dispc hsdivs
Date: Wed, 12 Nov 2014 13:52:12 +0200
Message-ID: <1415793144-11723-11-git-send-email-tomi.valkeinen@ti.com>
References: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53611 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752467AbaKLLw7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Nov 2014 06:52:59 -0500
In-Reply-To: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

The HSDIV outputs of DSI PLL (and also other PLLs) all have the same
bit width for the divider value.

Simplify the code by merging HSDIV divider widths into one width.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dsi.c          | 13 ++++++-------
 drivers/video/fbdev/omap2/dss/dss_features.c | 12 ++++--------
 drivers/video/fbdev/omap2/dss/dss_features.h |  3 +--
 3 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dsi.c b/drivers/video/fbdev/omap2/dss/dsi.c
index 406af309f8ff..22cc91851e94 100644
--- a/drivers/video/fbdev/omap2/dss/dsi.c
+++ b/drivers/video/fbdev/omap2/dss/dsi.c
@@ -374,7 +374,7 @@ struct dsi_data {
 #endif
 	/* DSI PLL Parameter Ranges */
 	unsigned long regm_max, regn_max;
-	unsigned long  regm_dispc_max, regm_dsi_max;
+	unsigned long  regm_hsdiv_max;
 	unsigned long  fint_min, fint_max;
 	unsigned long lpdiv_max;
 
@@ -1414,7 +1414,7 @@ bool dsi_hsdiv_calc(struct platform_device *dsidev, unsigned long pll,
 	out_max = dss_feat_get_param_max(FEAT_PARAM_DSS_FCK);
 
 	regm_start = max(DIV_ROUND_UP(pll, out_max), 1ul);
-	regm_stop = min(pll / out_min, dsi->regm_dispc_max);
+	regm_stop = min(pll / out_min, dsi->regm_hsdiv_max);
 
 	for (regm = regm_start; regm <= regm_stop; ++regm) {
 		out = pll / regm;
@@ -1477,10 +1477,10 @@ static int dsi_calc_clock_rates(struct platform_device *dsidev,
 	if (cinfo->regm == 0 || cinfo->regm > dsi->regm_max)
 		return -EINVAL;
 
-	if (cinfo->regm_hsdiv[HSDIV_DISPC] > dsi->regm_dispc_max)
+	if (cinfo->regm_hsdiv[HSDIV_DISPC] > dsi->regm_hsdiv_max)
 		return -EINVAL;
 
-	if (cinfo->regm_hsdiv[HSDIV_DSI] > dsi->regm_dsi_max)
+	if (cinfo->regm_hsdiv[HSDIV_DSI] > dsi->regm_hsdiv_max)
 		return -EINVAL;
 
 	cinfo->fint = clk_get_rate(dsi->sys_clk) / cinfo->regn;
@@ -5232,9 +5232,8 @@ static void dsi_calc_clock_param_ranges(struct platform_device *dsidev)
 
 	dsi->regn_max = dss_feat_get_param_max(FEAT_PARAM_DSIPLL_REGN);
 	dsi->regm_max = dss_feat_get_param_max(FEAT_PARAM_DSIPLL_REGM);
-	dsi->regm_dispc_max =
-		dss_feat_get_param_max(FEAT_PARAM_DSIPLL_REGM_DISPC);
-	dsi->regm_dsi_max = dss_feat_get_param_max(FEAT_PARAM_DSIPLL_REGM_DSI);
+	dsi->regm_hsdiv_max =
+		dss_feat_get_param_max(FEAT_PARAM_DSIPLL_REGM_HSDIV);
 	dsi->fint_min = dss_feat_get_param_min(FEAT_PARAM_DSIPLL_FINT);
 	dsi->fint_max = dss_feat_get_param_max(FEAT_PARAM_DSIPLL_FINT);
 	dsi->lpdiv_max = dss_feat_get_param_max(FEAT_PARAM_DSIPLL_LPDIV);
diff --git a/drivers/video/fbdev/omap2/dss/dss_features.c b/drivers/video/fbdev/omap2/dss/dss_features.c
index 15088df7bd16..7e7fcf450342 100644
--- a/drivers/video/fbdev/omap2/dss/dss_features.c
+++ b/drivers/video/fbdev/omap2/dss/dss_features.c
@@ -439,8 +439,7 @@ static const struct dss_param_range omap2_dss_param_range[] = {
 	[FEAT_PARAM_DSS_PCD]			= { 2, 255 },
 	[FEAT_PARAM_DSIPLL_REGN]		= { 0, 0 },
 	[FEAT_PARAM_DSIPLL_REGM]		= { 0, 0 },
-	[FEAT_PARAM_DSIPLL_REGM_DISPC]		= { 0, 0 },
-	[FEAT_PARAM_DSIPLL_REGM_DSI]		= { 0, 0 },
+	[FEAT_PARAM_DSIPLL_REGM_HSDIV]		= { 0, 0 },
 	[FEAT_PARAM_DSIPLL_FINT]		= { 0, 0 },
 	[FEAT_PARAM_DSIPLL_LPDIV]		= { 0, 0 },
 	[FEAT_PARAM_DOWNSCALE]			= { 1, 2 },
@@ -456,8 +455,7 @@ static const struct dss_param_range omap3_dss_param_range[] = {
 	[FEAT_PARAM_DSS_PCD]			= { 1, 255 },
 	[FEAT_PARAM_DSIPLL_REGN]		= { 0, (1 << 7) - 1 },
 	[FEAT_PARAM_DSIPLL_REGM]		= { 0, (1 << 11) - 1 },
-	[FEAT_PARAM_DSIPLL_REGM_DISPC]		= { 0, (1 << 4) - 1 },
-	[FEAT_PARAM_DSIPLL_REGM_DSI]		= { 0, (1 << 4) - 1 },
+	[FEAT_PARAM_DSIPLL_REGM_HSDIV]		= { 0, (1 << 4) - 1 },
 	[FEAT_PARAM_DSIPLL_FINT]		= { 750000, 2100000 },
 	[FEAT_PARAM_DSIPLL_LPDIV]		= { 1, (1 << 13) - 1},
 	[FEAT_PARAM_DSI_FCK]			= { 0, 173000000 },
@@ -477,8 +475,7 @@ static const struct dss_param_range omap4_dss_param_range[] = {
 	[FEAT_PARAM_DSS_PCD]			= { 1, 255 },
 	[FEAT_PARAM_DSIPLL_REGN]		= { 0, (1 << 8) - 1 },
 	[FEAT_PARAM_DSIPLL_REGM]		= { 0, (1 << 12) - 1 },
-	[FEAT_PARAM_DSIPLL_REGM_DISPC]		= { 0, (1 << 5) - 1 },
-	[FEAT_PARAM_DSIPLL_REGM_DSI]		= { 0, (1 << 5) - 1 },
+	[FEAT_PARAM_DSIPLL_REGM_HSDIV]		= { 0, (1 << 5) - 1 },
 	[FEAT_PARAM_DSIPLL_FINT]		= { 500000, 2500000 },
 	[FEAT_PARAM_DSIPLL_LPDIV]		= { 0, (1 << 13) - 1 },
 	[FEAT_PARAM_DSI_FCK]			= { 0, 170000000 },
@@ -491,8 +488,7 @@ static const struct dss_param_range omap5_dss_param_range[] = {
 	[FEAT_PARAM_DSS_PCD]			= { 1, 255 },
 	[FEAT_PARAM_DSIPLL_REGN]		= { 0, (1 << 8) - 1 },
 	[FEAT_PARAM_DSIPLL_REGM]		= { 0, (1 << 12) - 1 },
-	[FEAT_PARAM_DSIPLL_REGM_DISPC]		= { 0, (1 << 5) - 1 },
-	[FEAT_PARAM_DSIPLL_REGM_DSI]		= { 0, (1 << 5) - 1 },
+	[FEAT_PARAM_DSIPLL_REGM_HSDIV]		= { 0, (1 << 5) - 1 },
 	[FEAT_PARAM_DSIPLL_FINT]		= { 150000, 52000000 },
 	[FEAT_PARAM_DSIPLL_LPDIV]		= { 0, (1 << 13) - 1 },
 	[FEAT_PARAM_DSI_FCK]			= { 0, 209250000 },
diff --git a/drivers/video/fbdev/omap2/dss/dss_features.h b/drivers/video/fbdev/omap2/dss/dss_features.h
index e3ef3b714896..05e8127d36b0 100644
--- a/drivers/video/fbdev/omap2/dss/dss_features.h
+++ b/drivers/video/fbdev/omap2/dss/dss_features.h
@@ -88,8 +88,7 @@ enum dss_range_param {
 	FEAT_PARAM_DSS_PCD,
 	FEAT_PARAM_DSIPLL_REGN,
 	FEAT_PARAM_DSIPLL_REGM,
-	FEAT_PARAM_DSIPLL_REGM_DISPC,
-	FEAT_PARAM_DSIPLL_REGM_DSI,
+	FEAT_PARAM_DSIPLL_REGM_HSDIV,
 	FEAT_PARAM_DSIPLL_FINT,
 	FEAT_PARAM_DSIPLL_LPDIV,
 	FEAT_PARAM_DSI_FCK,
-- 
2.1.3

