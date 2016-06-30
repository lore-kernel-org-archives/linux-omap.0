From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 2/7] clk: ti: add clkdev get helper
Date: Thu, 30 Jun 2016 17:13:33 +0300
Message-ID: <1467296018-25086-3-git-send-email-t-kristo@ti.com>
References: <1467296018-25086-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1467296018-25086-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, tony@atomide.com, paul@pwsan.com, sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

TI clocks can be found based on a simple query against the clock name,
thus add a clkdev helper functionality for this. Using this new helper
implementation  allows getting rid of most of the DT_CLK() entries under
drivers/clk/ti.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/clk.c | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index 5fcf247..17554c3 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -68,6 +68,36 @@ static u32 clk_memmap_readl(void __iomem *reg)
 }
 
 /**
+ * ti_clk_get - lookup a TI clock handle
+ * @dev_id: device to lookup clock for
+ * @con_id: connection ID to find
+ *
+ * Searches for a TI clock handle based on the DT node name.
+ * Returns the pointer to the clock handle, or ERR_PTR in failure.
+ */
+static struct clk *ti_clk_get(const char *dev_id, const char *con_id)
+{
+	struct of_phandle_args clkspec;
+	struct device_node *node;
+	struct clk *clk;
+
+	/* Only check for cases of type clk_get_sys(NULL, "xyz") */
+	if (dev_id || !con_id)
+		return ERR_PTR(-ENOENT);
+
+	if (of_have_populated_dt()) {
+		node = of_find_node_by_name(NULL, con_id);
+		clkspec.np = node;
+		clk = of_clk_get_from_provider(&clkspec);
+
+		if (!IS_ERR(clk))
+			return clk;
+	}
+
+	return ERR_PTR(-ENOENT);
+}
+
+/**
  * ti_clk_setup_ll_ops - setup low level clock operations
  * @ops: low level clock ops descriptor
  *
@@ -87,6 +117,8 @@ int ti_clk_setup_ll_ops(struct ti_clk_ll_ops *ops)
 	ops->clk_readl = clk_memmap_readl;
 	ops->clk_writel = clk_memmap_writel;
 
+	clkdev_helper_register(ti_clk_get);
+
 	return 0;
 }
 
@@ -102,14 +134,10 @@ int ti_clk_setup_ll_ops(struct ti_clk_ll_ops *ops)
 void __init ti_dt_clocks_register(struct ti_dt_clk oclks[])
 {
 	struct ti_dt_clk *c;
-	struct device_node *node;
 	struct clk *clk;
-	struct of_phandle_args clkspec;
 
 	for (c = oclks; c->node_name != NULL; c++) {
-		node = of_find_node_by_name(NULL, c->node_name);
-		clkspec.np = node;
-		clk = of_clk_get_from_provider(&clkspec);
+		clk = ti_clk_get(NULL, c->node_name);
 
 		if (!IS_ERR(clk)) {
 			c->lk.clk = clk;
-- 
1.9.1

