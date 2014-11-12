From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 04/22] OMAPDSS: DSI: separate LP clock info from dsi_clock_info
Date: Wed, 12 Nov 2014 13:52:06 +0200
Message-ID: <1415793144-11723-5-git-send-email-tomi.valkeinen@ti.com>
References: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:36449 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752168AbaKLLwu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Nov 2014 06:52:50 -0500
In-Reply-To: <1415793144-11723-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

struct dsi_clock_info represents the clocks handled by the DSI, mostly
PLL related clocks. In an effort to create common PLL code, we need to
remove all the non-PLL items from dsi_clock_info.

This patch removes LP clock related fields from dsi_clock_info, and
creates a new struct dsi_lp_clock_info for holding clock info for the LP
clock.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dsi.c | 30 +++++++++++++++++++-----------
 drivers/video/fbdev/omap2/dss/dss.h |  2 --
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/video/fbdev/omap2/dss/dsi.c b/drivers/video/fbdev/omap2/dss/dsi.c
index 0083f6500949..1c5a15581669 100644
--- a/drivers/video/fbdev/omap2/dss/dsi.c
+++ b/drivers/video/fbdev/omap2/dss/dsi.c
@@ -287,6 +287,11 @@ struct dsi_clk_calc_ctx {
 	struct omap_dss_dsi_videomode_timings dsi_vm;
 };
 
+struct dsi_lp_clock_info {
+	unsigned long lp_clk;
+	u16 lp_clk_div;
+};
+
 struct dsi_data {
 	struct platform_device *pdev;
 	void __iomem *proto_base;
@@ -307,6 +312,9 @@ struct dsi_data {
 
 	struct dsi_clock_info current_cinfo;
 
+	struct dsi_lp_clock_info user_lp_cinfo;
+	struct dsi_lp_clock_info current_lp_cinfo;
+
 	bool vdds_dsi_enabled;
 	struct regulator *vdds_dsi_reg;
 
@@ -1293,10 +1301,10 @@ static unsigned long dsi_fclk_rate(struct platform_device *dsidev)
 	return r;
 }
 
-static int dsi_lp_clock_calc(struct dsi_clock_info *cinfo,
-		unsigned long lp_clk_min, unsigned long lp_clk_max)
+static int dsi_lp_clock_calc(unsigned long dsi_fclk,
+		unsigned long lp_clk_min, unsigned long lp_clk_max,
+		struct dsi_lp_clock_info *lp_cinfo)
 {
-	unsigned long dsi_fclk = cinfo->dsi_pll_hsdiv_dsi_clk;
 	unsigned lp_clk_div;
 	unsigned long lp_clk;
 
@@ -1306,8 +1314,8 @@ static int dsi_lp_clock_calc(struct dsi_clock_info *cinfo,
 	if (lp_clk < lp_clk_min || lp_clk > lp_clk_max)
 		return -EINVAL;
 
-	cinfo->lp_clk_div = lp_clk_div;
-	cinfo->lp_clk = lp_clk;
+	lp_cinfo->lp_clk_div = lp_clk_div;
+	lp_cinfo->lp_clk = lp_clk;
 
 	return 0;
 }
@@ -1319,7 +1327,7 @@ static int dsi_set_lp_clk_divisor(struct platform_device *dsidev)
 	unsigned lp_clk_div;
 	unsigned long lp_clk;
 
-	lp_clk_div = dsi->user_dsi_cinfo.lp_clk_div;
+	lp_clk_div = dsi->user_lp_cinfo.lp_clk_div;
 
 	if (lp_clk_div == 0 || lp_clk_div > dsi->lpdiv_max)
 		return -EINVAL;
@@ -1329,8 +1337,8 @@ static int dsi_set_lp_clk_divisor(struct platform_device *dsidev)
 	lp_clk = dsi_fclk / 2 / lp_clk_div;
 
 	DSSDBG("LP_CLK_DIV %u, LP_CLK %lu\n", lp_clk_div, lp_clk);
-	dsi->current_cinfo.lp_clk = lp_clk;
-	dsi->current_cinfo.lp_clk_div = lp_clk_div;
+	dsi->current_lp_cinfo.lp_clk = lp_clk;
+	dsi->current_lp_cinfo.lp_clk_div = lp_clk_div;
 
 	/* LP_CLK_DIVISOR */
 	REG_FLD_MOD(dsidev, DSI_CLK_CTRL, lp_clk_div, 12, 0);
@@ -1801,7 +1809,7 @@ static void dsi_dump_dsidev_clocks(struct platform_device *dsidev,
 
 	seq_printf(s,	"TxByteClkHS\t%lu\n", dsi_get_txbyteclkhs(dsidev));
 
-	seq_printf(s,	"LP_CLK\t\t%lu\n", cinfo->lp_clk);
+	seq_printf(s,	"LP_CLK\t\t%lu\n", dsi->current_lp_cinfo.lp_clk);
 
 	dsi_runtime_put(dsidev);
 }
@@ -5110,8 +5118,8 @@ static int dsi_set_config(struct omap_dss_device *dssdev,
 
 	dsi_pll_calc_dsi_fck(&ctx.dsi_cinfo);
 
-	r = dsi_lp_clock_calc(&ctx.dsi_cinfo, config->lp_clk_min,
-			config->lp_clk_max);
+	r = dsi_lp_clock_calc(ctx.dsi_cinfo.dsi_pll_hsdiv_dsi_clk,
+		config->lp_clk_min, config->lp_clk_max, &dsi->user_lp_cinfo);
 	if (r) {
 		DSSERR("failed to find suitable DSI LP clock settings\n");
 		goto err;
diff --git a/drivers/video/fbdev/omap2/dss/dss.h b/drivers/video/fbdev/omap2/dss/dss.h
index 2defcaedbef5..712592d2e5f7 100644
--- a/drivers/video/fbdev/omap2/dss/dss.h
+++ b/drivers/video/fbdev/omap2/dss/dss.h
@@ -119,7 +119,6 @@ struct dsi_clock_info {
 						 * OMAP4: PLLx_CLK1 */
 	unsigned long dsi_pll_hsdiv_dsi_clk;	/* OMAP3: DSI2_PLL_CLK
 						 * OMAP4: PLLx_CLK2 */
-	unsigned long lp_clk;
 
 	/* dividers */
 	u16 regn;
@@ -128,7 +127,6 @@ struct dsi_clock_info {
 			 * OMAP4: REGM4 */
 	u16 regm_dsi;	/* OMAP3: REGM4
 			 * OMAP4: REGM5 */
-	u16 lp_clk_div;
 };
 
 struct dss_lcd_mgr_config {
-- 
2.1.3

