From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 20/31] CLK: TI: add am33xx clock init file
Date: Fri, 2 Aug 2013 19:25:39 +0300
Message-ID: <1375460751-23676-21-git-send-email-t-kristo@ti.com>
References: <1375460751-23676-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36786 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754639Ab3HBQ1g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Aug 2013 12:27:36 -0400
In-Reply-To: <1375460751-23676-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

clk-33xx.c now contains the clock init functionality for am33xx, including
DT clock registration and adding of static clkdev entries.

This patch also moves the omap2_clk_enable_init_clocks declaration to
the driver include, as this is needed by the am33xx clock init code.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock.h |    1 -
 drivers/clk/ti/clk-33xx.c   |   85 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/clk/ti.h      |    1 +
 3 files changed, 86 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/ti/clk-33xx.c

diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 46b3672..08c9aa6 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -266,7 +266,6 @@ void omap2_clk_dflt_find_idlest(struct clk_hw_omap *clk,
 				void __iomem **idlest_reg,
 				u8 *idlest_bit, u8 *idlest_val);
 int omap2_clk_enable_autoidle_all(void);
-void omap2_clk_enable_init_clocks(const char **clk_names, u8 num_clocks);
 int omap2_clk_switch_mpurate_at_boot(const char *mpurate_ck_name);
 void omap2_clk_print_new_rates(const char *hfclkin_ck_name,
 			       const char *core_ck_name,
diff --git a/drivers/clk/ti/clk-33xx.c b/drivers/clk/ti/clk-33xx.c
new file mode 100644
index 0000000..b3d4942
--- /dev/null
+++ b/drivers/clk/ti/clk-33xx.c
@@ -0,0 +1,85 @@
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
+static struct omap_dt_clk am33xx_clks[] = {
+	DT_CLK("cpu0", NULL, "dpll_mpu_ck"),
+	DT_CLK("481cc000.d_can", NULL, "dcan0_fck"),
+	DT_CLK("481d0000.d_can", NULL, "dcan1_fck"),
+	DT_CLK(NULL, "timer_32k_ck", "clkdiv32k_ick"),
+	DT_CLK(NULL, "timer_sys_ck", "sys_clkin_ck"),
+	DT_CLK("48300200.ehrpwm", "tbclk", "ehrpwm0_tbclk"),
+	DT_CLK("48302200.ehrpwm", "tbclk", "ehrpwm1_tbclk"),
+	DT_CLK("48304200.ehrpwm", "tbclk", "ehrpwm2_tbclk"),
+	{ NULL },
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
+int __init am33xx_clk_init(void)
+{
+	struct clk *clk1, *clk2;
+
+	of_clk_init(NULL);
+
+	omap_dt_clocks_register(am33xx_clks);
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
index 54f5a4f..8ff2c29 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -181,6 +181,7 @@ unsigned long omap3_clkoutx2_recalc(struct clk_hw *hw,
 int omap2_clkops_enable_clkdm(struct clk_hw *hw);
 void omap2_clkops_disable_clkdm(struct clk_hw *hw);
 int omap2_clk_disable_autoidle_all(void);
+void omap2_clk_enable_init_clocks(const char **clk_names, u8 num_clocks);
 int omap3_dpll4_set_rate(struct clk_hw *clk, unsigned long rate,
 			 unsigned long parent_rate);
 int omap2_dflt_clk_enable(struct clk_hw *hw);
-- 
1.7.9.5

