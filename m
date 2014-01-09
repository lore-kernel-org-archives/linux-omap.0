From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv13 03/40] CLK: TI: Add DPLL clock support
Date: Thu, 9 Jan 2014 16:00:14 +0200
Message-ID: <1389276051-1326-4-git-send-email-t-kristo@ti.com>
References: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46872 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755235AbaAIOCM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Jan 2014 09:02:12 -0500
In-Reply-To: <1389276051-1326-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

The OMAP clock driver now supports DPLL clock type. This patch also
adds support for DT DPLL nodes.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 .../devicetree/bindings/clock/ti/dpll.txt          |   75 +++
 arch/arm/mach-omap2/clock.h                        |  164 +-----
 arch/arm/mach-omap2/clock3xxx.h                    |    2 -
 drivers/clk/ti/Makefile                            |    2 +-
 drivers/clk/ti/dpll.c                              |  558 ++++++++++++++++++++
 include/linux/clk/ti.h                             |  172 ++++++
 6 files changed, 807 insertions(+), 166 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/ti/dpll.txt
 create mode 100644 drivers/clk/ti/dpll.c

diff --git a/Documentation/devicetree/bindings/clock/ti/dpll.txt b/Documentation/devicetree/bindings/clock/ti/dpll.txt
new file mode 100644
index 0000000..30bfdb7
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ti/dpll.txt
@@ -0,0 +1,75 @@
+Binding for Texas Instruments DPLL clock.
+
+Binding status: Unstable - ABI compatibility may be broken in the future
+
+This binding uses the common clock binding[1].  It assumes a
+register-mapped DPLL with usually two selectable input clocks
+(reference clock and bypass clock), with digital phase locked
+loop logic for multiplying the input clock to a desired output
+clock. This clock also typically supports different operation
+modes (locked, low power stop etc.) This binding has several
+sub-types, which effectively result in slightly different setup
+for the actual DPLL clock.
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Required properties:
+- compatible : shall be one of:
+		"ti,omap3-dpll-clock",
+		"ti,omap3-dpll-core-clock",
+		"ti,omap3-dpll-per-clock",
+		"ti,omap3-dpll-per-j-type-clock",
+		"ti,omap4-dpll-clock",
+		"ti,omap4-dpll-x2-clock",
+		"ti,omap4-dpll-core-clock",
+		"ti,omap4-dpll-m4xen-clock",
+		"ti,omap4-dpll-j-type-clock",
+		"ti,am3-dpll-no-gate-clock",
+		"ti,am3-dpll-j-type-clock",
+		"ti,am3-dpll-no-gate-j-type-clock",
+		"ti,am3-dpll-clock",
+		"ti,am3-dpll-core-clock",
+		"ti,am3-dpll-x2-clock",
+
+- #clock-cells : from common clock binding; shall be set to 0.
+- clocks : link phandles of parent clocks, first entry lists reference clock
+  and second entry bypass clock
+- reg : offsets for the register set for controlling the DPLL.
+  Registers are listed in following order:
+	"control" - contains the control register base address
+	"idlest" - contains the idle status register base address
+	"mult-div1" - contains the multiplier / divider register base address
+	"autoidle" - contains the autoidle register base address (optional)
+  ti,am3-* dpll types do not have autoidle register
+
+Optional properties:
+- DPLL mode setting - defining any one or more of the following overrides
+  default setting.
+	- ti,low-power-stop : DPLL supports low power stop mode, gating output
+	- ti,low-power-bypass : DPLL output matches rate of parent bypass clock
+	- ti,lock : DPLL locks in programmed rate
+
+Examples:
+	dpll_core_ck: dpll_core_ck@44e00490 {
+		#clock-cells = <0>;
+		compatible = "ti,omap4-dpll-core-clock";
+		clocks = <&sys_clkin_ck>, <&sys_clkin_ck>;
+		reg = <0x490>, <0x45c>, <0x488>, <0x468>;
+	};
+
+	dpll2_ck: dpll2_ck@48004004 {
+		#clock-cells = <0>;
+		compatible = "ti,omap3-dpll-clock";
+		clocks = <&sys_ck>, <&dpll2_fck>;
+		ti,low-power-stop;
+		ti,low-power-bypass;
+		ti,lock;
+		reg = <0x4>, <0x24>, <0x34>, <0x40>;
+	};
+
+	dpll_core_ck: dpll_core_ck@44e00490 {
+		#clock-cells = <0>;
+		compatible = "ti,am3-dpll-core-clock";
+		clocks = <&sys_clkin_ck>, <&sys_clkin_ck>;
+		reg = <0x90>, <0x5c>, <0x68>;
+	};
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 82916cc..b345f3e 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -21,6 +21,7 @@
 
 #include <linux/clkdev.h>
 #include <linux/clk-provider.h>
+#include <linux/clk/ti.h>
 
 struct omap_clk {
 	u16				cpu;
@@ -37,7 +38,6 @@ struct omap_clk {
 	}
 
 struct clockdomain;
-#define to_clk_hw_omap(_hw) container_of(_hw, struct clk_hw_omap, hw)
 
 #define DEFINE_STRUCT_CLK(_name, _parent_array_name, _clkops_name)	\
 	static struct clk _name = {				\
@@ -178,141 +178,6 @@ struct clksel {
 	const struct clksel_rate *rates;
 };
 
-/**
- * struct dpll_data - DPLL registers and integration data
- * @mult_div1_reg: register containing the DPLL M and N bitfields
- * @mult_mask: mask of the DPLL M bitfield in @mult_div1_reg
- * @div1_mask: mask of the DPLL N bitfield in @mult_div1_reg
- * @clk_bypass: struct clk pointer to the clock's bypass clock input
- * @clk_ref: struct clk pointer to the clock's reference clock input
- * @control_reg: register containing the DPLL mode bitfield
- * @enable_mask: mask of the DPLL mode bitfield in @control_reg
- * @last_rounded_rate: cache of the last rate result of omap2_dpll_round_rate()
- * @last_rounded_m: cache of the last M result of omap2_dpll_round_rate()
- * @last_rounded_m4xen: cache of the last M4X result of
- *			omap4_dpll_regm4xen_round_rate()
- * @last_rounded_lpmode: cache of the last lpmode result of
- *			 omap4_dpll_lpmode_recalc()
- * @max_multiplier: maximum valid non-bypass multiplier value (actual)
- * @last_rounded_n: cache of the last N result of omap2_dpll_round_rate()
- * @min_divider: minimum valid non-bypass divider value (actual)
- * @max_divider: maximum valid non-bypass divider value (actual)
- * @modes: possible values of @enable_mask
- * @autoidle_reg: register containing the DPLL autoidle mode bitfield
- * @idlest_reg: register containing the DPLL idle status bitfield
- * @autoidle_mask: mask of the DPLL autoidle mode bitfield in @autoidle_reg
- * @freqsel_mask: mask of the DPLL jitter correction bitfield in @control_reg
- * @idlest_mask: mask of the DPLL idle status bitfield in @idlest_reg
- * @lpmode_mask: mask of the DPLL low-power mode bitfield in @control_reg
- * @m4xen_mask: mask of the DPLL M4X multiplier bitfield in @control_reg
- * @auto_recal_bit: bitshift of the driftguard enable bit in @control_reg
- * @recal_en_bit: bitshift of the PRM_IRQENABLE_* bit for recalibration IRQs
- * @recal_st_bit: bitshift of the PRM_IRQSTATUS_* bit for recalibration IRQs
- * @flags: DPLL type/features (see below)
- *
- * Possible values for @flags:
- * DPLL_J_TYPE: "J-type DPLL" (only some 36xx, 4xxx DPLLs)
- *
- * @freqsel_mask is only used on the OMAP34xx family and AM35xx.
- *
- * XXX Some DPLLs have multiple bypass inputs, so it's not technically
- * correct to only have one @clk_bypass pointer.
- *
- * XXX The runtime-variable fields (@last_rounded_rate, @last_rounded_m,
- * @last_rounded_n) should be separated from the runtime-fixed fields
- * and placed into a different structure, so that the runtime-fixed data
- * can be placed into read-only space.
- */
-struct dpll_data {
-	void __iomem		*mult_div1_reg;
-	u32			mult_mask;
-	u32			div1_mask;
-	struct clk		*clk_bypass;
-	struct clk		*clk_ref;
-	void __iomem		*control_reg;
-	u32			enable_mask;
-	unsigned long		last_rounded_rate;
-	u16			last_rounded_m;
-	u8			last_rounded_m4xen;
-	u8			last_rounded_lpmode;
-	u16			max_multiplier;
-	u8			last_rounded_n;
-	u8			min_divider;
-	u16			max_divider;
-	u8			modes;
-	void __iomem		*autoidle_reg;
-	void __iomem		*idlest_reg;
-	u32			autoidle_mask;
-	u32			freqsel_mask;
-	u32			idlest_mask;
-	u32			dco_mask;
-	u32			sddiv_mask;
-	u32			lpmode_mask;
-	u32			m4xen_mask;
-	u8			auto_recal_bit;
-	u8			recal_en_bit;
-	u8			recal_st_bit;
-	u8			flags;
-};
-
-/*
- * struct clk.flags possibilities
- *
- * XXX document the rest of the clock flags here
- *
- * CLOCK_CLKOUTX2: (OMAP4 only) DPLL CLKOUT and CLKOUTX2 GATE_CTRL
- *     bits share the same register.  This flag allows the
- *     omap4_dpllmx*() code to determine which GATE_CTRL bit field
- *     should be used.  This is a temporary solution - a better approach
- *     would be to associate clock type-specific data with the clock,
- *     similar to the struct dpll_data approach.
- */
-#define ENABLE_REG_32BIT	(1 << 0)	/* Use 32-bit access */
-#define CLOCK_IDLE_CONTROL	(1 << 1)
-#define CLOCK_NO_IDLE_PARENT	(1 << 2)
-#define ENABLE_ON_INIT		(1 << 3)	/* Enable upon framework init */
-#define INVERT_ENABLE		(1 << 4)	/* 0 enables, 1 disables */
-#define CLOCK_CLKOUTX2		(1 << 5)
-
-/**
- * struct clk_hw_omap - OMAP struct clk
- * @node: list_head connecting this clock into the full clock list
- * @enable_reg: register to write to enable the clock (see @enable_bit)
- * @enable_bit: bitshift to write to enable/disable the clock (see @enable_reg)
- * @flags: see "struct clk.flags possibilities" above
- * @clksel_reg: for clksel clks, register va containing src/divisor select
- * @clksel_mask: bitmask in @clksel_reg for the src/divisor selector
- * @clksel: for clksel clks, pointer to struct clksel for this clock
- * @dpll_data: for DPLLs, pointer to struct dpll_data for this clock
- * @clkdm_name: clockdomain name that this clock is contained in
- * @clkdm: pointer to struct clockdomain, resolved from @clkdm_name at runtime
- * @rate_offset: bitshift for rate selection bitfield (OMAP1 only)
- * @src_offset: bitshift for source selection bitfield (OMAP1 only)
- *
- * XXX @rate_offset, @src_offset should probably be removed and OMAP1
- * clock code converted to use clksel.
- *
- */
-
-struct clk_hw_omap_ops;
-
-struct clk_hw_omap {
-	struct clk_hw		hw;
-	struct list_head	node;
-	unsigned long		fixed_rate;
-	u8			fixed_div;
-	void __iomem		*enable_reg;
-	u8			enable_bit;
-	u8			flags;
-	void __iomem		*clksel_reg;
-	u32			clksel_mask;
-	const struct clksel	*clksel;
-	struct dpll_data	*dpll_data;
-	const char		*clkdm_name;
-	struct clockdomain	*clkdm;
-	const struct clk_hw_omap_ops	*ops;
-};
-
 struct clk_hw_omap_ops {
 	void			(*find_idlest)(struct clk_hw_omap *oclk,
 					void __iomem **idlest_reg,
@@ -348,36 +213,13 @@ unsigned long omap_fixed_divisor_recalc(struct clk_hw *hw,
 #define OMAP4XXX_EN_DPLL_FRBYPASS		0x6
 #define OMAP4XXX_EN_DPLL_LOCKED			0x7
 
-/* CM_CLKEN_PLL*.EN* bit values - not all are available for every DPLL */
-#define DPLL_LOW_POWER_STOP	0x1
-#define DPLL_LOW_POWER_BYPASS	0x5
-#define DPLL_LOCKED		0x7
-
-/* DPLL Type and DCO Selection Flags */
-#define DPLL_J_TYPE		0x1
-
-long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rate,
-			unsigned long *parent_rate);
-unsigned long omap3_dpll_recalc(struct clk_hw *hw, unsigned long parent_rate);
-int omap3_noncore_dpll_enable(struct clk_hw *hw);
-void omap3_noncore_dpll_disable(struct clk_hw *hw);
-int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
-				unsigned long parent_rate);
 u32 omap3_dpll_autoidle_read(struct clk_hw_omap *clk);
 void omap3_dpll_allow_idle(struct clk_hw_omap *clk);
 void omap3_dpll_deny_idle(struct clk_hw_omap *clk);
-unsigned long omap3_clkoutx2_recalc(struct clk_hw *hw,
-				    unsigned long parent_rate);
 int omap4_dpllmx_gatectrl_read(struct clk_hw_omap *clk);
 void omap4_dpllmx_allow_gatectrl(struct clk_hw_omap *clk);
 void omap4_dpllmx_deny_gatectrl(struct clk_hw_omap *clk);
-unsigned long omap4_dpll_regm4xen_recalc(struct clk_hw *hw,
-				unsigned long parent_rate);
-long omap4_dpll_regm4xen_round_rate(struct clk_hw *hw,
-				    unsigned long target_rate,
-				    unsigned long *parent_rate);
 
-void omap2_init_clk_clkdm(struct clk_hw *clk);
 void __init omap2_clk_disable_clkdm_control(void);
 
 /* clkt_clksel.c public functions */
@@ -396,7 +238,6 @@ int omap2_clksel_set_parent(struct clk_hw *hw, u8 field_val);
 extern void omap2_clkt_iclk_allow_idle(struct clk_hw_omap *clk);
 extern void omap2_clkt_iclk_deny_idle(struct clk_hw_omap *clk);
 
-u8 omap2_init_dpll_parent(struct clk_hw *hw);
 unsigned long omap2_get_dpll_rate(struct clk_hw_omap *clk);
 
 int omap2_dflt_clk_enable(struct clk_hw *hw);
@@ -408,7 +249,6 @@ void omap2_clk_dflt_find_companion(struct clk_hw_omap *clk,
 void omap2_clk_dflt_find_idlest(struct clk_hw_omap *clk,
 				void __iomem **idlest_reg,
 				u8 *idlest_bit, u8 *idlest_val);
-void omap2_init_clk_hw_omap_clocks(struct clk *clk);
 int omap2_clk_enable_autoidle_all(void);
 int omap2_clk_disable_autoidle_all(void);
 int omap2_clk_allow_idle(struct clk *clk);
@@ -433,10 +273,8 @@ extern const struct clksel_rate gfx_l3_rates[];
 extern const struct clksel_rate dsp_ick_rates[];
 extern struct clk dummy_ck;
 
-extern const struct clk_hw_omap_ops clkhwops_omap3_dpll;
 extern const struct clk_hw_omap_ops clkhwops_iclk_wait;
 extern const struct clk_hw_omap_ops clkhwops_wait;
-extern const struct clk_hw_omap_ops clkhwops_omap4_dpllmx;
 extern const struct clk_hw_omap_ops clkhwops_iclk;
 extern const struct clk_hw_omap_ops clkhwops_omap3430es2_ssi_wait;
 extern const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_ssi_wait;
diff --git a/arch/arm/mach-omap2/clock3xxx.h b/arch/arm/mach-omap2/clock3xxx.h
index 8cd4b0a..dab90e2 100644
--- a/arch/arm/mach-omap2/clock3xxx.h
+++ b/arch/arm/mach-omap2/clock3xxx.h
@@ -9,8 +9,6 @@
 #define __ARCH_ARM_MACH_OMAP2_CLOCK3XXX_H
 
 int omap3xxx_clk_init(void);
-int omap3_dpll4_set_rate(struct clk_hw *clk, unsigned long rate,
-					unsigned long parent_rate);
 int omap3_core_dpll_m2_set_rate(struct clk_hw *clk, unsigned long rate,
 					unsigned long parent_rate);
 void omap3_clk_lock_dpll5(void);
diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
index 1825f7f..05af5d8 100644
--- a/drivers/clk/ti/Makefile
+++ b/drivers/clk/ti/Makefile
@@ -1,3 +1,3 @@
 ifneq ($(CONFIG_OF),)
-obj-y					+= clk.o
+obj-y					+= clk.o dpll.o
 endif
diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
new file mode 100644
index 0000000..7e498a4
--- /dev/null
+++ b/drivers/clk/ti/dpll.c
@@ -0,0 +1,558 @@
+/*
+ * OMAP DPLL clock support
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
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/clk/ti.h>
+
+#undef pr_fmt
+#define pr_fmt(fmt) "%s: " fmt, __func__
+
+#define DPLL_HAS_AUTOIDLE	0x1
+
+#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || \
+	defined(CONFIG_SOC_DRA7XX)
+static const struct clk_ops dpll_m4xen_ck_ops = {
+	.enable		= &omap3_noncore_dpll_enable,
+	.disable	= &omap3_noncore_dpll_disable,
+	.recalc_rate	= &omap4_dpll_regm4xen_recalc,
+	.round_rate	= &omap4_dpll_regm4xen_round_rate,
+	.set_rate	= &omap3_noncore_dpll_set_rate,
+	.get_parent	= &omap2_init_dpll_parent,
+};
+#endif
+
+static const struct clk_ops dpll_core_ck_ops = {
+	.recalc_rate	= &omap3_dpll_recalc,
+	.get_parent	= &omap2_init_dpll_parent,
+};
+
+#ifdef CONFIG_ARCH_OMAP3
+static const struct clk_ops omap3_dpll_core_ck_ops = {
+	.get_parent	= &omap2_init_dpll_parent,
+	.recalc_rate	= &omap3_dpll_recalc,
+	.round_rate	= &omap2_dpll_round_rate,
+};
+#endif
+
+static const struct clk_ops dpll_ck_ops = {
+	.enable		= &omap3_noncore_dpll_enable,
+	.disable	= &omap3_noncore_dpll_disable,
+	.recalc_rate	= &omap3_dpll_recalc,
+	.round_rate	= &omap2_dpll_round_rate,
+	.set_rate	= &omap3_noncore_dpll_set_rate,
+	.get_parent	= &omap2_init_dpll_parent,
+};
+
+static const struct clk_ops dpll_no_gate_ck_ops = {
+	.recalc_rate	= &omap3_dpll_recalc,
+	.get_parent	= &omap2_init_dpll_parent,
+	.round_rate	= &omap2_dpll_round_rate,
+	.set_rate	= &omap3_noncore_dpll_set_rate,
+};
+
+#ifdef CONFIG_ARCH_OMAP3
+static const struct clk_ops omap3_dpll_ck_ops = {
+	.enable		= &omap3_noncore_dpll_enable,
+	.disable	= &omap3_noncore_dpll_disable,
+	.get_parent	= &omap2_init_dpll_parent,
+	.recalc_rate	= &omap3_dpll_recalc,
+	.set_rate	= &omap3_noncore_dpll_set_rate,
+	.round_rate	= &omap2_dpll_round_rate,
+};
+
+static const struct clk_ops omap3_dpll_per_ck_ops = {
+	.enable		= &omap3_noncore_dpll_enable,
+	.disable	= &omap3_noncore_dpll_disable,
+	.get_parent	= &omap2_init_dpll_parent,
+	.recalc_rate	= &omap3_dpll_recalc,
+	.set_rate	= &omap3_dpll4_set_rate,
+	.round_rate	= &omap2_dpll_round_rate,
+};
+#endif
+
+static const struct clk_ops dpll_x2_ck_ops = {
+	.recalc_rate	= &omap3_clkoutx2_recalc,
+};
+
+/**
+ * ti_clk_register_dpll - low level registration of a DPLL clock
+ * @hw: hardware clock definition for the clock
+ * @node: device node for the clock
+ *
+ * Finalizes DPLL registration process. In case a failure (clk-ref or
+ * clk-bypass is missing), the clock is added to retry list and
+ * the initialization is retried on later stage.
+ */
+static void __init ti_clk_register_dpll(struct clk_hw *hw,
+					struct device_node *node)
+{
+	struct clk_hw_omap *clk_hw = to_clk_hw_omap(hw);
+	struct dpll_data *dd = clk_hw->dpll_data;
+	struct clk *clk;
+
+	dd->clk_ref = of_clk_get(node, 0);
+	dd->clk_bypass = of_clk_get(node, 1);
+
+	if (IS_ERR(dd->clk_ref) || IS_ERR(dd->clk_bypass)) {
+		pr_debug("clk-ref or clk-bypass missing for %s, retry later\n",
+			 node->name);
+		if (!ti_clk_retry_init(node, hw, ti_clk_register_dpll))
+			return;
+
+		goto cleanup;
+	}
+
+	/* register the clock */
+	clk = clk_register(NULL, &clk_hw->hw);
+
+	if (!IS_ERR(clk)) {
+		omap2_init_clk_hw_omap_clocks(clk);
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+		kfree(clk_hw->hw.init->parent_names);
+		kfree(clk_hw->hw.init);
+		return;
+	}
+
+cleanup:
+	kfree(clk_hw->dpll_data);
+	kfree(clk_hw->hw.init->parent_names);
+	kfree(clk_hw->hw.init);
+	kfree(clk_hw);
+}
+
+#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || \
+	defined(CONFIG_SOC_DRA7XX) || defined(CONFIG_SOC_AM33XX)
+/**
+ * ti_clk_register_dpll_x2 - Registers a DPLLx2 clock
+ * @node: device node for this clock
+ * @ops: clk_ops for this clock
+ * @hw_ops: clk_hw_ops for this clock
+ *
+ * Initializes a DPLL x 2 clock from device tree data.
+ */
+static void ti_clk_register_dpll_x2(struct device_node *node,
+				    const struct clk_ops *ops,
+				    const struct clk_hw_omap_ops *hw_ops)
+{
+	struct clk *clk;
+	struct clk_init_data init = { NULL };
+	struct clk_hw_omap *clk_hw;
+	const char *name = node->name;
+	const char *parent_name;
+
+	parent_name = of_clk_get_parent_name(node, 0);
+	if (!parent_name) {
+		pr_err("%s must have parent\n", node->name);
+		return;
+	}
+
+	clk_hw = kzalloc(sizeof(*clk_hw), GFP_KERNEL);
+	if (!clk_hw)
+		return;
+
+	clk_hw->ops = hw_ops;
+	clk_hw->hw.init = &init;
+
+	init.name = name;
+	init.ops = ops;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+
+	/* register the clock */
+	clk = clk_register(NULL, &clk_hw->hw);
+
+	if (IS_ERR(clk)) {
+		kfree(clk_hw);
+	} else {
+		omap2_init_clk_hw_omap_clocks(clk);
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	}
+}
+#endif
+
+/**
+ * of_ti_dpll_setup - Setup function for OMAP DPLL clocks
+ * @node: device node containing the DPLL info
+ * @ops: ops for the DPLL
+ * @ddt: DPLL data template to use
+ * @init_flags: flags for controlling init types
+ *
+ * Initializes a DPLL clock from device tree data.
+ */
+static void __init of_ti_dpll_setup(struct device_node *node,
+				    const struct clk_ops *ops,
+				    const struct dpll_data *ddt,
+				    u8 init_flags)
+{
+	struct clk_hw_omap *clk_hw = NULL;
+	struct clk_init_data *init = NULL;
+	const char **parent_names = NULL;
+	struct dpll_data *dd = NULL;
+	int i;
+	u8 dpll_mode = 0;
+
+	dd = kzalloc(sizeof(*dd), GFP_KERNEL);
+	clk_hw = kzalloc(sizeof(*clk_hw), GFP_KERNEL);
+	init = kzalloc(sizeof(*init), GFP_KERNEL);
+	if (!dd || !clk_hw || !init)
+		goto cleanup;
+
+	memcpy(dd, ddt, sizeof(*dd));
+
+	clk_hw->dpll_data = dd;
+	clk_hw->ops = &clkhwops_omap3_dpll;
+	clk_hw->hw.init = init;
+	clk_hw->flags = MEMMAP_ADDRESSING;
+
+	init->name = node->name;
+	init->ops = ops;
+
+	init->num_parents = of_clk_get_parent_count(node);
+	if (init->num_parents < 1) {
+		pr_err("%s must have parent(s)\n", node->name);
+		goto cleanup;
+	}
+
+	parent_names = kzalloc(sizeof(char *) * init->num_parents, GFP_KERNEL);
+	if (!parent_names)
+		goto cleanup;
+
+	for (i = 0; i < init->num_parents; i++)
+		parent_names[i] = of_clk_get_parent_name(node, i);
+
+	init->parent_names = parent_names;
+
+	dd->control_reg = ti_clk_get_reg_addr(node, 0);
+	dd->idlest_reg = ti_clk_get_reg_addr(node, 1);
+	dd->mult_div1_reg = ti_clk_get_reg_addr(node, 2);
+
+	if (!dd->control_reg || !dd->idlest_reg || !dd->mult_div1_reg)
+		goto cleanup;
+
+	if (init_flags & DPLL_HAS_AUTOIDLE) {
+		dd->autoidle_reg = ti_clk_get_reg_addr(node, 3);
+		if (!dd->autoidle_reg)
+			goto cleanup;
+	}
+
+	if (of_property_read_bool(node, "ti,low-power-stop"))
+		dpll_mode |= 1 << DPLL_LOW_POWER_STOP;
+
+	if (of_property_read_bool(node, "ti,low-power-bypass"))
+		dpll_mode |= 1 << DPLL_LOW_POWER_BYPASS;
+
+	if (of_property_read_bool(node, "ti,lock"))
+		dpll_mode |= 1 << DPLL_LOCKED;
+
+	if (dpll_mode)
+		dd->modes = dpll_mode;
+
+	ti_clk_register_dpll(&clk_hw->hw, node);
+	return;
+
+cleanup:
+	kfree(dd);
+	kfree(parent_names);
+	kfree(init);
+	kfree(clk_hw);
+}
+
+#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || \
+	defined(CONFIG_SOC_DRA7XX)
+static void __init of_ti_omap4_dpll_x2_setup(struct device_node *node)
+{
+	ti_clk_register_dpll_x2(node, &dpll_x2_ck_ops, &clkhwops_omap4_dpllmx);
+}
+CLK_OF_DECLARE(ti_omap4_dpll_x2_clock, "ti,omap4-dpll-x2-clock",
+	       of_ti_omap4_dpll_x2_setup);
+#endif
+
+#ifdef CONFIG_SOC_AM33XX
+static void __init of_ti_am3_dpll_x2_setup(struct device_node *node)
+{
+	ti_clk_register_dpll_x2(node, &dpll_x2_ck_ops, NULL);
+}
+CLK_OF_DECLARE(ti_am3_dpll_x2_clock, "ti,am3-dpll-x2-clock",
+	       of_ti_am3_dpll_x2_setup);
+#endif
+
+#ifdef CONFIG_ARCH_OMAP3
+static void __init of_ti_omap3_dpll_setup(struct device_node *node)
+{
+	const struct dpll_data dd = {
+		.idlest_mask = 0x1,
+		.enable_mask = 0x7,
+		.autoidle_mask = 0x7,
+		.mult_mask = 0x7ff << 8,
+		.div1_mask = 0x7f,
+		.max_multiplier = 2047,
+		.max_divider = 128,
+		.min_divider = 1,
+		.freqsel_mask = 0xf0,
+		.modes = (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
+	};
+
+	of_ti_dpll_setup(node, &omap3_dpll_ck_ops, &dd, DPLL_HAS_AUTOIDLE);
+}
+CLK_OF_DECLARE(ti_omap3_dpll_clock, "ti,omap3-dpll-clock",
+	       of_ti_omap3_dpll_setup);
+
+static void __init of_ti_omap3_core_dpll_setup(struct device_node *node)
+{
+	const struct dpll_data dd = {
+		.idlest_mask = 0x1,
+		.enable_mask = 0x7,
+		.autoidle_mask = 0x7,
+		.mult_mask = 0x7ff << 16,
+		.div1_mask = 0x7f << 8,
+		.max_multiplier = 2047,
+		.max_divider = 128,
+		.min_divider = 1,
+		.freqsel_mask = 0xf0,
+	};
+
+	of_ti_dpll_setup(node, &omap3_dpll_core_ck_ops, &dd, DPLL_HAS_AUTOIDLE);
+}
+CLK_OF_DECLARE(ti_omap3_core_dpll_clock, "ti,omap3-dpll-core-clock",
+	       of_ti_omap3_core_dpll_setup);
+
+static void __init of_ti_omap3_per_dpll_setup(struct device_node *node)
+{
+	const struct dpll_data dd = {
+		.idlest_mask = 0x1 << 1,
+		.enable_mask = 0x7 << 16,
+		.autoidle_mask = 0x7 << 3,
+		.mult_mask = 0x7ff << 8,
+		.div1_mask = 0x7f,
+		.max_multiplier = 2047,
+		.max_divider = 128,
+		.min_divider = 1,
+		.freqsel_mask = 0xf00000,
+		.modes = (1 << DPLL_LOW_POWER_STOP) | (1 << DPLL_LOCKED),
+	};
+
+	of_ti_dpll_setup(node, &omap3_dpll_per_ck_ops, &dd, DPLL_HAS_AUTOIDLE);
+}
+CLK_OF_DECLARE(ti_omap3_per_dpll_clock, "ti,omap3-dpll-per-clock",
+	       of_ti_omap3_per_dpll_setup);
+
+static void __init of_ti_omap3_per_jtype_dpll_setup(struct device_node *node)
+{
+	const struct dpll_data dd = {
+		.idlest_mask = 0x1 << 1,
+		.enable_mask = 0x7 << 16,
+		.autoidle_mask = 0x7 << 3,
+		.mult_mask = 0xfff << 8,
+		.div1_mask = 0x7f,
+		.max_multiplier = 4095,
+		.max_divider = 128,
+		.min_divider = 1,
+		.sddiv_mask = 0xff << 24,
+		.dco_mask = 0xe << 20,
+		.flags = DPLL_J_TYPE,
+		.modes = (1 << DPLL_LOW_POWER_STOP) | (1 << DPLL_LOCKED),
+	};
+
+	of_ti_dpll_setup(node, &omap3_dpll_per_ck_ops, &dd, DPLL_HAS_AUTOIDLE);
+}
+CLK_OF_DECLARE(ti_omap3_per_jtype_dpll_clock, "ti,omap3-dpll-per-j-type-clock",
+	       of_ti_omap3_per_jtype_dpll_setup);
+#endif
+
+static void __init of_ti_omap4_dpll_setup(struct device_node *node)
+{
+	const struct dpll_data dd = {
+		.idlest_mask = 0x1,
+		.enable_mask = 0x7,
+		.autoidle_mask = 0x7,
+		.mult_mask = 0x7ff << 8,
+		.div1_mask = 0x7f,
+		.max_multiplier = 2047,
+		.max_divider = 128,
+		.min_divider = 1,
+		.modes = (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
+	};
+
+	of_ti_dpll_setup(node, &dpll_ck_ops, &dd, DPLL_HAS_AUTOIDLE);
+}
+CLK_OF_DECLARE(ti_omap4_dpll_clock, "ti,omap4-dpll-clock",
+	       of_ti_omap4_dpll_setup);
+
+static void __init of_ti_omap4_core_dpll_setup(struct device_node *node)
+{
+	const struct dpll_data dd = {
+		.idlest_mask = 0x1,
+		.enable_mask = 0x7,
+		.autoidle_mask = 0x7,
+		.mult_mask = 0x7ff << 8,
+		.div1_mask = 0x7f,
+		.max_multiplier = 2047,
+		.max_divider = 128,
+		.min_divider = 1,
+		.modes = (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
+	};
+
+	of_ti_dpll_setup(node, &dpll_core_ck_ops, &dd, DPLL_HAS_AUTOIDLE);
+}
+CLK_OF_DECLARE(ti_omap4_core_dpll_clock, "ti,omap4-dpll-core-clock",
+	       of_ti_omap4_core_dpll_setup);
+
+#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || \
+	defined(CONFIG_SOC_DRA7XX)
+static void __init of_ti_omap4_m4xen_dpll_setup(struct device_node *node)
+{
+	const struct dpll_data dd = {
+		.idlest_mask = 0x1,
+		.enable_mask = 0x7,
+		.autoidle_mask = 0x7,
+		.mult_mask = 0x7ff << 8,
+		.div1_mask = 0x7f,
+		.max_multiplier = 2047,
+		.max_divider = 128,
+		.min_divider = 1,
+		.m4xen_mask = 0x800,
+		.lpmode_mask = 1 << 10,
+		.modes = (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
+	};
+
+	of_ti_dpll_setup(node, &dpll_m4xen_ck_ops, &dd, DPLL_HAS_AUTOIDLE);
+}
+CLK_OF_DECLARE(ti_omap4_m4xen_dpll_clock, "ti,omap4-dpll-m4xen-clock",
+	       of_ti_omap4_m4xen_dpll_setup);
+
+static void __init of_ti_omap4_jtype_dpll_setup(struct device_node *node)
+{
+	const struct dpll_data dd = {
+		.idlest_mask = 0x1,
+		.enable_mask = 0x7,
+		.autoidle_mask = 0x7,
+		.mult_mask = 0xfff << 8,
+		.div1_mask = 0xff,
+		.max_multiplier = 4095,
+		.max_divider = 256,
+		.min_divider = 1,
+		.sddiv_mask = 0xff << 24,
+		.flags = DPLL_J_TYPE,
+		.modes = (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
+	};
+
+	of_ti_dpll_setup(node, &dpll_m4xen_ck_ops, &dd, DPLL_HAS_AUTOIDLE);
+}
+CLK_OF_DECLARE(ti_omap4_jtype_dpll_clock, "ti,omap4-dpll-j-type-clock",
+	       of_ti_omap4_jtype_dpll_setup);
+#endif
+
+static void __init of_ti_am3_no_gate_dpll_setup(struct device_node *node)
+{
+	const struct dpll_data dd = {
+		.idlest_mask = 0x1,
+		.enable_mask = 0x7,
+		.autoidle_mask = 0x7,
+		.mult_mask = 0x7ff << 8,
+		.div1_mask = 0x7f,
+		.max_multiplier = 2047,
+		.max_divider = 128,
+		.min_divider = 1,
+		.modes = (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
+	};
+
+	of_ti_dpll_setup(node, &dpll_no_gate_ck_ops, &dd, 0);
+}
+CLK_OF_DECLARE(ti_am3_no_gate_dpll_clock, "ti,am3-dpll-no-gate-clock",
+	       of_ti_am3_no_gate_dpll_setup);
+
+static void __init of_ti_am3_jtype_dpll_setup(struct device_node *node)
+{
+	const struct dpll_data dd = {
+		.idlest_mask = 0x1,
+		.enable_mask = 0x7,
+		.autoidle_mask = 0x7,
+		.mult_mask = 0x7ff << 8,
+		.div1_mask = 0x7f,
+		.max_multiplier = 4095,
+		.max_divider = 256,
+		.min_divider = 2,
+		.flags = DPLL_J_TYPE,
+		.modes = (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
+	};
+
+	of_ti_dpll_setup(node, &dpll_ck_ops, &dd, 0);
+}
+CLK_OF_DECLARE(ti_am3_jtype_dpll_clock, "ti,am3-dpll-j-type-clock",
+	       of_ti_am3_jtype_dpll_setup);
+
+static void __init of_ti_am3_no_gate_jtype_dpll_setup(struct device_node *node)
+{
+	const struct dpll_data dd = {
+		.idlest_mask = 0x1,
+		.enable_mask = 0x7,
+		.autoidle_mask = 0x7,
+		.mult_mask = 0x7ff << 8,
+		.div1_mask = 0x7f,
+		.max_multiplier = 2047,
+		.max_divider = 128,
+		.min_divider = 1,
+		.flags = DPLL_J_TYPE,
+		.modes = (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
+	};
+
+	of_ti_dpll_setup(node, &dpll_no_gate_ck_ops, &dd, 0);
+}
+CLK_OF_DECLARE(ti_am3_no_gate_jtype_dpll_clock,
+	       "ti,am3-dpll-no-gate-j-type-clock",
+	       of_ti_am3_no_gate_jtype_dpll_setup);
+
+static void __init of_ti_am3_dpll_setup(struct device_node *node)
+{
+	const struct dpll_data dd = {
+		.idlest_mask = 0x1,
+		.enable_mask = 0x7,
+		.autoidle_mask = 0x7,
+		.mult_mask = 0x7ff << 8,
+		.div1_mask = 0x7f,
+		.max_multiplier = 2047,
+		.max_divider = 128,
+		.min_divider = 1,
+		.modes = (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
+	};
+
+	of_ti_dpll_setup(node, &dpll_ck_ops, &dd, 0);
+}
+CLK_OF_DECLARE(ti_am3_dpll_clock, "ti,am3-dpll-clock", of_ti_am3_dpll_setup);
+
+static void __init of_ti_am3_core_dpll_setup(struct device_node *node)
+{
+	const struct dpll_data dd = {
+		.idlest_mask = 0x1,
+		.enable_mask = 0x7,
+		.autoidle_mask = 0x7,
+		.mult_mask = 0x7ff << 8,
+		.div1_mask = 0x7f,
+		.max_multiplier = 2047,
+		.max_divider = 128,
+		.min_divider = 1,
+		.modes = (1 << DPLL_LOW_POWER_BYPASS) | (1 << DPLL_LOCKED),
+	};
+
+	of_ti_dpll_setup(node, &dpll_core_ck_ops, &dd, 0);
+}
+CLK_OF_DECLARE(ti_am3_core_dpll_clock, "ti,am3-dpll-core-clock",
+	       of_ti_am3_core_dpll_setup);
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index c6eded5..3f9de39 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -18,6 +18,153 @@
 #include <linux/clkdev.h>
 
 /**
+ * struct dpll_data - DPLL registers and integration data
+ * @mult_div1_reg: register containing the DPLL M and N bitfields
+ * @mult_mask: mask of the DPLL M bitfield in @mult_div1_reg
+ * @div1_mask: mask of the DPLL N bitfield in @mult_div1_reg
+ * @clk_bypass: struct clk pointer to the clock's bypass clock input
+ * @clk_ref: struct clk pointer to the clock's reference clock input
+ * @control_reg: register containing the DPLL mode bitfield
+ * @enable_mask: mask of the DPLL mode bitfield in @control_reg
+ * @last_rounded_rate: cache of the last rate result of omap2_dpll_round_rate()
+ * @last_rounded_m: cache of the last M result of omap2_dpll_round_rate()
+ * @last_rounded_m4xen: cache of the last M4X result of
+ *			omap4_dpll_regm4xen_round_rate()
+ * @last_rounded_lpmode: cache of the last lpmode result of
+ *			 omap4_dpll_lpmode_recalc()
+ * @max_multiplier: maximum valid non-bypass multiplier value (actual)
+ * @last_rounded_n: cache of the last N result of omap2_dpll_round_rate()
+ * @min_divider: minimum valid non-bypass divider value (actual)
+ * @max_divider: maximum valid non-bypass divider value (actual)
+ * @modes: possible values of @enable_mask
+ * @autoidle_reg: register containing the DPLL autoidle mode bitfield
+ * @idlest_reg: register containing the DPLL idle status bitfield
+ * @autoidle_mask: mask of the DPLL autoidle mode bitfield in @autoidle_reg
+ * @freqsel_mask: mask of the DPLL jitter correction bitfield in @control_reg
+ * @idlest_mask: mask of the DPLL idle status bitfield in @idlest_reg
+ * @lpmode_mask: mask of the DPLL low-power mode bitfield in @control_reg
+ * @m4xen_mask: mask of the DPLL M4X multiplier bitfield in @control_reg
+ * @auto_recal_bit: bitshift of the driftguard enable bit in @control_reg
+ * @recal_en_bit: bitshift of the PRM_IRQENABLE_* bit for recalibration IRQs
+ * @recal_st_bit: bitshift of the PRM_IRQSTATUS_* bit for recalibration IRQs
+ * @flags: DPLL type/features (see below)
+ *
+ * Possible values for @flags:
+ * DPLL_J_TYPE: "J-type DPLL" (only some 36xx, 4xxx DPLLs)
+ *
+ * @freqsel_mask is only used on the OMAP34xx family and AM35xx.
+ *
+ * XXX Some DPLLs have multiple bypass inputs, so it's not technically
+ * correct to only have one @clk_bypass pointer.
+ *
+ * XXX The runtime-variable fields (@last_rounded_rate, @last_rounded_m,
+ * @last_rounded_n) should be separated from the runtime-fixed fields
+ * and placed into a different structure, so that the runtime-fixed data
+ * can be placed into read-only space.
+ */
+struct dpll_data {
+	void __iomem		*mult_div1_reg;
+	u32			mult_mask;
+	u32			div1_mask;
+	struct clk		*clk_bypass;
+	struct clk		*clk_ref;
+	void __iomem		*control_reg;
+	u32			enable_mask;
+	unsigned long		last_rounded_rate;
+	u16			last_rounded_m;
+	u8			last_rounded_m4xen;
+	u8			last_rounded_lpmode;
+	u16			max_multiplier;
+	u8			last_rounded_n;
+	u8			min_divider;
+	u16			max_divider;
+	u8			modes;
+	void __iomem		*autoidle_reg;
+	void __iomem		*idlest_reg;
+	u32			autoidle_mask;
+	u32			freqsel_mask;
+	u32			idlest_mask;
+	u32			dco_mask;
+	u32			sddiv_mask;
+	u32			lpmode_mask;
+	u32			m4xen_mask;
+	u8			auto_recal_bit;
+	u8			recal_en_bit;
+	u8			recal_st_bit;
+	u8			flags;
+};
+
+struct clk_hw_omap_ops;
+
+/**
+ * struct clk_hw_omap - OMAP struct clk
+ * @node: list_head connecting this clock into the full clock list
+ * @enable_reg: register to write to enable the clock (see @enable_bit)
+ * @enable_bit: bitshift to write to enable/disable the clock (see @enable_reg)
+ * @flags: see "struct clk.flags possibilities" above
+ * @clksel_reg: for clksel clks, register va containing src/divisor select
+ * @clksel_mask: bitmask in @clksel_reg for the src/divisor selector
+ * @clksel: for clksel clks, pointer to struct clksel for this clock
+ * @dpll_data: for DPLLs, pointer to struct dpll_data for this clock
+ * @clkdm_name: clockdomain name that this clock is contained in
+ * @clkdm: pointer to struct clockdomain, resolved from @clkdm_name at runtime
+ * @ops: clock ops for this clock
+ */
+struct clk_hw_omap {
+	struct clk_hw		hw;
+	struct list_head	node;
+	unsigned long		fixed_rate;
+	u8			fixed_div;
+	void __iomem		*enable_reg;
+	u8			enable_bit;
+	u8			flags;
+	void __iomem		*clksel_reg;
+	u32			clksel_mask;
+	const struct clksel	*clksel;
+	struct dpll_data	*dpll_data;
+	const char		*clkdm_name;
+	struct clockdomain	*clkdm;
+	const struct clk_hw_omap_ops	*ops;
+};
+
+/*
+ * struct clk_hw_omap.flags possibilities
+ *
+ * XXX document the rest of the clock flags here
+ *
+ * ENABLE_REG_32BIT: (OMAP1 only) clock control register must be accessed
+ *     with 32bit ops, by default OMAP1 uses 16bit ops.
+ * CLOCK_IDLE_CONTROL: (OMAP1 only) clock has autoidle support.
+ * CLOCK_NO_IDLE_PARENT: (OMAP1 only) when clock is enabled, its parent
+ *     clock is put to no-idle mode.
+ * ENABLE_ON_INIT: Clock is enabled on init.
+ * INVERT_ENABLE: By default, clock enable bit behavior is '1' enable, '0'
+ *     disable. This inverts the behavior making '0' enable and '1' disable.
+ * CLOCK_CLKOUTX2: (OMAP4 only) DPLL CLKOUT and CLKOUTX2 GATE_CTRL
+ *     bits share the same register.  This flag allows the
+ *     omap4_dpllmx*() code to determine which GATE_CTRL bit field
+ *     should be used.  This is a temporary solution - a better approach
+ *     would be to associate clock type-specific data with the clock,
+ *     similar to the struct dpll_data approach.
+ * MEMMAP_ADDRESSING: Use memmap addressing to access clock registers.
+ */
+#define ENABLE_REG_32BIT	(1 << 0)	/* Use 32-bit access */
+#define CLOCK_IDLE_CONTROL	(1 << 1)
+#define CLOCK_NO_IDLE_PARENT	(1 << 2)
+#define ENABLE_ON_INIT		(1 << 3)	/* Enable upon framework init */
+#define INVERT_ENABLE		(1 << 4)	/* 0 enables, 1 disables */
+#define CLOCK_CLKOUTX2		(1 << 5)
+#define MEMMAP_ADDRESSING	(1 << 6)
+
+/* CM_CLKEN_PLL*.EN* bit values - not all are available for every DPLL */
+#define DPLL_LOW_POWER_STOP	0x1
+#define DPLL_LOW_POWER_BYPASS	0x5
+#define DPLL_LOCKED		0x7
+
+/* DPLL Type and DCO Selection Flags */
+#define DPLL_J_TYPE		0x1
+
+/**
  * struct ti_dt_clk - OMAP DT clock alias declarations
  * @lk: clock lookup definition
  * @node_name: clock DT node to map to
@@ -68,10 +215,35 @@ struct ti_clk_ll_ops {
 
 extern struct ti_clk_ll_ops *ti_clk_ll_ops;
 
+#define to_clk_hw_omap(_hw) container_of(_hw, struct clk_hw_omap, hw)
+
+void omap2_init_clk_hw_omap_clocks(struct clk *clk);
+int omap3_noncore_dpll_enable(struct clk_hw *hw);
+void omap3_noncore_dpll_disable(struct clk_hw *hw);
+int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long parent_rate);
+unsigned long omap4_dpll_regm4xen_recalc(struct clk_hw *hw,
+					 unsigned long parent_rate);
+long omap4_dpll_regm4xen_round_rate(struct clk_hw *hw,
+				    unsigned long target_rate,
+				    unsigned long *parent_rate);
+u8 omap2_init_dpll_parent(struct clk_hw *hw);
+unsigned long omap3_dpll_recalc(struct clk_hw *hw, unsigned long parent_rate);
+long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rate,
+			   unsigned long *parent_rate);
+void omap2_init_clk_clkdm(struct clk_hw *clk);
+unsigned long omap3_clkoutx2_recalc(struct clk_hw *hw,
+				    unsigned long parent_rate);
+int omap3_dpll4_set_rate(struct clk_hw *clk, unsigned long rate,
+			 unsigned long parent_rate);
+
 void __iomem *ti_clk_get_reg_addr(struct device_node *node, int index);
 void ti_dt_clocks_register(struct ti_dt_clk *oclks);
 void ti_dt_clk_init_provider(struct device_node *np, int index);
 int ti_clk_retry_init(struct device_node *node, struct clk_hw *hw,
 		      ti_of_clk_init_cb_t func);
 
+extern const struct clk_hw_omap_ops clkhwops_omap3_dpll;
+extern const struct clk_hw_omap_ops clkhwops_omap4_dpllmx;
+
 #endif
-- 
1.7.9.5

