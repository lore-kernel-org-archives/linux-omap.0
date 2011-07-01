From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 4/7] OMAP4: clocks: Update the clock tree with 4460 clock nodes
Date: Fri, 1 Jul 2011 07:37:58 +0530
Message-ID: <1309486081-8257-5-git-send-email-rnayak@ti.com>
References: <1309486081-8257-1-git-send-email-rnayak@ti.com>
 <1309486081-8257-2-git-send-email-rnayak@ti.com>
 <1309486081-8257-3-git-send-email-rnayak@ti.com>
 <1309486081-8257-4-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56762 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752149Ab1GACIX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Jun 2011 22:08:23 -0400
In-Reply-To: <1309486081-8257-4-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, khilman@ti.com, b-cousson@ti.com, Rajendra Nayak <rnayak@ti.com>, Nishanth Menon <nm@ti.com>

Add the new clock nodes (bandgap_ts_fclk, div_ts_ck) for omap4460.
Handle these nodes using the clock flags (CK_*).

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/clock44xx_data.c          |   39 +++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/clkdev_omap.h |    2 +-
 arch/arm/plat-omap/include/plat/clock.h       |    3 +-
 3 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index f1cfa3c..be016ee 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -1277,6 +1277,40 @@ static struct clk bandgap_fclk = {
 	.clkdm_name	= "l4_wkup_clkdm",
 };
 
+static const struct clksel_rate div3_8to32_rates[] = {
+	{ .div = 8, .val = 0, .flags = RATE_IN_44XX },
+	{ .div = 16, .val = 1, .flags = RATE_IN_44XX },
+	{ .div = 32, .val = 2, .flags = RATE_IN_44XX },
+	{ .div = 0 },
+};
+
+static const struct clksel div_ts_div[] = {
+	{ .parent = &l4_wkup_clk_mux_ck, .rates = div3_8to32_rates },
+	{ .parent = NULL },
+};
+
+static struct clk div_ts_ck = {
+	.name		= "div_ts_ck",
+	.parent		= &l4_wkup_clk_mux_ck,
+	.clksel		= div_ts_div,
+	.clksel_reg	= OMAP4430_CM_WKUP_BANDGAP_CLKCTRL,
+	.clksel_mask	= OMAP4430_CLKSEL_24_25_MASK,
+	.ops		= &clkops_null,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate,
+};
+
+static struct clk bandgap_ts_fclk = {
+	.name		= "bandgap_ts_fclk",
+	.ops		= &clkops_omap2_dflt,
+	.enable_reg	= OMAP4430_CM_WKUP_BANDGAP_CLKCTRL,
+	.enable_bit	= OMAP4460_OPTFCLKEN_TS_FCLK_SHIFT,
+	.clkdm_name	= "l4_wkup_clkdm",
+	.parent		= &div_ts_ck,
+	.recalc		= &followparent_recalc,
+};
+
 static struct clk dss_48mhz_clk = {
 	.name		= "dss_48mhz_clk",
 	.parent		= &func_48mc_fclk,
@@ -2487,6 +2521,7 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"pmd_trace_clk_mux_ck",		&pmd_trace_clk_mux_ck,	CK_44XX),
 	CLK(NULL,	"syc_clk_div_ck",		&syc_clk_div_ck,	CK_44XX),
 	CLK(NULL,	"bandgap_fclk",			&bandgap_fclk,	CK_44XX),
+	CLK(NULL,	"bandgap_ts_fclk",		&bandgap_ts_fclk,	CK_446X),
 	CLK("omapdss_dss",	"video_clk",		&dss_48mhz_clk,	CK_44XX),
 	CLK("omapdss_dss",	"fck",			&dss_dss_clk,	CK_44XX),
 	CLK("omapdss_dss",	"sys_clk",		&dss_sys_clk,	CK_44XX),
@@ -2530,6 +2565,7 @@ static struct omap_clk omap44xx_clks[] = {
 	CLK(NULL,	"cm2_dm3_mux_ck",		&cm2_dm3_mux_ck,	CK_44XX),
 	CLK(NULL,	"cm2_dm4_mux_ck",		&cm2_dm4_mux_ck,	CK_44XX),
 	CLK(NULL,	"cm2_dm9_mux_ck",		&cm2_dm9_mux_ck,	CK_44XX),
+	CLK(NULL,	"div_ts_ck",			&div_ts_ck,	CK_446X),
 	CLK(NULL,	"dmic_sync_mux_ck",		&dmic_sync_mux_ck,	CK_44XX),
 	CLK(NULL,	"gpt1_fck",			&timer1_fck,	CK_44XX),
 	CLK(NULL,	"fdif_fclk",			&fdif_fclk,	CK_44XX),
@@ -2619,6 +2655,9 @@ int __init omap4xxx_clk_init(void)
 	if (cpu_is_omap443x()) {
 		cpu_mask = RATE_IN_4430;
 		cpu_clkflg = CK_443X;
+	} else if (cpu_is_omap446x()) {
+		cpu_mask = RATE_IN_4460;
+		cpu_clkflg = CK_446X;
 	}
 
 	clk_init(&omap2_clk_functions);
diff --git a/arch/arm/plat-omap/include/plat/clkdev_omap.h b/arch/arm/plat-omap/include/plat/clkdev_omap.h
index 4609a3f..324446b 100644
--- a/arch/arm/plat-omap/include/plat/clkdev_omap.h
+++ b/arch/arm/plat-omap/include/plat/clkdev_omap.h
@@ -45,7 +45,7 @@ struct omap_clk {
 #define CK_34XX		(CK_3430ES1 | CK_3430ES2PLUS)
 #define CK_AM35XX	(CK_3505 | CK_3517)	/* all Sitara AM35xx */
 #define CK_3XXX		(CK_34XX | CK_AM35XX | CK_36XX)
-#define CK_44XX		(CK_443X)
+#define CK_44XX		(CK_443X | CK_446X)
 
 
 #endif
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 10349fe..df4b968 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -58,11 +58,12 @@ struct clkops {
 #define RATE_IN_36XX		(1 << 4)
 #define RATE_IN_4430		(1 << 5)
 #define RATE_IN_TI816X		(1 << 6)
+#define RATE_IN_4460		(1 << 7)
 
 #define RATE_IN_24XX		(RATE_IN_242X | RATE_IN_243X)
 #define RATE_IN_34XX		(RATE_IN_3430ES1 | RATE_IN_3430ES2PLUS)
 #define RATE_IN_3XXX		(RATE_IN_34XX | RATE_IN_36XX)
-#define RATE_IN_44XX		(RATE_IN_4430)
+#define RATE_IN_44XX		(RATE_IN_4430 | RATE_IN_4460)
 
 /* RATE_IN_3430ES2PLUS_36XX includes 34xx/35xx with ES >=2, and all 36xx/37xx */
 #define RATE_IN_3430ES2PLUS_36XX	(RATE_IN_3430ES2PLUS | RATE_IN_36XX)
-- 
1.7.4.1

