From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 10/15] clk: ti: mux: convert TI mux clock to use its internal data representation
Date: Sat, 11 Mar 2017 14:50:01 +0200
Message-ID: <1489236606-24023-11-git-send-email-t-kristo@ti.com>
References: <1489236606-24023-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1489236606-24023-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, tony@atomide.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Instead of using the generic clock driver data struct, use one internal
for the TI clock driver itself. This allows modifying the register access
parts in subsequent patch.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 drivers/clk/ti/clock.h | 11 +++++++++++
 drivers/clk/ti/mux.c   | 10 +++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index cb906a1..41913bf 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -16,6 +16,17 @@
 #ifndef __DRIVERS_CLK_TI_CLOCK__
 #define __DRIVERS_CLK_TI_CLOCK__
 
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

