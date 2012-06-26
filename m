From: Archit Taneja <archit@ti.com>
Subject: [PATCH 01/17] OMAPDSS: Remove passive matrix LCD support (part 1)
Date: Tue, 26 Jun 2012 15:06:37 +0530
Message-ID: <1340703414-1915-2-git-send-email-archit@ti.com>
References: <1340703414-1915-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41512 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753547Ab2FZJiM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jun 2012 05:38:12 -0400
In-Reply-To: <1340703414-1915-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: rob@ti.com, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Remove clock constraints related to passive matrix displays.

There is a constraint (pcd_min should be 3) for passive matrix displays. Remove
this constraint in clock divider calculations as we won't support passive
matrix displays any more.

This cleans up the functions which calculate the clock dividers with DSI's PLL
or DSS_FCLK as the clock source.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c |    5 +----
 drivers/video/omap2/dss/dpi.c   |   28 +++++++++++-----------------
 drivers/video/omap2/dss/dsi.c   |    8 ++++----
 drivers/video/omap2/dss/dss.c   |    7 +++----
 drivers/video/omap2/dss/dss.h   |    9 ++++-----
 drivers/video/omap2/dss/sdi.c   |    3 +--
 6 files changed, 24 insertions(+), 36 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 0858024..3aa8c9c 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3127,7 +3127,7 @@ void dispc_mgr_set_pol_freq(enum omap_channel channel,
 }
 
 /* with fck as input clock rate, find dispc dividers that produce req_pck */
-void dispc_find_clk_divs(bool is_tft, unsigned long req_pck, unsigned long fck,
+void dispc_find_clk_divs(unsigned long req_pck, unsigned long fck,
 		struct dispc_clock_info *cinfo)
 {
 	u16 pcd_min, pcd_max;
@@ -3138,9 +3138,6 @@ void dispc_find_clk_divs(bool is_tft, unsigned long req_pck, unsigned long fck,
 	pcd_min = dss_feat_get_param_min(FEAT_PARAM_DSS_PCD);
 	pcd_max = dss_feat_get_param_max(FEAT_PARAM_DSS_PCD);
 
-	if (!is_tft)
-		pcd_min = 3;
-
 	best_pck = 0;
 	best_ld = 0;
 	best_pd = 0;
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 43bffc7..ca0e45a 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -78,7 +78,7 @@ static bool dpi_use_dsi_pll(struct omap_dss_device *dssdev)
 		lcd_src == OMAP_DSS_CLK_SRC_DSI2_PLL_HSDIV_DISPC;
 }
 
-static int dpi_set_dsi_clk(struct omap_dss_device *dssdev, bool is_tft,
+static int dpi_set_dsi_clk(struct omap_dss_device *dssdev,
 		unsigned long pck_req, unsigned long *fck, int *lck_div,
 		int *pck_div)
 {
@@ -87,8 +87,8 @@ static int dpi_set_dsi_clk(struct omap_dss_device *dssdev, bool is_tft,
 	struct dispc_clock_info dispc_cinfo;
 	int r;
 
-	r = dsi_pll_calc_clock_div_pck(dpi.dsidev, is_tft, pck_req,
-			&dsi_cinfo, &dispc_cinfo);
+	r = dsi_pll_calc_clock_div_pck(dpi.dsidev, pck_req, &dsi_cinfo,
+			&dispc_cinfo);
 	if (r)
 		return r;
 
@@ -113,7 +113,7 @@ static int dpi_set_dsi_clk(struct omap_dss_device *dssdev, bool is_tft,
 	return 0;
 }
 
-static int dpi_set_dispc_clk(struct omap_dss_device *dssdev, bool is_tft,
+static int dpi_set_dispc_clk(struct omap_dss_device *dssdev,
 		unsigned long pck_req, unsigned long *fck, int *lck_div,
 		int *pck_div)
 {
@@ -121,7 +121,7 @@ static int dpi_set_dispc_clk(struct omap_dss_device *dssdev, bool is_tft,
 	struct dispc_clock_info dispc_cinfo;
 	int r;
 
-	r = dss_calc_clock_div(is_tft, pck_req, &dss_cinfo, &dispc_cinfo);
+	r = dss_calc_clock_div(pck_req, &dss_cinfo, &dispc_cinfo);
 	if (r)
 		return r;
 
@@ -146,20 +146,17 @@ static int dpi_set_mode(struct omap_dss_device *dssdev)
 	int lck_div = 0, pck_div = 0;
 	unsigned long fck = 0;
 	unsigned long pck;
-	bool is_tft;
 	int r = 0;
 
 	dispc_mgr_set_pol_freq(dssdev->manager->id, dssdev->panel.config,
 			dssdev->panel.acbi, dssdev->panel.acb);
 
-	is_tft = (dssdev->panel.config & OMAP_DSS_LCD_TFT) != 0;
-
 	if (dpi_use_dsi_pll(dssdev))
-		r = dpi_set_dsi_clk(dssdev, is_tft, t->pixel_clock * 1000,
-				&fck, &lck_div, &pck_div);
+		r = dpi_set_dsi_clk(dssdev, t->pixel_clock * 1000, &fck,
+				&lck_div, &pck_div);
 	else
-		r = dpi_set_dispc_clk(dssdev, is_tft, t->pixel_clock * 1000,
-				&fck, &lck_div, &pck_div);
+		r = dpi_set_dispc_clk(dssdev, t->pixel_clock * 1000, &fck,
+				&lck_div, &pck_div);
 	if (r)
 		return r;
 
@@ -315,7 +312,6 @@ EXPORT_SYMBOL(dpi_set_timings);
 int dpi_check_timings(struct omap_dss_device *dssdev,
 			struct omap_video_timings *timings)
 {
-	bool is_tft;
 	int r;
 	int lck_div, pck_div;
 	unsigned long fck;
@@ -328,11 +324,9 @@ int dpi_check_timings(struct omap_dss_device *dssdev,
 	if (timings->pixel_clock == 0)
 		return -EINVAL;
 
-	is_tft = (dssdev->panel.config & OMAP_DSS_LCD_TFT) != 0;
-
 	if (dpi_use_dsi_pll(dssdev)) {
 		struct dsi_clock_info dsi_cinfo;
-		r = dsi_pll_calc_clock_div_pck(dpi.dsidev, is_tft,
+		r = dsi_pll_calc_clock_div_pck(dpi.dsidev,
 				timings->pixel_clock * 1000,
 				&dsi_cinfo, &dispc_cinfo);
 
@@ -342,7 +336,7 @@ int dpi_check_timings(struct omap_dss_device *dssdev,
 		fck = dsi_cinfo.dsi_pll_hsdiv_dispc_clk;
 	} else {
 		struct dss_clock_info dss_cinfo;
-		r = dss_calc_clock_div(is_tft, timings->pixel_clock * 1000,
+		r = dss_calc_clock_div(timings->pixel_clock * 1000,
 				&dss_cinfo, &dispc_cinfo);
 
 		if (r)
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index cad72db..0eb5452 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1313,7 +1313,7 @@ static int dsi_calc_clock_rates(struct platform_device *dsidev,
 	return 0;
 }
 
-int dsi_pll_calc_clock_div_pck(struct platform_device *dsidev, bool is_tft,
+int dsi_pll_calc_clock_div_pck(struct platform_device *dsidev,
 		unsigned long req_pck, struct dsi_clock_info *dsi_cinfo,
 		struct dispc_clock_info *dispc_cinfo)
 {
@@ -1332,8 +1332,8 @@ int dsi_pll_calc_clock_div_pck(struct platform_device *dsidev, bool is_tft,
 			dsi->cache_cinfo.clkin == dss_sys_clk) {
 		DSSDBG("DSI clock info found from cache\n");
 		*dsi_cinfo = dsi->cache_cinfo;
-		dispc_find_clk_divs(is_tft, req_pck,
-			dsi_cinfo->dsi_pll_hsdiv_dispc_clk, dispc_cinfo);
+		dispc_find_clk_divs(req_pck, dsi_cinfo->dsi_pll_hsdiv_dispc_clk,
+			dispc_cinfo);
 		return 0;
 	}
 
@@ -1399,7 +1399,7 @@ retry:
 
 				match = 1;
 
-				dispc_find_clk_divs(is_tft, req_pck,
+				dispc_find_clk_divs(req_pck,
 						cur.dsi_pll_hsdiv_dispc_clk,
 						&cur_dispc);
 
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 7706323..4ff0b8f 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -502,8 +502,7 @@ unsigned long dss_get_dpll4_rate(void)
 		return 0;
 }
 
-int dss_calc_clock_div(bool is_tft, unsigned long req_pck,
-		struct dss_clock_info *dss_cinfo,
+int dss_calc_clock_div(unsigned long req_pck, struct dss_clock_info *dss_cinfo,
 		struct dispc_clock_info *dispc_cinfo)
 {
 	unsigned long prate;
@@ -551,7 +550,7 @@ retry:
 		fck = clk_get_rate(dss.dss_clk);
 		fck_div = 1;
 
-		dispc_find_clk_divs(is_tft, req_pck, fck, &cur_dispc);
+		dispc_find_clk_divs(req_pck, fck, &cur_dispc);
 		match = 1;
 
 		best_dss.fck = fck;
@@ -581,7 +580,7 @@ retry:
 
 			match = 1;
 
-			dispc_find_clk_divs(is_tft, req_pck, fck, &cur_dispc);
+			dispc_find_clk_divs(req_pck, fck, &cur_dispc);
 
 			if (abs(cur_dispc.pck - req_pck) <
 					abs(best_dispc.pck - req_pck)) {
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index c6d8c68..d33df16 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -265,8 +265,7 @@ unsigned long dss_get_dpll4_rate(void);
 int dss_calc_clock_rates(struct dss_clock_info *cinfo);
 int dss_set_clock_div(struct dss_clock_info *cinfo);
 int dss_get_clock_div(struct dss_clock_info *cinfo);
-int dss_calc_clock_div(bool is_tft, unsigned long req_pck,
-		struct dss_clock_info *dss_cinfo,
+int dss_calc_clock_div(unsigned long req_pck, struct dss_clock_info *dss_cinfo,
 		struct dispc_clock_info *dispc_cinfo);
 
 /* SDI */
@@ -293,7 +292,7 @@ u8 dsi_get_pixel_size(enum omap_dss_dsi_pixel_format fmt);
 unsigned long dsi_get_pll_hsdiv_dispc_rate(struct platform_device *dsidev);
 int dsi_pll_set_clock_div(struct platform_device *dsidev,
 		struct dsi_clock_info *cinfo);
-int dsi_pll_calc_clock_div_pck(struct platform_device *dsidev, bool is_tft,
+int dsi_pll_calc_clock_div_pck(struct platform_device *dsidev,
 		unsigned long req_pck, struct dsi_clock_info *cinfo,
 		struct dispc_clock_info *dispc_cinfo);
 int dsi_pll_init(struct platform_device *dsidev, bool enable_hsclk,
@@ -327,7 +326,7 @@ static inline int dsi_pll_set_clock_div(struct platform_device *dsidev,
 	return -ENODEV;
 }
 static inline int dsi_pll_calc_clock_div_pck(struct platform_device *dsidev,
-		bool is_tft, unsigned long req_pck,
+		unsigned long req_pck,
 		struct dsi_clock_info *dsi_cinfo,
 		struct dispc_clock_info *dispc_cinfo)
 {
@@ -384,7 +383,7 @@ void dispc_set_loadmode(enum omap_dss_load_mode mode);
 bool dispc_mgr_timings_ok(enum omap_channel channel,
 		const struct omap_video_timings *timings);
 unsigned long dispc_fclk_rate(void);
-void dispc_find_clk_divs(bool is_tft, unsigned long req_pck, unsigned long fck,
+void dispc_find_clk_divs(unsigned long req_pck, unsigned long fck,
 		struct dispc_clock_info *cinfo);
 int dispc_calc_clock_rates(unsigned long dispc_fclk_rate,
 		struct dispc_clock_info *cinfo);
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index 3a43dc2..d07ecc4 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -84,8 +84,7 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 	dispc_mgr_set_pol_freq(dssdev->manager->id, dssdev->panel.config,
 			dssdev->panel.acbi, dssdev->panel.acb);
 
-	r = dss_calc_clock_div(1, t->pixel_clock * 1000,
-			&dss_cinfo, &dispc_cinfo);
+	r = dss_calc_clock_div(t->pixel_clock * 1000, &dss_cinfo, &dispc_cinfo);
 	if (r)
 		goto err_calc_clock_div;
 
-- 
1.7.9.5

