From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 08/22] OMAPDSS: DSI: rename clkin4ddr to clkdco
Date: Wed, 12 Nov 2014 13:52:10 +0200
Message-ID: <1415793144-11723-9-git-send-email-tomi.valkeinen@ti.com>
References: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53607 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752288AbaKLLw4 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Nov 2014 06:52:56 -0500
In-Reply-To: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

We are creating a common DSS PLL code, so rename 'clkin4ddr' field,
which is DSI specific name, to 'clkdco' which is a generic name.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dpi.c |  2 +-
 drivers/video/fbdev/omap2/dss/dsi.c | 36 ++++++++++++++++++------------------
 drivers/video/fbdev/omap2/dss/dss.h |  2 +-
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dpi.c b/drivers/video/fbdev/omap2/dss/dpi.c
index 91f18ab72007..f6a14c80bd0b 100644
--- a/drivers/video/fbdev/omap2/dss/dpi.c
+++ b/drivers/video/fbdev/omap2/dss/dpi.c
@@ -195,7 +195,7 @@ static bool dpi_calc_pll_cb(int regn, int regm, unsigned long fint,
 	ctx->dsi_cinfo.regn = regn;
 	ctx->dsi_cinfo.regm = regm;
 	ctx->dsi_cinfo.fint = fint;
-	ctx->dsi_cinfo.clkin4ddr = pll;
+	ctx->dsi_cinfo.clkdco = pll;
 
 	return dsi_hsdiv_calc(ctx->dsidev, pll, ctx->pck_min,
 			dpi_calc_hsdiv_cb, ctx);
diff --git a/drivers/video/fbdev/omap2/dss/dsi.c b/drivers/video/fbdev/omap2/dss/dsi.c
index b0a3c9ed1341..5996ffd6dff1 100644
--- a/drivers/video/fbdev/omap2/dss/dsi.c
+++ b/drivers/video/fbdev/omap2/dss/dsi.c
@@ -1275,7 +1275,7 @@ static unsigned long dsi_get_txbyteclkhs(struct platform_device *dsidev)
 {
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
-	return dsi->current_cinfo.clkin4ddr / 16;
+	return dsi->current_cinfo.clkdco / 16;
 }
 
 static unsigned long dsi_fclk_rate(struct platform_device *dsidev)
@@ -1484,20 +1484,20 @@ static int dsi_calc_clock_rates(struct platform_device *dsidev,
 	if (cinfo->fint > dsi->fint_max || cinfo->fint < dsi->fint_min)
 		return -EINVAL;
 
-	cinfo->clkin4ddr = 2 * cinfo->regm * cinfo->fint;
+	cinfo->clkdco = 2 * cinfo->regm * cinfo->fint;
 
-	if (cinfo->clkin4ddr > 1800 * 1000 * 1000)
+	if (cinfo->clkdco > 1800 * 1000 * 1000)
 		return -EINVAL;
 
 	if (cinfo->regm_dispc > 0)
 		cinfo->dsi_pll_hsdiv_dispc_clk =
-			cinfo->clkin4ddr / cinfo->regm_dispc;
+			cinfo->clkdco / cinfo->regm_dispc;
 	else
 		cinfo->dsi_pll_hsdiv_dispc_clk = 0;
 
 	if (cinfo->regm_dsi > 0)
 		cinfo->dsi_pll_hsdiv_dsi_clk =
-			cinfo->clkin4ddr / cinfo->regm_dsi;
+			cinfo->clkdco / cinfo->regm_dsi;
 	else
 		cinfo->dsi_pll_hsdiv_dsi_clk = 0;
 
@@ -1510,8 +1510,8 @@ static void dsi_pll_calc_dsi_fck(struct dsi_clock_info *cinfo)
 
 	max_dsi_fck = dss_feat_get_param_max(FEAT_PARAM_DSI_FCK);
 
-	cinfo->regm_dsi = DIV_ROUND_UP(cinfo->clkin4ddr, max_dsi_fck);
-	cinfo->dsi_pll_hsdiv_dsi_clk = cinfo->clkin4ddr / cinfo->regm_dsi;
+	cinfo->regm_dsi = DIV_ROUND_UP(cinfo->clkdco, max_dsi_fck);
+	cinfo->dsi_pll_hsdiv_dsi_clk = cinfo->clkdco / cinfo->regm_dsi;
 }
 
 static int dsi_wait_hsdiv_ack(struct platform_device *dsidev, u32 hsdiv_ack_mask)
@@ -1551,12 +1551,12 @@ int dsi_pll_set_clock_div(struct platform_device *dsidev,
 			cinfo->regm,
 			cinfo->regn,
 			clk_get_rate(dsi->sys_clk),
-			cinfo->clkin4ddr);
+			cinfo->clkdco);
 
 	DSSDBG("Data rate on 1 DSI lane %ld Mbps\n",
-			cinfo->clkin4ddr / 1000 / 1000 / 2);
+			cinfo->clkdco / 1000 / 1000 / 2);
 
-	DSSDBG("Clock lane freq %ld Hz\n", cinfo->clkin4ddr / 4);
+	DSSDBG("Clock lane freq %ld Hz\n", cinfo->clkdco / 4);
 
 	DSSDBG("regm_dispc = %d, %s (%s) = %lu\n", cinfo->regm_dispc,
 		dss_get_generic_clk_source_name(OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC),
@@ -1604,7 +1604,7 @@ int dsi_pll_set_clock_div(struct platform_device *dsidev,
 
 		l = FLD_MOD(l, f, 4, 1);	/* DSI_PLL_FREQSEL */
 	} else if (dss_has_feature(FEAT_DSI_PLL_SELFREQDCO)) {
-		f = cinfo->clkin4ddr < 1000000000 ? 0x2 : 0x4;
+		f = cinfo->clkdco < 1000000000 ? 0x2 : 0x4;
 
 		l = FLD_MOD(l, f, 3, 1);	/* PLL_SELFREQDCO */
 	}
@@ -1754,7 +1754,7 @@ static void dsi_dump_dsidev_clocks(struct platform_device *dsidev,
 	seq_printf(s,	"Fint\t\t%-16luregn %u\n", cinfo->fint, cinfo->regn);
 
 	seq_printf(s,	"CLKIN4DDR\t%-16luregm %u\n",
-			cinfo->clkin4ddr, cinfo->regm);
+			cinfo->clkdco, cinfo->regm);
 
 	seq_printf(s,	"DSI_PLL_HSDIV_DISPC (%s)\t%-16luregm_dispc %u\t(%s)\n",
 			dss_feat_get_clk_source_name(dsi_module == 0 ?
@@ -1783,7 +1783,7 @@ static void dsi_dump_dsidev_clocks(struct platform_device *dsidev,
 	seq_printf(s,	"DSI_FCLK\t%lu\n", dsi_fclk_rate(dsidev));
 
 	seq_printf(s,	"DDR_CLK\t\t%lu\n",
-			cinfo->clkin4ddr / 4);
+			cinfo->clkdco / 4);
 
 	seq_printf(s,	"TxByteClkHS\t%lu\n", dsi_get_txbyteclkhs(dsidev));
 
@@ -2122,7 +2122,7 @@ static inline unsigned ns2ddr(struct platform_device *dsidev, unsigned ns)
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
 	/* convert time in ns to ddr ticks, rounding up */
-	unsigned long ddr_clk = dsi->current_cinfo.clkin4ddr / 4;
+	unsigned long ddr_clk = dsi->current_cinfo.clkdco / 4;
 	return (ns * (ddr_clk / 1000 / 1000) + 999) / 1000;
 }
 
@@ -2130,7 +2130,7 @@ static inline unsigned ddr2ns(struct platform_device *dsidev, unsigned ddr)
 {
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 
-	unsigned long ddr_clk = dsi->current_cinfo.clkin4ddr / 4;
+	unsigned long ddr_clk = dsi->current_cinfo.clkdco / 4;
 	return ddr * 1000 * 1000 / (ddr_clk / 1000);
 }
 
@@ -4723,7 +4723,7 @@ static bool dsi_cm_calc_pll_cb(int regn, int regm, unsigned long fint,
 	ctx->dsi_cinfo.regn = regn;
 	ctx->dsi_cinfo.regm = regm;
 	ctx->dsi_cinfo.fint = fint;
-	ctx->dsi_cinfo.clkin4ddr = pll;
+	ctx->dsi_cinfo.clkdco = pll;
 
 	return dsi_hsdiv_calc(ctx->dsidev, pll, ctx->req_pck_min,
 			dsi_cm_calc_hsdiv_cb, ctx);
@@ -4773,7 +4773,7 @@ static bool dsi_vm_calc_blanking(struct dsi_clk_calc_ctx *ctx)
 	const struct omap_dss_dsi_config *cfg = ctx->config;
 	int bitspp = dsi_get_pixel_size(cfg->pixel_format);
 	int ndl = dsi->num_lanes_used - 1;
-	unsigned long hsclk = ctx->dsi_cinfo.clkin4ddr / 4;
+	unsigned long hsclk = ctx->dsi_cinfo.clkdco / 4;
 	unsigned long byteclk = hsclk / 4;
 
 	unsigned long dispc_pck, req_pck_min, req_pck_nom, req_pck_max;
@@ -5019,7 +5019,7 @@ static bool dsi_vm_calc_pll_cb(int regn, int regm, unsigned long fint,
 	ctx->dsi_cinfo.regn = regn;
 	ctx->dsi_cinfo.regm = regm;
 	ctx->dsi_cinfo.fint = fint;
-	ctx->dsi_cinfo.clkin4ddr = pll;
+	ctx->dsi_cinfo.clkdco = pll;
 
 	return dsi_hsdiv_calc(ctx->dsidev, pll, ctx->req_pck_min,
 			dsi_vm_calc_hsdiv_cb, ctx);
diff --git a/drivers/video/fbdev/omap2/dss/dss.h b/drivers/video/fbdev/omap2/dss/dss.h
index 45e255ecff29..e2f0196a083b 100644
--- a/drivers/video/fbdev/omap2/dss/dss.h
+++ b/drivers/video/fbdev/omap2/dss/dss.h
@@ -113,7 +113,7 @@ struct dispc_clock_info {
 struct dsi_clock_info {
 	/* rates that we get with dividers below */
 	unsigned long fint;
-	unsigned long clkin4ddr;
+	unsigned long clkdco;
 	unsigned long dsi_pll_hsdiv_dispc_clk;	/* OMAP3: DSI1_PLL_CLK
 						 * OMAP4: PLLx_CLK1 */
 	unsigned long dsi_pll_hsdiv_dsi_clk;	/* OMAP3: DSI2_PLL_CLK
-- 
2.1.3

