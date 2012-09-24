From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/9] OMAPDSS: DSI: improve DSI clock calcs for DISPC
Date: Mon, 24 Sep 2012 16:58:31 +0300
Message-ID: <1348495119-8262-2-git-send-email-tomi.valkeinen@ti.com>
References: <1348495119-8262-1-git-send-email-tomi.valkeinen@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:39974 "EHLO
	na3sys009aog132.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755481Ab2IXN6v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Sep 2012 09:58:51 -0400
Received: by lbbgj3 with SMTP id gj3so6750026lbb.19
        for <linux-omap@vger.kernel.org>; Mon, 24 Sep 2012 06:58:48 -0700 (PDT)
In-Reply-To: <1348495119-8262-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Commit ee144e645a081daad5de1ccac77f0a0e98e6a67b added
dsi_pll_calc_ddrfreq() which calculates PLL dividers based on given DSI
bus clock speed. The function works ok, but it can be improved for the
DISPC clock calc.

The current version calculates the clock going from the PLL to the DISPC
simply by setting the clock as close to DISPC maximum as possible, and
the pixel clock is calculated based on that.

This patch changes the function to calculate DISPC clock more
dynamically, iterating through different DISPC clocks and pixel clock
values, and thus we'll get more suitable pixel clocks.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |  144 ++++++++++++++++++++++++++++++++---------
 1 file changed, 113 insertions(+), 31 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 8d815e3..8d47fb7 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1454,26 +1454,17 @@ found:
 }
 
 static int dsi_pll_calc_ddrfreq(struct platform_device *dsidev,
-		unsigned long req_clk, struct dsi_clock_info *cinfo)
+		unsigned long req_clkin4ddr, struct dsi_clock_info *cinfo)
 {
 	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	struct dsi_clock_info cur, best;
-	unsigned long dss_sys_clk, max_dss_fck, max_dsi_fck;
-	unsigned long req_clkin4ddr;
 
 	DSSDBG("dsi_pll_calc_ddrfreq\n");
 
-	dss_sys_clk = clk_get_rate(dsi->sys_clk);
-
-	max_dss_fck = dss_feat_get_param_max(FEAT_PARAM_DSS_FCK);
-	max_dsi_fck = dss_feat_get_param_max(FEAT_PARAM_DSI_FCK);
-
 	memset(&best, 0, sizeof(best));
 	memset(&cur, 0, sizeof(cur));
 
-	cur.clkin = dss_sys_clk;
-
-	req_clkin4ddr = req_clk * 4;
+	cur.clkin = clk_get_rate(dsi->sys_clk);
 
 	for (cur.regn = 1; cur.regn < dsi->regn_max; ++cur.regn) {
 		cur.fint = cur.clkin / cur.regn;
@@ -1503,18 +1494,107 @@ static int dsi_pll_calc_ddrfreq(struct platform_device *dsidev,
 		}
 	}
 found:
-	best.regm_dispc = DIV_ROUND_UP(best.clkin4ddr, max_dss_fck);
-	best.dsi_pll_hsdiv_dispc_clk = best.clkin4ddr / best.regm_dispc;
-
-	best.regm_dsi = DIV_ROUND_UP(best.clkin4ddr, max_dsi_fck);
-	best.dsi_pll_hsdiv_dsi_clk = best.clkin4ddr / best.regm_dsi;
-
 	if (cinfo)
 		*cinfo = best;
 
 	return 0;
 }
 
+static void dsi_pll_calc_dsi_fck(struct platform_device *dsidev,
+		struct dsi_clock_info *cinfo)
+{
+	unsigned long max_dsi_fck;
+
+	max_dsi_fck = dss_feat_get_param_max(FEAT_PARAM_DSI_FCK);
+
+	cinfo->regm_dsi = DIV_ROUND_UP(cinfo->clkin4ddr, max_dsi_fck);
+	cinfo->dsi_pll_hsdiv_dsi_clk = cinfo->clkin4ddr / cinfo->regm_dsi;
+}
+
+static int dsi_pll_calc_dispc_fck(struct platform_device *dsidev,
+		unsigned long req_pck, struct dsi_clock_info *cinfo,
+		struct dispc_clock_info *dispc_cinfo)
+{
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
+	unsigned regm_dispc, best_regm_dispc;
+	unsigned long dispc_clk, best_dispc_clk;
+	int min_fck_per_pck;
+	unsigned long max_dss_fck;
+	struct dispc_clock_info best_dispc;
+	bool match;
+
+	max_dss_fck = dss_feat_get_param_max(FEAT_PARAM_DSS_FCK);
+
+	min_fck_per_pck = CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK;
+
+	if (min_fck_per_pck &&
+			req_pck * min_fck_per_pck > max_dss_fck) {
+		DSSERR("Requested pixel clock not possible with the current "
+				"OMAP2_DSS_MIN_FCK_PER_PCK setting. Turning "
+				"the constraint off.\n");
+		min_fck_per_pck = 0;
+	}
+
+retry:
+	best_regm_dispc = 0;
+	best_dispc_clk = 0;
+	memset(&best_dispc, 0, sizeof(best_dispc));
+	match = false;
+
+	for (regm_dispc = 1; regm_dispc < dsi->regm_dispc_max; ++regm_dispc) {
+		struct dispc_clock_info cur_dispc;
+
+		dispc_clk = cinfo->clkin4ddr / regm_dispc;
+
+		/* this will narrow down the search a bit,
+		 * but still give pixclocks below what was
+		 * requested */
+		if (dispc_clk  < req_pck)
+			break;
+
+		if (dispc_clk > max_dss_fck)
+			continue;
+
+		if (min_fck_per_pck && dispc_clk < req_pck * min_fck_per_pck)
+			continue;
+
+		match = true;
+
+		dispc_find_clk_divs(req_pck, dispc_clk, &cur_dispc);
+
+		if (abs(cur_dispc.pck - req_pck) <
+				abs(best_dispc.pck - req_pck)) {
+			best_regm_dispc = regm_dispc;
+			best_dispc_clk = dispc_clk;
+			best_dispc = cur_dispc;
+
+			if (cur_dispc.pck == req_pck)
+				goto found;
+		}
+	}
+
+	if (!match) {
+		if (min_fck_per_pck) {
+			DSSERR("Could not find suitable clock settings.\n"
+					"Turning FCK/PCK constraint off and"
+					"trying again.\n");
+			min_fck_per_pck = 0;
+			goto retry;
+		}
+
+		DSSERR("Could not find suitable clock settings.\n");
+
+		return -EINVAL;
+	}
+found:
+	cinfo->regm_dispc = best_regm_dispc;
+	cinfo->dsi_pll_hsdiv_dispc_clk = best_dispc_clk;
+
+	*dispc_cinfo = best_dispc;
+
+	return 0;
+}
+
 int dsi_pll_set_clock_div(struct platform_device *dsidev,
 		struct dsi_clock_info *cinfo)
 {
@@ -4188,33 +4268,35 @@ int omapdss_dsi_set_clocks(struct omap_dss_device *dssdev,
 
 	mutex_lock(&dsi->lock);
 
-	r = dsi_pll_calc_ddrfreq(dsidev, ddr_clk, &cinfo);
+	/* Calculate PLL output clock */
+	r = dsi_pll_calc_ddrfreq(dsidev, ddr_clk * 4, &cinfo);
 	if (r)
 		goto err;
 
-	dssdev->clocks.dsi.regn = cinfo.regn;
-	dssdev->clocks.dsi.regm = cinfo.regm;
-	dssdev->clocks.dsi.regm_dispc = cinfo.regm_dispc;
-	dssdev->clocks.dsi.regm_dsi = cinfo.regm_dsi;
+	/* Calculate PLL's DSI clock */
+	dsi_pll_calc_dsi_fck(dsidev, &cinfo);
 
+	/* Calculate PLL's DISPC clock and pck & lck divs */
+	pck = cinfo.clkin4ddr / 16 * (dsi->num_lanes_used - 1) * 8 / bpp;
+	DSSDBG("finding dispc dividers for pck %lu\n", pck);
+	r = dsi_pll_calc_dispc_fck(dsidev, pck, &cinfo, &dispc_cinfo);
+	if (r)
+		goto err;
 
+	/* Calculate LP clock */
 	dsi_fclk = cinfo.dsi_pll_hsdiv_dsi_clk;
 	lp_clk_div = DIV_ROUND_UP(dsi_fclk, lp_clk * 2);
 
-	dssdev->clocks.dsi.lp_clk_div = lp_clk_div;
-
-	/* pck = TxByteClkHS * datalanes * 8 / bitsperpixel */
-
-	pck = cinfo.clkin4ddr / 16 * (dsi->num_lanes_used - 1) * 8 / bpp;
-
-	DSSDBG("finding dispc dividers for pck %lu\n", pck);
+	dssdev->clocks.dsi.regn = cinfo.regn;
+	dssdev->clocks.dsi.regm = cinfo.regm;
+	dssdev->clocks.dsi.regm_dispc = cinfo.regm_dispc;
+	dssdev->clocks.dsi.regm_dsi = cinfo.regm_dsi;
 
-	dispc_find_clk_divs(pck, cinfo.dsi_pll_hsdiv_dispc_clk, &dispc_cinfo);
+	dssdev->clocks.dsi.lp_clk_div = lp_clk_div;
 
 	dssdev->clocks.dispc.channel.lck_div = dispc_cinfo.lck_div;
 	dssdev->clocks.dispc.channel.pck_div = dispc_cinfo.pck_div;
 
-
 	dssdev->clocks.dispc.dispc_fclk_src = OMAP_DSS_CLK_SRC_FCK;
 
 	dssdev->clocks.dispc.channel.lcd_clk_src =
-- 
1.7.9.5

