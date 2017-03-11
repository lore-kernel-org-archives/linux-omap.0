From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 07/15] clk: ti: enforce const types on string arrays
Date: Sat, 11 Mar 2017 14:49:58 +0200
Message-ID: <1489236606-24023-8-git-send-email-t-kristo@ti.com>
References: <1489236606-24023-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1489236606-24023-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, tony@atomide.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Constant string arrays should use const char * const instead of just
const char *. Change the implementations using these to proper type.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 drivers/clk/ti/clock.h     | 2 +-
 drivers/clk/ti/composite.c | 2 +-
 drivers/clk/ti/mux.c       | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/ti/clock.h b/drivers/clk/ti/clock.h
index ecf82d8..cb906a1 100644
--- a/drivers/clk/ti/clock.h
+++ b/drivers/clk/ti/clock.h
@@ -86,7 +86,7 @@ struct ti_clk_mux {
 	int num_parents;
 	u16 reg;
 	u8 module;
-	const char **parents;
+	const char * const *parents;
 	u16 flags;
 };
 
diff --git a/drivers/clk/ti/composite.c b/drivers/clk/ti/composite.c
index 3f60f99..beea894 100644
--- a/drivers/clk/ti/composite.c
+++ b/drivers/clk/ti/composite.c
@@ -124,7 +124,7 @@ struct clk *ti_clk_register_composite(struct ti_clk *setup)
 	struct clk_hw *mux;
 	struct clk_hw *div;
 	int num_parents = 1;
-	const char **parent_names = NULL;
+	const char * const *parent_names = NULL;
 	struct clk *clk;
 	int ret;
 
diff --git a/drivers/clk/ti/mux.c b/drivers/clk/ti/mux.c
index 0da149e..3cc6db4 100644
--- a/drivers/clk/ti/mux.c
+++ b/drivers/clk/ti/mux.c
@@ -97,10 +97,10 @@ static int ti_clk_mux_set_parent(struct clk_hw *hw, u8 index)
 };
 
 static struct clk *_register_mux(struct device *dev, const char *name,
-				 const char **parent_names, u8 num_parents,
-				 unsigned long flags, void __iomem *reg,
-				 u8 shift, u32 mask, u8 clk_mux_flags,
-				 u32 *table)
+				 const char * const *parent_names,
+				 u8 num_parents, unsigned long flags,
+				 void __iomem *reg, u8 shift, u32 mask,
+				 u8 clk_mux_flags, u32 *table)
 {
 	struct clk_mux *mux;
 	struct clk *clk;
-- 
1.9.1

