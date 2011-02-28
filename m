From: Archit Taneja <archit@ti.com>
Subject: [PATCH 2/3] OMAP2PLUS: DSS2: Use dss features to get clock source names of current OMAP
Date: Mon, 28 Feb 2011 12:20:36 +0530
Message-ID: <1298875837-6305-3-git-send-email-archit@ti.com>
References: <1298875837-6305-1-git-send-email-archit@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45420 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751061Ab1B1GsJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 01:48:09 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1S6m8Br027217
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 28 Feb 2011 00:48:08 -0600
In-Reply-To: <1298875837-6305-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tomi.valkeinen@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Clock source names vary across OMAP2/3 and OMAP4, the clock source enum
names have been made generic in the driver, but for purposes of debugging
and dumping clock sources, it is better to preserve the actual TRM name of
the clock.

Introduce a dss feature function 'dss_feat_get_clk_source_name()' which
returns a string with the TRM clock name for the current OMAP in use. The OMAP
specific name is printed along the generic name within brackets.

Signed-off-by: Archit Taneja <archit@ti.com>
---
 drivers/video/omap2/dss/dispc.c        |    7 +++--
 drivers/video/omap2/dss/dsi.c          |   42 ++++++++++++++++++++++----------
 drivers/video/omap2/dss/dss.c          |   19 +++++++++++++-
 drivers/video/omap2/dss/dss.h          |    7 +++++
 drivers/video/omap2/dss/dss_features.c |   23 +++++++++++++++++
 drivers/video/omap2/dss/dss_features.h |    1 +
 6 files changed, 81 insertions(+), 18 deletions(-)

diff --git a/drivers/video/omap2/dss/dispc.c b/drivers/video/omap2/dss/dispc.c
index 7563f12..c6392c4 100644
--- a/drivers/video/omap2/dss/dispc.c
+++ b/drivers/video/omap2/dss/dispc.c
@@ -2387,14 +2387,15 @@ void dispc_dump_clocks(struct seq_file *s)
 {
 	int lcd, pcd;
 	u32 l;
+	enum dss_clk_source dispc_clk_src = dss_get_dispc_clk_source();
 
 	enable_clocks(1);
 
 	seq_printf(s, "- DISPC -\n");
 
-	seq_printf(s, "dispc fclk source = %s\n",
-			dss_get_dispc_clk_source() == DSS_CLK_SRC_FCK ?
-			"dss1_alwon_fclk" : "dsi1_pll_fclk");
+	seq_printf(s, "dispc fclk source = %s (%s)\n",
+			dss_get_generic_clk_source_name(dispc_clk_src),
+			dss_feat_get_clk_source_name(dispc_clk_src));
 
 	seq_printf(s, "fck\t\t%-16lu\n", dispc_fclk_rate());
 
diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
index 964dbd5..4009991 100644
--- a/drivers/video/omap2/dss/dsi.c
+++ b/drivers/video/omap2/dss/dsi.c
@@ -1022,10 +1022,14 @@ int dsi_pll_set_clock_div(struct dsi_clock_info *cinfo)
 
 	DSSDBG("Clock lane freq %ld Hz\n", cinfo->clkin4ddr / 4);
 
-	DSSDBG("regm3 = %d, dsi1_pll_fclk = %lu\n",
-			cinfo->regm3, cinfo->dsi1_pll_fclk);
-	DSSDBG("regm4 = %d, dsi2_pll_fclk = %lu\n",
-			cinfo->regm4, cinfo->dsi2_pll_fclk);
+	DSSDBG("regm3 = %d, %s (%s) = %lu\n", cinfo->regm3,
+		dss_get_generic_clk_source_name(DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC),
+		dss_feat_get_clk_source_name(DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC),
+		cinfo->dsi1_pll_fclk);
+	DSSDBG("regm4 = %d, %s (%s) = %lu\n", cinfo->regm4,
+		dss_get_generic_clk_source_name(DSS_CLK_SRC_DSI_PLL_HSDIV_DSI),
+		dss_feat_get_clk_source_name(DSS_CLK_SRC_DSI_PLL_HSDIV_DSI),
+		cinfo->dsi2_pll_fclk);
 
 	REG_FLD_MOD(DSI_PLL_CONTROL, 0, 0, 0); /* DSI_PLL_AUTOMODE = manual */
 
@@ -1169,6 +1173,10 @@ void dsi_dump_clocks(struct seq_file *s)
 {
 	int clksel;
 	struct dsi_clock_info *cinfo = &dsi.current_cinfo;
+	enum dss_clk_source dispc_clk_src, dsi_clk_src;
+
+	dispc_clk_src = dss_get_dispc_clk_source();
+	dsi_clk_src = dss_get_dsi_clk_source();
 
 	enable_clocks(1);
 
@@ -1185,23 +1193,27 @@ void dsi_dump_clocks(struct seq_file *s)
 	seq_printf(s,	"CLKIN4DDR\t%-16luregm %u\n",
 			cinfo->clkin4ddr, cinfo->regm);
 
-	seq_printf(s,	"dsi1_pll_fck\t%-16luregm3 %u\t(%s)\n",
+	seq_printf(s,	"%s (%s)\t%-16luregm3 %u\t(%s)\n",
+			dss_get_generic_clk_source_name(dispc_clk_src),
+			dss_feat_get_clk_source_name(dispc_clk_src),
 			cinfo->dsi1_pll_fclk,
 			cinfo->regm3,
-			dss_get_dispc_clk_source() == DSS_CLK_SRC_FCK ?
+			dispc_clk_src == DSS_CLK_SRC_FCK ?
 			"off" : "on");
 
-	seq_printf(s,	"dsi2_pll_fck\t%-16luregm4 %u\t(%s)\n",
+	seq_printf(s,	"%s (%s)\t%-16luregm4 %u\t(%s)\n",
+			dss_get_generic_clk_source_name(dsi_clk_src),
+			dss_feat_get_clk_source_name(dsi_clk_src),
 			cinfo->dsi2_pll_fclk,
 			cinfo->regm4,
-			dss_get_dsi_clk_source() == DSS_CLK_SRC_FCK ?
+			dsi_clk_src == DSS_CLK_SRC_FCK ?
 			"off" : "on");
 
 	seq_printf(s,	"- DSI -\n");
 
-	seq_printf(s,	"dsi fclk source = %s\n",
-			dss_get_dsi_clk_source() == DSS_CLK_SRC_FCK ?
-			"dss1_alwon_fclk" : "dsi2_pll_fclk");
+	seq_printf(s,	"dsi fclk source = %s (%s)\n",
+			dss_get_generic_clk_source_name(dsi_clk_src),
+			dss_feat_get_clk_source_name(dsi_clk_src));
 
 	seq_printf(s,	"DSI_FCLK\t%lu\n", dsi_fclk_rate());
 
@@ -3249,13 +3261,17 @@ int dsi_init_display(struct omap_dss_device *dssdev)
 void dsi_wait_dsi1_pll_active(void)
 {
 	if (wait_for_bit_change(DSI_PLL_STATUS, 7, 1) != 1)
-		DSSERR("DSI1 PLL clock not active\n");
+		DSSERR("%s (%s) not active\n",
+			dss_get_generic_clk_source_name(DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC),
+			dss_feat_get_clk_source_name(DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC));
 }
 
 void dsi_wait_dsi2_pll_active(void)
 {
 	if (wait_for_bit_change(DSI_PLL_STATUS, 8, 1) != 1)
-		DSSERR("DSI2 PLL clock not active\n");
+		DSSERR("%s (%s) not active\n",
+			dss_get_generic_clk_source_name(DSS_CLK_SRC_DSI_PLL_HSDIV_DSI),
+			dss_feat_get_clk_source_name(DSS_CLK_SRC_DSI_PLL_HSDIV_DSI));
 }
 
 static int dsi_init(struct platform_device *pdev)
diff --git a/drivers/video/omap2/dss/dss.c b/drivers/video/omap2/dss/dss.c
index 1225979..44707a3 100644
--- a/drivers/video/omap2/dss/dss.c
+++ b/drivers/video/omap2/dss/dss.c
@@ -81,6 +81,12 @@ static struct {
 	u32		ctx[DSS_SZ_REGS / sizeof(u32)];
 } dss;
 
+static const struct dss_clk_source_name dss_generic_clk_source_names[] = {
+	{ DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC, "DSI_PLL_HSDIV_DISPC" },
+	{ DSS_CLK_SRC_DSI_PLL_HSDIV_DSI, "DSI_PLL_HSDIV_DSI" },
+	{ DSS_CLK_SRC_FCK, "DSS_FCK" },
+};
+
 static void dss_clk_enable_all_no_ctx(void);
 static void dss_clk_disable_all_no_ctx(void);
 static void dss_clk_enable_no_ctx(enum dss_clock clks);
@@ -221,6 +227,11 @@ void dss_sdi_disable(void)
 	REG_FLD_MOD(DSS_PLL_CONTROL, 0, 18, 18); /* SDI_PLL_SYSRESET */
 }
 
+const char *dss_get_generic_clk_source_name(enum dss_clk_source clk_src)
+{
+	return dss_generic_clk_source_names[clk_src].clksrc_name;
+}
+
 void dss_dump_clocks(struct seq_file *s)
 {
 	unsigned long dpll4_ck_rate;
@@ -236,12 +247,16 @@ void dss_dump_clocks(struct seq_file *s)
 	seq_printf(s, "dpll4_ck %lu\n", dpll4_ck_rate);
 
 	if (cpu_is_omap3630())
-		seq_printf(s, "dss1_alwon_fclk = %lu / %lu  = %lu\n",
+		seq_printf(s, "%s (%s) = %lu / %lu  = %lu\n",
+			dss_get_generic_clk_source_name(DSS_CLK_SRC_FCK),
+			dss_feat_get_clk_source_name(DSS_CLK_SRC_FCK),
 			dpll4_ck_rate,
 			dpll4_ck_rate / dpll4_m4_ck_rate,
 			dss_clk_get_rate(DSS_CLK_FCK));
 	else
-		seq_printf(s, "dss1_alwon_fclk = %lu / %lu * 2 = %lu\n",
+		seq_printf(s, "%s (%s) = %lu / %lu * 2 = %lu\n",
+			dss_get_generic_clk_source_name(DSS_CLK_SRC_FCK),
+			dss_feat_get_clk_source_name(DSS_CLK_SRC_FCK),
 			dpll4_ck_rate,
 			dpll4_ck_rate / dpll4_m4_ck_rate,
 			dss_clk_get_rate(DSS_CLK_FCK));
diff --git a/drivers/video/omap2/dss/dss.h b/drivers/video/omap2/dss/dss.h
index a166ff3..42ca70f 100644
--- a/drivers/video/omap2/dss/dss.h
+++ b/drivers/video/omap2/dss/dss.h
@@ -123,6 +123,12 @@ enum dss_clk_source {
 	DSS_CLK_SRC_FCK,			/* DSS1_ALWON_FCLK */
 };
 
+/* Correlates clock source name and dss_clk_source member */
+struct dss_clk_source_name {
+	enum dss_clk_source clksrc;
+	const char *clksrc_name;
+};
+
 struct dss_clock_info {
 	/* rates that we get with dividers below */
 	unsigned long fck;
@@ -215,6 +221,7 @@ void dss_clk_enable(enum dss_clock clks);
 void dss_clk_disable(enum dss_clock clks);
 unsigned long dss_clk_get_rate(enum dss_clock clk);
 int dss_need_ctx_restore(void);
+const char *dss_get_generic_clk_source_name(enum dss_clk_source clk_src);
 void dss_dump_clocks(struct seq_file *s);
 
 void dss_dump_regs(struct seq_file *s);
diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 5ba591e..6c8d709 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -25,6 +25,7 @@
 #include <plat/display.h>
 #include <plat/cpu.h>
 
+#include "dss.h"
 #include "dss_features.h"
 
 /* Defines a generic omap register field */
@@ -44,6 +45,7 @@ struct omap_dss_features {
 	const unsigned long max_dss_fck;
 	const enum omap_display_type *supported_displays;
 	const enum omap_color_mode *supported_color_modes;
+	const struct dss_clk_source_name *clksrc_names;
 };
 
 /* This struct is assigned to one of the below during initialization */
@@ -149,6 +151,18 @@ static const enum omap_color_mode omap3_dss_supported_color_modes[] = {
 	OMAP_DSS_COLOR_RGBA32 | OMAP_DSS_COLOR_RGBX32,
 };
 
+static const struct dss_clk_source_name omap2_dss_clk_source_names[] = {
+	{ DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC, "N/A" },
+	{ DSS_CLK_SRC_DSI_PLL_HSDIV_DSI, "N/A" },
+	{ DSS_CLK_SRC_FCK, "DSS_FCLK1" },
+};
+
+static const struct dss_clk_source_name omap3_dss_clk_source_names[] = {
+	{ DSS_CLK_SRC_DSI_PLL_HSDIV_DISPC, "DSI1_PLL_FCLK" },
+	{ DSS_CLK_SRC_DSI_PLL_HSDIV_DSI, "DSI2_PLL_FCLK" },
+	{ DSS_CLK_SRC_FCK, "DSS1_ALWON_FCLK" },
+};
+
 /* OMAP2 DSS Features */
 static struct omap_dss_features omap2_dss_features = {
 	.reg_fields = omap2_dss_reg_fields,
@@ -164,6 +178,7 @@ static struct omap_dss_features omap2_dss_features = {
 	.max_dss_fck = 173000000,
 	.supported_displays = omap2_dss_supported_displays,
 	.supported_color_modes = omap2_dss_supported_color_modes,
+	.clksrc_names = omap2_dss_clk_source_names,
 };
 
 /* OMAP3 DSS Features */
@@ -182,6 +197,7 @@ static struct omap_dss_features omap3430_dss_features = {
 	.max_dss_fck = 173000000,
 	.supported_displays = omap3_dss_supported_displays,
 	.supported_color_modes = omap3_dss_supported_color_modes,
+	.clksrc_names = omap3_dss_clk_source_names,
 };
 
 static struct omap_dss_features omap3630_dss_features = {
@@ -200,6 +216,7 @@ static struct omap_dss_features omap3630_dss_features = {
 	.max_dss_fck = 173000000,
 	.supported_displays = omap3_dss_supported_displays,
 	.supported_color_modes = omap3_dss_supported_color_modes,
+	.clksrc_names = omap3_dss_clk_source_names,
 };
 
 /* OMAP4 DSS Features */
@@ -217,6 +234,7 @@ static struct omap_dss_features omap4_dss_features = {
 	.max_dss_fck = 186000000,
 	.supported_displays = omap4_dss_supported_displays,
 	.supported_color_modes = omap3_dss_supported_color_modes,
+	.clksrc_names = omap3_dss_clk_source_names,
 };
 
 /* Functions returning values related to a DSS feature */
@@ -253,6 +271,11 @@ bool dss_feat_color_mode_supported(enum omap_plane plane,
 			color_mode;
 }
 
+const char *dss_feat_get_clk_source_name(enum dss_clk_source id)
+{
+	return omap_current_dss_features->clksrc_names[id].clksrc_name;
+}
+
 /* DSS has_feature check */
 bool dss_has_feature(enum dss_feat_id id)
 {
diff --git a/drivers/video/omap2/dss/dss_features.h b/drivers/video/omap2/dss/dss_features.h
index b983c21..4f11e5e 100644
--- a/drivers/video/omap2/dss/dss_features.h
+++ b/drivers/video/omap2/dss/dss_features.h
@@ -59,6 +59,7 @@ enum omap_display_type dss_feat_get_supported_displays(enum omap_channel channel
 enum omap_color_mode dss_feat_get_supported_color_modes(enum omap_plane plane);
 bool dss_feat_color_mode_supported(enum omap_plane plane,
 		enum omap_color_mode color_mode);
+const char *dss_feat_get_clk_source_name(enum dss_clk_source id);
 
 bool dss_has_feature(enum dss_feat_id id);
 void dss_feat_get_reg_field(enum dss_feat_reg_field id, u8 *start, u8 *end);
-- 
1.7.1

