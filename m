From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] clk: ti: Remove unused function ti_clk_build_component_gate
Date: Sun, 12 May 2019 18:03:28 +0800
Message-ID: <20190512100328.27136-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: t-kristo@ti.com, mturquette@baylibre.com, sboyd@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: linux-omap@vger.kernel.org

There is no callers in tree, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/clk/ti/gate.c | 30 ------------------------------
 1 file changed, 30 deletions(-)

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
-- 
2.7.4
