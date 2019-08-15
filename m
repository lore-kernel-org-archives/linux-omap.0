From: Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH] clk: ti: Don't reference clk_init_data after registration
Date: Thu, 15 Aug 2019 15:12:49 -0700
Message-ID: <20190815221249.53235-1-sboyd@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

A future patch is going to change semantics of clk_register() so that
clk_hw::init is guaranteed to be NULL after a clk is registered. Avoid
referencing this member here so that we don't run into NULL pointer
exceptions.

Cc: Tero Kristo <t-kristo@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---

This might be causing boot regressions in linux-next. Not sure.

 drivers/clk/ti/apll.c | 9 +++++----
 drivers/clk/ti/dpll.c | 9 +++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/ti/apll.c b/drivers/clk/ti/apll.c
index 015a657d3382..ac5bc8857a51 100644
--- a/drivers/clk/ti/apll.c
+++ b/drivers/clk/ti/apll.c
@@ -140,6 +140,7 @@ static void __init omap_clk_register_apll(void *user,
 	struct clk_hw_omap *clk_hw = to_clk_hw_omap(hw);
 	struct dpll_data *ad = clk_hw->dpll_data;
 	struct clk *clk;
+	const struct clk_init_data *init = clk_hw->hw.init;
 
 	clk = of_clk_get(node, 0);
 	if (IS_ERR(clk)) {
@@ -168,15 +169,15 @@ static void __init omap_clk_register_apll(void *user,
 	clk = ti_clk_register_omap_hw(NULL, &clk_hw->hw, node->name);
 	if (!IS_ERR(clk)) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
-		kfree(clk_hw->hw.init->parent_names);
-		kfree(clk_hw->hw.init);
+		kfree(init->parent_names);
+		kfree(init);
 		return;
 	}
 
 cleanup:
 	kfree(clk_hw->dpll_data);
-	kfree(clk_hw->hw.init->parent_names);
-	kfree(clk_hw->hw.init);
+	kfree(init->parent_names);
+	kfree(init);
 	kfree(clk_hw);
 }
 
diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
index 659dadb23279..f3f609c465a7 100644
--- a/drivers/clk/ti/dpll.c
+++ b/drivers/clk/ti/dpll.c
@@ -165,6 +165,7 @@ static void __init _register_dpll(void *user,
 	struct clk_hw_omap *clk_hw = to_clk_hw_omap(hw);
 	struct dpll_data *dd = clk_hw->dpll_data;
 	struct clk *clk;
+	const struct clk_init_data *init = hw->init;
 
 	clk = of_clk_get(node, 0);
 	if (IS_ERR(clk)) {
@@ -196,15 +197,15 @@ static void __init _register_dpll(void *user,
 
 	if (!IS_ERR(clk)) {
 		of_clk_add_provider(node, of_clk_src_simple_get, clk);
-		kfree(clk_hw->hw.init->parent_names);
-		kfree(clk_hw->hw.init);
+		kfree(init->parent_names);
+		kfree(init);
 		return;
 	}
 
 cleanup:
 	kfree(clk_hw->dpll_data);
-	kfree(clk_hw->hw.init->parent_names);
-	kfree(clk_hw->hw.init);
+	kfree(init->parent_names);
+	kfree(init);
 	kfree(clk_hw);
 }
 
-- 
Sent by a computer through tubes
