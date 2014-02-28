From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 04/12] CLK: TI: DPLL: add support for omap2 core dpll
Date: Fri, 28 Feb 2014 11:22:56 +0200
Message-ID: <1393579384-23440-5-git-send-email-t-kristo@ti.com>
References: <1393579384-23440-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40321 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751240AbaB1JYS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Feb 2014 04:24:18 -0500
In-Reply-To: <1393579384-23440-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

OMAP2 has slightly different DPLL compared to later OMAP generations.
This patch adds support for the ti,omap2-dpll-core-clock and also adds
the bindings documentation.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 .../devicetree/bindings/clock/ti/dpll.txt          |    9 ++++
 arch/arm/mach-omap2/clock.h                        |    1 -
 arch/arm/mach-omap2/clock2xxx.h                    |    4 --
 drivers/clk/ti/dpll.c                              |   45 ++++++++++++++++++--
 include/linux/clk/ti.h                             |    6 +++
 5 files changed, 57 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/ti/dpll.txt b/Documentation/devicetree/bindings/clock/ti/dpll.txt
index 30bfdb7..50a1a42 100644
--- a/Documentation/devicetree/bindings/clock/ti/dpll.txt
+++ b/Documentation/devicetree/bindings/clock/ti/dpll.txt
@@ -30,6 +30,7 @@ Required properties:
 		"ti,am3-dpll-clock",
 		"ti,am3-dpll-core-clock",
 		"ti,am3-dpll-x2-clock",
+		"ti,omap2-dpll-core-clock",
 
 - #clock-cells : from common clock binding; shall be set to 0.
 - clocks : link phandles of parent clocks, first entry lists reference clock
@@ -41,6 +42,7 @@ Required properties:
 	"mult-div1" - contains the multiplier / divider register base address
 	"autoidle" - contains the autoidle register base address (optional)
   ti,am3-* dpll types do not have autoidle register
+  ti,omap2-* dpll type does not support idlest / autoidle registers
 
 Optional properties:
 - DPLL mode setting - defining any one or more of the following overrides
@@ -73,3 +75,10 @@ Examples:
 		clocks = <&sys_clkin_ck>, <&sys_clkin_ck>;
 		reg = <0x90>, <0x5c>, <0x68>;
 	};
+
+	dpll_ck: dpll_ck {
+		#clock-cells = <0>;
+		compatible = "ti,omap2-dpll-core-clock";
+		clocks = <&sys_ck>, <&sys_ck>;
+		reg = <0x0500>, <0x0540>;
+	};
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 3843c9f..7057f37 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -276,7 +276,6 @@ extern const struct clk_hw_omap_ops clkhwops_omap3430es2_hsotgusb_wait;
 extern const struct clk_hw_omap_ops clkhwops_am35xx_ipss_module_wait;
 extern const struct clk_hw_omap_ops clkhwops_apll54;
 extern const struct clk_hw_omap_ops clkhwops_apll96;
-extern const struct clk_hw_omap_ops clkhwops_omap2xxx_dpll;
 extern const struct clk_hw_omap_ops clkhwops_omap2430_i2chs_wait;
 
 /* clksel_rate blocks shared between OMAP44xx and AM33xx */
diff --git a/arch/arm/mach-omap2/clock2xxx.h b/arch/arm/mach-omap2/clock2xxx.h
index 8d52a0c..a090225 100644
--- a/arch/arm/mach-omap2/clock2xxx.h
+++ b/arch/arm/mach-omap2/clock2xxx.h
@@ -21,10 +21,6 @@ unsigned long omap2xxx_sys_clk_recalc(struct clk_hw *clk,
 				      unsigned long parent_rate);
 unsigned long omap2_osc_clk_recalc(struct clk_hw *clk,
 				   unsigned long parent_rate);
-unsigned long omap2_dpllcore_recalc(struct clk_hw *hw,
-				    unsigned long parent_rate);
-int omap2_reprogram_dpllcore(struct clk_hw *clk, unsigned long rate,
-			     unsigned long parent_rate);
 void omap2xxx_clkt_dpllcore_init(struct clk_hw *hw);
 unsigned long omap2_clk_apll54_recalc(struct clk_hw *hw,
 				      unsigned long parent_rate);
diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
index dda262d..bb2c0c4 100644
--- a/drivers/clk/ti/dpll.c
+++ b/drivers/clk/ti/dpll.c
@@ -42,6 +42,15 @@ static const struct clk_ops dpll_core_ck_ops = {
 	.get_parent	= &omap2_init_dpll_parent,
 };
 
+#ifdef CONFIG_ARCH_OMAP2
+static const struct clk_ops omap2_dpll_core_ck_ops = {
+	.get_parent	= &omap2_init_dpll_parent,
+	.recalc_rate	= &omap2_dpllcore_recalc,
+	.round_rate	= &omap2_dpll_round_rate,
+	.set_rate	= &omap2_reprogram_dpllcore,
+};
+#endif
+
 #ifdef CONFIG_ARCH_OMAP3
 static const struct clk_ops omap3_dpll_core_ck_ops = {
 	.get_parent	= &omap2_init_dpll_parent,
@@ -237,10 +246,25 @@ static void __init of_ti_dpll_setup(struct device_node *node,
 	init->parent_names = parent_names;
 
 	dd->control_reg = ti_clk_get_reg_addr(node, 0);
-	dd->idlest_reg = ti_clk_get_reg_addr(node, 1);
-	dd->mult_div1_reg = ti_clk_get_reg_addr(node, 2);
 
-	if (!dd->control_reg || !dd->idlest_reg || !dd->mult_div1_reg)
+	/*
+	 * Special case for OMAP2 DPLL, register order is different due to
+	 * missing idlest_reg, also clkhwops is different. Detected from
+	 * missing idlest_mask.
+	 */
+	if (!dd->idlest_mask) {
+		dd->mult_div1_reg = ti_clk_get_reg_addr(node, 1);
+		clk_hw->ops = &clkhwops_omap2xxx_dpll;
+		omap2xxx_clkt_dpllcore_init(&clk_hw->hw);
+	} else {
+		dd->idlest_reg = ti_clk_get_reg_addr(node, 1);
+		if (!dd->idlest_reg)
+			goto cleanup;
+
+		dd->mult_div1_reg = ti_clk_get_reg_addr(node, 2);
+	}
+
+	if (!dd->control_reg || !dd->mult_div1_reg)
 		goto cleanup;
 
 	if (dd->autoidle_mask) {
@@ -547,3 +571,18 @@ static void __init of_ti_am3_core_dpll_setup(struct device_node *node)
 }
 CLK_OF_DECLARE(ti_am3_core_dpll_clock, "ti,am3-dpll-core-clock",
 	       of_ti_am3_core_dpll_setup);
+
+static void __init of_ti_omap2_core_dpll_setup(struct device_node *node)
+{
+	const struct dpll_data dd = {
+		.enable_mask = 0x3,
+		.mult_mask = 0x3ff << 12,
+		.div1_mask = 0xf << 8,
+		.max_divider = 16,
+		.min_divider = 1,
+	};
+
+	of_ti_dpll_setup(node, &omap2_dpll_core_ck_ops, &dd);
+}
+CLK_OF_DECLARE(ti_omap2_core_dpll_clock, "ti,omap2-dpll-core-clock",
+	       of_ti_omap2_core_dpll_setup);
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 092b641..2310adc 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -255,6 +255,11 @@ int omap2_dflt_clk_enable(struct clk_hw *hw);
 void omap2_dflt_clk_disable(struct clk_hw *hw);
 int omap2_dflt_clk_is_enabled(struct clk_hw *hw);
 void omap3_clk_lock_dpll5(void);
+unsigned long omap2_dpllcore_recalc(struct clk_hw *hw,
+				    unsigned long parent_rate);
+int omap2_reprogram_dpllcore(struct clk_hw *clk, unsigned long rate,
+			     unsigned long parent_rate);
+void omap2xxx_clkt_dpllcore_init(struct clk_hw *hw);
 
 void __iomem *ti_clk_get_reg_addr(struct device_node *node, int index);
 void ti_dt_clocks_register(struct ti_dt_clk *oclks);
@@ -283,6 +288,7 @@ static inline void of_ti_clk_allow_autoidle_all(void) { }
 static inline void of_ti_clk_deny_autoidle_all(void) { }
 #endif
 
+extern const struct clk_hw_omap_ops clkhwops_omap2xxx_dpll;
 extern const struct clk_hw_omap_ops clkhwops_omap3_dpll;
 extern const struct clk_hw_omap_ops clkhwops_omap4_dpllmx;
 extern const struct clk_hw_omap_ops clkhwops_wait;
-- 
1.7.9.5

