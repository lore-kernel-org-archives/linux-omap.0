From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 09/15] clk: ti: drop unnecessary MEMMAP_ADDRESSING flag
Date: Mon, 13 Feb 2017 11:35:05 +0200
Message-ID: <1486978511-29668-10-git-send-email-t-kristo@ti.com>
References: <1486978511-29668-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1486978511-29668-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This has been superceded by the usage of ti_clk_ll_ops for now.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/apll.c      | 1 -
 drivers/clk/ti/dpll.c      | 2 --
 drivers/clk/ti/gate.c      | 4 +---
 drivers/clk/ti/interface.c | 1 -
 include/linux/clk/ti.h     | 2 --
 5 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/clk/ti/apll.c b/drivers/clk/ti/apll.c
index 62b5db7..5cba28c 100644
--- a/drivers/clk/ti/apll.c
+++ b/drivers/clk/ti/apll.c
@@ -194,7 +194,6 @@ static void __init of_dra7_apll_setup(struct device_node *node)
 
 	clk_hw->dpll_data = ad;
 	clk_hw->hw.init = init;
-	clk_hw->flags = MEMMAP_ADDRESSING;
 
 	init->name = node->name;
 	init->ops = &apll_ck_ops;
diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
index 37624e1..c149bd1 100644
--- a/drivers/clk/ti/dpll.c
+++ b/drivers/clk/ti/dpll.c
@@ -248,7 +248,6 @@ struct clk *ti_clk_register_dpll(struct ti_clk *setup)
 	clk_hw->dpll_data = dd;
 	clk_hw->ops = &clkhwops_omap3_dpll;
 	clk_hw->hw.init = &init;
-	clk_hw->flags = MEMMAP_ADDRESSING;
 
 	init.name = setup->name;
 	init.ops = ops;
@@ -380,7 +379,6 @@ static void __init of_ti_dpll_setup(struct device_node *node,
 	clk_hw->dpll_data = dd;
 	clk_hw->ops = &clkhwops_omap3_dpll;
 	clk_hw->hw.init = init;
-	clk_hw->flags = MEMMAP_ADDRESSING;
 
 	init->name = node->name;
 	init->ops = ops;
diff --git a/drivers/clk/ti/gate.c b/drivers/clk/ti/gate.c
index b3291db..5ff62e2 100644
--- a/drivers/clk/ti/gate.c
+++ b/drivers/clk/ti/gate.c
@@ -113,7 +113,7 @@ static struct clk *_register_gate(struct device *dev, const char *name,
 	clk_hw->enable_bit = bit_idx;
 	clk_hw->ops = hw_ops;
 
-	clk_hw->flags = MEMMAP_ADDRESSING | clk_gate_flags;
+	clk_hw->flags = clk_gate_flags;
 
 	init.parent_names = &parent_name;
 	init.num_parents = 1;
@@ -203,7 +203,6 @@ struct clk_hw *ti_clk_build_component_gate(struct ti_clk_gate *setup)
 		ops = &clkhwops_iclk_wait;
 
 	gate->ops = ops;
-	gate->flags = MEMMAP_ADDRESSING;
 
 	return &gate->hw;
 }
@@ -269,7 +268,6 @@ static void __init _of_ti_gate_clk_setup(struct device_node *node,
 
 	gate->enable_bit = val;
 	gate->ops = hw_ops;
-	gate->flags = MEMMAP_ADDRESSING;
 
 	if (!ti_clk_add_component(node, &gate->hw, CLK_COMPONENT_TYPE_GATE))
 		return;
diff --git a/drivers/clk/ti/interface.c b/drivers/clk/ti/interface.c
index 7927e1a..42d9fd4 100644
--- a/drivers/clk/ti/interface.c
+++ b/drivers/clk/ti/interface.c
@@ -47,7 +47,6 @@ static struct clk *_register_interface(struct device *dev, const char *name,
 
 	clk_hw->hw.init = &init;
 	clk_hw->ops = ops;
-	clk_hw->flags = MEMMAP_ADDRESSING;
 	clk_hw->enable_reg = reg;
 	clk_hw->enable_bit = bit_idx;
 
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 626ae94..affdabd 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -168,7 +168,6 @@ struct clk_hw_omap {
  *     should be used.  This is a temporary solution - a better approach
  *     would be to associate clock type-specific data with the clock,
  *     similar to the struct dpll_data approach.
- * MEMMAP_ADDRESSING: Use memmap addressing to access clock registers.
  */
 #define ENABLE_REG_32BIT	(1 << 0)	/* Use 32-bit access */
 #define CLOCK_IDLE_CONTROL	(1 << 1)
@@ -176,7 +175,6 @@ struct clk_hw_omap {
 #define ENABLE_ON_INIT		(1 << 3)	/* Enable upon framework init */
 #define INVERT_ENABLE		(1 << 4)	/* 0 enables, 1 disables */
 #define CLOCK_CLKOUTX2		(1 << 5)
-#define MEMMAP_ADDRESSING	(1 << 6)
 
 /* CM_CLKEN_PLL*.EN* bit values - not all are available for every DPLL */
 #define DPLL_LOW_POWER_STOP	0x1
-- 
1.9.1

