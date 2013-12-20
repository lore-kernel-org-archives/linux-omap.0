From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv12 17/49] CLK: TI: add support for gate clock
Date: Fri, 20 Dec 2013 18:34:31 +0200
Message-ID: <1387557274-22583-13-git-send-email-t-kristo@ti.com>
References: <1387557274-22583-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33539 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756170Ab3LTQgH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Dec 2013 11:36:07 -0500
In-Reply-To: <1387557274-22583-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

This patch adds support for TI specific gate clocks. These behave as basic
gate-clock, but have different ops / hw-ops for controlling the actual
gate, for example waiting until the clock is ready. Several sub-types
are supported:
- ti,gate-clock: basic gate clock with default ops/hwops
- ti,clkdm-gate-clock: clockdomain level gate control
- ti,dss-gate-clock: gate clock with DSS specific hardware handling
- ti,am35xx-gate-clock: gate clock with AM35xx specific hardware handling
- ti,hsdiv-gate-clock: gate clock with OMAP36xx hardware errata handling

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 .../devicetree/bindings/clock/ti/gate.txt          |   85 +++++++
 drivers/clk/ti/Makefile                            |    2 +-
 drivers/clk/ti/gate.c                              |  247 ++++++++++++++++++++
 include/linux/clk/ti.h                             |    6 +
 4 files changed, 339 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/ti/gate.txt
 create mode 100644 drivers/clk/ti/gate.c

diff --git a/Documentation/devicetree/bindings/clock/ti/gate.txt b/Documentation/devicetree/bindings/clock/ti/gate.txt
new file mode 100644
index 0000000..125281a
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ti/gate.txt
@@ -0,0 +1,85 @@
+Binding for Texas Instruments gate clock.
+
+Binding status: Unstable - ABI compatibility may be broken in the future
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
+[3] Documentation/devicetree/bindings/clock/ti/clockdomain.txt
+
+Required properties:
+- compatible : shall be one of:
+  "ti,gate-clock" - basic gate clock
+  "ti,wait-gate-clock" - gate clock which waits until clock is active before
+			 returning from clk_enable()
+  "ti,dss-gate-clock" - gate clock with DSS specific hardware handling
+  "ti,am35xx-gate-clock" - gate clock with AM35xx specific hardware handling
+  "ti,clkdm-gate-clock" - clockdomain gate clock, which derives its functional
+			  clock directly from a clockdomain, see [3] how
+			  to map clockdomains properly
+  "ti,hsdiv-gate-clock" - gate clock with OMAP36xx specific hardware handling,
+			  required for a hardware errata
+- #clock-cells : from common clock binding; shall be set to 0
+- clocks : link to phandle of parent clock
+- reg : offset for register controlling adjustable gate, not needed for
+	ti,clkdm-gate-clock type
+
+Optional properties:
+- ti,bit-shift : bit shift for programming the clock gate, invalid for
+		 ti,clkdm-gate-clock type
+- ti,set-bit-to-disable : inverts default gate programming. Setting the bit
+  gates the clock and clearing the bit ungates the clock.
+
+Examples:
+	mmchs2_fck: mmchs2_fck@48004a00 {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&core_96m_fck>;
+		reg = <0x48004a00 0x4>;
+		ti,bit-shift = <25>;
+	};
+
+	uart4_fck_am35xx: uart4_fck_am35xx {
+		#clock-cells = <0>;
+		compatible = "ti,wait-gate-clock";
+		clocks = <&core_48m_fck>;
+		reg = <0x0a00>;
+		ti,bit-shift = <23>;
+	};
+
+	dss1_alwon_fck_3430es2: dss1_alwon_fck_3430es2@48004e00 {
+		#clock-cells = <0>;
+		compatible = "ti,dss-gate-clock";
+		clocks = <&dpll4_m4x2_ck>;
+		reg = <0x48004e00 0x4>;
+		ti,bit-shift = <0>;
+	};
+
+	emac_ick: emac_ick@4800259c {
+		#clock-cells = <0>;
+		compatible = "ti,am35xx-gate-clock";
+		clocks = <&ipss_ick>;
+		reg = <0x4800259c 0x4>;
+		ti,bit-shift = <1>;
+	};
+
+	emu_src_ck: emu_src_ck {
+		#clock-cells = <0>;
+		compatible = "ti,clkdm-gate-clock";
+		clocks = <&emu_src_mux_ck>;
+	};
+
+	dpll4_m2x2_ck: dpll4_m2x2_ck@48004d00 {
+		#clock-cells = <0>;
+		compatible = "ti,hsdiv-gate-clock";
+		clocks = <&dpll4_m2x2_mul_ck>;
+		ti,bit-shift = <0x1b>;
+		reg = <0x48004d00 0x4>;
+		ti,set-bit-to-disable;
+	};
diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
index f57fc4b..7cba389 100644
--- a/drivers/clk/ti/Makefile
+++ b/drivers/clk/ti/Makefile
@@ -1,4 +1,4 @@
 ifneq ($(CONFIG_OF),)
 obj-y					+= clk.o dpll.o autoidle.o divider.o \
-					   fixed-factor.o composite.o
+					   fixed-factor.o gate.o composite.o
 endif
diff --git a/drivers/clk/ti/gate.c b/drivers/clk/ti/gate.c
new file mode 100644
index 0000000..12ce4d3
--- /dev/null
+++ b/drivers/clk/ti/gate.c
@@ -0,0 +1,247 @@
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
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/clk/ti.h>
+
+#define to_clk_divider(_hw) container_of(_hw, struct clk_divider, hw)
+
+#undef pr_fmt
+#define pr_fmt(fmt) "%s: " fmt, __func__
+
+static int omap36xx_gate_clk_enable_with_hsdiv_restore(struct clk_hw *clk);
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
+static const struct clk_ops omap_gate_clk_hsdiv_restore_ops = {
+	.init		= &omap2_init_clk_clkdm,
+	.enable		= &omap36xx_gate_clk_enable_with_hsdiv_restore,
+	.disable	= &omap2_dflt_clk_disable,
+	.is_enabled	= &omap2_dflt_clk_is_enabled,
+};
+
+/**
+ * omap36xx_gate_clk_enable_with_hsdiv_restore - enable clocks suffering
+ *         from HSDivider PWRDN problem Implements Errata ID: i556.
+ * @clk: DPLL output struct clk
+ *
+ * 3630 only: dpll3_m3_ck, dpll4_m2_ck, dpll4_m3_ck, dpll4_m4_ck,
+ * dpll4_m5_ck & dpll4_m6_ck dividers gets loaded with reset
+ * valueafter their respective PWRDN bits are set.  Any dummy write
+ * (Any other value different from the Read value) to the
+ * corresponding CM_CLKSEL register will refresh the dividers.
+ */
+static int omap36xx_gate_clk_enable_with_hsdiv_restore(struct clk_hw *clk)
+{
+	struct clk_divider *parent;
+	struct clk_hw *parent_hw;
+	u32 dummy_v, orig_v;
+	int ret;
+
+	/* Clear PWRDN bit of HSDIVIDER */
+	ret = omap2_dflt_clk_enable(clk);
+
+	/* Parent is the x2 node, get parent of parent for the m2 div */
+	parent_hw = __clk_get_hw(__clk_get_parent(__clk_get_parent(clk->clk)));
+	parent = to_clk_divider(parent_hw);
+
+	/* Restore the dividers */
+	if (!ret) {
+		orig_v = ti_clk_ll_ops->clk_readl(parent->reg);
+		dummy_v = orig_v;
+
+		/* Write any other value different from the Read value */
+		dummy_v ^= (1 << parent->shift);
+		ti_clk_ll_ops->clk_writel(dummy_v, parent->reg);
+
+		/* Write the original divider */
+		ti_clk_ll_ops->clk_writel(orig_v, parent->reg);
+	}
+
+	return ret;
+}
+
+static void __init _of_ti_gate_clk_setup(struct device_node *node,
+					 const struct clk_ops *ops,
+					 const struct clk_hw_omap_ops *hw_ops)
+{
+	struct clk *clk;
+	struct clk_init_data init = { NULL };
+	struct clk_hw_omap *clk_hw;
+	const char *clk_name = node->name;
+	const char *parent_name;
+	u32 val;
+
+	clk_hw = kzalloc(sizeof(*clk_hw), GFP_KERNEL);
+	if (!clk_hw)
+		return;
+
+	clk_hw->hw.init = &init;
+
+	init.name = clk_name;
+	init.ops = ops;
+
+	if (ops != &omap_gate_clkdm_clk_ops) {
+		clk_hw->enable_reg = ti_clk_get_reg_addr(node, 0);
+		if (!clk_hw->enable_reg)
+			goto cleanup;
+
+		if (!of_property_read_u32(node, "ti,bit-shift", &val))
+			clk_hw->enable_bit = val;
+	}
+
+	clk_hw->ops = hw_ops;
+
+	clk_hw->flags = MEMMAP_ADDRESSING;
+
+	if (of_clk_get_parent_count(node) != 1) {
+		pr_err("%s must have 1 parent\n", clk_name);
+		goto cleanup;
+	}
+
+	parent_name = of_clk_get_parent_name(node, 0);
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+
+	if (of_property_read_bool(node, "ti,set-rate-parent"))
+		init.flags |= CLK_SET_RATE_PARENT;
+
+	if (of_property_read_bool(node, "ti,set-bit-to-disable"))
+		clk_hw->flags |= INVERT_ENABLE;
+
+	clk = clk_register(NULL, &clk_hw->hw);
+
+	if (!IS_ERR(clk)) {
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+		return;
+	}
+
+cleanup:
+	kfree(clk_hw);
+}
+
+static void __init
+_of_ti_composite_gate_clk_setup(struct device_node *node,
+				const struct clk_hw_omap_ops *hw_ops)
+{
+	struct clk_hw_omap *gate;
+	u32 val = 0;
+
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		return;
+
+	gate->enable_reg = ti_clk_get_reg_addr(node, 0);
+	if (!gate->enable_reg)
+		goto cleanup;
+
+	of_property_read_u32(node, "ti,bit-shift", &val);
+
+	gate->enable_bit = val;
+	gate->ops = hw_ops;
+	gate->flags = MEMMAP_ADDRESSING;
+
+	if (!ti_clk_add_component(node, &gate->hw, CLK_COMPONENT_TYPE_GATE))
+		return;
+
+cleanup:
+	kfree(gate);
+}
+
+static void __init
+of_ti_composite_no_wait_gate_clk_setup(struct device_node *node)
+{
+	_of_ti_composite_gate_clk_setup(node, NULL);
+}
+CLK_OF_DECLARE(ti_composite_no_wait_gate_clk, "ti,composite-no-wait-gate-clock",
+	       of_ti_composite_no_wait_gate_clk_setup);
+
+static void __init of_ti_composite_interface_clk_setup(struct device_node *node)
+{
+	_of_ti_composite_gate_clk_setup(node, &clkhwops_iclk_wait);
+}
+CLK_OF_DECLARE(ti_composite_interface_clk, "ti,composite-interface-clock",
+	       of_ti_composite_interface_clk_setup);
+
+static void __init of_ti_composite_gate_clk_setup(struct device_node *node)
+{
+	_of_ti_composite_gate_clk_setup(node, &clkhwops_wait);
+}
+CLK_OF_DECLARE(ti_composite_gate_clk, "ti,composite-gate-clock",
+	       of_ti_composite_gate_clk_setup);
+
+
+static void __init of_ti_clkdm_gate_clk_setup(struct device_node *node)
+{
+	_of_ti_gate_clk_setup(node, &omap_gate_clkdm_clk_ops, NULL);
+}
+CLK_OF_DECLARE(ti_clkdm_gate_clk, "ti,clkdm-gate-clock",
+	       of_ti_clkdm_gate_clk_setup);
+
+static void __init of_ti_hsdiv_gate_clk_setup(struct device_node *node)
+{
+	_of_ti_gate_clk_setup(node, &omap_gate_clk_hsdiv_restore_ops,
+			      &clkhwops_wait);
+}
+CLK_OF_DECLARE(ti_hsdiv_gate_clk, "ti,hsdiv-gate-clock",
+	       of_ti_hsdiv_gate_clk_setup);
+
+static void __init of_ti_gate_clk_setup(struct device_node *node)
+{
+	_of_ti_gate_clk_setup(node, &omap_gate_clk_ops, NULL);
+}
+CLK_OF_DECLARE(ti_gate_clk, "ti,gate-clock", of_ti_gate_clk_setup)
+
+static void __init of_ti_wait_gate_clk_setup(struct device_node *node)
+{
+	_of_ti_gate_clk_setup(node, &omap_gate_clk_ops, &clkhwops_wait);
+}
+CLK_OF_DECLARE(ti_wait_gate_clk, "ti,wait-gate-clock",
+	       of_ti_wait_gate_clk_setup);
+
+#ifdef CONFIG_ARCH_OMAP3
+static void __init of_ti_am35xx_gate_clk_setup(struct device_node *node)
+{
+	_of_ti_gate_clk_setup(node, &omap_gate_clk_ops,
+			      &clkhwops_am35xx_ipss_module_wait);
+}
+CLK_OF_DECLARE(ti_am35xx_gate_clk, "ti,am35xx-gate-clock",
+	       of_ti_am35xx_gate_clk_setup);
+
+static void __init of_ti_dss_gate_clk_setup(struct device_node *node)
+{
+	_of_ti_gate_clk_setup(node, &omap_gate_clk_ops,
+			      &clkhwops_omap3430es2_dss_usbhost_wait);
+}
+CLK_OF_DECLARE(ti_dss_gate_clk, "ti,dss-gate-clock",
+	       of_ti_dss_gate_clk_setup);
+#endif
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 4d4ec49..e38e9e1 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -227,6 +227,8 @@ long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rate,
 void omap2_init_clk_clkdm(struct clk_hw *clk);
 unsigned long omap3_clkoutx2_recalc(struct clk_hw *hw,
 				    unsigned long parent_rate);
+int omap2_clkops_enable_clkdm(struct clk_hw *hw);
+void omap2_clkops_disable_clkdm(struct clk_hw *hw);
 int omap3_dpll4_set_rate(struct clk_hw *clk, unsigned long rate,
 			 unsigned long parent_rate);
 int omap2_dflt_clk_enable(struct clk_hw *hw);
@@ -251,5 +253,9 @@ static inline void of_ti_clk_deny_autoidle_all(void) { }
 
 extern const struct clk_hw_omap_ops clkhwops_omap3_dpll;
 extern const struct clk_hw_omap_ops clkhwops_omap4_dpllmx;
+extern const struct clk_hw_omap_ops clkhwops_wait;
+extern const struct clk_hw_omap_ops clkhwops_omap3430es2_dss_usbhost_wait;
+extern const struct clk_hw_omap_ops clkhwops_am35xx_ipss_module_wait;
+extern const struct clk_hw_omap_ops clkhwops_iclk_wait;
 
 #endif
-- 
1.7.9.5

