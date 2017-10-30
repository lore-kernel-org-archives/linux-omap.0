From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 12/27] clk: ti: am33xx: cleanup unnecessary clock aliases
Date: Mon, 30 Oct 2017 15:04:30 +0200
Message-ID: <1509368685-29112-13-git-send-email-t-kristo@ti.com>
References: <1509368685-29112-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1509368685-29112-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

Most of the clock aliases are no longer needed, only leave the ones
required by OMAP timer code in place.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/clk-33xx.c | 88 ++---------------------------------------------
 1 file changed, 2 insertions(+), 86 deletions(-)

diff --git a/drivers/clk/ti/clk-33xx.c b/drivers/clk/ti/clk-33xx.c
index 0e47d95..53a6726 100644
--- a/drivers/clk/ti/clk-33xx.c
+++ b/drivers/clk/ti/clk-33xx.c
@@ -23,94 +23,8 @@
 #include "clock.h"
 
 static struct ti_dt_clk am33xx_clks[] = {
-	DT_CLK(NULL, "clk_32768_ck", "clk_32768_ck"),
-	DT_CLK(NULL, "clk_rc32k_ck", "clk_rc32k_ck"),
-	DT_CLK(NULL, "virt_19200000_ck", "virt_19200000_ck"),
-	DT_CLK(NULL, "virt_24000000_ck", "virt_24000000_ck"),
-	DT_CLK(NULL, "virt_25000000_ck", "virt_25000000_ck"),
-	DT_CLK(NULL, "virt_26000000_ck", "virt_26000000_ck"),
-	DT_CLK(NULL, "sys_clkin_ck", "sys_clkin_ck"),
-	DT_CLK(NULL, "tclkin_ck", "tclkin_ck"),
-	DT_CLK(NULL, "dpll_core_ck", "dpll_core_ck"),
-	DT_CLK(NULL, "dpll_core_x2_ck", "dpll_core_x2_ck"),
-	DT_CLK(NULL, "dpll_core_m4_ck", "dpll_core_m4_ck"),
-	DT_CLK(NULL, "dpll_core_m5_ck", "dpll_core_m5_ck"),
-	DT_CLK(NULL, "dpll_core_m6_ck", "dpll_core_m6_ck"),
-	DT_CLK(NULL, "dpll_mpu_ck", "dpll_mpu_ck"),
-	DT_CLK(NULL, "dpll_mpu_m2_ck", "dpll_mpu_m2_ck"),
-	DT_CLK(NULL, "dpll_ddr_ck", "dpll_ddr_ck"),
-	DT_CLK(NULL, "dpll_ddr_m2_ck", "dpll_ddr_m2_ck"),
-	DT_CLK(NULL, "dpll_ddr_m2_div2_ck", "dpll_ddr_m2_div2_ck"),
-	DT_CLK(NULL, "dpll_disp_ck", "dpll_disp_ck"),
-	DT_CLK(NULL, "dpll_disp_m2_ck", "dpll_disp_m2_ck"),
-	DT_CLK(NULL, "dpll_per_ck", "dpll_per_ck"),
-	DT_CLK(NULL, "dpll_per_m2_ck", "dpll_per_m2_ck"),
-	DT_CLK(NULL, "dpll_per_m2_div4_wkupdm_ck", "dpll_per_m2_div4_wkupdm_ck"),
-	DT_CLK(NULL, "dpll_per_m2_div4_ck", "dpll_per_m2_div4_ck"),
-	DT_CLK(NULL, "adc_tsc_fck", "adc_tsc_fck"),
-	DT_CLK(NULL, "cefuse_fck", "cefuse_fck"),
-	DT_CLK(NULL, "clkdiv32k_ck", "clkdiv32k_ck"),
-	DT_CLK(NULL, "clkdiv32k_ick", "clkdiv32k_ick"),
-	DT_CLK(NULL, "dcan0_fck", "dcan0_fck"),
-	DT_CLK("481cc000.d_can", NULL, "dcan0_fck"),
-	DT_CLK(NULL, "dcan1_fck", "dcan1_fck"),
-	DT_CLK("481d0000.d_can", NULL, "dcan1_fck"),
-	DT_CLK(NULL, "pruss_ocp_gclk", "pruss_ocp_gclk"),
-	DT_CLK(NULL, "mcasp0_fck", "mcasp0_fck"),
-	DT_CLK(NULL, "mcasp1_fck", "mcasp1_fck"),
-	DT_CLK(NULL, "mmu_fck", "mmu_fck"),
-	DT_CLK(NULL, "smartreflex0_fck", "smartreflex0_fck"),
-	DT_CLK(NULL, "smartreflex1_fck", "smartreflex1_fck"),
-	DT_CLK(NULL, "sha0_fck", "sha0_fck"),
-	DT_CLK(NULL, "aes0_fck", "aes0_fck"),
-	DT_CLK(NULL, "rng_fck", "rng_fck"),
-	DT_CLK(NULL, "timer1_fck", "timer1_fck"),
-	DT_CLK(NULL, "timer2_fck", "timer2_fck"),
-	DT_CLK(NULL, "timer3_fck", "timer3_fck"),
-	DT_CLK(NULL, "timer4_fck", "timer4_fck"),
-	DT_CLK(NULL, "timer5_fck", "timer5_fck"),
-	DT_CLK(NULL, "timer6_fck", "timer6_fck"),
-	DT_CLK(NULL, "timer7_fck", "timer7_fck"),
-	DT_CLK(NULL, "usbotg_fck", "usbotg_fck"),
-	DT_CLK(NULL, "ieee5000_fck", "ieee5000_fck"),
-	DT_CLK(NULL, "wdt1_fck", "wdt1_fck"),
-	DT_CLK(NULL, "l4_rtc_gclk", "l4_rtc_gclk"),
-	DT_CLK(NULL, "l3_gclk", "l3_gclk"),
-	DT_CLK(NULL, "dpll_core_m4_div2_ck", "dpll_core_m4_div2_ck"),
-	DT_CLK(NULL, "l4hs_gclk", "l4hs_gclk"),
-	DT_CLK(NULL, "l3s_gclk", "l3s_gclk"),
-	DT_CLK(NULL, "l4fw_gclk", "l4fw_gclk"),
-	DT_CLK(NULL, "l4ls_gclk", "l4ls_gclk"),
-	DT_CLK(NULL, "clk_24mhz", "clk_24mhz"),
-	DT_CLK(NULL, "sysclk_div_ck", "sysclk_div_ck"),
-	DT_CLK(NULL, "cpsw_125mhz_gclk", "cpsw_125mhz_gclk"),
-	DT_CLK(NULL, "cpsw_cpts_rft_clk", "cpsw_cpts_rft_clk"),
-	DT_CLK(NULL, "gpio0_dbclk_mux_ck", "gpio0_dbclk_mux_ck"),
-	DT_CLK(NULL, "gpio0_dbclk", "gpio0_dbclk"),
-	DT_CLK(NULL, "gpio1_dbclk", "gpio1_dbclk"),
-	DT_CLK(NULL, "gpio2_dbclk", "gpio2_dbclk"),
-	DT_CLK(NULL, "gpio3_dbclk", "gpio3_dbclk"),
-	DT_CLK(NULL, "lcd_gclk", "lcd_gclk"),
-	DT_CLK(NULL, "mmc_clk", "mmc_clk"),
-	DT_CLK(NULL, "gfx_fclk_clksel_ck", "gfx_fclk_clksel_ck"),
-	DT_CLK(NULL, "gfx_fck_div_ck", "gfx_fck_div_ck"),
-	DT_CLK(NULL, "sysclkout_pre_ck", "sysclkout_pre_ck"),
-	DT_CLK(NULL, "clkout2_div_ck", "clkout2_div_ck"),
 	DT_CLK(NULL, "timer_32k_ck", "clkdiv32k_ick"),
 	DT_CLK(NULL, "timer_sys_ck", "sys_clkin_ck"),
-	DT_CLK(NULL, "dbg_sysclk_ck", "dbg_sysclk_ck"),
-	DT_CLK(NULL, "dbg_clka_ck", "dbg_clka_ck"),
-	DT_CLK(NULL, "stm_pmd_clock_mux_ck", "stm_pmd_clock_mux_ck"),
-	DT_CLK(NULL, "trace_pmd_clk_mux_ck", "trace_pmd_clk_mux_ck"),
-	DT_CLK(NULL, "stm_clk_div_ck", "stm_clk_div_ck"),
-	DT_CLK(NULL, "trace_clk_div_ck", "trace_clk_div_ck"),
-	DT_CLK(NULL, "clkout2_ck", "clkout2_ck"),
-	DT_CLK("48300200.ehrpwm", "tbclk", "ehrpwm0_tbclk"),
-	DT_CLK("48302200.ehrpwm", "tbclk", "ehrpwm1_tbclk"),
-	DT_CLK("48304200.ehrpwm", "tbclk", "ehrpwm2_tbclk"),
-	DT_CLK("48300200.pwm", "tbclk", "ehrpwm0_tbclk"),
-	DT_CLK("48302200.pwm", "tbclk", "ehrpwm1_tbclk"),
-	DT_CLK("48304200.pwm", "tbclk", "ehrpwm2_tbclk"),
 	{ .node_name = NULL },
 };
 
@@ -133,6 +47,8 @@ int __init am33xx_dt_clk_init(void)
 
 	omap2_clk_disable_autoidle_all();
 
+	ti_clk_add_aliases();
+
 	omap2_clk_enable_init_clocks(enable_init_clks,
 				     ARRAY_SIZE(enable_init_clks));
 
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
