From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 05/28] clk: ti: convert retry_init param to use void data type
Date: Thu, 9 Nov 2017 11:15:15 +0200
Message-ID: <1510218917-1725-3-git-send-email-t-kristo@ti.com>
References: <1510218917-1725-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1510218917-1725-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

User data should be void type, as the core framework doesn't need to
know what is passed through.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/apll.c      |  3 ++-
 drivers/clk/ti/clk.c       | 12 ++++++------
 drivers/clk/ti/clock.h     |  4 ++--
 drivers/clk/ti/composite.c |  3 ++-
 drivers/clk/ti/dpll.c      |  3 ++-
 5 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/ti/apll.c b/drivers/clk/ti/apll.c
index 83b148f..9498e93 100644
--- a/drivers/clk/ti/apll.c
+++ b/drivers/clk/ti/apll.c
@@ -133,9 +133,10 @@ static u8 dra7_init_apll_parent(struct clk_hw *hw)
 	.get_parent	= &dra7_init_apll_parent,
 };
 
-static void __init omap_clk_register_apll(struct clk_hw *hw,
+static void __init omap_clk_register_apll(void *user,
 					  struct device_node *node)
 {
+	struct clk_hw *hw = user;
 	struct clk_hw_omap *clk_hw = to_clk_hw_omap(hw);
 	struct dpll_data *ad = clk_hw->dpll_data;
 	struct clk *clk;
diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index 10a7045..302c9e6 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -178,7 +178,7 @@ void __init ti_dt_clocks_register(struct ti_dt_clk oclks[])
 
 struct clk_init_item {
 	struct device_node *node;
-	struct clk_hw *hw;
+	void *user;
 	ti_of_clk_init_cb_t func;
 	struct list_head link;
 };
@@ -188,14 +188,14 @@ struct clk_init_item {
 /**
  * ti_clk_retry_init - retries a failed clock init at later phase
  * @node: device not for the clock
- * @hw: partially initialized clk_hw struct for the clock
+ * @user: user data pointer
  * @func: init function to be called for the clock
  *
  * Adds a failed clock init to the retry list. The retry list is parsed
  * once all the other clocks have been initialized.
  */
-int __init ti_clk_retry_init(struct device_node *node, struct clk_hw *hw,
-			      ti_of_clk_init_cb_t func)
+int __init ti_clk_retry_init(struct device_node *node, void *user,
+			     ti_of_clk_init_cb_t func)
 {
 	struct clk_init_item *retry;
 
@@ -206,7 +206,7 @@ int __init ti_clk_retry_init(struct device_node *node, struct clk_hw *hw,
 
 	retry->node = node;
 	retry->func = func;
-	retry->hw = hw;
+	retry->user = user;
 	list_add(&retry->link, &retry_list);
 
 	return 0;
@@ -328,7 +328,7 @@ void ti_dt_clk_init_retry_clks(void)
 	while (!list_empty(&retry_list) && retries) {
 		list_for_each_entry_safe(retry, tmp, &retry_list, link) {
 			pr_debug("retry-init: %s\n", retry->node->name);
-			retry->func(retry->hw, retry->node);
+			retry->func(retry->user, retry->node);
 			list_del(&retry->link);
 			kfree(retry);
 		}
diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index 169241f..999fe72 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -235,7 +235,7 @@ struct omap_clkctrl_data {
 #define CLKF_HW_SUP	BIT(1)
 #define CLKF_NO_IDLEST	BIT(2)
 
-typedef void (*ti_of_clk_init_cb_t)(struct clk_hw *, struct device_node *);
+typedef void (*ti_of_clk_init_cb_t)(void *, struct device_node *);
 
 struct clk *ti_clk_register_gate(struct ti_clk *setup);
 struct clk *ti_clk_register_interface(struct ti_clk *setup);
@@ -263,7 +263,7 @@ int ti_clk_parse_divider_data(int *div_table, int num_dividers, int max_div,
 int ti_clk_get_reg_addr(struct device_node *node, int index,
 			struct clk_omap_reg *reg);
 void ti_dt_clocks_register(struct ti_dt_clk *oclks);
-int ti_clk_retry_init(struct device_node *node, struct clk_hw *hw,
+int ti_clk_retry_init(struct device_node *node, void *user,
 		      ti_of_clk_init_cb_t func);
 int ti_clk_add_component(struct device_node *node, struct clk_hw *hw, int type);
 
diff --git a/drivers/clk/ti/composite.c b/drivers/clk/ti/composite.c
index beea894..3eaba2d 100644
--- a/drivers/clk/ti/composite.c
+++ b/drivers/clk/ti/composite.c
@@ -161,9 +161,10 @@ struct clk *ti_clk_register_composite(struct ti_clk *setup)
 }
 #endif
 
-static void __init _register_composite(struct clk_hw *hw,
+static void __init _register_composite(void *user,
 				       struct device_node *node)
 {
+	struct clk_hw *hw = user;
 	struct clk *clk;
 	struct clk_hw_omap_comp *cclk = to_clk_hw_comp(hw);
 	struct component_clk *comp;
diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
index d4e4444..d246598 100644
--- a/drivers/clk/ti/dpll.c
+++ b/drivers/clk/ti/dpll.c
@@ -152,9 +152,10 @@
  * clk-bypass is missing), the clock is added to retry list and
  * the initialization is retried on later stage.
  */
-static void __init _register_dpll(struct clk_hw *hw,
+static void __init _register_dpll(void *user,
 				  struct device_node *node)
 {
+	struct clk_hw *hw = user;
 	struct clk_hw_omap *clk_hw = to_clk_hw_omap(hw);
 	struct dpll_data *dd = clk_hw->dpll_data;
 	struct clk *clk;
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
