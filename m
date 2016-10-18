From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 13/15] clk: ti: add support for omap4 module clocks
Date: Tue, 18 Oct 2016 18:46:06 +0300
Message-ID: <1476805568-19264-14-git-send-email-t-kristo@ti.com>
References: <1476805568-19264-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1476805568-19264-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, tony@atomide.com, mturquette@baylibre.com, sboyd@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Previously, hwmod core has been used for controlling the hwmod level
clocks. This has certain drawbacks, like being unable to share the
clocks for multiple users, missing usecounting and generally being
totally incompatible with common clock framework.

Add support for new clock type under the TI clock driver, which will
be used to convert all the existing hwmod clocks to.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/Makefile   |   3 +-
 drivers/clk/ti/clk.c      |   6 +
 drivers/clk/ti/clkt_mod.c | 344 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/ti/clock.h    |  24 ++++
 include/linux/clk/ti.h    |   2 +
 5 files changed, 378 insertions(+), 1 deletion(-)
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
diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index 8bebda4..3a75d8e 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -372,6 +372,12 @@ struct clk __init *ti_clk_register_clk(struct ti_clk *setup)
 	case TI_CLK_DPLL:
 		clk = ti_clk_register_dpll(setup);
 		break;
+	case TI_CLK_HWMOD:
+		clk = ti_clk_register_hwmod(setup);
+		break;
+	case TI_CLK_HWMOD_MUX:
+		clk = ti_clk_register_hwmod_mux(setup);
+		break;
 	default:
 		pr_err("bad type for %s!\n", setup->name);
 		clk = ERR_PTR(-EINVAL);
diff --git a/drivers/clk/ti/clkt_mod.c b/drivers/clk/ti/clkt_mod.c
new file mode 100644
index 0000000..dc86109
--- /dev/null
+++ b/drivers/clk/ti/clkt_mod.c
@@ -0,0 +1,344 @@
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
+		if (ktime_us_delta(ktime_get(), time->start) < timeout) {
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
+struct clk *ti_clk_register_hwmod(struct ti_clk *setup)
+{
+	struct ti_clk_hwmod *data = setup->data;
+	struct clk_init_data init = { NULL };
+	struct clk_hw_omap *hw;
+	struct clk *clk;
+	int ret;
+
+	hw = kzalloc(sizeof(*hw), GFP_KERNEL);
+	if (!hw) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	hw->enable_reg = ti_clk_get_reg_addr_clkdm(setup->clkdm_name,
+						   data->reg);
+	if (!hw->enable_reg) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	if (data->flags & CLKF_SW_SUP)
+		hw->enable_bit = MODULEMODE_SWCTRL;
+	if (data->flags & CLKF_HW_SUP)
+		hw->enable_bit = MODULEMODE_HWCTRL;
+	if (data->flags & CLKF_NO_IDLEST)
+		hw->flags |= NO_IDLEST;
+
+	init.parent_names = &data->parent;
+	init.num_parents = 1;
+	init.flags = 0;
+	init.name = setup->name;
+	init.ops = &omap4_module_clk_ops;
+	hw->hw.init = &init;
+
+	clk = ti_clk_register(NULL, &hw->hw, setup->name);
+	if (!IS_ERR(clk))
+		return clk;
+err:
+	kfree(hw);
+	return ERR_PTR(ret);
+}
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
+struct clk *ti_clk_register_hwmod_mux(struct ti_clk *setup)
+{
+	struct ti_clk_hwmod_mux *data = setup->data;
+	struct clk_init_data init = { NULL };
+	struct clk_mux *mux;
+	struct clk_hw_omap *gate;
+	struct clk *clk;
+	int ret;
+	u8 modulemode;
+
+	if (data->num_parents < 2) {
+		pr_err("%s: must have parents\n", setup->name);
+		return ERR_PTR(-EINVAL);
+	}
+
+	mux = kzalloc(sizeof(*mux), GFP_KERNEL);
+	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
+
+	if (!mux || !gate) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	gate->mux = &mux->hw;
+	mux->shift = data->shift;
+
+	if (data->flags & CLKF_INDEX_STARTS_AT_ONE)
+		mux->flags |= CLK_MUX_INDEX_ONE;
+
+	if (data->flags & CLKF_SW_SUP)
+		modulemode = MODULEMODE_SWCTRL;
+	if (data->flags & CLKF_HW_SUP)
+		modulemode = MODULEMODE_HWCTRL;
+
+	gate->enable_bit = modulemode;
+	gate->enable_reg = ti_clk_get_reg_addr_clkdm(setup->clkdm_name,
+						     data->mod_reg);
+	mux->reg = ti_clk_get_reg_addr_clkdm(setup->clkdm_name, data->mux_reg);
+
+	if (!gate->enable_reg || !mux->reg) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	init.num_parents = data->num_parents;
+	init.parent_names = data->parents;
+	init.flags = 0;
+
+	init.name = setup->name;
+	init.ops = &omap4_mux_module_clk_ops;
+	gate->hw.init = &init;
+
+	clk = ti_clk_register(NULL, &gate->hw, setup->name);
+
+	if (!IS_ERR(clk))
+		return clk;
+
+err:
+	kfree(gate);
+	kfree(mux);
+
+	return ERR_PTR(ret);
+}
diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index 2e5fab8..ebcd81b 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -26,6 +26,8 @@ enum {
 	TI_CLK_FIXED_FACTOR,
 	TI_CLK_GATE,
 	TI_CLK_DPLL,
+	TI_CLK_HWMOD,
+	TI_CLK_HWMOD_MUX,
 };
 
 /* Global flags */
@@ -54,6 +56,11 @@ enum {
 #define CLKF_CORE			(1 << 9)
 #define CLKF_J_TYPE			(1 << 10)
 
+/* HWMOD clk flags */
+#define CLKF_SW_SUP			BIT(5)
+#define CLKF_HW_SUP			BIT(6)
+#define CLKF_NO_IDLEST			BIT(7)
+
 #define CLK(dev, con, ck)		\
 	{				\
 		.lk = {			\
@@ -156,6 +163,21 @@ struct ti_clk_dpll {
 	u8 recal_st_bit;
 };
 
+struct ti_clk_hwmod {
+	u16 reg;
+	u16 flags;
+	const char *parent;
+};
+
+struct ti_clk_hwmod_mux {
+	u16 mux_reg;
+	u16 mod_reg;
+	u16 flags;
+	u8 shift;
+	u8 num_parents;
+	const char * const *parents;
+};
+
 /* Composite clock component types */
 enum {
 	CLK_COMPONENT_TYPE_GATE = 0,
@@ -191,6 +213,8 @@ struct ti_dt_clk {
 struct clk *ti_clk_register_divider(struct ti_clk *setup);
 struct clk *ti_clk_register_composite(struct ti_clk *setup);
 struct clk *ti_clk_register_dpll(struct ti_clk *setup);
+struct clk *ti_clk_register_hwmod(struct ti_clk *setup);
+struct clk *ti_clk_register_hwmod_mux(struct ti_clk *setup);
 struct clk *ti_clk_register(struct device *dev, struct clk_hw *hw,
 			    const char *con);
 int ti_clk_add_alias(struct device *dev, struct clk *clk, const char *con);
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index afccb48..5c7c24c 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -130,6 +130,7 @@ struct clk_hw_omap_ops {
  * @enable_bit: bitshift to write to enable/disable the clock (see @enable_reg)
  * @flags: see "struct clk.flags possibilities" above
  * @clksel_reg: for clksel clks, register va containing src/divisor select
+ * @mux: for module clocks, pointer to the optional mux component
  * @dpll_data: for DPLLs, pointer to struct dpll_data for this clock
  * @clkdm_name: clockdomain name that this clock is contained in
  * @clkdm: pointer to struct clockdomain, resolved from @clkdm_name at runtime
@@ -145,6 +146,7 @@ struct clk_hw_omap {
 	u8			enable_bit;
 	u8			flags;
 	void __iomem		*clksel_reg;
+	struct clk_hw		*mux;
 	struct dpll_data	*dpll_data;
 	const char		*clkdm_name;
 	struct clockdomain	*clkdm;
-- 
1.9.1

