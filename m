From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 05/31] CLK: TI: add support for OMAP gate clock
Date: Fri, 2 Aug 2013 19:25:24 +0300
Message-ID: <1375460751-23676-6-git-send-email-t-kristo@ti.com>
References: <1375460751-23676-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56708 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753002Ab3HBQ0q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Aug 2013 12:26:46 -0400
In-Reply-To: <1375460751-23676-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

This node adds support for a clock node which allows control to the
clockdomain enable / disable.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 .../devicetree/bindings/clock/ti/gate.txt          |   41 ++++++++
 arch/arm/mach-omap2/clock.h                        |    9 --
 drivers/clk/ti/Makefile                            |    2 +-
 drivers/clk/ti/gate.c                              |  106 ++++++++++++++++++++
 include/linux/clk/ti.h                             |    8 ++
 5 files changed, 156 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/ti/gate.txt
 create mode 100644 drivers/clk/ti/gate.c

diff --git a/Documentation/devicetree/bindings/clock/ti/gate.txt b/Documentation/devicetree/bindings/clock/ti/gate.txt
new file mode 100644
index 0000000..620a73d
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ti/gate.txt
@@ -0,0 +1,41 @@
+Binding for Texas Instruments gate clock.
+
+This binding uses the common clock binding[1]. This clock is
+quite much similar to the basic gate-clock [2], however,
+it supports a number of additional features. If no register
+is provided for this clock, the code assumes that a clockdomain
+will be controlled instead and the corresponding hw-ops for
+that is used.
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+[2] Documentation/devicetree/bindings/clock/gate-clock.txt
+
+Required properties:
+- compatible : shall be "ti,gate-clock"
+- #clock-cells : from common clock binding; shall be set to 0
+- clocks : link to phandle of parent clock
+
+Optional properties:
+- reg : base address for register controlling adjustable gate
+- ti,enable-bit : bit shift for programming the clock gate
+- ti,dss-clk : use DSS hardware OPS for the clock
+- ti,am35xx-clk : use AM35xx hardware OPS for the clock
+- ti,clkdm-name : clockdomain to control this gate
+
+Examples:
+	trace_clk_div_ck: trace_clk_div_ck {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&trace_clk_div_div_ck>;
+		ti,clkdm-name = "emu_sys_clkdm";
+	};
+
+	emac_ick: emac_ick@4800259c {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&ipss_ick>;
+		reg = <0x4800259c 0x4>;
+		ti,clkdm-name = "core_l3_clkdm";
+		ti,enable-bit = <1>;
+		ti,am35xx-clk;
+	};
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 079536a..1a8c41a 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -260,9 +260,6 @@ extern void omap2_clkt_iclk_deny_idle(struct clk_hw_omap *clk);
 
 unsigned long omap2_get_dpll_rate(struct clk_hw_omap *clk);
 
-int omap2_dflt_clk_enable(struct clk_hw *hw);
-void omap2_dflt_clk_disable(struct clk_hw *hw);
-int omap2_dflt_clk_is_enabled(struct clk_hw *hw);
 void omap2_clk_dflt_find_companion(struct clk_hw_omap *clk,
 				   void __iomem **other_reg,
 				   u8 *other_bit);
@@ -292,15 +289,12 @@ extern const struct clksel_rate dsp_ick_rates[];
 extern struct clk dummy_ck;
 
 extern const struct clk_hw_omap_ops clkhwops_iclk_wait;
-extern const struct clk_hw_omap_ops clkhwops_wait;
 extern const struct clk_hw_omap_ops clkhwops_iclk;
 extern const struct clk_hw_omap_ops clkhwops_omap3430es2_ssi_wait;
 extern const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_ssi_wait;
-extern const struct clk_hw_omap_ops clkhwops_omap3430es2_dss_usbhost_wait;
 extern const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_dss_usbhost_wait;
 extern const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_hsotgusb_wait;
 extern const struct clk_hw_omap_ops clkhwops_omap3430es2_hsotgusb_wait;
-extern const struct clk_hw_omap_ops clkhwops_am35xx_ipss_module_wait;
 extern const struct clk_hw_omap_ops clkhwops_am35xx_ipss_wait;
 extern const struct clk_hw_omap_ops clkhwops_apll54;
 extern const struct clk_hw_omap_ops clkhwops_apll96;
@@ -318,8 +312,5 @@ extern const struct clksel_rate div31_1to31_rates[];
 
 extern int am33xx_clk_init(void);
 
-extern int omap2_clkops_enable_clkdm(struct clk_hw *hw);
-extern void omap2_clkops_disable_clkdm(struct clk_hw *hw);
-
 extern void omap_clocks_register(struct omap_clk *oclks, int cnt);
 #endif
diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
index 533efb4..57bfbaa 100644
--- a/drivers/clk/ti/Makefile
+++ b/drivers/clk/ti/Makefile
@@ -1,3 +1,3 @@
 ifneq ($(CONFIG_OF),)
-obj-y					+= clk.o dpll.o autoidle.o
+obj-y					+= clk.o dpll.o autoidle.o gate.o
 endif
diff --git a/drivers/clk/ti/gate.c b/drivers/clk/ti/gate.c
new file mode 100644
index 0000000..2c68310
--- /dev/null
+++ b/drivers/clk/ti/gate.c
@@ -0,0 +1,106 @@
+/*
+ * OMAP gate clock support
+ *
+ * Copyright (C) 2013 Texas Instruments, Inc.
+ *
+ * Tero Kristo <t-kristo@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/clk/ti.h>
+
+static const struct clk_ops omap_gate_clkdm_clk_ops = {
+	.init		= &omap2_init_clk_clkdm,
+	.enable		= &omap2_clkops_enable_clkdm,
+	.disable	= &omap2_clkops_disable_clkdm,
+};
+
+static const struct clk_ops omap_gate_clk_ops = {
+	.init		= &omap2_init_clk_clkdm,
+	.enable		= &omap2_dflt_clk_enable,
+	.disable	= &omap2_dflt_clk_disable,
+	.is_enabled	= &omap2_dflt_clk_is_enabled,
+};
+
+void __init of_omap_gate_clk_setup(struct device_node *node)
+{
+	struct clk *clk;
+	struct clk_init_data init = { 0 };
+	struct clk_hw_omap *clk_hw;
+	const char *clk_name = node->name;
+	int num_parents;
+	const char **parent_names = NULL;
+	int i;
+	u32 val;
+
+	clk_hw = kzalloc(sizeof(*clk_hw), GFP_KERNEL);
+	if (!clk_hw) {
+		pr_err("%s: could not allocate clk_hw_omap\n", __func__);
+		return;
+	}
+
+	clk_hw->hw.init = &init;
+
+	of_property_read_string(node, "clock-output-names", &clk_name);
+	of_property_read_string(node, "ti,clkdm-name", &clk_hw->clkdm_name);
+
+	init.name = clk_name;
+	init.flags = 0;
+
+	if (of_property_read_u32_index(node, "reg", 0, &val)) {
+		/* No register, clkdm control only */
+		init.ops = &omap_gate_clkdm_clk_ops;
+	} else {
+		init.ops = &omap_gate_clk_ops;
+		clk_hw->enable_reg = of_iomap(node, 0);
+		of_property_read_u32(node, "ti,enable-bit", &val);
+		clk_hw->enable_bit = val;
+
+		clk_hw->ops = &clkhwops_wait;
+
+		if (of_property_read_bool(node, "ti,dss-clk"))
+			clk_hw->ops = &clkhwops_omap3430es2_dss_usbhost_wait;
+
+		if (of_property_read_bool(node, "ti,am35xx-clk"))
+			clk_hw->ops = &clkhwops_am35xx_ipss_module_wait;
+	}
+
+	num_parents = of_clk_get_parent_count(node);
+	if (num_parents < 1) {
+		pr_err("%s: omap trace_clk %s must have parent(s)\n",
+		       __func__, node->name);
+		goto cleanup;
+	}
+
+	parent_names = kzalloc(sizeof(char *) * num_parents, GFP_KERNEL);
+
+	for (i = 0; i < num_parents; i++)
+		parent_names[i] = of_clk_get_parent_name(node, i);
+
+	init.num_parents = num_parents;
+	init.parent_names = parent_names;
+
+	clk = clk_register(NULL, &clk_hw->hw);
+
+	if (!IS_ERR(clk)) {
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+		return;
+	}
+
+cleanup:
+	kfree(parent_names);
+	kfree(clk_hw);
+}
+CLK_OF_DECLARE(omap_gate_clk, "ti,gate-clock", of_omap_gate_clk_setup);
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 781ef23..eec4973 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -176,8 +176,13 @@ long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rate,
 void omap2_init_clk_clkdm(struct clk_hw *clk);
 unsigned long omap3_clkoutx2_recalc(struct clk_hw *hw,
 				    unsigned long parent_rate);
+int omap2_clkops_enable_clkdm(struct clk_hw *hw);
+void omap2_clkops_disable_clkdm(struct clk_hw *hw);
 int omap3_dpll4_set_rate(struct clk_hw *clk, unsigned long rate,
 			 unsigned long parent_rate);
+int omap2_dflt_clk_enable(struct clk_hw *hw);
+void omap2_dflt_clk_disable(struct clk_hw *hw);
+int omap2_dflt_clk_is_enabled(struct clk_hw *hw);
 
 void omap_dt_clocks_register(struct omap_dt_clk *oclks);
 #ifdef CONFIG_OF
@@ -190,5 +195,8 @@ static inline void of_omap_clk_deny_autoidle_all(void) { }
 
 extern const struct clk_hw_omap_ops clkhwops_omap3_dpll;
 extern const struct clk_hw_omap_ops clkhwops_omap4_dpllmx;
+extern const struct clk_hw_omap_ops clkhwops_wait;
+extern const struct clk_hw_omap_ops clkhwops_omap3430es2_dss_usbhost_wait;
+extern const struct clk_hw_omap_ops clkhwops_am35xx_ipss_module_wait;
 
 #endif
-- 
1.7.9.5

