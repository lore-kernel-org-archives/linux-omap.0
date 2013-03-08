From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 13/14] OMAPDSS: remove unused old clock calculation code
Date: Fri, 8 Mar 2013 13:52:48 +0200
Message-ID: <1362743569-10289-14-git-send-email-tomi.valkeinen@ti.com>
References: <1362743569-10289-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33559 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933870Ab3CHLxa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Mar 2013 06:53:30 -0500
In-Reply-To: <1362743569-10289-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Now that the old clock calculation code is no longer used, we can remove
it from the driver.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dispc.c |   48 ------
 drivers/video/omap2/dss/dsi.c   |  317 ---------------------------------------
 drivers/video/omap2/dss/dss.c   |  115 --------------
 drivers/video/omap2/dss/dss.h   |   15 --
 4 files changed, 495 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index cd54e8f..8cfa27b 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -3311,54 +3311,6 @@ static void dispc_dump_regs(struct seq_file *s)
 #undef DUMPREG
 }
 
-/* with fck as input clock rate, find dispc dividers that produce req_pck */
-void dispc_find_clk_divs(unsigned long req_pck, unsigned long fck,
-		struct dispc_clock_info *cinfo)
-{
-	u16 pcd_min, pcd_max;
-	unsigned long best_pck;
-	u16 best_ld, cur_ld;
-	u16 best_pd, cur_pd;
-
-	pcd_min = dss_feat_get_param_min(FEAT_PARAM_DSS_PCD);
-	pcd_max = dss_feat_get_param_max(FEAT_PARAM_DSS_PCD);
-
-	best_pck = 0;
-	best_ld = 0;
-	best_pd = 0;
-
-	for (cur_ld = 1; cur_ld <= 255; ++cur_ld) {
-		unsigned long lck = fck / cur_ld;
-
-		for (cur_pd = pcd_min; cur_pd <= pcd_max; ++cur_pd) {
-			unsigned long pck = lck / cur_pd;
-			long old_delta = abs(best_pck - req_pck);
-			long new_delta = abs(pck - req_pck);
-
-			if (best_pck == 0 || new_delta < old_delta) {
-				best_pck = pck;
-				best_ld = cur_ld;
-				best_pd = cur_pd;
-
-				if (pck == req_pck)
-					goto found;
-			}
-
-			if (pck < req_pck)
-				break;
-		}
-
-		if (lck / pcd_min < req_pck)
-			break;
-	}
-
-found:
-	cinfo->lck_div = best_ld;
-	cinfo->pck_div = best_pd;
-	cinfo->lck = fck / cinfo->lck_div;
-	cinfo->pck = cinfo->lck / cinfo->pck_div;
-}
-
 /* calculate clock rates using dividers in cinfo */
 int dispc_calc_clock_rates(unsigned long dispc_fclk_rate,
 		struct dispc_clock_info *cinfo)
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 593022b..46e3d47 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1430,190 +1430,6 @@ static int dsi_calc_clock_rates(struct platform_device *dsidev,
 	return 0;
 }
 
-int dsi_pll_calc_clock_div_pck(struct platform_device *dsidev,
-		unsigned long req_pck, struct dsi_clock_info *dsi_cinfo,
-		struct dispc_clock_info *dispc_cinfo)
-{
-	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-	struct dsi_clock_info cur, best;
-	struct dispc_clock_info best_dispc;
-	int min_fck_per_pck;
-	int match = 0;
-	unsigned long dss_sys_clk, max_dss_fck;
-
-	dss_sys_clk = clk_get_rate(dsi->sys_clk);
-
-	max_dss_fck = dss_feat_get_param_max(FEAT_PARAM_DSS_FCK);
-
-	if (req_pck == dsi->cache_req_pck &&
-			dsi->cache_cinfo.clkin == dss_sys_clk) {
-		DSSDBG("DSI clock info found from cache\n");
-		*dsi_cinfo = dsi->cache_cinfo;
-		dispc_find_clk_divs(req_pck, dsi_cinfo->dsi_pll_hsdiv_dispc_clk,
-			dispc_cinfo);
-		return 0;
-	}
-
-	min_fck_per_pck = CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK;
-
-	if (min_fck_per_pck &&
-		req_pck * min_fck_per_pck > max_dss_fck) {
-		DSSERR("Requested pixel clock not possible with the current "
-				"OMAP2_DSS_MIN_FCK_PER_PCK setting. Turning "
-				"the constraint off.\n");
-		min_fck_per_pck = 0;
-	}
-
-	DSSDBG("dsi_pll_calc\n");
-
-retry:
-	memset(&best, 0, sizeof(best));
-	memset(&best_dispc, 0, sizeof(best_dispc));
-
-	memset(&cur, 0, sizeof(cur));
-	cur.clkin = dss_sys_clk;
-
-	/* 0.75MHz < Fint = clkin / regn < 2.1MHz */
-	/* To reduce PLL lock time, keep Fint high (around 2 MHz) */
-	for (cur.regn = 1; cur.regn < dsi->regn_max; ++cur.regn) {
-		cur.fint = cur.clkin / cur.regn;
-
-		if (cur.fint > dsi->fint_max || cur.fint < dsi->fint_min)
-			continue;
-
-		/* DSIPHY(MHz) = (2 * regm / regn) * clkin */
-		for (cur.regm = 1; cur.regm < dsi->regm_max; ++cur.regm) {
-			unsigned long a, b;
-
-			a = 2 * cur.regm * (cur.clkin/1000);
-			b = cur.regn;
-			cur.clkin4ddr = a / b * 1000;
-
-			if (cur.clkin4ddr > 1800 * 1000 * 1000)
-				break;
-
-			/* dsi_pll_hsdiv_dispc_clk(MHz) =
-			 * DSIPHY(MHz) / regm_dispc  < 173MHz/186Mhz */
-			for (cur.regm_dispc = 1; cur.regm_dispc <
-					dsi->regm_dispc_max; ++cur.regm_dispc) {
-				struct dispc_clock_info cur_dispc;
-				cur.dsi_pll_hsdiv_dispc_clk =
-					cur.clkin4ddr / cur.regm_dispc;
-
-				if (cur.regm_dispc > 1 &&
-						cur.regm_dispc % 2 != 0 &&
-						req_pck >= 1000000)
-					continue;
-
-				/* this will narrow down the search a bit,
-				 * but still give pixclocks below what was
-				 * requested */
-				if (cur.dsi_pll_hsdiv_dispc_clk  < req_pck)
-					break;
-
-				if (cur.dsi_pll_hsdiv_dispc_clk > max_dss_fck)
-					continue;
-
-				if (min_fck_per_pck &&
-					cur.dsi_pll_hsdiv_dispc_clk <
-						req_pck * min_fck_per_pck)
-					continue;
-
-				match = 1;
-
-				dispc_find_clk_divs(req_pck,
-						cur.dsi_pll_hsdiv_dispc_clk,
-						&cur_dispc);
-
-				if (abs(cur_dispc.pck - req_pck) <
-						abs(best_dispc.pck - req_pck)) {
-					best = cur;
-					best_dispc = cur_dispc;
-
-					if (cur_dispc.pck == req_pck)
-						goto found;
-				}
-			}
-		}
-	}
-found:
-	if (!match) {
-		if (min_fck_per_pck) {
-			DSSERR("Could not find suitable clock settings.\n"
-					"Turning FCK/PCK constraint off and"
-					"trying again.\n");
-			min_fck_per_pck = 0;
-			goto retry;
-		}
-
-		DSSERR("Could not find suitable clock settings.\n");
-
-		return -EINVAL;
-	}
-
-	/* dsi_pll_hsdiv_dsi_clk (regm_dsi) is not used */
-	best.regm_dsi = 0;
-	best.dsi_pll_hsdiv_dsi_clk = 0;
-
-	if (dsi_cinfo)
-		*dsi_cinfo = best;
-	if (dispc_cinfo)
-		*dispc_cinfo = best_dispc;
-
-	dsi->cache_req_pck = req_pck;
-	dsi->cache_clk_freq = 0;
-	dsi->cache_cinfo = best;
-
-	return 0;
-}
-
-static int dsi_pll_calc_ddrfreq(struct platform_device *dsidev,
-		unsigned long req_clkin4ddr, struct dsi_clock_info *cinfo)
-{
-	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-	struct dsi_clock_info cur, best;
-
-	DSSDBG("dsi_pll_calc_ddrfreq\n");
-
-	memset(&best, 0, sizeof(best));
-	memset(&cur, 0, sizeof(cur));
-
-	cur.clkin = clk_get_rate(dsi->sys_clk);
-
-	for (cur.regn = 1; cur.regn < dsi->regn_max; ++cur.regn) {
-		cur.fint = cur.clkin / cur.regn;
-
-		if (cur.fint > dsi->fint_max || cur.fint < dsi->fint_min)
-			continue;
-
-		/* DSIPHY(MHz) = (2 * regm / regn) * clkin */
-		for (cur.regm = 1; cur.regm < dsi->regm_max; ++cur.regm) {
-			unsigned long a, b;
-
-			a = 2 * cur.regm * (cur.clkin/1000);
-			b = cur.regn;
-			cur.clkin4ddr = a / b * 1000;
-
-			if (cur.clkin4ddr > 1800 * 1000 * 1000)
-				break;
-
-			if (abs(cur.clkin4ddr - req_clkin4ddr) <
-					abs(best.clkin4ddr - req_clkin4ddr)) {
-				best = cur;
-				DSSDBG("best %ld\n", best.clkin4ddr);
-			}
-
-			if (cur.clkin4ddr == req_clkin4ddr)
-				goto found;
-		}
-	}
-found:
-	if (cinfo)
-		*cinfo = best;
-
-	return 0;
-}
-
 static void dsi_pll_calc_dsi_fck(struct dsi_clock_info *cinfo)
 {
 	unsigned long max_dsi_fck;
@@ -1624,90 +1440,6 @@ static void dsi_pll_calc_dsi_fck(struct dsi_clock_info *cinfo)
 	cinfo->dsi_pll_hsdiv_dsi_clk = cinfo->clkin4ddr / cinfo->regm_dsi;
 }
 
-static int dsi_pll_calc_dispc_fck(struct platform_device *dsidev,
-		unsigned long req_pck, struct dsi_clock_info *cinfo,
-		struct dispc_clock_info *dispc_cinfo)
-{
-	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-	unsigned regm_dispc, best_regm_dispc;
-	unsigned long dispc_clk, best_dispc_clk;
-	int min_fck_per_pck;
-	unsigned long max_dss_fck;
-	struct dispc_clock_info best_dispc;
-	bool match;
-
-	max_dss_fck = dss_feat_get_param_max(FEAT_PARAM_DSS_FCK);
-
-	min_fck_per_pck = CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK;
-
-	if (min_fck_per_pck &&
-			req_pck * min_fck_per_pck > max_dss_fck) {
-		DSSERR("Requested pixel clock not possible with the current "
-				"OMAP2_DSS_MIN_FCK_PER_PCK setting. Turning "
-				"the constraint off.\n");
-		min_fck_per_pck = 0;
-	}
-
-retry:
-	best_regm_dispc = 0;
-	best_dispc_clk = 0;
-	memset(&best_dispc, 0, sizeof(best_dispc));
-	match = false;
-
-	for (regm_dispc = 1; regm_dispc < dsi->regm_dispc_max; ++regm_dispc) {
-		struct dispc_clock_info cur_dispc;
-
-		dispc_clk = cinfo->clkin4ddr / regm_dispc;
-
-		/* this will narrow down the search a bit,
-		 * but still give pixclocks below what was
-		 * requested */
-		if (dispc_clk  < req_pck)
-			break;
-
-		if (dispc_clk > max_dss_fck)
-			continue;
-
-		if (min_fck_per_pck && dispc_clk < req_pck * min_fck_per_pck)
-			continue;
-
-		match = true;
-
-		dispc_find_clk_divs(req_pck, dispc_clk, &cur_dispc);
-
-		if (abs(cur_dispc.pck - req_pck) <
-				abs(best_dispc.pck - req_pck)) {
-			best_regm_dispc = regm_dispc;
-			best_dispc_clk = dispc_clk;
-			best_dispc = cur_dispc;
-
-			if (cur_dispc.pck == req_pck)
-				goto found;
-		}
-	}
-
-	if (!match) {
-		if (min_fck_per_pck) {
-			DSSERR("Could not find suitable clock settings.\n"
-					"Turning FCK/PCK constraint off and"
-					"trying again.\n");
-			min_fck_per_pck = 0;
-			goto retry;
-		}
-
-		DSSERR("Could not find suitable clock settings.\n");
-
-		return -EINVAL;
-	}
-found:
-	cinfo->regm_dispc = best_regm_dispc;
-	cinfo->dsi_pll_hsdiv_dispc_clk = best_dispc_clk;
-
-	*dispc_cinfo = best_dispc;
-
-	return 0;
-}
-
 int dsi_pll_set_clock_div(struct platform_device *dsidev,
 		struct dsi_clock_info *cinfo)
 {
@@ -4384,55 +4116,6 @@ int omapdss_dsi_configure_pins(struct omap_dss_device *dssdev,
 }
 EXPORT_SYMBOL(omapdss_dsi_configure_pins);
 
-static int dsi_set_clocks(struct omap_dss_device *dssdev,
-		unsigned long ddr_clk, unsigned long lp_clk)
-{
-	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
-	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
-	struct dsi_clock_info cinfo;
-	struct dispc_clock_info dispc_cinfo;
-	unsigned lp_clk_div;
-	unsigned long dsi_fclk;
-	int bpp = dsi_get_pixel_size(dssdev->panel.dsi_pix_fmt);
-	unsigned long pck;
-	int r;
-
-	DSSDBG("Setting DSI clocks: ddr_clk %lu, lp_clk %lu", ddr_clk, lp_clk);
-
-	/* Calculate PLL output clock */
-	r = dsi_pll_calc_ddrfreq(dsidev, ddr_clk * 4, &cinfo);
-	if (r)
-		goto err;
-
-	/* Calculate PLL's DSI clock */
-	dsi_pll_calc_dsi_fck(&cinfo);
-
-	/* Calculate PLL's DISPC clock and pck & lck divs */
-	pck = cinfo.clkin4ddr / 16 * (dsi->num_lanes_used - 1) * 8 / bpp;
-	DSSDBG("finding dispc dividers for pck %lu\n", pck);
-	r = dsi_pll_calc_dispc_fck(dsidev, pck, &cinfo, &dispc_cinfo);
-	if (r)
-		goto err;
-
-	/* Calculate LP clock */
-	dsi_fclk = cinfo.dsi_pll_hsdiv_dsi_clk;
-	lp_clk_div = DIV_ROUND_UP(dsi_fclk, lp_clk * 2);
-
-	dsi->user_dsi_cinfo.regn = cinfo.regn;
-	dsi->user_dsi_cinfo.regm = cinfo.regm;
-	dsi->user_dsi_cinfo.regm_dispc = cinfo.regm_dispc;
-	dsi->user_dsi_cinfo.regm_dsi = cinfo.regm_dsi;
-
-	dsi->user_dsi_cinfo.lp_clk_div = lp_clk_div;
-
-	dsi->user_dispc_cinfo.lck_div = dispc_cinfo.lck_div;
-	dsi->user_dispc_cinfo.pck_div = dispc_cinfo.pck_div;
-
-	return 0;
-err:
-	return r;
-}
-
 int dsi_enable_video_output(struct omap_dss_device *dssdev, int channel)
 {
 	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 21a3dc8..ee288f0 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -578,121 +578,6 @@ static int dss_setup_default_clock(void)
 	return 0;
 }
 
-int dss_calc_clock_div(unsigned long req_pck, struct dss_clock_info *dss_cinfo,
-		struct dispc_clock_info *dispc_cinfo)
-{
-	unsigned long prate;
-	struct dss_clock_info best_dss;
-	struct dispc_clock_info best_dispc;
-
-	unsigned long fck, max_dss_fck;
-
-	u16 fck_div;
-
-	int match = 0;
-	int min_fck_per_pck;
-
-	prate = dss_get_dpll4_rate();
-
-	max_dss_fck = dss_feat_get_param_max(FEAT_PARAM_DSS_FCK);
-
-	fck = clk_get_rate(dss.dss_clk);
-	if (req_pck == dss.cache_req_pck && prate == dss.cache_prate &&
-		dss.cache_dss_cinfo.fck == fck) {
-		DSSDBG("dispc clock info found from cache.\n");
-		*dss_cinfo = dss.cache_dss_cinfo;
-		*dispc_cinfo = dss.cache_dispc_cinfo;
-		return 0;
-	}
-
-	min_fck_per_pck = CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK;
-
-	if (min_fck_per_pck &&
-		req_pck * min_fck_per_pck > max_dss_fck) {
-		DSSERR("Requested pixel clock not possible with the current "
-				"OMAP2_DSS_MIN_FCK_PER_PCK setting. Turning "
-				"the constraint off.\n");
-		min_fck_per_pck = 0;
-	}
-
-retry:
-	memset(&best_dss, 0, sizeof(best_dss));
-	memset(&best_dispc, 0, sizeof(best_dispc));
-
-	if (dss.dpll4_m4_ck == NULL) {
-		struct dispc_clock_info cur_dispc;
-		/* XXX can we change the clock on omap2? */
-		fck = clk_get_rate(dss.dss_clk);
-		fck_div = 1;
-
-		dispc_find_clk_divs(req_pck, fck, &cur_dispc);
-		match = 1;
-
-		best_dss.fck = fck;
-		best_dss.fck_div = fck_div;
-
-		best_dispc = cur_dispc;
-
-		goto found;
-	} else {
-		for (fck_div = dss.feat->fck_div_max; fck_div > 0; --fck_div) {
-			struct dispc_clock_info cur_dispc;
-
-			fck = prate / fck_div * dss.feat->dss_fck_multiplier;
-
-			if (fck > max_dss_fck)
-				continue;
-
-			if (min_fck_per_pck &&
-					fck < req_pck * min_fck_per_pck)
-				continue;
-
-			match = 1;
-
-			dispc_find_clk_divs(req_pck, fck, &cur_dispc);
-
-			if (abs(cur_dispc.pck - req_pck) <
-					abs(best_dispc.pck - req_pck)) {
-
-				best_dss.fck = fck;
-				best_dss.fck_div = fck_div;
-
-				best_dispc = cur_dispc;
-
-				if (cur_dispc.pck == req_pck)
-					goto found;
-			}
-		}
-	}
-
-found:
-	if (!match) {
-		if (min_fck_per_pck) {
-			DSSERR("Could not find suitable clock settings.\n"
-					"Turning FCK/PCK constraint off and"
-					"trying again.\n");
-			min_fck_per_pck = 0;
-			goto retry;
-		}
-
-		DSSERR("Could not find suitable clock settings.\n");
-
-		return -EINVAL;
-	}
-
-	if (dss_cinfo)
-		*dss_cinfo = best_dss;
-	if (dispc_cinfo)
-		*dispc_cinfo = best_dispc;
-
-	dss.cache_req_pck = req_pck;
-	dss.cache_prate = prate;
-	dss.cache_dss_cinfo = best_dss;
-	dss.cache_dispc_cinfo = best_dispc;
-
-	return 0;
-}
-
 void dss_set_venc_output(enum omap_dss_venc_type type)
 {
 	int l = 0;
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index dde6cc1..faaf358 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -268,8 +268,6 @@ void dss_set_dac_pwrdn_bgz(bool enable);
 unsigned long dss_get_dpll4_rate(void);
 int dss_calc_clock_rates(struct dss_clock_info *cinfo);
 int dss_set_clock_div(struct dss_clock_info *cinfo);
-int dss_calc_clock_div(unsigned long req_pck, struct dss_clock_info *dss_cinfo,
-		struct dispc_clock_info *dispc_cinfo);
 
 typedef bool (*dss_div_calc_func)(int fckd, unsigned long fck, void *data);
 bool dss_div_calc(unsigned long fck_min, dss_div_calc_func func, void *data);
@@ -310,9 +308,6 @@ bool dsi_pll_calc(struct platform_device *dsidev, unsigned long clkin,
 unsigned long dsi_get_pll_hsdiv_dispc_rate(struct platform_device *dsidev);
 int dsi_pll_set_clock_div(struct platform_device *dsidev,
 		struct dsi_clock_info *cinfo);
-int dsi_pll_calc_clock_div_pck(struct platform_device *dsidev,
-		unsigned long req_pck, struct dsi_clock_info *cinfo,
-		struct dispc_clock_info *dispc_cinfo);
 int dsi_pll_init(struct platform_device *dsidev, bool enable_hsclk,
 		bool enable_hsdiv);
 void dsi_pll_uninit(struct platform_device *dsidev, bool disconnect_lanes);
@@ -343,14 +338,6 @@ static inline int dsi_pll_set_clock_div(struct platform_device *dsidev,
 	WARN("%s: DSI not compiled in\n", __func__);
 	return -ENODEV;
 }
-static inline int dsi_pll_calc_clock_div_pck(struct platform_device *dsidev,
-		unsigned long req_pck,
-		struct dsi_clock_info *dsi_cinfo,
-		struct dispc_clock_info *dispc_cinfo)
-{
-	WARN("%s: DSI not compiled in\n", __func__);
-	return -ENODEV;
-}
 static inline int dsi_pll_init(struct platform_device *dsidev,
 		bool enable_hsclk, bool enable_hsdiv)
 {
@@ -400,8 +387,6 @@ bool dispc_div_calc(unsigned long dispc,
 bool dispc_mgr_timings_ok(enum omap_channel channel,
 		const struct omap_video_timings *timings);
 unsigned long dispc_fclk_rate(void);
-void dispc_find_clk_divs(unsigned long req_pck, unsigned long fck,
-		struct dispc_clock_info *cinfo);
 int dispc_calc_clock_rates(unsigned long dispc_fclk_rate,
 		struct dispc_clock_info *cinfo);
 
-- 
1.7.10.4

