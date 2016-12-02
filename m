From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH] clk: ti: divider: Add the table parsing to get the best divider value
Date: Fri, 2 Dec 2016 14:35:43 +0530
Message-ID: <1480669543-16197-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: t-kristo@ti.com
Cc: mturquette@baylibre.com, sboyd@codeaurora.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

Currently the divider selection logic blindly divides the parent_rate
by the clk rate and gives the divider value for the divider clocks
which do not have the CLK_SET_RATE_PARENT flag set. Add the clk divider
table parsing to get the closest divider available in the table
provided via Device tree.

The code is pretty much taken from: drivers/clk/clk-divider.c.
and used here to fix up the best divider selection logic.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Reported-by: Richard Woodruff <r-woodruff2@ti.com>
---
 drivers/clk/ti/divider.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ti/divider.c b/drivers/clk/ti/divider.c
index b4e5de1..6bb8778 100644
--- a/drivers/clk/ti/divider.c
+++ b/drivers/clk/ti/divider.c
@@ -140,6 +140,35 @@ static bool _is_valid_div(struct clk_divider *divider, unsigned int div)
 	return true;
 }
 
+static int _div_round_up(const struct clk_div_table *table,
+			 unsigned long parent_rate, unsigned long rate)
+{
+	const struct clk_div_table *clkt;
+	int up = INT_MAX;
+	int div = DIV_ROUND_UP_ULL((u64)parent_rate, rate);
+
+	for (clkt = table; clkt->div; clkt++) {
+		if (clkt->div == div)
+			return clkt->div;
+		else if (clkt->div < div)
+			continue;
+
+		if ((clkt->div - div) < (up - div))
+			up = clkt->div;
+	}
+
+	return up;
+}
+
+static int _div_round(const struct clk_div_table *table,
+		      unsigned long parent_rate, unsigned long rate)
+{
+	if (!table)
+		return DIV_ROUND_UP(parent_rate, rate);
+
+	return _div_round_up(table, parent_rate, rate);
+}
+
 static int ti_clk_divider_bestdiv(struct clk_hw *hw, unsigned long rate,
 				  unsigned long *best_parent_rate)
 {
@@ -155,7 +184,7 @@ static int ti_clk_divider_bestdiv(struct clk_hw *hw, unsigned long rate,
 
 	if (!(clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT)) {
 		parent_rate = *best_parent_rate;
-		bestdiv = DIV_ROUND_UP(parent_rate, rate);
+		bestdiv = _div_round(divider->table, parent_rate, rate);
 		bestdiv = bestdiv == 0 ? 1 : bestdiv;
 		bestdiv = bestdiv > maxdiv ? maxdiv : bestdiv;
 		return bestdiv;
-- 
1.9.1
