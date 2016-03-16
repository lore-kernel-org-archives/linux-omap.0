From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 1/3] clk: ti: dpll: add support for specifying max rate for DPLLs
Date: Wed, 16 Mar 2016 21:54:55 +0200
Message-ID: <1458158097-21137-2-git-send-email-t-kristo@ti.com>
References: <1458158097-21137-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1458158097-21137-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>
List-Id: linux-omap@vger.kernel.org

DPLLs typically have a maximum rate they can support, and this varies
from DPLL to DPLL. Add support of the maximum rate value to the DPLL
data struct, and also add check for this in the DPLL round_rate function.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Lokesh Vutla <lokeshvutla@ti.com>
---
 drivers/clk/ti/clkt_dpll.c |    3 +++
 include/linux/clk/ti.h     |    2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/clk/ti/clkt_dpll.c b/drivers/clk/ti/clkt_dpll.c
index b5cc6f6..7d97b07 100644
--- a/drivers/clk/ti/clkt_dpll.c
+++ b/drivers/clk/ti/clkt_dpll.c
@@ -301,6 +301,9 @@ long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rate,
 
 	dd = clk->dpll_data;
 
+	if (dd->max_rate && target_rate > dd->max_rate)
+		target_rate = dd->max_rate;
+
 	ref_rate = clk_get_rate(dd->clk_ref);
 	clk_name = clk_hw_get_name(hw);
 	pr_debug("clock: %s: starting DPLL round_rate, target rate %lu\n",
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 9a63860..1a48ee2 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -37,6 +37,7 @@
  * @last_rounded_n: cache of the last N result of omap2_dpll_round_rate()
  * @min_divider: minimum valid non-bypass divider value (actual)
  * @max_divider: maximum valid non-bypass divider value (actual)
+ * @max_rate: maximum clock rate for the DPLL
  * @modes: possible values of @enable_mask
  * @autoidle_reg: register containing the DPLL autoidle mode bitfield
  * @idlest_reg: register containing the DPLL idle status bitfield
@@ -81,6 +82,7 @@ struct dpll_data {
 	u8			last_rounded_n;
 	u8			min_divider;
 	u16			max_divider;
+	unsigned long		max_rate;
 	u8			modes;
 	void __iomem		*autoidle_reg;
 	void __iomem		*idlest_reg;
-- 
1.7.9.5

