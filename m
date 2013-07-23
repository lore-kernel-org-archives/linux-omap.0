From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 19/33] CLK: omap: add am33xx clock init file
Date: Tue, 23 Jul 2013 10:20:14 +0300
Message-ID: <1374564028-11352-20-git-send-email-t-kristo@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48675 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753566Ab3GWHWw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Jul 2013 03:22:52 -0400
In-Reply-To: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@linaro.org, tony@atomide.com, mturquette@linaro.org, nm@ti.com, rnayak@ti.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

clk-33xx.c now contains the clock init functionality for am33xx, including
DT clock registration and adding of static clkdev entries.

This patch also moves the omap2_clk_enable_init_clocks declaration to
the driver include, as this is needed by the am33xx clock init code.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock.h |    1 -
 drivers/clk/omap/clk-33xx.c |   85 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/clk/omap.h    |    1 +
 3 files changed, 86 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/omap/clk-33xx.c

diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index d1a3125..6273f14 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -267,7 +267,6 @@ void omap2_clk_dflt_find_idlest(struct clk_hw_omap *clk,
 				void __iomem **idlest_reg,
 				u8 *idlest_bit, u8 *idlest_val);
 int omap2_clk_enable_autoidle_all(void);
-void omap2_clk_enable_init_clocks(const char **clk_names, u8 num_clocks);
 int omap2_clk_switch_mpurate_at_boot(const char *mpurate_ck_name);
 void omap2_clk_print_new_rates(const char *hfclkin_ck_name,
 			       const char *core_ck_name,
diff --git a/drivers/clk/omap/clk-33xx.c b/drivers/clk/omap/clk-33xx.c
new file mode 100644
index 0000000..3ada30e
--- /dev/null
+++ b/drivers/clk/omap/clk-33xx.c
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
+#include <linux/clk/omap.h>
+
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
+	dt_omap_clk_init();
+
+	omap_dt_clocks_register(am33xx_clks, ARRAY_SIZE(am33xx_clks));
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
diff --git a/include/linux/clk/omap.h b/include/linux/clk/omap.h
index 58ebb80..c8d9468 100644
--- a/include/linux/clk/omap.h
+++ b/include/linux/clk/omap.h
@@ -184,6 +184,7 @@ int omap2_clkops_enable_clkdm(struct clk_hw *hw);
 void omap2_clkops_disable_clkdm(struct clk_hw *hw);
 
 int omap2_clk_disable_autoidle_all(void);
+void omap2_clk_enable_init_clocks(const char **clk_names, u8 num_clocks);
 
 extern const struct clk_hw_omap_ops clkhwops_omap3_dpll;
 extern const struct clk_hw_omap_ops clkhwops_omap4_dpllmx;
-- 
1.7.9.5

