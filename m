From: <hvaibhav@ti.com>
Subject: [RFC PATCH 1/3] ARM: AM33XX: clock: Add debugSS clock nodes to clock tree
Date: Mon, 4 Mar 2013 17:05:55 +0530
Message-ID: <1362396957-30113-2-git-send-email-hvaibhav@ti.com>
References: <hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42328 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757156Ab3CDLgb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Mar 2013 06:36:31 -0500
In-Reply-To: <hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, khilman@linaro.org, paul@pwsan.com, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>

From: Vaibhav Hiremath <hvaibhav@ti.com>

Represent debugSS clock interface as provided in
CM_WKUP_DEBUGSS_CLKCTRL register, which includes,
	- Clock gate for optional DEBUG_CLKA and DBGSYSCLK
	- Clock Mux for TRC_PMD and STM_PMD
	- Clock divider for STM and TPIU

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Kevin Hilman <khilman@linaro.org>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/cclock33xx_data.c |   47 +++++++++++++++++++++++++++++---
 1 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/cclock33xx_data.c b/arch/arm/mach-omap2/cclock33xx_data.c
index 3d5a0e5..12db88c 100644
--- a/arch/arm/mach-omap2/cclock33xx_data.c
+++ b/arch/arm/mach-omap2/cclock33xx_data.c
@@ -422,15 +422,11 @@ DEFINE_STRUCT_CLK(smartreflex1_fck, dpll_core_ck_parents, clk_ops_null);
  *  - Driver code is not yet migrated to use hwmod/runtime pm
  *  - Modules outside kernel access (to disable them by default)
  *
- *     - debugss
  *     - mmu (gfx domain)
  *     - cefuse
  *     - usbotg_fck (its additional clock and not really a modulemode)
  *     - ieee5000
  */
-DEFINE_CLK_GATE(debugss_ick, "dpll_core_m4_ck", &dpll_core_m4_ck, 0x0,
-		AM33XX_CM_WKUP_DEBUGSS_CLKCTRL, AM33XX_MODULEMODE_SWCTRL_SHIFT,
-		0x0, NULL);

 DEFINE_CLK_GATE(mmu_fck, "dpll_core_m4_ck", &dpll_core_m4_ck, 0x0,
 		AM33XX_CM_GFX_MMUDATA_CLKCTRL, AM33XX_MODULEMODE_SWCTRL_SHIFT,
@@ -833,6 +829,42 @@ static struct clk_hw_omap wdt1_fck_hw = {
 DEFINE_STRUCT_CLK(wdt1_fck, wdt_ck_parents, gpio_fck_ops);

 /*
+ * debugss optional clocks
+ */
+DEFINE_CLK_GATE(dbg_sysclk_ck, "sys_clkin_ck", &sys_clkin_ck,
+		0x0, AM33XX_CM_WKUP_DEBUGSS_CLKCTRL,
+		AM33XX_OPTFCLKEN_DBGSYSCLK_SHIFT, 0x0, NULL);
+
+DEFINE_CLK_GATE(dbg_clka_ck, "dpll_core_m4_ck", &dpll_core_m4_ck,
+		0x0, AM33XX_CM_WKUP_DEBUGSS_CLKCTRL,
+		AM33XX_OPTCLK_DEBUG_CLKA_SHIFT, 0x0, NULL);
+
+static const char *stm_pmd_clock_mux_ck_parents[] = {
+	"dbg_sysclk_ck", "dbg_clka_ck",
+};
+
+DEFINE_CLK_MUX(stm_pmd_clock_mux_ck, stm_pmd_clock_mux_ck_parents, NULL, 0x0,
+	       AM33XX_CM_WKUP_DEBUGSS_CLKCTRL, AM33XX_STM_PMD_CLKSEL_SHIFT,
+	       AM33XX_STM_PMD_CLKSEL_WIDTH, 0x0, NULL);
+
+DEFINE_CLK_MUX(trace_pmd_clk_mux_ck, stm_pmd_clock_mux_ck_parents, NULL, 0x0,
+	       AM33XX_CM_WKUP_DEBUGSS_CLKCTRL,
+	       AM33XX_TRC_PMD_CLKSEL_SHIFT,
+	       AM33XX_TRC_PMD_CLKSEL_WIDTH, 0x0, NULL);
+
+DEFINE_CLK_DIVIDER(stm_clk_div_ck, "stm_pmd_clock_mux_ck",
+		   &stm_pmd_clock_mux_ck, 0x0, AM33XX_CM_WKUP_DEBUGSS_CLKCTRL,
+		   AM33XX_STM_PMD_CLKDIVSEL_SHIFT,
+		   AM33XX_STM_PMD_CLKDIVSEL_WIDTH, CLK_DIVIDER_POWER_OF_TWO,
+		   NULL);
+
+DEFINE_CLK_DIVIDER(trace_clk_div_ck, "trace_pmd_clk_mux_ck",
+		   &trace_pmd_clk_mux_ck, 0x0, AM33XX_CM_WKUP_DEBUGSS_CLKCTRL,
+		   AM33XX_TRC_PMD_CLKDIVSEL_SHIFT,
+		   AM33XX_TRC_PMD_CLKDIVSEL_WIDTH, CLK_DIVIDER_POWER_OF_TWO,
+		   NULL);
+
+/*
  * clkdev
  */
 static struct omap_clk am33xx_clks[] = {
@@ -869,7 +901,6 @@ static struct omap_clk am33xx_clks[] = {
 	CLK("481cc000.d_can",	NULL,		&dcan0_fck,	CK_AM33XX),
 	CLK(NULL,	"dcan1_fck",		&dcan1_fck,	CK_AM33XX),
 	CLK("481d0000.d_can",	NULL,		&dcan1_fck,	CK_AM33XX),
-	CLK(NULL,	"debugss_ick",		&debugss_ick,	CK_AM33XX),
 	CLK(NULL,	"pruss_ocp_gclk",	&pruss_ocp_gclk,	CK_AM33XX),
 	CLK(NULL,	"mcasp0_fck",		&mcasp0_fck,	CK_AM33XX),
 	CLK(NULL,	"mcasp1_fck",		&mcasp1_fck,	CK_AM33XX),
@@ -910,6 +941,12 @@ static struct omap_clk am33xx_clks[] = {
 	CLK(NULL,	"clkout2_div_ck",	&clkout2_div_ck,	CK_AM33XX),
 	CLK(NULL,	"timer_32k_ck",		&clkdiv32k_ick,	CK_AM33XX),
 	CLK(NULL,	"timer_sys_ck",		&sys_clkin_ck,	CK_AM33XX),
+	CLK(NULL,	"dbg_sysclk_ck",	&dbg_sysclk_ck,	CK_AM33XX),
+	CLK(NULL,	"dbg_clka_ck",		&dbg_clka_ck,	CK_AM33XX),
+	CLK(NULL,	"stm_pmd_clock_mux_ck",	&stm_pmd_clock_mux_ck,	CK_AM33XX),
+	CLK(NULL,	"trace_pmd_clk_mux_ck",	&trace_pmd_clk_mux_ck,	CK_AM33XX),
+	CLK(NULL,	"stm_clk_div_ck",	&stm_clk_div_ck,	CK_AM33XX),
+	CLK(NULL,	"trace_clk_div_ck",	&trace_clk_div_ck,	CK_AM33XX),
 };


--
1.7.0.4

