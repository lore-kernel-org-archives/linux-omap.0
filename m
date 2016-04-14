From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv2 11/28] clk: ti: am33xx: transition to usage of ti_clk_get
Date: Thu, 14 Apr 2016 14:08:00 +0300
Message-ID: <1460632097-25727-12-git-send-email-t-kristo@ti.com>
References: <1460632097-25727-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1460632097-25727-1-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Cleanup any unnecessary DT_CLK() alias entries from the AM33xx clock file.
Also, use ti_clk_get where necessary.

Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
---
 drivers/clk/ti/clk-33xx.c |   92 ++++-----------------------------------------
 1 file changed, 7 insertions(+), 85 deletions(-)

diff --git a/drivers/clk/ti/clk-33xx.c b/drivers/clk/ti/clk-33xx.c
index ef2ec64..43847bc 100644
--- a/drivers/clk/ti/clk-33xx.c
+++ b/drivers/clk/ti/clk-33xx.c
@@ -23,88 +23,10 @@
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
+	DT_CLK("481cc000.d_can", NULL, "dcan0_fck"),
+	DT_CLK("481d0000.d_can", NULL, "dcan1_fck"),
 	DT_CLK("48300200.ehrpwm", "tbclk", "ehrpwm0_tbclk"),
 	DT_CLK("48302200.ehrpwm", "tbclk", "ehrpwm1_tbclk"),
 	DT_CLK("48304200.ehrpwm", "tbclk", "ehrpwm2_tbclk"),
@@ -142,11 +64,11 @@ int __init am33xx_dt_clk_init(void)
 	 *    oscillator clock.
 	 */
 
-	clk1 = clk_get_sys(NULL, "sys_clkin_ck");
-	clk2 = clk_get_sys(NULL, "timer3_fck");
+	clk1 = ti_clk_get("sys_clkin_ck");
+	clk2 = ti_clk_get("timer3_fck");
 	clk_set_parent(clk2, clk1);
 
-	clk2 = clk_get_sys(NULL, "timer6_fck");
+	clk2 = ti_clk_get("timer6_fck");
 	clk_set_parent(clk2, clk1);
 	/*
 	 * The On-Chip 32K RC Osc clock is not an accurate clock-source as per
@@ -155,8 +77,8 @@ int __init am33xx_dt_clk_init(void)
 	 * not expected by any use-case, so change WDT1 clock source to PRCM
 	 * 32KHz clock.
 	 */
-	clk1 = clk_get_sys(NULL, "wdt1_fck");
-	clk2 = clk_get_sys(NULL, "clkdiv32k_ick");
+	clk1 = ti_clk_get("wdt1_fck");
+	clk2 = ti_clk_get("clkdiv32k_ick");
 	clk_set_parent(clk1, clk2);
 
 	return 0;
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
