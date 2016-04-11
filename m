From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 18/30] clk: ti: add support for omap4 module clocks
Date: Mon, 11 Apr 2016 11:19:09 +0300
Message-ID: <1460362761-4842-19-git-send-email-t-kristo@ti.com>
References: <1460362761-4842-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1460362761-4842-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, mturquette@baylibre.com, sboyd@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Previously, hwmod core has been used for controlling the hwmod level
clocks. This has certain drawbacks, like being unable to share the
clocks for multiple users, missing usecounting and generally being
totally incompatible with common clock framework.

Add support for new clock type under the TI clock driver, which will
be used to convert all the existing hwmdo clocks to. This helps to
get rid of the clock related hwmod data from kernel and instead
parsing this from DT.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/Makefile   |    3 +-
 drivers/clk/ti/clkt_mod.c |  408 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/clk/ti.h    |    2 +
 3 files changed, 412 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/ti/clkt_mod.c

diff --git a/drivers/clk/ti/Makefile b/drivers/clk/ti/Makefile
index 0deac98..15886ef 100644
--- a/drivers/clk/ti/Makefile
+++ b/drivers/clk/ti/Makefile
@@ -3,7 +3,8 @@ ifeq ($(CONFIG_ARCH_OMAP2PLUS), y)
 obj-y					+= clk.o autoidle.o clockdomain.o
 clk-common				= dpll.o composite.o divider.o gate.o \
 					  fixed-factor.o mux.o apll.o \
-					  clkt_dpll.o clkt_iclk.o clkt_dflt.o
+					  clkt_dpll.o clkt_iclk.o clkt_dflt.o \
+					  clkt_mod.o
 obj-$(CONFIG_SOC_AM33XX)		+= $(clk-common) clk-33xx.o dpll3xxx.o
 obj-$(CONFIG_SOC_TI81XX)		+= $(clk-common) fapll.o clk-814x.o clk-816x.o
 obj-$(CONFIG_ARCH_OMAP2)		+= $(clk-common) interface.o clk-2xxx.o
diff --git a/drivers/clk/ti/clkt_mod.c b/drivers/clk/ti/clkt_mod.c
new file mode 100644
index 0000000..78422e2
--- /dev/null
+++ b/drivers/clk/ti/clkt_mod.c
@@ -0,0 +1,414 @@
+/*
+ * OMAP hardware module clock support
+ *
+ * Copyright (C) 2015 Texas Instruments, Inc.
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
+#include <linux/delay.h>
+#include "clock.h"
+
+#undef pr_fmt
+#define pr_fmt(fmt) "%s: " fmt, __func__
+
+#define NO_IDLEST			0x1
+
+#define OMAP4_MODULEMODE_MASK		0x3
+
+#define MODULEMODE_HWCTRL		0x1
+#define MODULEMODE_SWCTRL		0x2
+
+#define OMAP4_IDLEST_MASK		(0x3 << 16)
+#define OMAP4_IDLEST_SHIFT		16
+
+#define CLKCTRL_IDLEST_FUNCTIONAL	0x0
+#define CLKCTRL_IDLEST_INTERFACE_IDLE	0x2
+#define CLKCTRL_IDLEST_DISABLED		0x3
+
+/* These timeouts are in us */
+#define OMAP4_MAX_MODULE_READY_TIME	2000
+#define OMAP4_MAX_MODULE_DISABLE_TIME	5000
+
+static bool _early_timeout = true;
+
+union omap4_timeout {
+	u32 cycles;
+	ktime_t start;
+};
+
+static u32 _omap4_idlest(u32 val)
+{
+	val &= OMAP4_IDLEST_MASK;
+	val >>= OMAP4_IDLEST_SHIFT;
+
+	return val;
+}
+
+static bool _omap4_is_idle(u32 val)
+{
+	val = _omap4_idlest(val);
+
+	return val == CLKCTRL_IDLEST_DISABLED;
+}
+
+static bool _omap4_is_ready(u32 val)
+{
+	val = _omap4_idlest(val);
+
+	return val == CLKCTRL_IDLEST_FUNCTIONAL ||
+	       val == CLKCTRL_IDLEST_INTERFACE_IDLE;
+}
+
+static bool _omap4_is_timeout(union omap4_timeout *time, u32 timeout)
+{
+	if (unlikely(_early_timeout)) {
+		if (time->cycles++ < timeout) {
+			udelay(1);
+			return false;
+		}
+	} else {
+		if (!ktime_to_ns(time->start)) {
+			time->start = ktime_get();
+			return false;
+		}
+
+		if (ktime_us_delta(ktime_get(), time->start) > timeout) {
+			cpu_relax();
+			return false;
+		}
+	}
+
+	return true;
+}
+
+static int __init _omap4_disable_early_timeout(void)
+{
+	_early_timeout = false;
+
+	return 0;
+}
+arch_initcall(_omap4_disable_early_timeout);
+
+static int _omap4_hwmod_clk_enable(struct clk_hw *hw)
+{
+	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
+	u32 val;
+	int ret;
+	union omap4_timeout timeout = { 0 };
+
+	if (!clk->enable_bit)
+		return 0;
+
+	if (clk->clkdm) {
+		ret = ti_clk_ll_ops->clkdm_clk_enable(clk->clkdm, hw->clk);
+		if (ret) {
+			WARN(1,
+			     "%s: could not enable %s's clockdomain %s: %d\n",
+			     __func__, clk_hw_get_name(hw),
+			     clk->clkdm_name, ret);
+			return ret;
+		}
+	}
+
+	val = ti_clk_ll_ops->clk_readl(clk->enable_reg);
+
+	val &= ~OMAP4_MODULEMODE_MASK;
+	val |= clk->enable_bit;
+
+	ti_clk_ll_ops->clk_writel(val, clk->enable_reg);
+
+	if (clk->flags & NO_IDLEST)
+		return 0;
+
+	/* Wait until module is enabled */
+	while (!_omap4_is_ready(ti_clk_ll_ops->clk_readl(clk->enable_reg))) {
+		if (_omap4_is_timeout(&timeout, OMAP4_MAX_MODULE_READY_TIME)) {
+			pr_err("%s: failed to enable\n", clk_hw_get_name(hw));
+			return -EBUSY;
+		}
+	}
+
+	return 0;
+}
+
+static void _omap4_hwmod_clk_disable(struct clk_hw *hw)
+{
+	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
+	u32 val;
+	union omap4_timeout timeout = { 0 };
+
+	if (!clk->enable_bit)
+		return;
+
+	val = ti_clk_ll_ops->clk_readl(clk->enable_reg);
+
+	val &= ~OMAP4_MODULEMODE_MASK;
+
+	ti_clk_ll_ops->clk_writel(val, clk->enable_reg);
+
+	if (clk->flags & NO_IDLEST)
+		return;
+
+	/* Wait until module is disabled */
+	while (!_omap4_is_idle(ti_clk_ll_ops->clk_readl(clk->enable_reg))) {
+		if (_omap4_is_timeout(&timeout,
+				      OMAP4_MAX_MODULE_DISABLE_TIME)) {
+			pr_err("%s: failed to disable\n", clk_hw_get_name(hw));
+			break;
+		}
+	}
+
+	if (clk->clkdm)
+		ti_clk_ll_ops->clkdm_clk_disable(clk->clkdm, hw->clk);
+}
+
+static int _omap4_hwmod_clk_is_enabled(struct clk_hw *hw)
+{
+	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
+	u32 val;
+
+	val = ti_clk_ll_ops->clk_readl(clk->enable_reg);
+
+	if (val & clk->enable_bit)
+		return 1;
+
+	return 0;
+}
+
+static const struct clk_ops omap4_module_clk_ops = {
+	.enable		= _omap4_hwmod_clk_enable,
+	.disable	= _omap4_hwmod_clk_disable,
+	.is_enabled	= _omap4_hwmod_clk_is_enabled,
+};
+
+static void __init _of_ti_hwmod_clk_setup(struct device_node *node,
+					  u8 modulemode, u8 flags)
+{
+	const char *parent_name;
+	void __iomem *reg;
+	u8 enable_bit;
+	struct clk_hw_omap *clk_hw;
+	struct clk_init_data init = { NULL };
+	struct clk *clk;
+
+	reg = ti_clk_get_reg_addr(node, 0);
+	if (IS_ERR(reg))
+		return;
+
+	parent_name = of_clk_get_parent_name(node, 0);
+	if (!parent_name) {
+		pr_err("%s must have 1 parent\n", node->name);
+		return;
+	}
+
+	enable_bit = modulemode;
+
+	clk_hw = kzalloc(sizeof(*clk_hw), GFP_KERNEL);
+
+	clk_hw->flags = flags;
+
+	clk_hw->enable_reg = reg;
+	clk_hw->enable_bit = enable_bit;
+
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+	init.flags = 0;
+
+	init.ops = &omap4_module_clk_ops;
+	clk_hw->hw.init = &init;
+	init.name = node->name;
+
+	clk = clk_register(NULL, &clk_hw->hw);
+
+	if (!IS_ERR(clk))
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+}
+
+static void __init of_ti_omap4_hwmod_clk_setup(struct device_node *node)
+{
+	_of_ti_hwmod_clk_setup(node, 0, 0);
+}
+
+CLK_OF_DECLARE(ti_omap4_hwmod_clk, "ti,omap4-mod-clock",
+	       of_ti_omap4_hwmod_clk_setup);
+
+static void __init of_ti_omap4_hwmod_hw_clk_setup(struct device_node *node)
+{
+	_of_ti_hwmod_clk_setup(node, MODULEMODE_HWCTRL, 0);
+}
+
+CLK_OF_DECLARE(ti_omap4_hwmod_hw_clk, "ti,omap4-hw-mod-clock",
+	       of_ti_omap4_hwmod_hw_clk_setup);
+
+static void __init of_ti_omap4_hwmod_sw_clk_setup(struct device_node *node)
+{
+	_of_ti_hwmod_clk_setup(node, MODULEMODE_SWCTRL, 0);
+}
+
+CLK_OF_DECLARE(ti_omap4_hwmod_sw_clk, "ti,omap4-sw-mod-clock",
+	       of_ti_omap4_hwmod_sw_clk_setup);
+
+static void __init
+of_ti_omap4_hwmod_sw_no_idlest_clk_setup(struct device_node *node)
+{
+	_of_ti_hwmod_clk_setup(node, MODULEMODE_SWCTRL, NO_IDLEST);
+}
+
+CLK_OF_DECLARE(ti_omap4_hwmod_sw_no_idlest_clk,
+	       "ti,omap4-sw-no-idlest-mod-clock",
+	       of_ti_omap4_hwmod_sw_no_idlest_clk_setup);
+
+static u8 _omap4_mux_mod_get_parent(struct clk_hw *hw)
+{
+	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
+	struct clk_hw *mux_hw = clk->mux;
+
+	__clk_hw_set_clk(mux_hw, hw);
+
+	return ti_clk_mux_get_parent(mux_hw);
+}
+
+static int _omap4_mux_mod_set_parent(struct clk_hw *hw, u8 index)
+{
+	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
+	struct clk_hw *mux_hw = clk->mux;
+
+	__clk_hw_set_clk(mux_hw, hw);
+
+	return ti_clk_mux_set_parent(mux_hw, index);
+}
+
+static int _omap4_mux_mod_determine_rate(struct clk_hw *hw,
+					 struct clk_rate_request *req)
+{
+	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
+	struct clk_hw *mux_hw = clk->mux;
+
+	__clk_hw_set_clk(mux_hw, hw);
+
+	return __clk_mux_determine_rate(mux_hw, req);
+}
+
+static const struct clk_ops omap4_mux_module_clk_ops = {
+	.enable		= _omap4_hwmod_clk_enable,
+	.disable	= _omap4_hwmod_clk_disable,
+	.is_enabled	= _omap4_hwmod_clk_is_enabled,
+	.get_parent	= _omap4_mux_mod_get_parent,
+	.set_parent	= _omap4_mux_mod_set_parent,
+	.determine_rate	= _omap4_mux_mod_determine_rate,
+};
+
+static void __init _of_ti_omap4_hwmod_mux_clk_setup(struct device_node *node,
+						    u8 modulemode)
+{
+	struct clk_hw_omap *gate;
+	struct clk_mux *mux;
+	int num_parents;
+	const char **parent_names = NULL;
+	u32 val;
+	void __iomem *reg;
+	struct clk *clk;
+	struct clk_init_data init = { NULL };
+
+	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+
+	if (!mux || !gate)
+		goto err;
+
+	gate->mux = &mux->hw;
+
+	if (!of_property_read_u32(node, "ti,bit-shift", &val))
+		mux->shift = val;
+
+	if (of_property_read_bool(node, "ti,index-starts-at-one"))
+		mux->flags |= CLK_MUX_INDEX_ONE;
+
+	num_parents = of_clk_get_parent_count(node);
+
+	if (num_parents < 2) {
+		pr_err("%s: must have parents\n", node->name);
+		goto err;
+	}
+
+	parent_names = kzalloc((sizeof(char *) * num_parents), GFP_KERNEL);
+	if (!parent_names)
+		goto err;
+
+	of_clk_parent_fill(node, parent_names, num_parents);
+
+	reg = ti_clk_get_reg_addr(node, 0);
+
+	if (IS_ERR(reg))
+		goto err;
+
+	gate->enable_bit = modulemode;
+	gate->enable_reg = reg;
+
+	reg = ti_clk_get_reg_addr(node, 1);
+
+	if (IS_ERR(reg))
+		goto err;
+
+	mux->reg = reg;
+
+	init.parent_names = parent_names;
+	init.num_parents = num_parents;
+	init.flags = 0;
+
+	init.ops = &omap4_mux_module_clk_ops;
+	gate->hw.init = &init;
+	init.name = node->name;
+
+	clk = clk_register(NULL, &gate->hw);
+
+	if (!IS_ERR(clk)) {
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+		goto cleanup;
+	}
+err:
+	kfree(gate);
+	kfree(mux);
+
+cleanup:
+	kfree(parent_names);
+}
+
+static void __init of_ti_omap4_hwmod_mux_clk_setup(struct device_node *node)
+{
+	_of_ti_omap4_hwmod_mux_clk_setup(node, 0);
+}
+
+CLK_OF_DECLARE(ti_omap4_mux_hwmod_clk, "ti,omap4-mux-mod-clock",
+	       of_ti_omap4_hwmod_mux_clk_setup);
+
+static void __init of_ti_omap4_hwmod_sw_mux_clk_setup(struct device_node *node)
+{
+	_of_ti_omap4_hwmod_mux_clk_setup(node, MODULEMODE_SWCTRL);
+}
+
+CLK_OF_DECLARE(ti_omap4_mux_hwmod_sw_clk, "ti,omap4-sw-mux-mod-clock",
+	       of_ti_omap4_hwmod_sw_mux_clk_setup);
+
+static void __init of_ti_omap4_hwmod_hw_mux_clk_setup(struct device_node *node)
+{
+	_of_ti_omap4_hwmod_mux_clk_setup(node, MODULEMODE_HWCTRL);
+}
+
+CLK_OF_DECLARE(ti_omap4_mux_hwmod_hw_clk, "ti,omap4-hw-mux-mod-clock",
+	       of_ti_omap4_hwmod_hw_mux_clk_setup);
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 1451291..4ba364e 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -127,6 +127,7 @@ struct clk_hw_omap_ops {
  * @enable_bit: bitshift to write to enable/disable the clock (see @enable_reg)
  * @flags: see "struct clk.flags possibilities" above
  * @clksel_reg: for clksel clks, register va containing src/divisor select
+ * @mux: for module clocks, pointer to the optional mux component
  * @dpll_data: for DPLLs, pointer to struct dpll_data for this clock
  * @clkdm_name: clockdomain name that this clock is contained in
  * @clkdm: pointer to struct clockdomain, resolved from @clkdm_name at runtime
@@ -141,6 +142,7 @@ struct clk_hw_omap {
 	u8			enable_bit;
 	u8			flags;
 	void __iomem		*clksel_reg;
+	struct clk_hw		*mux;
 	struct dpll_data	*dpll_data;
 	const char		*clkdm_name;
 	struct clockdomain	*clkdm;
-- 
1.7.9.5

