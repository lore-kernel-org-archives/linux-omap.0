From: Sumit Semwal <sumit.semwal@ti.com>
Subject: [PATCH 2/3] OMAP2PLUS: DSS2: Generalize naming of PRCM related clock enums in DSS driver
Date: Wed,  5 Jan 2011 23:07:43 +0530
Message-ID: <1294249064-11491-3-git-send-email-sumit.semwal@ti.com>
References: <1294249064-11491-1-git-send-email-sumit.semwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40293 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752130Ab1AERiN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Jan 2011 12:38:13 -0500
In-Reply-To: <1294249064-11491-1-git-send-email-sumit.semwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@nokia.com, paul@pwsan.com, khilman@deeprootsystems.com, hvaibhav@ti.com, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>

From: Archit Taneja <archit@ti.com>

enum dss_clock structure is replaced with generic names that
could be used across OMAP2420, 2430, 3xxx, 44xx platforms.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/core.c    |    4 +-
 drivers/video/omap2/dss/dispc.c   |   10 +++---
 drivers/video/omap2/dss/dpi.c     |   16 +++++-----
 drivers/video/omap2/dss/dsi.c     |   18 +++++-----
 drivers/video/omap2/dss/dss.c     |   62 ++++++++++++++++++------------------
 drivers/video/omap2/dss/dss.h     |   10 +++---
 drivers/video/omap2/dss/manager.c |    4 +-
 drivers/video/omap2/dss/overlay.c |    4 +-
 drivers/video/omap2/dss/rfbi.c    |   10 +++---
 drivers/video/omap2/dss/sdi.c     |    8 ++--
 drivers/video/omap2/dss/venc.c    |    8 ++--
 11 files changed, 77 insertions(+), 77 deletions(-)

diff --git a/drivers/video/omap2/dss/core.c b/drivers/video/omap2/dss/core.c
index aadc580..21757ba 100644
--- a/drivers/video/omap2/dss/core.c
+++ b/drivers/video/omap2/dss/core.c
@@ -175,7 +175,7 @@ static int omap_dss_probe(struct platform_device *pdev)
 	dss_init_overlay_managers(pdev);
 	dss_init_overlays(pdev);
 
-	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_54M);
+	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK | DSS_CLK_TVFCK);
 
 	r = dpi_init(pdev);
 	if (r) {
@@ -213,7 +213,7 @@ static int omap_dss_probe(struct platform_device *pdev)
 			pdata->default_device = dssdev;
 	}
 
-	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_54M);
+	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK | DSS_CLK_TVFCK);
 
 	return 0;
 
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 8798e76..6e91ac1 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -506,9 +506,9 @@ void dispc_restore_context(void)
 static inline void enable_clocks(bool enable)
 {
 	if (enable)
-		dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1);
+		dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK);
 	else
-		dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
+		dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
 }
 
 bool dispc_go_busy(enum omap_channel channel)
@@ -2208,7 +2208,7 @@ unsigned long dispc_fclk_rate(void)
 	unsigned long r = 0;
 
 	if (dss_get_dispc_clk_source() == DSS_SRC_DSS1_ALWON_FCLK)
-		r = dss_clk_get_rate(DSS_CLK_FCK1);
+		r = dss_clk_get_rate(DSS_CLK_FCK);
 	else
 #ifdef CONFIG_OMAP2_DSS_DSI
 		r = dsi_get_dsi1_pll_rate();
@@ -2316,7 +2316,7 @@ void dispc_dump_regs(struct seq_file *s)
 {
 #define DUMPREG(r) seq_printf(s, "%-35s %08x\n", #r, dispc_read_reg(r))
 
-	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1);
+	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK);
 
 	DUMPREG(DISPC_REVISION);
 	DUMPREG(DISPC_SYSCONFIG);
@@ -2453,7 +2453,7 @@ void dispc_dump_regs(struct seq_file *s)
 	DUMPREG(DISPC_VID_PRELOAD(0));
 	DUMPREG(DISPC_VID_PRELOAD(1));
 
-	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
+	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
 #undef DUMPREG
 }
 
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 960e977..470af3d 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -105,7 +105,7 @@ static int dpi_set_mode(struct omap_dss_device *dssdev)
 	bool is_tft;
 	int r = 0;
 
-	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1);
+	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK);
 
 	dispc_set_pol_freq(dssdev->panel.config, dssdev->panel.acbi,
 			dssdev->panel.acb);
@@ -135,7 +135,7 @@ static int dpi_set_mode(struct omap_dss_device *dssdev)
 	dispc_set_lcd_timings(t);
 
 err0:
-	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
+	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
 	return r;
 }
 
@@ -169,14 +169,14 @@ int omapdss_dpi_display_enable(struct omap_dss_device *dssdev)
 			goto err1;
 	}
 
-	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1);
+	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK);
 
 	r = dpi_basic_init(dssdev);
 	if (r)
 		goto err2;
 
 #ifdef CONFIG_OMAP2_DSS_USE_DSI_PLL
-	dss_clk_enable(DSS_CLK_FCK2);
+	dss_clk_enable(DSS_CLK_SYSCK);
 	r = dsi_pll_init(dssdev, 0, 1);
 	if (r)
 		goto err3;
@@ -195,10 +195,10 @@ err4:
 #ifdef CONFIG_OMAP2_DSS_USE_DSI_PLL
 	dsi_pll_uninit();
 err3:
-	dss_clk_disable(DSS_CLK_FCK2);
+	dss_clk_disable(DSS_CLK_SYSCK);
 #endif
 err2:
-	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
+	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
 	if (cpu_is_omap34xx())
 		regulator_disable(dpi.vdds_dsi_reg);
 err1:
@@ -215,10 +215,10 @@ void omapdss_dpi_display_disable(struct omap_dss_device *dssdev)
 #ifdef CONFIG_OMAP2_DSS_USE_DSI_PLL
 	dss_select_dispc_clk_source(DSS_SRC_DSS1_ALWON_FCLK);
 	dsi_pll_uninit();
-	dss_clk_disable(DSS_CLK_FCK2);
+	dss_clk_disable(DSS_CLK_SYSCK);
 #endif
 
-	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
+	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
 
 	if (cpu_is_omap34xx())
 		regulator_disable(dpi.vdds_dsi_reg);
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index c3dabf6..6a66cc1 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -655,18 +655,18 @@ static void dsi_vc_disable_bta_irq(int channel)
 static inline void enable_clocks(bool enable)
 {
 	if (enable)
-		dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1);
+		dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK);
 	else
-		dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
+		dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
 }
 
 /* source clock for DSI PLL. this could also be PCLKFREE */
 static inline void dsi_enable_pll_clock(bool enable)
 {
 	if (enable)
-		dss_clk_enable(DSS_CLK_FCK2);
+		dss_clk_enable(DSS_CLK_SYSCK);
 	else
-		dss_clk_disable(DSS_CLK_FCK2);
+		dss_clk_disable(DSS_CLK_SYSCK);
 
 	if (enable && dsi.pll_locked) {
 		if (wait_for_bit_change(DSI_PLL_STATUS, 1, 1) != 1)
@@ -742,7 +742,7 @@ static unsigned long dsi_fclk_rate(void)
 
 	if (dss_get_dsi_clk_source() == DSS_SRC_DSS1_ALWON_FCLK) {
 		/* DSI FCLK source is DSS1_ALWON_FCK, which is dss1_fck */
-		r = dss_clk_get_rate(DSS_CLK_FCK1);
+		r = dss_clk_get_rate(DSS_CLK_FCK);
 	} else {
 		/* DSI FCLK source is DSI2_PLL_FCLK */
 		r = dsi_get_dsi2_pll_rate();
@@ -821,7 +821,7 @@ static int dsi_calc_clock_rates(struct dsi_clock_info *cinfo)
 		return -EINVAL;
 
 	if (cinfo->use_dss2_fck) {
-		cinfo->clkin = dss_clk_get_rate(DSS_CLK_FCK2);
+		cinfo->clkin = dss_clk_get_rate(DSS_CLK_SYSCK);
 		/* XXX it is unclear if highfreq should be used
 		 * with DSS2_FCK source also */
 		cinfo->highfreq = 0;
@@ -867,7 +867,7 @@ int dsi_pll_calc_clock_div_pck(bool is_tft, unsigned long req_pck,
 	int match = 0;
 	unsigned long dss_clk_fck2;
 
-	dss_clk_fck2 = dss_clk_get_rate(DSS_CLK_FCK2);
+	dss_clk_fck2 = dss_clk_get_rate(DSS_CLK_SYSCK);
 
 	if (req_pck == dsi.cache_req_pck &&
 			dsi.cache_cinfo.clkin == dss_clk_fck2) {
@@ -1319,7 +1319,7 @@ void dsi_dump_regs(struct seq_file *s)
 {
 #define DUMPREG(r) seq_printf(s, "%-35s %08x\n", #r, dsi_read_reg(r))
 
-	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1);
+	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK);
 
 	DUMPREG(DSI_REVISION);
 	DUMPREG(DSI_SYSCONFIG);
@@ -1391,7 +1391,7 @@ void dsi_dump_regs(struct seq_file *s)
 	DUMPREG(DSI_PLL_CONFIGURATION1);
 	DUMPREG(DSI_PLL_CONFIGURATION2);
 
-	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
+	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
 #undef DUMPREG
 }
 
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index c37be9a..72c13dc 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -228,7 +228,7 @@ void dss_dump_clocks(struct seq_file *s)
 	unsigned long dpll4_ck_rate;
 	unsigned long dpll4_m4_ck_rate;
 
-	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1);
+	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK);
 
 	dpll4_ck_rate = clk_get_rate(clk_get_parent(dss.dpll4_m4_ck));
 	dpll4_m4_ck_rate = clk_get_rate(dss.dpll4_m4_ck);
@@ -241,21 +241,21 @@ void dss_dump_clocks(struct seq_file *s)
 		seq_printf(s, "dss1_alwon_fclk = %lu / %lu  = %lu\n",
 			dpll4_ck_rate,
 			dpll4_ck_rate / dpll4_m4_ck_rate,
-			dss_clk_get_rate(DSS_CLK_FCK1));
+			dss_clk_get_rate(DSS_CLK_FCK));
 	else
 		seq_printf(s, "dss1_alwon_fclk = %lu / %lu * 2 = %lu\n",
 			dpll4_ck_rate,
 			dpll4_ck_rate / dpll4_m4_ck_rate,
-			dss_clk_get_rate(DSS_CLK_FCK1));
+			dss_clk_get_rate(DSS_CLK_FCK));
 
-	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
+	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
 }
 
 void dss_dump_regs(struct seq_file *s)
 {
 #define DUMPREG(r) seq_printf(s, "%-35s %08x\n", #r, dss_read_reg(r))
 
-	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1);
+	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK);
 
 	DUMPREG(DSS_REVISION);
 	DUMPREG(DSS_SYSCONFIG);
@@ -266,7 +266,7 @@ void dss_dump_regs(struct seq_file *s)
 	DUMPREG(DSS_PLL_CONTROL);
 	DUMPREG(DSS_SDI_STATUS);
 
-	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
+	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
 #undef DUMPREG
 }
 
@@ -351,7 +351,7 @@ int dss_set_clock_div(struct dss_clock_info *cinfo)
 
 int dss_get_clock_div(struct dss_clock_info *cinfo)
 {
-	cinfo->fck = dss_clk_get_rate(DSS_CLK_FCK1);
+	cinfo->fck = dss_clk_get_rate(DSS_CLK_FCK);
 
 	if (cpu_is_omap34xx()) {
 		unsigned long prate;
@@ -392,7 +392,7 @@ int dss_calc_clock_div(bool is_tft, unsigned long req_pck,
 
 	prate = dss_get_dpll4_rate();
 
-	fck = dss_clk_get_rate(DSS_CLK_FCK1);
+	fck = dss_clk_get_rate(DSS_CLK_FCK);
 	if (req_pck == dss.cache_req_pck &&
 			((cpu_is_omap34xx() && prate == dss.cache_prate) ||
 			 dss.cache_dss_cinfo.fck == fck)) {
@@ -419,7 +419,7 @@ retry:
 	if (cpu_is_omap24xx()) {
 		struct dispc_clock_info cur_dispc;
 		/* XXX can we change the clock on omap2? */
-		fck = dss_clk_get_rate(DSS_CLK_FCK1);
+		fck = dss_clk_get_rate(DSS_CLK_FCK);
 		fck_div = 1;
 
 		dispc_find_clk_divs(is_tft, req_pck, fck, &cur_dispc);
@@ -698,7 +698,7 @@ static void save_all_ctx(void)
 {
 	DSSDBG("save context\n");
 
-	dss_clk_enable_no_ctx(DSS_CLK_ICK | DSS_CLK_FCK1);
+	dss_clk_enable_no_ctx(DSS_CLK_ICK | DSS_CLK_FCK);
 
 	dss_save_context();
 	dispc_save_context();
@@ -706,7 +706,7 @@ static void save_all_ctx(void)
 	dsi_save_context();
 #endif
 
-	dss_clk_disable_no_ctx(DSS_CLK_ICK | DSS_CLK_FCK1);
+	dss_clk_disable_no_ctx(DSS_CLK_ICK | DSS_CLK_FCK);
 }
 
 static void restore_all_ctx(void)
@@ -804,13 +804,13 @@ unsigned long dss_clk_get_rate(enum dss_clock clk)
 	switch (clk) {
 	case DSS_CLK_ICK:
 		return clk_get_rate(dss.dss_ick);
-	case DSS_CLK_FCK1:
+	case DSS_CLK_FCK:
 		return clk_get_rate(dss.dss1_fck);
-	case DSS_CLK_FCK2:
+	case DSS_CLK_SYSCK:
 		return clk_get_rate(dss.dss2_fck);
-	case DSS_CLK_54M:
+	case DSS_CLK_TVFCK:
 		return clk_get_rate(dss.dss_54m_fck);
-	case DSS_CLK_96M:
+	case DSS_CLK_VIDFCK:
 		return clk_get_rate(dss.dss_96m_fck);
 	}
 
@@ -824,13 +824,13 @@ static unsigned count_clk_bits(enum dss_clock clks)
 
 	if (clks & DSS_CLK_ICK)
 		++num_clks;
-	if (clks & DSS_CLK_FCK1)
+	if (clks & DSS_CLK_FCK)
 		++num_clks;
-	if (clks & DSS_CLK_FCK2)
+	if (clks & DSS_CLK_SYSCK)
 		++num_clks;
-	if (clks & DSS_CLK_54M)
+	if (clks & DSS_CLK_TVFCK)
 		++num_clks;
-	if (clks & DSS_CLK_96M)
+	if (clks & DSS_CLK_VIDFCK)
 		++num_clks;
 
 	return num_clks;
@@ -842,13 +842,13 @@ static void dss_clk_enable_no_ctx(enum dss_clock clks)
 
 	if (clks & DSS_CLK_ICK)
 		clk_enable(dss.dss_ick);
-	if (clks & DSS_CLK_FCK1)
+	if (clks & DSS_CLK_FCK)
 		clk_enable(dss.dss1_fck);
-	if (clks & DSS_CLK_FCK2)
+	if (clks & DSS_CLK_SYSCK)
 		clk_enable(dss.dss2_fck);
-	if (clks & DSS_CLK_54M)
+	if (clks & DSS_CLK_TVFCK)
 		clk_enable(dss.dss_54m_fck);
-	if (clks & DSS_CLK_96M)
+	if (clks & DSS_CLK_VIDFCK)
 		clk_enable(dss.dss_96m_fck);
 
 	dss.num_clks_enabled += num_clks;
@@ -870,13 +870,13 @@ static void dss_clk_disable_no_ctx(enum dss_clock clks)
 
 	if (clks & DSS_CLK_ICK)
 		clk_disable(dss.dss_ick);
-	if (clks & DSS_CLK_FCK1)
+	if (clks & DSS_CLK_FCK)
 		clk_disable(dss.dss1_fck);
-	if (clks & DSS_CLK_FCK2)
+	if (clks & DSS_CLK_SYSCK)
 		clk_disable(dss.dss2_fck);
-	if (clks & DSS_CLK_54M)
+	if (clks & DSS_CLK_TVFCK)
 		clk_disable(dss.dss_54m_fck);
-	if (clks & DSS_CLK_96M)
+	if (clks & DSS_CLK_VIDFCK)
 		clk_disable(dss.dss_96m_fck);
 
 	dss.num_clks_enabled -= num_clks;
@@ -900,9 +900,9 @@ static void dss_clk_enable_all_no_ctx(void)
 {
 	enum dss_clock clks;
 
-	clks = DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_FCK2 | DSS_CLK_54M;
+	clks = DSS_CLK_ICK | DSS_CLK_FCK | DSS_CLK_SYSCK | DSS_CLK_TVFCK;
 	if (cpu_is_omap34xx())
-		clks |= DSS_CLK_96M;
+		clks |= DSS_CLK_VIDFCK;
 	dss_clk_enable_no_ctx(clks);
 }
 
@@ -910,9 +910,9 @@ static void dss_clk_disable_all_no_ctx(void)
 {
 	enum dss_clock clks;
 
-	clks = DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_FCK2 | DSS_CLK_54M;
+	clks = DSS_CLK_ICK | DSS_CLK_FCK | DSS_CLK_SYSCK | DSS_CLK_TVFCK;
 	if (cpu_is_omap34xx())
-		clks |= DSS_CLK_96M;
+		clks |= DSS_CLK_VIDFCK;
 	dss_clk_disable_no_ctx(clks);
 }
 
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index 5374702..a9a7f62 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -112,11 +112,11 @@ enum omap_parallel_interface_mode {
 };
 
 enum dss_clock {
-	DSS_CLK_ICK	= 1 << 0,
-	DSS_CLK_FCK1	= 1 << 1,
-	DSS_CLK_FCK2	= 1 << 2,
-	DSS_CLK_54M	= 1 << 3,
-	DSS_CLK_96M	= 1 << 4,
+	DSS_CLK_ICK	= 1 << 0,	/* DSS_L3_ICLK and DSS_L4_ICLK */
+	DSS_CLK_FCK	= 1 << 1,	/* DSS1_ALWON_FCLK */
+	DSS_CLK_SYSCK	= 1 << 2,	/* DSS2_ALWON_FCLK */
+	DSS_CLK_TVFCK	= 1 << 3,	/* DSS_TV_FCLK */
+	DSS_CLK_VIDFCK	= 1 << 4,	/* DSS_96M_FCLK*/
 };
 
 enum dss_clk_source {
diff --git a/drivers/video/omap2/dss/manager.c b/drivers/video/omap2/dss/manager.c
index 545e9b9..7a18a6a 100644
--- a/drivers/video/omap2/dss/manager.c
+++ b/drivers/video/omap2/dss/manager.c
@@ -1381,7 +1381,7 @@ static int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 	}
 
 	r = 0;
-	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1);
+	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK);
 	if (!dss_cache.irq_enabled) {
 		r = omap_dispc_register_isr(dss_apply_irq_handler, NULL,
 				DISPC_IRQ_VSYNC	| DISPC_IRQ_EVSYNC_ODD |
@@ -1389,7 +1389,7 @@ static int omap_dss_mgr_apply(struct omap_overlay_manager *mgr)
 		dss_cache.irq_enabled = true;
 	}
 	configure_dispc();
-	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
+	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
 
 	spin_unlock_irqrestore(&dss_cache.lock, flags);
 
diff --git a/drivers/video/omap2/dss/overlay.c b/drivers/video/omap2/dss/overlay.c
index 75642c2..ade9aa2 100644
--- a/drivers/video/omap2/dss/overlay.c
+++ b/drivers/video/omap2/dss/overlay.c
@@ -449,7 +449,7 @@ static int omap_dss_set_manager(struct omap_overlay *ovl,
 
 	ovl->manager = mgr;
 
-	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1);
+	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK);
 	/* XXX: on manual update display, in auto update mode, a bug happens
 	 * here. When an overlay is first enabled on LCD, then it's disabled,
 	 * and the manager is changed to TV, we sometimes get SYNC_LOST_DIGIT
@@ -458,7 +458,7 @@ static int omap_dss_set_manager(struct omap_overlay *ovl,
 	 * but I don't understand how or why. */
 	msleep(40);
 	dispc_set_channel_out(ovl->id, mgr->id);
-	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
+	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
 
 	return 0;
 }
diff --git a/drivers/video/omap2/dss/rfbi.c b/drivers/video/omap2/dss/rfbi.c
index 112bfaf..1a16a12 100644
--- a/drivers/video/omap2/dss/rfbi.c
+++ b/drivers/video/omap2/dss/rfbi.c
@@ -141,9 +141,9 @@ static inline u32 rfbi_read_reg(const struct rfbi_reg idx)
 static void rfbi_enable_clocks(bool enable)
 {
 	if (enable)
-		dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1);
+		dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK);
 	else
-		dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
+		dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
 }
 
 void omap_rfbi_write_command(const void *buf, u32 len)
@@ -496,7 +496,7 @@ unsigned long rfbi_get_max_tx_rate(void)
 	};
 
 	l4_rate = rfbi.l4_khz / 1000;
-	dss1_rate = dss_clk_get_rate(DSS_CLK_FCK1) / 1000000;
+	dss1_rate = dss_clk_get_rate(DSS_CLK_FCK) / 1000000;
 
 	for (i = 0; i < ARRAY_SIZE(ftab); i++) {
 		/* Use a window instead of an exact match, to account
@@ -921,7 +921,7 @@ void rfbi_dump_regs(struct seq_file *s)
 {
 #define DUMPREG(r) seq_printf(s, "%-35s %08x\n", #r, rfbi_read_reg(r))
 
-	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1);
+	dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK);
 
 	DUMPREG(RFBI_REVISION);
 	DUMPREG(RFBI_SYSCONFIG);
@@ -952,7 +952,7 @@ void rfbi_dump_regs(struct seq_file *s)
 	DUMPREG(RFBI_VSYNC_WIDTH);
 	DUMPREG(RFBI_HSYNC_WIDTH);
 
-	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
+	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
 #undef DUMPREG
 }
 
diff --git a/drivers/video/omap2/dss/sdi.c b/drivers/video/omap2/dss/sdi.c
index ee07a3c..a8eccb5 100644
--- a/drivers/video/omap2/dss/sdi.c
+++ b/drivers/video/omap2/dss/sdi.c
@@ -66,7 +66,7 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 
 	/* In case of skip_init sdi_init has already enabled the clocks */
 	if (!sdi.skip_init)
-		dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1);
+		dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK);
 
 	sdi_basic_init();
 
@@ -126,7 +126,7 @@ int omapdss_sdi_display_enable(struct omap_dss_device *dssdev)
 
 	return 0;
 err2:
-	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
+	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
 	regulator_disable(sdi.vdds_sdi_reg);
 err1:
 	omap_dss_stop_device(dssdev);
@@ -141,7 +141,7 @@ void omapdss_sdi_display_disable(struct omap_dss_device *dssdev)
 
 	dss_sdi_disable();
 
-	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1);
+	dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK);
 
 	regulator_disable(sdi.vdds_sdi_reg);
 
@@ -171,7 +171,7 @@ int sdi_init(bool skip_init)
 	 * of them until sdi_display_enable is called.
 	 */
 	if (skip_init)
-		dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1);
+		dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK);
 	return 0;
 }
 
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index c5c4c2c..3e1aec1 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -391,11 +391,11 @@ static void venc_reset(void)
 static void venc_enable_clocks(int enable)
 {
 	if (enable)
-		dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_54M |
-				DSS_CLK_96M);
+		dss_clk_enable(DSS_CLK_ICK | DSS_CLK_FCK | DSS_CLK_TVFCK |
+				DSS_CLK_VIDFCK);
 	else
-		dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK1 | DSS_CLK_54M |
-				DSS_CLK_96M);
+		dss_clk_disable(DSS_CLK_ICK | DSS_CLK_FCK | DSS_CLK_TVFCK |
+				DSS_CLK_VIDFCK);
 }
 
 static const struct venc_config *venc_timings_to_config(
-- 
1.7.0.4

