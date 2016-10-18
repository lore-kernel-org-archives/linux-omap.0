From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 09/15] clk: ti: move omap2_init_clk_clkdm under TI clock driver
Date: Tue, 18 Oct 2016 18:46:02 +0300
Message-ID: <1476805568-19264-10-git-send-email-t-kristo@ti.com>
References: <1476805568-19264-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1476805568-19264-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, tony@atomide.com, mturquette@baylibre.com, sboyd@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This is not needed outside the driver, so move it inside it and remove
the prototype from the public header also.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock.c  | 34 ----------------------------------
 drivers/clk/ti/clock.h       |  1 +
 drivers/clk/ti/clockdomain.c | 30 ++++++++++++++++++++++++++++++
 include/linux/clk/ti.h       |  1 -
 4 files changed, 31 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 5391b66..ce8e804 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -79,40 +79,6 @@ int __init omap2_clk_setup_ll_ops(void)
  * OMAP2+ specific clock functions
  */
 
-/* Private functions */
-
-/* Public functions */
-
-/**
- * omap2_init_clk_clkdm - look up a clockdomain name, store pointer in clk
- * @clk: OMAP clock struct ptr to use
- *
- * Convert a clockdomain name stored in a struct clk 'clk' into a
- * clockdomain pointer, and save it into the struct clk.  Intended to be
- * called during clk_register().  No return value.
- */
-void omap2_init_clk_clkdm(struct clk_hw *hw)
-{
-	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
-	struct clockdomain *clkdm;
-	const char *clk_name;
-
-	if (!clk->clkdm_name)
-		return;
-
-	clk_name = __clk_get_name(hw->clk);
-
-	clkdm = clkdm_lookup(clk->clkdm_name);
-	if (clkdm) {
-		pr_debug("clock: associated clk %s to clkdm %s\n",
-			 clk_name, clk->clkdm_name);
-		clk->clkdm = clkdm;
-	} else {
-		pr_debug("clock: could not associate clk %s to clkdm %s\n",
-			 clk_name, clk->clkdm_name);
-	}
-}
-
 static int __initdata mpurate;
 
 /*
diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index 5675e37..9c85a51 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -232,6 +232,7 @@ int ti_clk_retry_init(struct device_node *node, struct clk_hw *hw,
 u8 ti_clk_mux_get_parent(struct clk_hw *hw);
 int ti_clk_mux_set_parent(struct clk_hw *hw, u8 index);
 
+void omap2_init_clk_clkdm(struct clk_hw *hw);
 int omap2_clkops_enable_clkdm(struct clk_hw *hw);
 void omap2_clkops_disable_clkdm(struct clk_hw *hw);
 
diff --git a/drivers/clk/ti/clockdomain.c b/drivers/clk/ti/clockdomain.c
index 6cf9dd1..704157d 100644
--- a/drivers/clk/ti/clockdomain.c
+++ b/drivers/clk/ti/clockdomain.c
@@ -103,6 +103,36 @@ void omap2_clkops_disable_clkdm(struct clk_hw *hw)
 	ti_clk_ll_ops->clkdm_clk_disable(clk->clkdm, hw->clk);
 }
 
+/**
+ * omap2_init_clk_clkdm - look up a clockdomain name, store pointer in clk
+ * @clk: OMAP clock struct ptr to use
+ *
+ * Convert a clockdomain name stored in a struct clk 'clk' into a
+ * clockdomain pointer, and save it into the struct clk.  Intended to be
+ * called during clk_register().  No return value.
+ */
+void omap2_init_clk_clkdm(struct clk_hw *hw)
+{
+	struct clk_hw_omap *clk = to_clk_hw_omap(hw);
+	struct clockdomain *clkdm;
+	const char *clk_name;
+
+	if (!clk->clkdm_name)
+		return;
+
+	clk_name = __clk_get_name(hw->clk);
+
+	clkdm = ti_clk_ll_ops->clkdm_lookup(clk->clkdm_name);
+	if (clkdm) {
+		pr_debug("clock: associated clk %s to clkdm %s\n",
+			 clk_name, clk->clkdm_name);
+		clk->clkdm = clkdm;
+	} else {
+		pr_debug("clock: could not associate clk %s to clkdm %s\n",
+			 clk_name, clk->clkdm_name);
+	}
+}
+
 static void __init of_ti_clockdomain_setup(struct device_node *node)
 {
 	struct clk *clk;
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index bc7fd8f..626ae94 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -238,7 +238,6 @@ struct ti_clk_ll_ops {
 
 #define to_clk_hw_omap(_hw) container_of(_hw, struct clk_hw_omap, hw)
 
-void omap2_init_clk_clkdm(struct clk_hw *clk);
 int omap2_clk_disable_autoidle_all(void);
 int omap2_clk_enable_autoidle_all(void);
 int omap2_clk_allow_idle(struct clk *clk);
-- 
1.9.1

