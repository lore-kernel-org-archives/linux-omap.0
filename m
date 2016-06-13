From: Tero Kristo <t-kristo@ti.com>
Subject: [RESEND PATCHv2 01/28] clk: ti: add ti_clk_get helper API
Date: Mon, 13 Jun 2016 22:04:35 +0300
Message-ID: <1465844702-12200-2-git-send-email-t-kristo@ti.com>
References: <1465844702-12200-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1465844702-12200-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The API can be used to fetch directly DT clocks based on name. Using
this new API allows getting rid of most of the DT_CLK() entries under
drivers/clk/ti.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/clk.c   | 35 +++++++++++++++++++++++++++++------
 include/linux/clk/ti.h |  2 ++
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index 5fcf247..3dcf97e 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -68,6 +68,33 @@ static u32 clk_memmap_readl(void __iomem *reg)
 }
 
 /**
+ * ti_clk_get - lookup a TI clock handle
+ * @name: clock to find
+ *
+ * Searches for a TI clock handle. Will first attempt to search for a
+ * clock based on a DT node name, but if this fails, will revert to
+ * looking up a clock alias. Returns the pointer to the clock handle,
+ * or ERR_PTR in failure.
+ */
+struct clk *ti_clk_get(const char *name)
+{
+	struct of_phandle_args clkspec;
+	struct device_node *node;
+	struct clk *clk;
+
+	if (of_have_populated_dt()) {
+		node = of_find_node_by_name(NULL, name);
+		clkspec.np = node;
+		clk = of_clk_get_from_provider(&clkspec);
+
+		if (!IS_ERR(clk))
+			return clk;
+	}
+
+	return clk_get(NULL, name);
+}
+
+/**
  * ti_clk_setup_ll_ops - setup low level clock operations
  * @ops: low level clock ops descriptor
  *
@@ -102,14 +129,10 @@ int ti_clk_setup_ll_ops(struct ti_clk_ll_ops *ops)
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
+		clk = ti_clk_get(c->node_name);
 
 		if (!IS_ERR(clk)) {
 			c->lk.clk = clk;
@@ -446,7 +469,7 @@ void omap2_clk_enable_init_clocks(const char **clk_names, u8 num_clocks)
 	int i;
 
 	for (i = 0; i < num_clocks; i++) {
-		init_clk = clk_get(NULL, clk_names[i]);
+		init_clk = ti_clk_get(clk_names[i]);
 		if (WARN(IS_ERR(init_clk), "could not find init clock %s\n",
 			 clk_names[i]))
 			continue;
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 6110fe0..331b81b 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -294,6 +294,8 @@ struct ti_clk_features {
 void ti_clk_setup_features(struct ti_clk_features *features);
 const struct ti_clk_features *ti_clk_get_features(void);
 
+struct clk *ti_clk_get(const char *name);
+
 extern const struct clk_hw_omap_ops clkhwops_omap2xxx_dpll;
 
 #ifdef CONFIG_ATAGS
-- 
1.9.1
