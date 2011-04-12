From: Archit Taneja <archit@ti.com>
Subject: [PATCH 1/4] OMAP2PLUS: DSS2: Change enum "dss_clk_source" to "omap_dss_clk_source"
Date: Tue, 12 Apr 2011 13:52:23 +0530
Message-ID: <1302596546-14888-2-git-send-email-archit@ti.com>
References: <1302596546-14888-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45254 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756747Ab1DLIRi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Apr 2011 04:17:38 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p3C8HbZ4028071
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 12 Apr 2011 03:17:37 -0500
In-Reply-To: <1302596546-14888-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Change enum dss_clk_source to omap_dss_clock_source and move it to
'plat/display.h'. Change the enum members to attach "OMAP_" in the beginning.
These changes are done in order to specify the clock sources for DSS in the
board file.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/plat-omap/include/plat/display.h |    9 +++++
 drivers/video/omap2/dss/dispc.c           |   12 +++---
 drivers/video/omap2/dss/dpi.c             |    4 +-
 drivers/video/omap2/dss/dsi.c             |   38 +++++++++++-----------
 drivers/video/omap2/dss/dss.c             |   50 ++++++++++++++--------------
 drivers/video/omap2/dss/dss.h             |   23 ++++---------
 drivers/video/omap2/dss/dss_features.c    |   20 ++++++------
 drivers/video/omap2/dss/dss_features.h    |    2 +-
 drivers/video/omap2/dss/hdmi.c            |    2 +-
 9 files changed, 80 insertions(+), 80 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/display.h b/arch/arm/plat-omap/include/plat/display.h
index f6e4b87..f28b446 100644
--- a/arch/arm/plat-omap/include/plat/display.h
+++ b/arch/arm/plat-omap/include/plat/display.h
@@ -174,6 +174,15 @@ enum omap_overlay_manager_caps {
 	OMAP_DSS_OVL_MGR_CAP_DISPC = 1 << 0,
 };
 
+enum omap_dss_clk_source {
+	OMAP_DSS_CLK_SRC_FCK = 0,		/* OMAP2/3: DSS1_ALWON_FCLK
+						 * OMAP4: DSS_FCLK */
+	OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC,	/* OMAP3: DSI1_PLL_FCLK
+						 * OMAP4: PLL1_CLK1 */
+	OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI,	/* OMAP3: DSI2_PLL_FCLK
+						 * OMAP4: PLL1_CLK2 */
+};
+
 /* RFBI */
 
 struct rfbi_timings {
diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 7804779..d728904 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2356,10 +2356,10 @@ unsigned long dispc_fclk_rate(void)
 	unsigned long r = 0;
 
 	switch (dss_get_dispc_clk_source()) {
-	case DSS_CLK_SRC_FCK:
+	case OMAP_DSS_CLK_SRC_FCK:
 		r = dss_clk_get_rate(DSS_CLK_FCK);
 		break;
-	case DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC:
+	case OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC:
 		r = dsi_get_pll_hsdiv_dispc_rate();
 		break;
 	default:
@@ -2380,10 +2380,10 @@ unsigned long dispc_lclk_rate(enum omap_channel channel)
 	lcd = FLD_GET(l, 23, 16);
 
 	switch (dss_get_lcd_clk_source(channel)) {
-	case DSS_CLK_SRC_FCK:
+	case OMAP_DSS_CLK_SRC_FCK:
 		r = dss_clk_get_rate(DSS_CLK_FCK);
 		break;
-	case DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC:
+	case OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC:
 		r = dsi_get_pll_hsdiv_dispc_rate();
 		break;
 	default:
@@ -2412,8 +2412,8 @@ void dispc_dump_clocks(struct seq_file *s)
 {
 	int lcd, pcd;
 	u32 l;
-	enum dss_clk_source dispc_clk_src = dss_get_dispc_clk_source();
-	enum dss_clk_source lcd_clk_src;
+	enum omap_dss_clk_source dispc_clk_src = dss_get_dispc_clk_source();
+	enum omap_dss_clk_source lcd_clk_src;
 
 	enable_clocks(1);
 
diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 2d3ca4c..9e8b061 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -57,7 +57,7 @@ static int dpi_set_dsi_clk(struct omap_dss_device *dssdev, bool is_tft,
 	if (r)
 		return r;
 
-	dss_select_dispc_clk_source(DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC);
+	dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC);
 
 	r = dispc_set_clock_div(dssdev->manager->id, &dispc_cinfo);
 	if (r)
@@ -217,7 +217,7 @@ void omapdss_dpi_display_disable(struct omap_dss_device *dssdev)
 	dssdev->manager->disable(dssdev->manager);
 
 #ifdef CONFIG_OMAP2_DSS_USE_DSI_PLL
-	dss_select_dispc_clk_source(DSS_CLK_SRC_FCK);
+	dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_FCK);
 	dsi_pll_uninit();
 	dss_clk_disable(DSS_CLK_SYSCK);
 #endif
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index d3b2ad1..546792b 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1009,7 +1009,7 @@ static unsigned long dsi_fclk_rate(void)
 {
 	unsigned long r;
 
-	if (dss_get_dsi_clk_source() == DSS_CLK_SRC_FCK) {
+	if (dss_get_dsi_clk_source() == OMAP_DSS_CLK_SRC_FCK) {
 		/* DSI FCLK source is DSS_CLK_FCK */
 		r = dss_clk_get_rate(DSS_CLK_FCK);
 	} else {
@@ -1309,12 +1309,12 @@ int dsi_pll_set_clock_div(struct dsi_clock_info *cinfo)
 	DSSDBG("Clock lane freq %ld Hz\n", cinfo->clkin4ddr / 4);
 
 	DSSDBG("regm_dispc = %d, %s (%s) = %lu\n", cinfo->regm_dispc,
-		dss_get_generic_clk_source_name(DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC),
-		dss_feat_get_clk_source_name(DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC),
+		dss_get_generic_clk_source_name(OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC),
+		dss_feat_get_clk_source_name(OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC),
 		cinfo->dsi_pll_hsdiv_dispc_clk);
 	DSSDBG("regm_dsi = %d, %s (%s) = %lu\n", cinfo->regm_dsi,
-		dss_get_generic_clk_source_name(DSS_CLK_SRC_DSI_PLL_HSDIV_DSI),
-		dss_feat_get_clk_source_name(DSS_CLK_SRC_DSI_PLL_HSDIV_DSI),
+		dss_get_generic_clk_source_name(OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI),
+		dss_feat_get_clk_source_name(OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI),
 		cinfo->dsi_pll_hsdiv_dsi_clk);
 
 	dss_feat_get_reg_field(FEAT_REG_DSIPLL_REGN, &regn_start, &regn_end);
@@ -1489,7 +1489,7 @@ void dsi_pll_uninit(void)
 void dsi_dump_clocks(struct seq_file *s)
 {
 	struct dsi_clock_info *cinfo = &dsi.current_cinfo;
-	enum dss_clk_source dispc_clk_src, dsi_clk_src;
+	enum omap_dss_clk_source dispc_clk_src, dsi_clk_src;
 
 	dispc_clk_src = dss_get_dispc_clk_source();
 	dsi_clk_src = dss_get_dsi_clk_source();
@@ -1511,7 +1511,7 @@ void dsi_dump_clocks(struct seq_file *s)
 			dss_feat_get_clk_source_name(dispc_clk_src),
 			cinfo->dsi_pll_hsdiv_dispc_clk,
 			cinfo->regm_dispc,
-			dispc_clk_src == DSS_CLK_SRC_FCK ?
+			dispc_clk_src == OMAP_DSS_CLK_SRC_FCK ?
 			"off" : "on");
 
 	seq_printf(s,	"%s (%s)\t%-16luregm_dsi %u\t(%s)\n",
@@ -1519,7 +1519,7 @@ void dsi_dump_clocks(struct seq_file *s)
 			dss_feat_get_clk_source_name(dsi_clk_src),
 			cinfo->dsi_pll_hsdiv_dsi_clk,
 			cinfo->regm_dsi,
-			dsi_clk_src == DSS_CLK_SRC_FCK ?
+			dsi_clk_src == OMAP_DSS_CLK_SRC_FCK ?
 			"off" : "on");
 
 	seq_printf(s,	"- DSI -\n");
@@ -3447,10 +3447,10 @@ static int dsi_display_init_dsi(struct omap_dss_device *dssdev)
 	if (r)
 		goto err1;
 
-	dss_select_dispc_clk_source(DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC);
-	dss_select_dsi_clk_source(DSS_CLK_SRC_DSI_PLL_HSDIV_DSI);
+	dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC);
+	dss_select_dsi_clk_source(OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI);
 	dss_select_lcd_clk_source(dssdev->manager->id,
-		DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC);
+		OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC);
 
 	DSSDBG("PLL OK\n");
 
@@ -3486,8 +3486,8 @@ static int dsi_display_init_dsi(struct omap_dss_device *dssdev)
 err3:
 	dsi_complexio_uninit();
 err2:
-	dss_select_dispc_clk_source(DSS_CLK_SRC_FCK);
-	dss_select_dsi_clk_source(DSS_CLK_SRC_FCK);
+	dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_FCK);
+	dss_select_dsi_clk_source(OMAP_DSS_CLK_SRC_FCK);
 err1:
 	dsi_pll_uninit();
 err0:
@@ -3503,8 +3503,8 @@ static void dsi_display_uninit_dsi(struct omap_dss_device *dssdev)
 	dsi_vc_enable(2, 0);
 	dsi_vc_enable(3, 0);
 
-	dss_select_dispc_clk_source(DSS_CLK_SRC_FCK);
-	dss_select_dsi_clk_source(DSS_CLK_SRC_FCK);
+	dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_FCK);
+	dss_select_dsi_clk_source(OMAP_DSS_CLK_SRC_FCK);
 	dsi_complexio_uninit();
 	dsi_pll_uninit();
 }
@@ -3695,16 +3695,16 @@ void dsi_wait_pll_hsdiv_dispc_active(void)
 {
 	if (wait_for_bit_change(DSI_PLL_STATUS, 7, 1) != 1)
 		DSSERR("%s (%s) not active\n",
-			dss_get_generic_clk_source_name(DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC),
-			dss_feat_get_clk_source_name(DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC));
+			dss_get_generic_clk_source_name(OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC),
+			dss_feat_get_clk_source_name(OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC));
 }
 
 void dsi_wait_pll_hsdiv_dsi_active(void)
 {
 	if (wait_for_bit_change(DSI_PLL_STATUS, 8, 1) != 1)
 		DSSERR("%s (%s) not active\n",
-			dss_get_generic_clk_source_name(DSS_CLK_SRC_DSI_PLL_HSDIV_DSI),
-			dss_feat_get_clk_source_name(DSS_CLK_SRC_DSI_PLL_HSDIV_DSI));
+			dss_get_generic_clk_source_name(OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI),
+			dss_feat_get_clk_source_name(OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI));
 }
 
 static void dsi_calc_clock_param_ranges(void)
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 70ec1c3..c8cd83e 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -75,17 +75,17 @@ static struct {
 	struct dss_clock_info cache_dss_cinfo;
 	struct dispc_clock_info cache_dispc_cinfo;
 
-	enum dss_clk_source dsi_clk_source;
-	enum dss_clk_source dispc_clk_source;
-	enum dss_clk_source lcd_clk_source[MAX_DSS_LCD_MANAGERS];
+	enum omap_dss_clk_source dsi_clk_source;
+	enum omap_dss_clk_source dispc_clk_source;
+	enum omap_dss_clk_source lcd_clk_source[MAX_DSS_LCD_MANAGERS];
 
 	u32		ctx[DSS_SZ_REGS / sizeof(u32)];
 } dss;
 
 static const char * const dss_generic_clk_source_names[] = {
-	[DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC]	= "DSI_PLL_HSDIV_DISPC",
-	[DSS_CLK_SRC_DSI_PLL_HSDIV_DSI]		= "DSI_PLL_HSDIV_DSI",
-	[DSS_CLK_SRC_FCK]			= "DSS_FCK",
+	[OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC]	= "DSI_PLL_HSDIV_DISPC",
+	[OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI]	= "DSI_PLL_HSDIV_DSI",
+	[OMAP_DSS_CLK_SRC_FCK]			= "DSS_FCK",
 };
 
 static void dss_clk_enable_all_no_ctx(void);
@@ -230,7 +230,7 @@ void dss_sdi_disable(void)
 	REG_FLD_MOD(DSS_PLL_CONTROL, 0, 18, 18); /* SDI_PLL_SYSRESET */
 }
 
-const char *dss_get_generic_clk_source_name(enum dss_clk_source clk_src)
+const char *dss_get_generic_clk_source_name(enum omap_dss_clk_source clk_src)
 {
 	return dss_generic_clk_source_names[clk_src];
 }
@@ -246,8 +246,8 @@ void dss_dump_clocks(struct seq_file *s)
 
 	seq_printf(s, "- DSS -\n");
 
-	fclk_name = dss_get_generic_clk_source_name(DSS_CLK_SRC_FCK);
-	fclk_real_name = dss_feat_get_clk_source_name(DSS_CLK_SRC_FCK);
+	fclk_name = dss_get_generic_clk_source_name(OMAP_DSS_CLK_SRC_FCK);
+	fclk_real_name = dss_feat_get_clk_source_name(OMAP_DSS_CLK_SRC_FCK);
 	fclk_rate = dss_clk_get_rate(DSS_CLK_FCK);
 
 	if (dss.dpll4_m4_ck) {
@@ -300,16 +300,16 @@ void dss_dump_regs(struct seq_file *s)
 #undef DUMPREG
 }
 
-void dss_select_dispc_clk_source(enum dss_clk_source clk_src)
+void dss_select_dispc_clk_source(enum omap_dss_clk_source clk_src)
 {
 	int b;
 	u8 start, end;
 
 	switch (clk_src) {
-	case DSS_CLK_SRC_FCK:
+	case OMAP_DSS_CLK_SRC_FCK:
 		b = 0;
 		break;
-	case DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC:
+	case OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC:
 		b = 1;
 		dsi_wait_pll_hsdiv_dispc_active();
 		break;
@@ -324,15 +324,15 @@ void dss_select_dispc_clk_source(enum dss_clk_source clk_src)
 	dss.dispc_clk_source = clk_src;
 }
 
-void dss_select_dsi_clk_source(enum dss_clk_source clk_src)
+void dss_select_dsi_clk_source(enum omap_dss_clk_source clk_src)
 {
 	int b;
 
 	switch (clk_src) {
-	case DSS_CLK_SRC_FCK:
+	case OMAP_DSS_CLK_SRC_FCK:
 		b = 0;
 		break;
-	case DSS_CLK_SRC_DSI_PLL_HSDIV_DSI:
+	case OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI:
 		b = 1;
 		dsi_wait_pll_hsdiv_dsi_active();
 		break;
@@ -346,7 +346,7 @@ void dss_select_dsi_clk_source(enum dss_clk_source clk_src)
 }
 
 void dss_select_lcd_clk_source(enum omap_channel channel,
-		enum dss_clk_source clk_src)
+		enum omap_dss_clk_source clk_src)
 {
 	int b, ix, pos;
 
@@ -354,10 +354,10 @@ void dss_select_lcd_clk_source(enum omap_channel channel,
 		return;
 
 	switch (clk_src) {
-	case DSS_CLK_SRC_FCK:
+	case OMAP_DSS_CLK_SRC_FCK:
 		b = 0;
 		break;
-	case DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC:
+	case OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC:
 		BUG_ON(channel != OMAP_DSS_CHANNEL_LCD);
 		b = 1;
 		dsi_wait_pll_hsdiv_dispc_active();
@@ -373,17 +373,17 @@ void dss_select_lcd_clk_source(enum omap_channel channel,
 	dss.lcd_clk_source[ix] = clk_src;
 }
 
-enum dss_clk_source dss_get_dispc_clk_source(void)
+enum omap_dss_clk_source dss_get_dispc_clk_source(void)
 {
 	return dss.dispc_clk_source;
 }
 
-enum dss_clk_source dss_get_dsi_clk_source(void)
+enum omap_dss_clk_source dss_get_dsi_clk_source(void)
 {
 	return dss.dsi_clk_source;
 }
 
-enum dss_clk_source dss_get_lcd_clk_source(enum omap_channel channel)
+enum omap_dss_clk_source dss_get_lcd_clk_source(enum omap_channel channel)
 {
 	if (dss_has_feature(FEAT_LCD_CLK_SRC)) {
 		int ix = channel == OMAP_DSS_CHANNEL_LCD ? 0 : 1;
@@ -711,10 +711,10 @@ static int dss_init(void)
 
 	dss.dpll4_m4_ck = dpll4_m4_ck;
 
-	dss.dsi_clk_source = DSS_CLK_SRC_FCK;
-	dss.dispc_clk_source = DSS_CLK_SRC_FCK;
-	dss.lcd_clk_source[0] = DSS_CLK_SRC_FCK;
-	dss.lcd_clk_source[1] = DSS_CLK_SRC_FCK;
+	dss.dsi_clk_source = OMAP_DSS_CLK_SRC_FCK;
+	dss.dispc_clk_source = OMAP_DSS_CLK_SRC_FCK;
+	dss.lcd_clk_source[0] = OMAP_DSS_CLK_SRC_FCK;
+	dss.lcd_clk_source[1] = OMAP_DSS_CLK_SRC_FCK;
 
 	dss_save_context();
 
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index c2f582b..d3b5697 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -117,15 +117,6 @@ enum dss_clock {
 	DSS_CLK_VIDFCK	= 1 << 4,	/* DSS_96M_FCLK*/
 };
 
-enum dss_clk_source {
-	DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC,	/* OMAP3: DSI1_PLL_FCLK
-						 * OMAP4: PLL1_CLK1 */
-	DSS_CLK_SRC_DSI_PLL_HSDIV_DSI,		/* OMAP3: DSI2_PLL_FCLK
-						 * OMAP4: PLL1_CLK2 */
-	DSS_CLK_SRC_FCK,			/* OMAP2/3: DSS1_ALWON_FCLK
-						 * OMAP4: DSS_FCLK */
-};
-
 enum dss_hdmi_venc_clk_source_select {
 	DSS_VENC_TV_CLK = 0,
 	DSS_HDMI_M_PCLK = 1,
@@ -236,7 +227,7 @@ void dss_clk_enable(enum dss_clock clks);
 void dss_clk_disable(enum dss_clock clks);
 unsigned long dss_clk_get_rate(enum dss_clock clk);
 int dss_need_ctx_restore(void);
-const char *dss_get_generic_clk_source_name(enum dss_clk_source clk_src);
+const char *dss_get_generic_clk_source_name(enum omap_dss_clk_source clk_src);
 void dss_dump_clocks(struct seq_file *s);
 
 void dss_dump_regs(struct seq_file *s);
@@ -248,13 +239,13 @@ void dss_sdi_init(u8 datapairs);
 int dss_sdi_enable(void);
 void dss_sdi_disable(void);
 
-void dss_select_dispc_clk_source(enum dss_clk_source clk_src);
-void dss_select_dsi_clk_source(enum dss_clk_source clk_src);
+void dss_select_dispc_clk_source(enum omap_dss_clk_source clk_src);
+void dss_select_dsi_clk_source(enum omap_dss_clk_source clk_src);
 void dss_select_lcd_clk_source(enum omap_channel channel,
-		enum dss_clk_source clk_src);
-enum dss_clk_source dss_get_dispc_clk_source(void);
-enum dss_clk_source dss_get_dsi_clk_source(void);
-enum dss_clk_source dss_get_lcd_clk_source(enum omap_channel channel);
+		enum omap_dss_clk_source clk_src);
+enum omap_dss_clk_source dss_get_dispc_clk_source(void);
+enum omap_dss_clk_source dss_get_dsi_clk_source(void);
+enum omap_dss_clk_source dss_get_lcd_clk_source(enum omap_channel channel);
 
 void dss_set_venc_output(enum omap_dss_venc_type type);
 void dss_set_dac_pwrdn_bgz(bool enable);
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 179a7a4..a8155d3 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -178,21 +178,21 @@ static const enum omap_color_mode omap3_dss_supported_color_modes[] = {
 };
 
 static const char * const omap2_dss_clk_source_names[] = {
-	[DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC]	= "N/A",
-	[DSS_CLK_SRC_DSI_PLL_HSDIV_DSI]		= "N/A",
-	[DSS_CLK_SRC_FCK]			= "DSS_FCLK1",
+	[OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC]	= "N/A",
+	[OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI]	= "N/A",
+	[OMAP_DSS_CLK_SRC_FCK]			= "DSS_FCLK1",
 };
 
 static const char * const omap3_dss_clk_source_names[] = {
-	[DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC]	= "DSI1_PLL_FCLK",
-	[DSS_CLK_SRC_DSI_PLL_HSDIV_DSI]		= "DSI2_PLL_FCLK",
-	[DSS_CLK_SRC_FCK]			= "DSS1_ALWON_FCLK",
+	[OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC]	= "DSI1_PLL_FCLK",
+	[OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI]	= "DSI2_PLL_FCLK",
+	[OMAP_DSS_CLK_SRC_FCK]			= "DSS1_ALWON_FCLK",
 };
 
 static const char * const omap4_dss_clk_source_names[] = {
-	[DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC]	= "PLL1_CLK1",
-	[DSS_CLK_SRC_DSI_PLL_HSDIV_DSI]		= "PLL1_CLK2",
-	[DSS_CLK_SRC_FCK]			= "DSS_FCLK",
+	[OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC]	= "PLL1_CLK1",
+	[OMAP_DSS_CLK_SRC_DSI_PLL_HSDIV_DSI]	= "PLL1_CLK2",
+	[OMAP_DSS_CLK_SRC_FCK]			= "DSS_FCLK",
 };
 
 static const struct dss_param_range omap2_dss_param_range[] = {
@@ -340,7 +340,7 @@ bool dss_feat_color_mode_supported(enum omap_plane plane,
 			color_mode;
 }
 
-const char *dss_feat_get_clk_source_name(enum dss_clk_source id)
+const char *dss_feat_get_clk_source_name(enum omap_dss_clk_source id)
 {
 	return omap_current_dss_features->clksrc_names[id];
 }
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index c5c0b40..0589591 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -81,7 +81,7 @@ enum omap_display_type dss_feat_get_supported_displays(enum omap_channel channel
 enum omap_color_mode dss_feat_get_supported_color_modes(enum omap_plane plane);
 bool dss_feat_color_mode_supported(enum omap_plane plane,
 		enum omap_color_mode color_mode);
-const char *dss_feat_get_clk_source_name(enum dss_clk_source id);
+const char *dss_feat_get_clk_source_name(enum omap_dss_clk_source id);
 
 bool dss_has_feature(enum dss_feat_id id);
 void dss_feat_get_reg_field(enum dss_feat_reg_field id, u8 *start, u8 *end);
diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 0d44f07..aad7354 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -1160,7 +1160,7 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
 	 * dynamically by user. This can be moved to single location , say
 	 * Boardfile.
 	 */
-	dss_select_dispc_clk_source(DSS_CLK_SRC_FCK);
+	dss_select_dispc_clk_source(OMAP_DSS_CLK_SRC_FCK);
 
 	/* bypass TV gamma table */
 	dispc_enable_gamma_table(0);
-- 
1.7.1

