From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 05/22] OMAPDSS: DSI: remove clkin from dsi_clock_info
Date: Wed, 12 Nov 2014 13:52:07 +0200
Message-ID: <1415793144-11723-6-git-send-email-tomi.valkeinen@ti.com>
References: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41984 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201AbaKLLww (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Nov 2014 06:52:52 -0500
In-Reply-To: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

struct dsi_clock_info contains clkin field, which is the rate of the
PLL's input clock. This field is not needed, as it can be easily
retrieved by using the clk_get_rate().

This patch removes the clkin field.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dpi.c |  1 -
 drivers/video/fbdev/omap2/dss/dsi.c | 13 ++++---------
 drivers/video/fbdev/omap2/dss/dss.h |  1 -
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dpi.c b/drivers/video/fbdev/omap2/dss/dpi.c
index aa095c4927ec..91f18ab72007 100644
--- a/drivers/video/fbdev/omap2/dss/dpi.c
+++ b/drivers/video/fbdev/omap2/dss/dpi.c
@@ -223,7 +223,6 @@ static bool dpi_dsi_clk_calc(struct dpi_data *dpi, unsigned long pck,
 	ctx->dsidev = dpi->dsidev;
 	ctx->pck_min = pck - 1000;
 	ctx->pck_max = pck + 1000;
-	ctx->dsi_cinfo.clkin = clkin;
 
 	pll_min = 0;
 	pll_max = 0;
diff --git a/drivers/video/fbdev/omap2/dss/dsi.c b/drivers/video/fbdev/omap2/dss/dsi.c
index 1c5a15581669..deab4135ddc0 100644
--- a/drivers/video/fbdev/omap2/dss/dsi.c
+++ b/drivers/video/fbdev/omap2/dss/dsi.c
@@ -1486,8 +1486,7 @@ static int dsi_calc_clock_rates(struct platform_device *dsidev,
 	if (cinfo->regm_dsi > dsi->regm_dsi_max)
 		return -EINVAL;
 
-	cinfo->clkin = clk_get_rate(dsi->sys_clk);
-	cinfo->fint = cinfo->clkin / cinfo->regn;
+	cinfo->fint = clk_get_rate(dsi->sys_clk) / cinfo->regn;
 
 	if (cinfo->fint > dsi->fint_max || cinfo->fint < dsi->fint_min)
 		return -EINVAL;
@@ -1548,7 +1547,6 @@ int dsi_pll_set_clock_div(struct platform_device *dsidev,
 
 	DSSDBG("DSI PLL clock config starts");
 
-	dsi->current_cinfo.clkin = cinfo->clkin;
 	dsi->current_cinfo.fint = cinfo->fint;
 	dsi->current_cinfo.clkin4ddr = cinfo->clkin4ddr;
 	dsi->current_cinfo.dsi_pll_hsdiv_dispc_clk =
@@ -1563,13 +1561,13 @@ int dsi_pll_set_clock_div(struct platform_device *dsidev,
 
 	DSSDBG("DSI Fint %ld\n", cinfo->fint);
 
-	DSSDBG("clkin rate %ld\n", cinfo->clkin);
+	DSSDBG("clkin rate %ld\n", clk_get_rate(dsi->sys_clk));
 
 	/* DSIPHY == CLKIN4DDR */
 	DSSDBG("CLKIN4DDR = 2 * %d / %d * %lu = %lu\n",
 			cinfo->regm,
 			cinfo->regn,
-			cinfo->clkin,
+			clk_get_rate(dsi->sys_clk),
 			cinfo->clkin4ddr);
 
 	DSSDBG("Data rate on 1 DSI lane %ld Mbps\n",
@@ -1771,7 +1769,7 @@ static void dsi_dump_dsidev_clocks(struct platform_device *dsidev,
 
 	seq_printf(s,	"- DSI%d PLL -\n", dsi_module + 1);
 
-	seq_printf(s,	"dsi pll clkin\t%lu\n", cinfo->clkin);
+	seq_printf(s,	"dsi pll clkin\t%lu\n", clk_get_rate(dsi->sys_clk));
 
 	seq_printf(s,	"Fint\t\t%-16luregn %u\n", cinfo->fint, cinfo->regn);
 
@@ -4780,7 +4778,6 @@ static bool dsi_cm_calc(struct dsi_data *dsi,
 	ctx->req_pck_min = pck;
 	ctx->req_pck_nom = pck;
 	ctx->req_pck_max = pck * 3 / 2;
-	ctx->dsi_cinfo.clkin = clkin;
 
 	pll_min = max(cfg->hs_clk_min * 4, txbyteclk * 4 * 4);
 	pll_max = cfg->hs_clk_max * 4;
@@ -5066,8 +5063,6 @@ static bool dsi_vm_calc(struct dsi_data *dsi,
 	ctx->dsidev = dsi->pdev;
 	ctx->config = cfg;
 
-	ctx->dsi_cinfo.clkin = clkin;
-
 	/* these limits should come from the panel driver */
 	ctx->req_pck_min = t->pixelclock - 1000;
 	ctx->req_pck_nom = t->pixelclock;
diff --git a/drivers/video/fbdev/omap2/dss/dss.h b/drivers/video/fbdev/omap2/dss/dss.h
index 712592d2e5f7..45e255ecff29 100644
--- a/drivers/video/fbdev/omap2/dss/dss.h
+++ b/drivers/video/fbdev/omap2/dss/dss.h
@@ -114,7 +114,6 @@ struct dsi_clock_info {
 	/* rates that we get with dividers below */
 	unsigned long fint;
 	unsigned long clkin4ddr;
-	unsigned long clkin;
 	unsigned long dsi_pll_hsdiv_dispc_clk;	/* OMAP3: DSI1_PLL_CLK
 						 * OMAP4: PLLx_CLK1 */
 	unsigned long dsi_pll_hsdiv_dsi_clk;	/* OMAP3: DSI2_PLL_CLK
-- 
2.1.3

