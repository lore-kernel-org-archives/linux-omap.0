From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: [PATCH 1/8] clk: divider: fix rate calculation for fractional rates
Date: Thu, 13 Feb 2014 12:03:59 +0200
Message-ID: <1392285846-13199-2-git-send-email-tomi.valkeinen@ti.com>
References: <1392285846-13199-1-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36688 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753854AbaBMKFC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Feb 2014 05:05:02 -0500
In-Reply-To: <1392285846-13199-1-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Mike Turquette <mturquette@linaro.org>

clk-divider.c does not calculate the rates consistently at the moment.

As an example, on OMAP3 we have a clock divider with a source clock of
864000000 Hz. With dividers 6, 7 and 8 the theoretical rates are:

6: 144000000
7: 123428571.428571...
8: 108000000

Calling clk_round_rate() with the rate in the first column will give the
rate in the second column:

144000000 -> 144000000
143999999 -> 123428571
123428572 -> 123428571
123428571 -> 108000000

Note how clk_round_rate() returns 123428571 for rates from 123428572 to
143999999, which is mathematically correct, but when clk_round_rate() is
called with 123428571, the returned value is surprisingly 108000000.

This means that the following code works a bit oddly:

rate = clk_round_rate(clk, 123428572);
clk_set_rate(clk, rate);

As clk_set_rate() also does clock rate rounding, the result is that the
clock is set to the rate of 108000000, not 123428571 returned by the
clk_round_rate.

This patch changes the clk-divider.c to use DIV_ROUND_UP when
calculating the rate. This gives the following behavior which fixes the
inconsistency:

144000000 -> 144000000
143999999 -> 123428572
123428572 -> 123428572
123428571 -> 108000000

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Mike Turquette <mturquette@linaro.org>
---
 drivers/clk/clk-divider.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index 5543b7df8e16..ec22112e569f 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -24,7 +24,7 @@
  * Traits of this clock:
  * prepare - clk_prepare only ensures that parents are prepared
  * enable - clk_enable only ensures that parents are enabled
- * rate - rate is adjustable.  clk->rate = parent->rate / divisor
+ * rate - rate is adjustable.  clk->rate = DIV_ROUND_UP(parent->rate / divisor)
  * parent - fixed parent.  No clk_set_parent support
  */
 
@@ -115,7 +115,7 @@ static unsigned long clk_divider_recalc_rate(struct clk_hw *hw,
 		return parent_rate;
 	}
 
-	return parent_rate / div;
+	return DIV_ROUND_UP(parent_rate, div);
 }
 
 /*
@@ -185,7 +185,7 @@ static int clk_divider_bestdiv(struct clk_hw *hw, unsigned long rate,
 		}
 		parent_rate = __clk_round_rate(__clk_get_parent(hw->clk),
 				MULT_ROUND_UP(rate, i));
-		now = parent_rate / i;
+		now = DIV_ROUND_UP(parent_rate, i);
 		if (now <= rate && now > best) {
 			bestdiv = i;
 			best = now;
@@ -207,7 +207,7 @@ static long clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
 	int div;
 	div = clk_divider_bestdiv(hw, rate, prate);
 
-	return *prate / div;
+	return DIV_ROUND_UP(*prate, div);
 }
 
 static int clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -218,7 +218,7 @@ static int clk_divider_set_rate(struct clk_hw *hw, unsigned long rate,
 	unsigned long flags = 0;
 	u32 val;
 
-	div = parent_rate / rate;
+	div = DIV_ROUND_UP(parent_rate, rate);
 	value = _get_val(divider, div);
 
 	if (value > div_mask(divider))
-- 
1.8.3.2

