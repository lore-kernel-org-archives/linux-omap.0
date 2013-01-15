From: Afzal Mohammed <afzal@ti.com>
Subject: [PATCH] ARM: AM33XX: clock: SET_RATE_PARENT in lcd path
Date: Tue, 15 Jan 2013 19:04:57 +0530
Message-ID: <1358256897-26275-1-git-send-email-afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Sekhar Nori <nsekhar@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

LCDC clock node is a one that does not have set rate capability. It
just passes on the rate that is sent downstream by it's parent. While
lcdc clock parent and it's grand parent - dpll_disp_m2_ck and
dpll_disp_ck has the capability to configure rate.

And the default rates provided by LCDC clock's ancestors are not
sufficient to obtain pixel clock for current LCDC use cases, hence
currently display would not work on AM335x SoC's (with driver
modifications in platfrom independent way).

Hence inform clock framework to propogate set rate for LCDC clock as
well as it's parent - dpll_disp_m2_ck. With this change, set rate on
LCDC clock would get propogated till dpll_disp_ck via dpll_disp_m2_ck,
hence allowing the driver (same driver is used in DaVinci too) to set
rates using LCDC clock without worrying about platform dependent clock
details.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---

Based on v3.8-rc3

 arch/arm/mach-omap2/cclock33xx_data.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/cclock33xx_data.c b/arch/arm/mach-omap2/cclock33xx_data.c
index ea64ad6..b731216 100644
--- a/arch/arm/mach-omap2/cclock33xx_data.c
+++ b/arch/arm/mach-omap2/cclock33xx_data.c
@@ -284,9 +284,10 @@ DEFINE_STRUCT_CLK(dpll_disp_ck, dpll_core_ck_parents, dpll_ddr_ck_ops);
  * TODO: Add clksel here (sys_clkin, CORE_CLKOUTM6, PER_CLKOUTM2
  * and ALT_CLK1/2)
  */
-DEFINE_CLK_DIVIDER(dpll_disp_m2_ck, "dpll_disp_ck", &dpll_disp_ck, 0x0,
-		   AM33XX_CM_DIV_M2_DPLL_DISP, AM33XX_DPLL_CLKOUT_DIV_SHIFT,
-		   AM33XX_DPLL_CLKOUT_DIV_WIDTH, CLK_DIVIDER_ONE_BASED, NULL);
+DEFINE_CLK_DIVIDER(dpll_disp_m2_ck, "dpll_disp_ck", &dpll_disp_ck,
+		   CLK_SET_RATE_PARENT, AM33XX_CM_DIV_M2_DPLL_DISP,
+		   AM33XX_DPLL_CLKOUT_DIV_SHIFT, AM33XX_DPLL_CLKOUT_DIV_WIDTH,
+		   CLK_DIVIDER_ONE_BASED, NULL);
 
 /* DPLL_PER */
 static struct dpll_data dpll_per_dd = {
@@ -932,6 +933,8 @@ int __init am33xx_clk_init(void)
 		cpu_clkflg = CK_AM33XX;
 	}
 
+	lcd_gclk.flags |= CLK_SET_RATE_PARENT;
+
 	for (c = am33xx_clks; c < am33xx_clks + ARRAY_SIZE(am33xx_clks); c++) {
 		if (c->cpu & cpu_clkflg) {
 			clkdev_add(&c->lk);
-- 
1.7.9.5
