From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv8 25/36] CLK: TI: add am33xx clock init file
Date: Wed, 9 Oct 2013 18:30:56 +0300
Message-ID: <1381332668-962-26-git-send-email-t-kristo@ti.com>
References: <1381332668-962-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60277 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752576Ab3JIPe2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Oct 2013 11:34:28 -0400
In-Reply-To: <1381332668-962-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

clk-33xx.c now contains the clock init functionality for am33xx, including
DT clock registration and adding of static clkdev entries.

This patch also moves the omap2_clk_enable_init_clocks declaration to
the driver include, as this is needed by the am33xx clock init code.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Tested-by: Nishanth Menon <nm@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clock.h |    1 -
 drivers/clk/ti/Makefile     |    1 +
 drivers/clk/ti/clk-33xx.c   |  163 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/clk/ti.h      |    2 +
 4 files changed, 166 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/ti/clk-33xx.c

diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 106c5c2..2e6cbeb 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -247,7 +247,6 @@ void omap2_clk_dflt_find_idlest(struct clk_hw_omap *clk,
 				void __iomem **idlest_reg,
 				u8 *idlest_bit, u8 *idlest_val);
 int omap2_clk_enable_autoidle_all(void);
-void omap2_clk_enable_init_clocks(const char **clk_names, u8 num_clocks);
 int omap2_clk_switch_mpurate_at_boot(const char *mpurate_ck_name);
 void omap2_clk_print_new_rates(const char *hfclkin_ck_name,
 			       const char *core_ck_name,
diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
index 1a83c3c..63b77f0 100644
--- a/drivers/clk/ti/Makefile
+++ b/drivers/clk/ti/Makefile
@@ -2,6 +2,7 @@ ifneq ($(CONFIG_OF),)
 obj-y					+= clk.o dpll.o autoidle.o divider.o \
 					   fixed-factor.o gate.o clockdomain.o \
 					   mux-gate.o mux.o apll.o
+obj-$(CONFIG_SOC_AM33XX)		+= clk-33xx.o
 obj-$(CONFIG_ARCH_OMAP4)		+= clk-44xx.o
 obj-$(CONFIG_SOC_OMAP5)			+= clk-54xx.o
 obj-$(CONFIG_SOC_DRA7XX)		+= clk-7xx.o
diff --git a/drivers/clk/ti/clk-33xx.c b/drivers/clk/ti/clk-33xx.c
new file mode 100644
index 0000000..d5774d5
--- /dev/null
+++ b/drivers/clk/ti/clk-33xx.c
@@ -0,0 +1,163 @@
+/*
+ * AM33XX Clock init
+ *
+ * Copyright (C) 2013 Texas Instruments, Inc
+ *     Tero Kristo (t-kristo@ti.com)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/clk-provider.h>
+#include <linux/clk/ti.h>
+
+static struct ti_dt_clk am33xx_clks[] = {
+	DT_CLK(NULL, "clk_32768_ck", "clk_32768_ck"),
+	DT_CLK(NULL, "clk_rc32k_ck", "clk_rc32k_ck"),
+	DT_CLK(NULL, "virt_19200000_ck", "virt_19200000_ck"),
+	DT_CLK(NULL, "virt_24000000_ck", "virt_24000000_ck"),
+	DT_CLK(NULL, "virt_25000000_ck", "virt_25000000_ck"),
+	DT_CLK(NULL, "virt_26000000_ck", "virt_26000000_ck"),
+	DT_CLK(NULL, "sys_clkin_ck", "sys_clkin_ck"),
+	DT_CLK(NULL, "tclkin_ck", "tclkin_ck"),
+	DT_CLK(NULL, "dpll_core_ck", "dpll_core_ck"),
+	DT_CLK(NULL, "dpll_core_x2_ck", "dpll_core_x2_ck"),
+	DT_CLK(NULL, "dpll_core_m4_ck", "dpll_core_m4_ck"),
+	DT_CLK(NULL, "dpll_core_m5_ck", "dpll_core_m5_ck"),
+	DT_CLK(NULL, "dpll_core_m6_ck", "dpll_core_m6_ck"),
+	DT_CLK(NULL, "dpll_mpu_ck", "dpll_mpu_ck"),
+	DT_CLK("cpu0", NULL, "dpll_mpu_ck"),
+	DT_CLK(NULL, "dpll_mpu_m2_ck", "dpll_mpu_m2_ck"),
+	DT_CLK(NULL, "dpll_ddr_ck", "dpll_ddr_ck"),
+	DT_CLK(NULL, "dpll_ddr_m2_ck", "dpll_ddr_m2_ck"),
+	DT_CLK(NULL, "dpll_ddr_m2_div2_ck", "dpll_ddr_m2_div2_ck"),
+	DT_CLK(NULL, "dpll_disp_ck", "dpll_disp_ck"),
+	DT_CLK(NULL, "dpll_disp_m2_ck", "dpll_disp_m2_ck"),
+	DT_CLK(NULL, "dpll_per_ck", "dpll_per_ck"),
+	DT_CLK(NULL, "dpll_per_m2_ck", "dpll_per_m2_ck"),
+	DT_CLK(NULL, "dpll_per_m2_div4_wkupdm_ck", "dpll_per_m2_div4_wkupdm_ck"),
+	DT_CLK(NULL, "dpll_per_m2_div4_ck", "dpll_per_m2_div4_ck"),
+	DT_CLK(NULL, "adc_tsc_fck", "adc_tsc_fck"),
+	DT_CLK(NULL, "cefuse_fck", "cefuse_fck"),
+	DT_CLK(NULL, "clkdiv32k_ck", "clkdiv32k_ck"),
+	DT_CLK(NULL, "clkdiv32k_ick", "clkdiv32k_ick"),
+	DT_CLK(NULL, "dcan0_fck", "dcan0_fck"),
+	DT_CLK("481cc000.d_can", NULL, "dcan0_fck"),
+	DT_CLK(NULL, "dcan1_fck", "dcan1_fck"),
+	DT_CLK("481d0000.d_can", NULL, "dcan1_fck"),
+	DT_CLK(NULL, "pruss_ocp_gclk", "pruss_ocp_gclk"),
+	DT_CLK(NULL, "mcasp0_fck", "mcasp0_fck"),
+	DT_CLK(NULL, "mcasp1_fck", "mcasp1_fck"),
+	DT_CLK(NULL, "mmu_fck", "mmu_fck"),
+	DT_CLK(NULL, "smartreflex0_fck", "smartreflex0_fck"),
+	DT_CLK(NULL, "smartreflex1_fck", "smartreflex1_fck"),
+	DT_CLK(NULL, "sha0_fck", "sha0_fck"),
+	DT_CLK(NULL, "aes0_fck", "aes0_fck"),
+	DT_CLK(NULL, "rng_fck", "rng_fck"),
+	DT_CLK(NULL, "timer1_fck", "timer1_fck"),
+	DT_CLK(NULL, "timer2_fck", "timer2_fck"),
+	DT_CLK(NULL, "timer3_fck", "timer3_fck"),
+	DT_CLK(NULL, "timer4_fck", "timer4_fck"),
+	DT_CLK(NULL, "timer5_fck", "timer5_fck"),
+	DT_CLK(NULL, "timer6_fck", "timer6_fck"),
+	DT_CLK(NULL, "timer7_fck", "timer7_fck"),
+	DT_CLK(NULL, "usbotg_fck", "usbotg_fck"),
+	DT_CLK(NULL, "ieee5000_fck", "ieee5000_fck"),
+	DT_CLK(NULL, "wdt1_fck", "wdt1_fck"),
+	DT_CLK(NULL, "l4_rtc_gclk", "l4_rtc_gclk"),
+	DT_CLK(NULL, "l3_gclk", "l3_gclk"),
+	DT_CLK(NULL, "dpll_core_m4_div2_ck", "dpll_core_m4_div2_ck"),
+	DT_CLK(NULL, "l4hs_gclk", "l4hs_gclk"),
+	DT_CLK(NULL, "l3s_gclk", "l3s_gclk"),
+	DT_CLK(NULL, "l4fw_gclk", "l4fw_gclk"),
+	DT_CLK(NULL, "l4ls_gclk", "l4ls_gclk"),
+	DT_CLK(NULL, "clk_24mhz", "clk_24mhz"),
+	DT_CLK(NULL, "sysclk_div_ck", "sysclk_div_ck"),
+	DT_CLK(NULL, "cpsw_125mhz_gclk", "cpsw_125mhz_gclk"),
+	DT_CLK(NULL, "cpsw_cpts_rft_clk", "cpsw_cpts_rft_clk"),
+	DT_CLK(NULL, "gpio0_dbclk_mux_ck", "gpio0_dbclk_mux_ck"),
+	DT_CLK(NULL, "gpio0_dbclk", "gpio0_dbclk"),
+	DT_CLK(NULL, "gpio1_dbclk", "gpio1_dbclk"),
+	DT_CLK(NULL, "gpio2_dbclk", "gpio2_dbclk"),
+	DT_CLK(NULL, "gpio3_dbclk", "gpio3_dbclk"),
+	DT_CLK(NULL, "lcd_gclk", "lcd_gclk"),
+	DT_CLK(NULL, "mmc_clk", "mmc_clk"),
+	DT_CLK(NULL, "gfx_fclk_clksel_ck", "gfx_fclk_clksel_ck"),
+	DT_CLK(NULL, "gfx_fck_div_ck", "gfx_fck_div_ck"),
+	DT_CLK(NULL, "sysclkout_pre_ck", "sysclkout_pre_ck"),
+	DT_CLK(NULL, "clkout2_div_ck", "clkout2_div_ck"),
+	DT_CLK(NULL, "timer_32k_ck", "clkdiv32k_ick"),
+	DT_CLK(NULL, "timer_sys_ck", "sys_clkin_ck"),
+	DT_CLK(NULL, "dbg_sysclk_ck", "dbg_sysclk_ck"),
+	DT_CLK(NULL, "dbg_clka_ck", "dbg_clka_ck"),
+	DT_CLK(NULL, "stm_pmd_clock_mux_ck", "stm_pmd_clock_mux_ck"),
+	DT_CLK(NULL, "trace_pmd_clk_mux_ck", "trace_pmd_clk_mux_ck"),
+	DT_CLK(NULL, "stm_clk_div_ck", "stm_clk_div_ck"),
+	DT_CLK(NULL, "trace_clk_div_ck", "trace_clk_div_ck"),
+	DT_CLK(NULL, "clkout2_ck", "clkout2_ck"),
+	DT_CLK("48300200.ehrpwm", "tbclk", "ehrpwm0_tbclk"),
+	DT_CLK("48302200.ehrpwm", "tbclk", "ehrpwm1_tbclk"),
+	DT_CLK("48304200.ehrpwm", "tbclk", "ehrpwm2_tbclk"),
+	{ .node_name = NULL },
+};
+
+static const char *enable_init_clks[] = {
+	"dpll_ddr_m2_ck",
+	"dpll_mpu_m2_ck",
+	"l3_gclk",
+	"l4hs_gclk",
+	"l4fw_gclk",
+	"l4ls_gclk",
+	/* Required for external peripherals like, Audio codecs */
+	"clkout2_ck",
+};
+
+int __init am33xx_dt_clk_init(void)
+{
+	struct clk *clk1, *clk2;
+
+	of_clk_init(NULL);
+
+	ti_dt_clocks_register(am33xx_clks);
+
+	omap2_clk_disable_autoidle_all();
+
+	omap2_clk_enable_init_clocks(enable_init_clks,
+				     ARRAY_SIZE(enable_init_clks));
+
+	/* TRM ERRATA: Timer 3 & 6 default parent (TCLKIN) may not be always
+	 *    physically present, in such a case HWMOD enabling of
+	 *    clock would be failure with default parent. And timer
+	 *    probe thinks clock is already enabled, this leads to
+	 *    crash upon accessing timer 3 & 6 registers in probe.
+	 *    Fix by setting parent of both these timers to master
+	 *    oscillator clock.
+	 */
+
+	clk1 = clk_get_sys(NULL, "sys_clkin_ck");
+	clk2 = clk_get_sys(NULL, "timer3_fck");
+	clk_set_parent(clk2, clk1);
+
+	clk2 = clk_get_sys(NULL, "timer6_fck");
+	clk_set_parent(clk2, clk1);
+	/*
+	 * The On-Chip 32K RC Osc clock is not an accurate clock-source as per
+	 * the design/spec, so as a result, for example, timer which supposed
+	 * to get expired @60Sec, but will expire somewhere ~@40Sec, which is
+	 * not expected by any use-case, so change WDT1 clock source to PRCM
+	 * 32KHz clock.
+	 */
+	clk1 = clk_get_sys(NULL, "wdt1_fck");
+	clk2 = clk_get_sys(NULL, "clkdiv32k_ick");
+	clk_set_parent(clk1, clk2);
+
+	return 0;
+}
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index a2b0658..67a9bf6 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -208,6 +208,7 @@ unsigned long omap3_clkoutx2_recalc(struct clk_hw *hw,
 int omap2_clkops_enable_clkdm(struct clk_hw *hw);
 void omap2_clkops_disable_clkdm(struct clk_hw *hw);
 int omap2_clk_disable_autoidle_all(void);
+void omap2_clk_enable_init_clocks(const char **clk_names, u8 num_clocks);
 int omap3_dpll4_set_rate(struct clk_hw *clk, unsigned long rate,
 			 unsigned long parent_rate);
 int omap2_dflt_clk_enable(struct clk_hw *hw);
@@ -222,6 +223,7 @@ struct clk_div_table *ti_clk_get_div_table(struct device_node *node);
 int omap4xxx_dt_clk_init(void);
 int omap5xxx_dt_clk_init(void);
 int dra7xx_dt_clk_init(void);
+int am33xx_dt_clk_init(void);
 
 #ifdef CONFIG_OF
 void of_ti_clk_allow_autoidle_all(void);
-- 
1.7.9.5

