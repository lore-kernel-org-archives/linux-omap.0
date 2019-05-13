From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2] clk: ti: Remove unused functions
Date: Mon, 13 May 2019 16:32:24 +0800
Message-ID: <20190513083224.28892-1-yuehaibing@huawei.com>
References: <20190512100328.27136-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190512100328.27136-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: t-kristo@ti.com, mturquette@baylibre.com, sboyd@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: linux-omap@vger.kernel.org

They are not used any more since
commit 7558562a70fb ("clk: ti: Drop legacy clk-3xxx-legacy code")

Reported-by: Hulk Robot <hulkci@huawei.com>
Suggested-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: also remove mux/div unused functions
---
 drivers/clk/ti/divider.c | 36 ------------------------------------
 drivers/clk/ti/gate.c    | 30 ------------------------------
 drivers/clk/ti/mux.c     | 31 -------------------------------
 3 files changed, 97 deletions(-)

diff --git a/drivers/clk/ti/divider.c b/drivers/clk/ti/divider.c
index 4786e0e..c2ff4ce 100644
--- a/drivers/clk/ti/divider.c
+++ b/drivers/clk/ti/divider.c
@@ -474,42 +474,6 @@ struct clk_hw *ti_clk_build_component_div(struct ti_clk_divider *setup)
 	return &div->hw;
 }
 
-struct clk *ti_clk_register_divider(struct ti_clk *setup)
-{
-	struct ti_clk_divider *div = setup->data;
-	struct clk_omap_reg reg = {
-		.index = div->module,
-		.offset = div->reg,
-	};
-	u8 width;
-	u32 flags = 0;
-	u8 div_flags = 0;
-	const struct clk_div_table *table;
-	struct clk *clk;
-
-	if (div->flags & CLKF_INDEX_STARTS_AT_ONE)
-		div_flags |= CLK_DIVIDER_ONE_BASED;
-
-	if (div->flags & CLKF_INDEX_POWER_OF_TWO)
-		div_flags |= CLK_DIVIDER_POWER_OF_TWO;
-
-	if (div->flags & CLKF_SET_RATE_PARENT)
-		flags |= CLK_SET_RATE_PARENT;
-
-	table = _get_div_table_from_setup(div, &width);
-	if (IS_ERR(table))
-		return (struct clk *)table;
-
-	clk = _register_divider(NULL, setup->name, div->parent,
-				flags, &reg, div->bit_shift,
-				width, -EINVAL, div_flags, table);
-
-	if (IS_ERR(clk))
-		kfree(table);
-
-	return clk;
-}
-
 static struct clk_div_table *
 __init ti_clk_get_div_table(struct device_node *node)
 {
diff --git a/drivers/clk/ti/gate.c b/drivers/clk/ti/gate.c
index 504c0e9..4238955 100644
--- a/drivers/clk/ti/gate.c
+++ b/drivers/clk/ti/gate.c
@@ -131,36 +131,6 @@ static struct clk *_register_gate(struct device *dev, const char *name,
 	return clk;
 }
 
-struct clk_hw *ti_clk_build_component_gate(struct ti_clk_gate *setup)
-{
-	struct clk_hw_omap *gate;
-	struct clk_omap_reg *reg;
-	const struct clk_hw_omap_ops *ops = &clkhwops_wait;
-
-	if (!setup)
-		return NULL;
-
-	gate = kzalloc(sizeof(*gate), GFP_KERNEL);
-	if (!gate)
-		return ERR_PTR(-ENOMEM);
-
-	reg = (struct clk_omap_reg *)&gate->enable_reg;
-	reg->index = setup->module;
-	reg->offset = setup->reg;
-
-	gate->enable_bit = setup->bit_shift;
-
-	if (setup->flags & CLKF_NO_WAIT)
-		ops = NULL;
-
-	if (setup->flags & CLKF_INTERFACE)
-		ops = &clkhwops_iclk_wait;
-
-	gate->ops = ops;
-
-	return &gate->hw;
-}
-
 static void __init _of_ti_gate_clk_setup(struct device_node *node,
 					 const struct clk_ops *ops,
 					 const struct clk_hw_omap_ops *hw_ops)
diff --git a/drivers/clk/ti/mux.c b/drivers/clk/ti/mux.c
index b7f9a4f..0069e7c 100644
--- a/drivers/clk/ti/mux.c
+++ b/drivers/clk/ti/mux.c
@@ -164,37 +164,6 @@ static struct clk *_register_mux(struct device *dev, const char *name,
 	return clk;
 }
 
-struct clk *ti_clk_register_mux(struct ti_clk *setup)
-{
-	struct ti_clk_mux *mux;
-	u32 flags;
-	u8 mux_flags = 0;
-	struct clk_omap_reg reg;
-	u32 mask;
-
-	mux = setup->data;
-	flags = CLK_SET_RATE_NO_REPARENT;
-
-	mask = mux->num_parents;
-	if (!(mux->flags & CLKF_INDEX_STARTS_AT_ONE))
-		mask--;
-
-	mask = (1 << fls(mask)) - 1;
-	reg.index = mux->module;
-	reg.offset = mux->reg;
-	reg.ptr = NULL;
-
-	if (mux->flags & CLKF_INDEX_STARTS_AT_ONE)
-		mux_flags |= CLK_MUX_INDEX_ONE;
-
-	if (mux->flags & CLKF_SET_RATE_PARENT)
-		flags |= CLK_SET_RATE_PARENT;
-
-	return _register_mux(NULL, setup->name, mux->parents, mux->num_parents,
-			     flags, &reg, mux->bit_shift, mask, -EINVAL,
-			     mux_flags, NULL);
-}
-
 /**
  * of_mux_clk_setup - Setup function for simple mux rate clock
  * @node: DT node for the clock
-- 
2.7.4
