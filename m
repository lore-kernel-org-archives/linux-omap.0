From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv9 04/43] CLK: TI: Add DPLL clock support
Date: Fri, 25 Oct 2013 18:56:58 +0300
Message-ID: <1382716658-6964-5-git-send-email-t-kristo@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40948 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754083Ab3JYP66 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Oct 2013 11:58:58 -0400
In-Reply-To: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, bcousson@baylibre.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

The OMAP clock driver now supports DPLL clock type. This patch also
adds support for DT DPLL nodes.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 .../devicetree/bindings/clock/ti/dpll.txt          |   81 +++
 arch/arm/mach-omap2/clock.h                        |  144 +----
 arch/arm/mach-omap2/clock3xxx.h                    |    2 -
 drivers/clk/Makefile                               |    1 +
 drivers/clk/ti/Makefile                            |    3 +
 drivers/clk/ti/dpll.c                              |  632 ++++++++++++++++++++
 include/linux/clk/ti.h                             |  161 +++++
 7 files changed, 879 insertions(+), 145 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/ti/dpll.txt
 create mode 100644 drivers/clk/ti/Makefile
 create mode 100644 drivers/clk/ti/dpll.c
 create mode 100644 include/linux/clk/ti.h

diff --git a/Documentation/devicetree/bindings/clock/ti/dpll.txt b/Documentation/devicetree/bindings/clock/ti/dpll.txt
new file mode 100644
index 0000000..7b87721
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/ti/dpll.txt
@@ -0,0 +1,81 @@
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
+	"autoidle" - contains the autoidle register base address
+	"mult-div1" - contains the multiplier / divider register base address
+  ti,am3-* dpll types list the registers in the same order, except "autoidle"
+  register is left out as this hardware does not have it, e.g.:
+	reg = <0x40>, <0x50>, <0x60>;
+  results in following register map:
+	base + 0x40 - control
+	base + 0x50 - idlest
+	base + 0x60 - mult-div1
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
index 7aa32cd..079536a 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -21,6 +21,7 @@
 
 #include <linux/clkdev.h>
 #include <linux/clk-provider.h>
+#include <linux/clk/ti.h>
 
 struct omap_clk {
 	u16				cpu;
@@ -178,83 +179,6 @@ struct clksel {
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
 /*
  * struct clk.flags possibilities
  *
@@ -274,45 +198,6 @@ struct dpll_data {
 #define INVERT_ENABLE		(1 << 4)	/* 0 enables, 1 disables */
 #define CLOCK_CLKOUTX2		(1 << 5)
 
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
@@ -348,36 +233,13 @@ unsigned long omap_fixed_divisor_recalc(struct clk_hw *hw,
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
@@ -396,7 +258,6 @@ int omap2_clksel_set_parent(struct clk_hw *hw, u8 field_val);
 extern void omap2_clkt_iclk_allow_idle(struct clk_hw_omap *clk);
 extern void omap2_clkt_iclk_deny_idle(struct clk_hw_omap *clk);
 
-u8 omap2_init_dpll_parent(struct clk_hw *hw);
 unsigned long omap2_get_dpll_rate(struct clk_hw_omap *clk);
 
 int omap2_dflt_clk_enable(struct clk_hw *hw);
@@ -408,7 +269,6 @@ void omap2_clk_dflt_find_companion(struct clk_hw_omap *clk,
 void omap2_clk_dflt_find_idlest(struct clk_hw_omap *clk,
 				void __iomem **idlest_reg,
 				u8 *idlest_bit, u8 *idlest_val);
-void omap2_init_clk_hw_omap_clocks(struct clk *clk);
 int omap2_clk_enable_autoidle_all(void);
 int omap2_clk_disable_autoidle_all(void);
 void omap2_clk_enable_init_clocks(const char **clk_names, u8 num_clocks);
@@ -431,10 +291,8 @@ extern const struct clksel_rate gfx_l3_rates[];
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
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 7b11106..981e14ac 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -32,6 +32,7 @@ obj-$(CONFIG_ARCH_VT8500)	+= clk-vt8500.o
 obj-$(CONFIG_ARCH_ZYNQ)		+= zynq/
 obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
 obj-$(CONFIG_PLAT_SAMSUNG)	+= samsung/
+obj-$(CONFIG_ARCH_OMAP)		+= ti/
 
 obj-$(CONFIG_X86)		+= x86/
 
diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
new file mode 100644
index 0000000..93177987
--- /dev/null
+++ b/drivers/clk/ti/Makefile
@@ -0,0 +1,3 @@
+ifneq ($(CONFIG_OF),)
+obj-y					+= dpll.o
+endif
diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
new file mode 100644
index 0000000..89733c9
--- /dev/null
+++ b/drivers/clk/ti/dpll.c
@@ -0,0 +1,632 @@
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
+ * ti_clk_register_dpll() - Registers the DPLL clock
+ * @name:	Name of the clock node
+ * @parent_names: list of parent names
+ * @num_parents: num of parents in parent_names
+ * @flags:	init flags
+ * @dpll_data:	DPLL data
+ * @ops:	ops for DPLL
+ */
+static struct clk *ti_clk_register_dpll(const char *name,
+					const char **parent_names,
+					int num_parents, unsigned long flags,
+					struct dpll_data *dpll_data,
+					const struct clk_ops *ops,
+					struct regmap *regmap)
+{
+	struct clk *clk;
+	struct clk_init_data init = { NULL };
+	struct clk_hw_omap *clk_hw;
+
+	/* allocate the divider */
+	clk_hw = kzalloc(sizeof(*clk_hw), GFP_KERNEL);
+	if (!clk_hw) {
+		pr_err("%s: could not allocate clk_hw_omap\n", __func__);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	clk_hw->dpll_data = dpll_data;
+	clk_hw->ops = &clkhwops_omap3_dpll;
+	clk_hw->hw.init = &init;
+	clk_hw->regmap = regmap;
+
+	init.name = name;
+	init.ops = ops;
+	init.flags = flags;
+	init.parent_names = parent_names;
+	init.num_parents = num_parents;
+
+	/* register the clock */
+	clk = clk_register(NULL, &clk_hw->hw);
+
+	if (IS_ERR(clk)) {
+		pr_err("%s: failed clk_register for %s (%ld)\n", __func__, name,
+		       PTR_ERR(clk));
+		kfree(clk_hw);
+	} else {
+		omap2_init_clk_hw_omap_clocks(clk);
+	}
+
+	return clk;
+}
+
+#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || \
+	defined(CONFIG_SOC_DRA7XX) || defined(CONFIG_SOC_AM33XX)
+/**
+ * ti_clk_register_dpll_x2() -  Registers the DPLLx2 clock
+ * @dev:	device pointer (if any)
+ * @name:	Name of the clock node
+ * @parent_name: parent name (only 1 parent)
+ * @reg:	register address for DPLL
+ * @ops:	ops for DPLL
+ */
+static struct clk *ti_clk_register_dpll_x2(struct device_node *node,
+					   const struct clk_ops *ops,
+					   const struct clk_hw_omap_ops *hw_ops,
+					   struct regmap *regmap)
+{
+	struct clk *clk;
+	struct clk_init_data init = { NULL };
+	struct clk_hw_omap *clk_hw;
+	const char *name = node->name;
+	const char *parent_name;
+
+	of_property_read_string(node, "clock-output-names", &name);
+
+	parent_name = of_clk_get_parent_name(node, 0);
+	if (!parent_name) {
+		pr_err("%s: dpll_x2 must have parent\n", __func__);
+		return ERR_PTR(-EINVAL);
+	}
+
+	clk_hw = kzalloc(sizeof(*clk_hw), GFP_KERNEL);
+	if (!clk_hw) {
+		pr_err("%s: could not allocate clk_hw_omap\n", __func__);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	clk_hw->ops = hw_ops;
+	of_property_read_u32(node, "reg", (u32 *)&clk_hw->clksel_reg);
+	clk_hw->regmap = regmap;
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
+	if (IS_ERR(clk))
+		kfree(clk_hw);
+	else
+		omap2_init_clk_hw_omap_clocks(clk);
+
+	return clk;
+}
+#endif
+
+/**
+ * of_ti_dpll_setup() - Setup function for OMAP DPLL clocks
+ *
+ * @node: device node containing the DPLL info
+ * @ops: ops for the DPLL
+ * @ddt: DPLL data template to use
+ * @init_flags: flags for controlling init types
+ */
+static int __init of_ti_dpll_setup(struct device_node *node,
+				    const struct clk_ops *ops,
+				    const struct dpll_data *ddt,
+				    u8 init_flags, struct regmap *regmap)
+{
+	struct clk *clk;
+	const char *clk_name = node->name;
+	int num_parents;
+	const char **parent_names = NULL;
+	u8 dpll_flags = 0;
+	struct dpll_data *dd;
+	int i;
+	u8 dpll_mode = 0;
+	int ret = 0;
+
+	dd = kzalloc(sizeof(*dd), GFP_KERNEL);
+	if (!dd) {
+		pr_err("%s: could not allocate dpll_data\n", __func__);
+		return -ENOMEM;
+	}
+
+	memcpy(dd, ddt, sizeof(*dd));
+
+	of_property_read_string(node, "clock-output-names", &clk_name);
+
+	num_parents = of_clk_get_parent_count(node);
+	if (num_parents < 1) {
+		pr_err("%s: omap dpll %s must have parent(s)\n",
+		       __func__, node->name);
+		ret = -EINVAL;
+		goto cleanup;
+	}
+
+	parent_names = kzalloc(sizeof(char *) * num_parents, GFP_KERNEL);
+
+	for (i = 0; i < num_parents; i++)
+		parent_names[i] = of_clk_get_parent_name(node, i);
+
+	dd->clk_ref = of_clk_get(node, 0);
+	dd->clk_bypass = of_clk_get(node, 1);
+
+	if (IS_ERR(dd->clk_ref)) {
+		pr_debug("%s: ti,clk-ref for %s not found\n", __func__,
+			 clk_name);
+		ret = -EAGAIN;
+		goto cleanup;
+	}
+
+	if (IS_ERR(dd->clk_bypass)) {
+		pr_debug("%s: ti,clk-bypass for %s not found\n", __func__,
+			 clk_name);
+		ret = -EAGAIN;
+		goto cleanup;
+	}
+
+	if (init_flags & DPLL_HAS_AUTOIDLE) {
+		of_property_read_u32_index(node, "reg", 0,
+					   (u32 *)&dd->control_reg);
+		of_property_read_u32_index(node, "reg", 1,
+					   (u32 *)&dd->idlest_reg);
+		of_property_read_u32_index(node, "reg", 2,
+					   (u32 *)&dd->autoidle_reg);
+		of_property_read_u32_index(node, "reg", 3,
+					   (u32 *)&dd->mult_div1_reg);
+	} else {
+		of_property_read_u32_index(node, "reg", 0,
+					   (u32 *)&dd->control_reg);
+		of_property_read_u32_index(node, "reg", 1,
+					   (u32 *)&dd->idlest_reg);
+		of_property_read_u32_index(node, "reg", 2,
+					   (u32 *)&dd->mult_div1_reg);
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
+	clk = ti_clk_register_dpll(clk_name, parent_names, num_parents,
+				   dpll_flags, dd, ops, regmap);
+
+	if (!IS_ERR(clk)) {
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+		return 0;
+	}
+
+	return PTR_ERR(clk);
+
+cleanup:
+	kfree(dd);
+	kfree(parent_names);
+	return ret;
+}
+
+#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || \
+	defined(CONFIG_SOC_DRA7XX)
+static int __init of_ti_omap4_dpll_x2_setup(struct device_node *node,
+					    struct regmap *regmap)
+{
+	struct clk *clk;
+
+	clk = ti_clk_register_dpll_x2(node, &dpll_x2_ck_ops,
+				      &clkhwops_omap4_dpllmx, regmap);
+
+	if (!IS_ERR(clk)) {
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+		return 0;
+	}
+
+	return PTR_ERR(clk);
+}
+CLK_OF_DECLARE(ti_omap4_dpll_x2_clock, "ti,omap4-dpll-x2-clock",
+	       of_ti_omap4_dpll_x2_setup);
+#endif
+
+#ifdef CONFIG_SOC_AM33XX
+static int __init of_ti_am3_dpll_x2_setup(struct device_node *node,
+					  struct regmap *regmap)
+{
+	struct clk *clk;
+
+	clk = ti_clk_register_dpll_x2(node, &dpll_x2_ck_ops, NULL, regmap);
+
+	if (!IS_ERR(clk)) {
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+		return 0;
+	}
+
+	return PTR_ERR(clk);
+}
+CLK_OF_DECLARE(ti_am3_dpll_x2_clock, "ti,am3-dpll-x2-clock",
+	       of_ti_am3_dpll_x2_setup);
+#endif
+
+#ifdef CONFIG_ARCH_OMAP3
+static int __init of_ti_omap3_dpll_setup(struct device_node *node,
+					 struct regmap *regmap)
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
+	return of_ti_dpll_setup(node, &omap3_dpll_ck_ops, &dd,
+				DPLL_HAS_AUTOIDLE, regmap);
+}
+CLK_OF_DECLARE(ti_omap3_dpll_clock, "ti,omap3-dpll-clock",
+	       of_ti_omap3_dpll_setup);
+
+static int __init of_ti_omap3_core_dpll_setup(struct device_node *node,
+					      struct regmap *regmap)
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
+	return of_ti_dpll_setup(node, &omap3_dpll_core_ck_ops, &dd,
+				DPLL_HAS_AUTOIDLE, regmap);
+}
+CLK_OF_DECLARE(ti_omap3_core_dpll_clock, "ti,omap3-dpll-core-clock",
+	       of_ti_omap3_core_dpll_setup);
+
+static int __init of_ti_omap3_per_dpll_setup(struct device_node *node,
+					     struct regmap *regmap)
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
+	return of_ti_dpll_setup(node, &omap3_dpll_per_ck_ops, &dd,
+				DPLL_HAS_AUTOIDLE, regmap);
+}
+CLK_OF_DECLARE(ti_omap3_per_dpll_clock, "ti,omap3-dpll-per-clock",
+	       of_ti_omap3_per_dpll_setup);
+
+static int __init of_ti_omap3_per_jtype_dpll_setup(struct device_node *node,
+						   struct regmap *regmap)
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
+	return of_ti_dpll_setup(node, &omap3_dpll_per_ck_ops, &dd,
+				DPLL_HAS_AUTOIDLE, regmap);
+}
+CLK_OF_DECLARE(ti_omap3_per_jtype_dpll_clock, "ti,omap3-dpll-per-j-type-clock",
+	       of_ti_omap3_per_jtype_dpll_setup);
+#endif
+
+static int __init of_ti_omap4_dpll_setup(struct device_node *node,
+					 struct regmap *regmap)
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
+	return of_ti_dpll_setup(node, &dpll_ck_ops, &dd, DPLL_HAS_AUTOIDLE,
+				regmap);
+}
+CLK_OF_DECLARE(ti_omap4_dpll_clock, "ti,omap4-dpll-clock",
+	       of_ti_omap4_dpll_setup);
+
+static int __init of_ti_omap4_core_dpll_setup(struct device_node *node,
+					      struct regmap *regmap)
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
+	return of_ti_dpll_setup(node, &dpll_core_ck_ops, &dd, DPLL_HAS_AUTOIDLE,
+				regmap);
+}
+CLK_OF_DECLARE(ti_omap4_core_dpll_clock, "ti,omap4-dpll-core-clock",
+	       of_ti_omap4_core_dpll_setup);
+
+#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || \
+	defined(CONFIG_SOC_DRA7XX)
+static int __init of_ti_omap4_m4xen_dpll_setup(struct device_node *node,
+					       struct regmap *regmap)
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
+	return of_ti_dpll_setup(node, &dpll_m4xen_ck_ops, &dd,
+				DPLL_HAS_AUTOIDLE, regmap);
+}
+CLK_OF_DECLARE(ti_omap4_m4xen_dpll_clock, "ti,omap4-dpll-m4xen-clock",
+	       of_ti_omap4_m4xen_dpll_setup);
+
+static int __init of_ti_omap4_jtype_dpll_setup(struct device_node *node,
+					       struct regmap *regmap)
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
+	return of_ti_dpll_setup(node, &dpll_m4xen_ck_ops, &dd,
+				DPLL_HAS_AUTOIDLE, regmap);
+}
+CLK_OF_DECLARE(ti_omap4_jtype_dpll_clock, "ti,omap4-dpll-j-type-clock",
+	       of_ti_omap4_jtype_dpll_setup);
+#endif
+
+static int __init of_ti_am3_no_gate_dpll_setup(struct device_node *node,
+					       struct regmap *regmap)
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
+	return of_ti_dpll_setup(node, &dpll_no_gate_ck_ops, &dd, 0, regmap);
+}
+CLK_OF_DECLARE(ti_am3_no_gate_dpll_clock, "ti,am3-dpll-no-gate-clock",
+	       of_ti_am3_no_gate_dpll_setup);
+
+static int __init of_ti_am3_jtype_dpll_setup(struct device_node *node,
+					     struct regmap *regmap)
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
+	return of_ti_dpll_setup(node, &dpll_ck_ops, &dd, 0, regmap);
+}
+CLK_OF_DECLARE(ti_am3_jtype_dpll_clock, "ti,am3-dpll-j-type-clock",
+	       of_ti_am3_jtype_dpll_setup);
+
+static int __init of_ti_am3_no_gate_jtype_dpll_setup(struct device_node *node,
+						     struct regmap *regmap)
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
+	return of_ti_dpll_setup(node, &dpll_no_gate_ck_ops, &dd, 0, regmap);
+}
+CLK_OF_DECLARE(ti_am3_no_gate_jtype_dpll_clock,
+	       "ti,am3-dpll-no-gate-j-type-clock",
+	       of_ti_am3_no_gate_jtype_dpll_setup);
+
+static int __init of_ti_am3_dpll_setup(struct device_node *node,
+				       struct regmap *regmap)
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
+	return of_ti_dpll_setup(node, &dpll_ck_ops, &dd, 0, regmap);
+}
+CLK_OF_DECLARE(ti_am3_dpll_clock, "ti,am3-dpll-clock", of_ti_am3_dpll_setup);
+
+static int __init of_ti_am3_core_dpll_setup(struct device_node *node,
+					    struct regmap *regmap)
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
+	return of_ti_dpll_setup(node, &dpll_core_ck_ops, &dd, 0, regmap);
+}
+CLK_OF_DECLARE(ti_am3_core_dpll_clock, "ti,am3-dpll-core-clock",
+	       of_ti_am3_core_dpll_setup);
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
new file mode 100644
index 0000000..c187023
--- /dev/null
+++ b/include/linux/clk/ti.h
@@ -0,0 +1,161 @@
+/*
+ * TI clock drivers support
+ *
+ * Copyright (C) 2013 Texas Instruments, Inc.
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
+#ifndef __LINUX_CLK_TI_H__
+#define __LINUX_CLK_TI_H__
+
+/**
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
+ *                     omap4_dpll_regm4xen_round_rate()
+ * @last_rounded_lpmode: cache of the last lpmode result of
+ *                      omap4_dpll_lpmode_recalc()
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
+ * @regmap: register map for accessing the clock registers for this clock
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
+	struct regmap		*regmap;
+};
+
+/* CM_CLKEN_PLL*.EN* bit values - not all are available for every DPLL */
+#define DPLL_LOW_POWER_STOP	0x1
+#define DPLL_LOW_POWER_BYPASS	0x5
+#define DPLL_LOCKED		0x7
+
+/* DPLL Type and DCO Selection Flags */
+#define DPLL_J_TYPE		0x1
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
+extern const struct clk_hw_omap_ops clkhwops_omap3_dpll;
+extern const struct clk_hw_omap_ops clkhwops_omap4_dpllmx;
+
+#endif
-- 
1.7.9.5

