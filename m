From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 04/11] clk: ti: interface: add support for legacy interface clock init
Date: Tue, 16 Dec 2014 18:20:49 +0200
Message-ID: <1418746856-17173-5-git-send-email-t-kristo@ti.com>
References: <1418746856-17173-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47460 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650AbaLPQUH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Dec 2014 11:20:07 -0500
In-Reply-To: <1418746856-17173-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, mturquette@linaro.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Legacy clock data is initialized slightly differently compared to
DT clocks, thus add support for this. The interface clock descriptor
itself is overloading the gate clock descriptor, thus it needs to
be called from the gate setup.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/clock.h     |    1 +
 drivers/clk/ti/gate.c      |    3 ++
 drivers/clk/ti/interface.c |   96 +++++++++++++++++++++++++++++++++-----------
 3 files changed, 76 insertions(+), 24 deletions(-)

diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index d0715bc..9430dc6 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -154,6 +154,7 @@ struct ti_clk_dpll {
 };
 
 struct clk *ti_clk_register_gate(struct ti_clk *setup);
+struct clk *ti_clk_register_interface(struct ti_clk *setup);
 struct clk *ti_clk_register_mux(struct ti_clk *setup);
 
 struct clk_hw *ti_clk_build_component_gate(struct ti_clk_gate *setup);
diff --git a/drivers/clk/ti/gate.c b/drivers/clk/ti/gate.c
index ff3380e..d4f6cb2 100644
--- a/drivers/clk/ti/gate.c
+++ b/drivers/clk/ti/gate.c
@@ -142,6 +142,9 @@ struct clk *ti_clk_register_gate(struct ti_clk *setup)
 
 	gate = setup->data;
 
+	if (gate->flags & CLKF_INTERFACE)
+		return ti_clk_register_interface(setup);
+
 	reg_setup = (struct clk_omap_reg *)&reg;
 
 	if (gate->flags & CLKF_SET_RATE_PARENT)
diff --git a/drivers/clk/ti/interface.c b/drivers/clk/ti/interface.c
index 9c3e8c4..d71cd9b 100644
--- a/drivers/clk/ti/interface.c
+++ b/drivers/clk/ti/interface.c
@@ -20,6 +20,7 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/clk/ti.h>
+#include "clock.h"
 
 #undef pr_fmt
 #define pr_fmt(fmt) "%s: " fmt, __func__
@@ -31,53 +32,100 @@ static const struct clk_ops ti_interface_clk_ops = {
 	.is_enabled	= &omap2_dflt_clk_is_enabled,
 };
 
-static void __init _of_ti_interface_clk_setup(struct device_node *node,
-					      const struct clk_hw_omap_ops *ops)
+static struct clk *_register_interface(struct device *dev, const char *name,
+				       const char *parent_name,
+				       void __iomem *reg, u8 bit_idx,
+				       const struct clk_hw_omap_ops *ops)
 {
-	struct clk *clk;
 	struct clk_init_data init = { NULL };
 	struct clk_hw_omap *clk_hw;
-	const char *parent_name;
-	u32 val;
+	struct clk *clk;
 
 	clk_hw = kzalloc(sizeof(*clk_hw), GFP_KERNEL);
 	if (!clk_hw)
-		return;
+		return ERR_PTR(-ENOMEM);
 
 	clk_hw->hw.init = &init;
 	clk_hw->ops = ops;
 	clk_hw->flags = MEMMAP_ADDRESSING;
+	clk_hw->enable_reg = reg;
+	clk_hw->enable_bit = bit_idx;
 
-	clk_hw->enable_reg = ti_clk_get_reg_addr(node, 0);
-	if (!clk_hw->enable_reg)
-		goto cleanup;
-
-	if (!of_property_read_u32(node, "ti,bit-shift", &val))
-		clk_hw->enable_bit = val;
-
-	init.name = node->name;
+	init.name = name;
 	init.ops = &ti_interface_clk_ops;
 	init.flags = 0;
 
-	parent_name = of_clk_get_parent_name(node, 0);
-	if (!parent_name) {
-		pr_err("%s must have a parent\n", node->name);
-		goto cleanup;
-	}
-
 	init.num_parents = 1;
 	init.parent_names = &parent_name;
 
 	clk = clk_register(NULL, &clk_hw->hw);
 
-	if (!IS_ERR(clk)) {
-		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+	if (IS_ERR(clk))
+		kfree(clk_hw);
+	else
 		omap2_init_clk_hw_omap_clocks(clk);
+
+	return clk;
+}
+
+struct clk *ti_clk_register_interface(struct ti_clk *setup)
+{
+	const struct clk_hw_omap_ops *ops = &clkhwops_iclk_wait;
+	u32 reg;
+	struct clk_omap_reg *reg_setup;
+	struct ti_clk_gate *gate;
+
+	gate = setup->data;
+	reg_setup = (struct clk_omap_reg *)&reg;
+	reg_setup->index = gate->module;
+	reg_setup->offset = gate->reg;
+
+	if (gate->flags & CLKF_NO_WAIT)
+		ops = &clkhwops_iclk;
+
+	if (gate->flags & CLKF_HSOTGUSB)
+		ops = &clkhwops_omap3430es2_iclk_hsotgusb_wait;
+
+	if (gate->flags & CLKF_DSS)
+		ops = &clkhwops_omap3430es2_iclk_dss_usbhost_wait;
+
+	if (gate->flags & CLKF_SSI)
+		ops = &clkhwops_omap3430es2_iclk_ssi_wait;
+
+	if (gate->flags & CLKF_AM35XX)
+		ops = &clkhwops_am35xx_ipss_wait;
+
+	return _register_interface(NULL, setup->name, gate->parent,
+				   (void __iomem *)reg, gate->bit_shift, ops);
+}
+
+static void __init _of_ti_interface_clk_setup(struct device_node *node,
+					      const struct clk_hw_omap_ops *ops)
+{
+	struct clk *clk;
+	const char *parent_name;
+	void __iomem *reg;
+	u8 enable_bit = 0;
+	u32 val;
+
+	reg = ti_clk_get_reg_addr(node, 0);
+	if (!reg)
+		return;
+
+	if (!of_property_read_u32(node, "ti,bit-shift", &val))
+		enable_bit = val;
+
+	parent_name = of_clk_get_parent_name(node, 0);
+	if (!parent_name) {
+		pr_err("%s must have a parent\n", node->name);
 		return;
 	}
 
-cleanup:
-	kfree(clk_hw);
+	clk = _register_interface(NULL, node->name, parent_name, reg,
+				  enable_bit, ops);
+
+	if (!IS_ERR(clk))
+		of_clk_add_provider(node, of_clk_src_simple_get, clk);
 }
 
 static void __init of_ti_interface_clk_setup(struct device_node *node)
-- 
1.7.9.5

