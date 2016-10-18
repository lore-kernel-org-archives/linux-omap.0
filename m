From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 04/15] clk: ti: add support for automatic clock alias generation
Date: Tue, 18 Oct 2016 18:45:57 +0300
Message-ID: <1476805568-19264-5-git-send-email-t-kristo@ti.com>
References: <1476805568-19264-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1476805568-19264-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, tony@atomide.com, mturquette@baylibre.com, sboyd@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Large portions of the OMAP framework still depend on the support of
having clock aliases in place, so add support functions for generating
these automatically.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/clk.c   | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/ti/clock.h |  5 ++++
 2 files changed, 69 insertions(+)

diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index 5fcf247..91bad55 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -24,6 +24,7 @@
 #include <linux/list.h>
 #include <linux/regmap.h>
 #include <linux/bootmem.h>
+#include <linux/device.h>
 
 #include "clock.h"
 
@@ -453,3 +454,66 @@ void omap2_clk_enable_init_clocks(const char **clk_names, u8 num_clocks)
 		clk_prepare_enable(init_clk);
 	}
 }
+
+/**
+ * ti_clk_add_alias - add a clock alias for a TI clock
+ * @dev: device alias for this clock
+ * @clk: clock handle to create alias for
+ * @con: connection ID for this clock
+ *
+ * Creates a clock alias for a TI clock. Allocates the clock lookup entry
+ * and assigns the data to it. Returns 0 if successful, negative error
+ * value otherwise.
+ */
+int ti_clk_add_alias(struct device *dev, struct clk *clk, const char *con)
+{
+	struct clk_lookup *cl;
+
+	if (!clk)
+		return 0;
+
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	cl = kzalloc(sizeof(*cl), GFP_KERNEL);
+	if (!cl)
+		return -ENOMEM;
+
+	if (dev)
+		cl->dev_id = dev_name(dev);
+	cl->con_id = con;
+	cl->clk = clk;
+
+	clkdev_add(cl);
+
+	return 0;
+}
+
+/**
+ * ti_clk_register - register a TI clock to the common clock framework
+ * @dev: device for this clock
+ * @hw: hardware clock handle
+ * @con: connection ID for this clock
+ *
+ * Registers a TI clock to the common clock framework, and adds a clock
+ * alias for it. Returns a handle to the registered clock if successful,
+ * ERR_PTR value in failure.
+ */
+struct clk *ti_clk_register(struct device *dev, struct clk_hw *hw,
+			    const char *con)
+{
+	struct clk *clk;
+	int ret;
+
+	clk = clk_register(dev, hw);
+	if (IS_ERR(clk))
+		return clk;
+
+	ret = ti_clk_add_alias(dev, clk, con);
+	if (ret) {
+		clk_unregister(clk);
+		return ERR_PTR(ret);
+	}
+
+	return clk;
+}
diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index 7eca8a1..6bf962d 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -16,6 +16,8 @@
 #ifndef __DRIVERS_CLK_TI_CLOCK__
 #define __DRIVERS_CLK_TI_CLOCK__
 
+#include <linux/clkdev.h>
+
 enum {
 	TI_CLK_FIXED,
 	TI_CLK_MUX,
@@ -189,6 +191,9 @@ struct ti_dt_clk {
 struct clk *ti_clk_register_divider(struct ti_clk *setup);
 struct clk *ti_clk_register_composite(struct ti_clk *setup);
 struct clk *ti_clk_register_dpll(struct ti_clk *setup);
+struct clk *ti_clk_register(struct device *dev, struct clk_hw *hw,
+			    const char *con);
+int ti_clk_add_alias(struct device *dev, struct clk *clk, const char *con);
 
 struct clk_hw *ti_clk_build_component_div(struct ti_clk_divider *setup);
 struct clk_hw *ti_clk_build_component_gate(struct ti_clk_gate *setup);
-- 
1.9.1

