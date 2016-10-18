From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 10/15] clk: ti: add support API for fetching memmap index
Date: Tue, 18 Oct 2016 18:46:03 +0300
Message-ID: <1476805568-19264-11-git-send-email-t-kristo@ti.com>
References: <1476805568-19264-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1476805568-19264-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, tony@atomide.com, mturquette@baylibre.com, sboyd@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Searches for a memmap index for a given node. Checks against all the
registered iomaps and sees if the node is registered for this.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/clk.c   | 24 ++++++++++++++++++++++++
 drivers/clk/ti/clock.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index 7a445f4..8bebda4 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -39,6 +39,7 @@
 struct clk_iomap {
 	struct regmap *regmap;
 	void __iomem *mem;
+	struct device_node *node;
 };
 
 static struct clk_iomap *clk_memmaps[CLK_MAX_MEMMAPS];
@@ -199,6 +200,28 @@ void __iomem *ti_clk_get_reg_addr(struct device_node *node, int index)
 }
 
 /**
+ * ti_clk_get_memmap_index - get memory mapping index for a node
+ * @node: device node pointer to find memmap index for
+ *
+ * Finds a matching memory mapping index for a node. Returns the index
+ * to the mapping, or negative error value in failure.
+ */
+int ti_clk_get_memmap_index(struct device_node *node)
+{
+	int i;
+
+	for (i = 0; i < CLK_MAX_MEMMAPS; i++) {
+		if (!clk_memmaps[i])
+			continue;
+
+		if (clk_memmaps[i]->node == node)
+			return i;
+	}
+
+	return -ENOENT;
+}
+
+/**
  * omap2_clk_provider_init - init master clock provider
  * @parent: master node
  * @index: internal index for clk_reg_ops
@@ -234,6 +257,7 @@ int __init omap2_clk_provider_init(struct device_node *parent, int index,
 
 	io->regmap = syscon;
 	io->mem = mem;
+	io->node = parent;
 
 	clk_memmaps[index] = io;
 
diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index 9c85a51..9b8a5f2 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -203,6 +203,7 @@ struct clk *ti_clk_register(struct device *dev, struct clk_hw *hw,
 struct clk *ti_clk_register_clk(struct ti_clk *setup);
 int ti_clk_register_clks(struct ti_clk_alias *clks);
 
+int ti_clk_get_memmap_index(struct device_node *node);
 void __iomem *ti_clk_get_reg_addr(struct device_node *node, int index);
 void ti_dt_clocks_register(struct ti_dt_clk *oclks);
 int ti_clk_retry_init(struct device_node *node, struct clk_hw *hw,
-- 
1.9.1

