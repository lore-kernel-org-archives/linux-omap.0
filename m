From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 10/15] clk: ti: mux: convert TI mux clock to use its internal data representation
Date: Mon, 13 Feb 2017 11:35:06 +0200
Message-ID: <1486978511-29668-11-git-send-email-t-kristo@ti.com>
References: <1486978511-29668-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1486978511-29668-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Instead of using the generic clock driver data struct, use one internal
for the TI clock driver itself. This allows modifying the register access
parts in subsequent patch.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/clock.h | 11 +++++++++++
 drivers/clk/ti/mux.c   | 10 +++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index a2d16190..4d0ace2 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -18,6 +18,17 @@
 
 #include <linux/clkdev.h>
 
+struct clk_omap_mux {
+	struct clk_hw		hw;
+	void __iomem		*reg;
+	u32			*table;
+	u32			mask;
+	u8			shift;
+	u8			flags;
+};
+
+#define to_clk_omap_mux(_hw) container_of(_hw, struct clk_omap_mux, hw)
+
 enum {
 	TI_CLK_FIXED,
 	TI_CLK_MUX,
diff --git a/drivers/clk/ti/mux.c b/drivers/clk/ti/mux.c
index 3cc6db4..daa2dee 100644
--- a/drivers/clk/ti/mux.c
+++ b/drivers/clk/ti/mux.c
@@ -28,7 +28,7 @@
 
 static u8 ti_clk_mux_get_parent(struct clk_hw *hw)
 {
-	struct clk_mux *mux = to_clk_mux(hw);
+	struct clk_omap_mux *mux = to_clk_omap_mux(hw);
 	int num_parents = clk_hw_get_num_parents(hw);
 	u32 val;
 
@@ -65,7 +65,7 @@ static u8 ti_clk_mux_get_parent(struct clk_hw *hw)
 
 static int ti_clk_mux_set_parent(struct clk_hw *hw, u8 index)
 {
-	struct clk_mux *mux = to_clk_mux(hw);
+	struct clk_omap_mux *mux = to_clk_omap_mux(hw);
 	u32 val;
 
 	if (mux->table) {
@@ -102,7 +102,7 @@ static struct clk *_register_mux(struct device *dev, const char *name,
 				 void __iomem *reg, u8 shift, u32 mask,
 				 u8 clk_mux_flags, u32 *table)
 {
-	struct clk_mux *mux;
+	struct clk_omap_mux *mux;
 	struct clk *clk;
 	struct clk_init_data init;
 
@@ -229,7 +229,7 @@ static void of_mux_clk_setup(struct device_node *node)
 
 struct clk_hw *ti_clk_build_component_mux(struct ti_clk_mux *setup)
 {
-	struct clk_mux *mux;
+	struct clk_omap_mux *mux;
 	struct clk_omap_reg *reg;
 	int num_parents;
 
@@ -260,7 +260,7 @@ struct clk_hw *ti_clk_build_component_mux(struct ti_clk_mux *setup)
 
 static void __init of_ti_composite_mux_clk_setup(struct device_node *node)
 {
-	struct clk_mux *mux;
+	struct clk_omap_mux *mux;
 	unsigned int num_parents;
 	u32 val;
 
-- 
1.9.1

