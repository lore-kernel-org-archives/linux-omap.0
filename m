From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 01/20] OMAPDSS: DSI: remove DSI & DISPC clk divisors from dssdev
Date: Fri, 8 Mar 2013 13:51:36 +0200
Message-ID: <1362743515-10152-2-git-send-email-tomi.valkeinen@ti.com>
References: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56447 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753110Ab3CHLwI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Mar 2013 06:52:08 -0500
In-Reply-To: <1362743515-10152-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

struct omap_dss_device contains DSS clock divisors. The idea is that the
board file can pass precalculated divisors to the display driver.
However, these divsors are no longer needed, as the omapdss driver can
calculate the divisors during runtime.

This patch removes the divisors from omap_dss_device, and their uses
from the dsi driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dsi.c |   47 +++++++++++++++++++++++------------------
 include/video/omapdss.h       |   21 ------------------
 2 files changed, 26 insertions(+), 42 deletions(-)

diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 28d41d1..9eb7845 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -261,6 +261,13 @@ struct dsi_data {
 	struct clk *dss_clk;
 	struct clk *sys_clk;
 
+	struct dispc_clock_info user_dispc_cinfo;
+	struct dsi_clock_info user_dsi_cinfo;
+
+	enum omap_dss_clk_source user_dispc_fclk_src;
+	enum omap_dss_clk_source user_lcd_clk_src;
+	enum omap_dss_clk_source user_dsi_fclk_src;
+
 	struct dsi_clock_info current_cinfo;
 
 	bool vdds_dsi_enabled;
@@ -1200,7 +1207,7 @@ static int dsi_set_lp_clk_divisor(struct omap_dss_device *dssdev)
 	unsigned lp_clk_div;
 	unsigned long lp_clk;
 
-	lp_clk_div = dssdev->clocks.dsi.lp_clk_div;
+	lp_clk_div = dsi->user_dsi_cinfo.lp_clk_div;
 
 	if (lp_clk_div == 0 || lp_clk_div > dsi->lpdiv_max)
 		return -EINVAL;
@@ -3910,7 +3917,7 @@ static void dsi_config_cmd_mode_interleaving(struct omap_dss_device *dssdev)
 	struct omap_video_timings *timings = &dsi->timings;
 	int bpp = dsi_get_pixel_size(dsi->pix_fmt);
 	int ndl = dsi->num_lanes_used - 1;
-	int dsi_fclk_hsdiv = dssdev->clocks.dsi.regm_dsi + 1;
+	int dsi_fclk_hsdiv = dsi->user_dsi_cinfo.regm_dsi + 1;
 	int hsa_interleave_hs = 0, hsa_interleave_lp = 0;
 	int hfp_interleave_hs = 0, hfp_interleave_lp = 0;
 	int hbp_interleave_hs = 0, hbp_interleave_lp = 0;
@@ -4302,24 +4309,24 @@ int omapdss_dsi_set_clocks(struct omap_dss_device *dssdev,
 	dsi_fclk = cinfo.dsi_pll_hsdiv_dsi_clk;
 	lp_clk_div = DIV_ROUND_UP(dsi_fclk, lp_clk * 2);
 
-	dssdev->clocks.dsi.regn = cinfo.regn;
-	dssdev->clocks.dsi.regm = cinfo.regm;
-	dssdev->clocks.dsi.regm_dispc = cinfo.regm_dispc;
-	dssdev->clocks.dsi.regm_dsi = cinfo.regm_dsi;
+	dsi->user_dsi_cinfo.regn = cinfo.regn;
+	dsi->user_dsi_cinfo.regm = cinfo.regm;
+	dsi->user_dsi_cinfo.regm_dispc = cinfo.regm_dispc;
+	dsi->user_dsi_cinfo.regm_dsi = cinfo.regm_dsi;
 
-	dssdev->clocks.dsi.lp_clk_div = lp_clk_div;
+	dsi->user_dsi_cinfo.lp_clk_div = lp_clk_div;
 
-	dssdev->clocks.dispc.channel.lck_div = dispc_cinfo.lck_div;
-	dssdev->clocks.dispc.channel.pck_div = dispc_cinfo.pck_div;
+	dsi->user_dispc_cinfo.lck_div = dispc_cinfo.lck_div;
+	dsi->user_dispc_cinfo.pck_div = dispc_cinfo.pck_div;
 
-	dssdev->clocks.dispc.dispc_fclk_src = OMAP_DSS_CLK_SRC_FCK;
+	dsi->user_dispc_fclk_src = OMAP_DSS_CLK_SRC_FCK;
 
-	dssdev->clocks.dispc.channel.lcd_clk_src =
+	dsi->user_lcd_clk_src =
 		dsi->module_id == 0 ?
 		OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC :
 		OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC;
 
-	dssdev->clocks.dsi.dsi_fclk_src =
+	dsi->user_dsi_fclk_src =
 		dsi->module_id == 0 ?
 		OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI :
 		OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DSI;
@@ -4589,8 +4596,8 @@ static int dsi_configure_dispc_clocks(struct omap_dss_device *dssdev)
 
 	fck = dsi_get_pll_hsdiv_dispc_rate(dsidev);
 
-	dispc_cinfo.lck_div = dssdev->clocks.dispc.channel.lck_div;
-	dispc_cinfo.pck_div = dssdev->clocks.dispc.channel.pck_div;
+	dispc_cinfo.lck_div = dsi->user_dispc_cinfo.lck_div;
+	dispc_cinfo.pck_div = dsi->user_dispc_cinfo.pck_div;
 
 	r = dispc_calc_clock_rates(fck, &dispc_cinfo);
 	if (r) {
@@ -4679,13 +4686,12 @@ static void dsi_display_uninit_dispc(struct omap_dss_device *dssdev)
 static int dsi_configure_dsi_clocks(struct omap_dss_device *dssdev)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
+	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
 	struct dsi_clock_info cinfo;
 	int r;
 
-	cinfo.regn  = dssdev->clocks.dsi.regn;
-	cinfo.regm  = dssdev->clocks.dsi.regm;
-	cinfo.regm_dispc = dssdev->clocks.dsi.regm_dispc;
-	cinfo.regm_dsi = dssdev->clocks.dsi.regm_dsi;
+	cinfo = dsi->user_dsi_cinfo;
+
 	r = dsi_calc_clock_rates(dsidev, &cinfo);
 	if (r) {
 		DSSERR("Failed to calc dsi clocks\n");
@@ -4716,9 +4722,8 @@ static int dsi_display_init_dsi(struct omap_dss_device *dssdev)
 	if (r)
 		goto err1;
 
-	dss_select_dsi_clk_source(dsi->module_id, dssdev->clocks.dsi.dsi_fclk_src);
-	dss_select_lcd_clk_source(mgr->id,
-			dssdev->clocks.dispc.channel.lcd_clk_src);
+	dss_select_dsi_clk_source(dsi->module_id, dsi->user_dsi_fclk_src);
+	dss_select_lcd_clk_source(mgr->id, dsi->user_lcd_clk_src);
 
 	DSSDBG("PLL OK\n");
 
diff --git a/include/video/omapdss.h b/include/video/omapdss.h
index caefa09..255bcf5 100644
--- a/include/video/omapdss.h
+++ b/include/video/omapdss.h
@@ -592,27 +592,6 @@ struct omap_dss_device {
 
 	struct {
 		struct {
-			struct {
-				u16 lck_div;
-				u16 pck_div;
-				enum omap_dss_clk_source lcd_clk_src;
-			} channel;
-
-			enum omap_dss_clk_source dispc_fclk_src;
-		} dispc;
-
-		struct {
-			/* regn is one greater than TRM's REGN value */
-			u16 regn;
-			u16 regm;
-			u16 regm_dispc;
-			u16 regm_dsi;
-
-			u16 lp_clk_div;
-			enum omap_dss_clk_source dsi_fclk_src;
-		} dsi;
-
-		struct {
 			/* regn is one greater than TRM's REGN value */
 			u16 regn;
 			u16 regm2;
-- 
1.7.10.4

