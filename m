From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Subject: [PATCH v2 27/34] clk: ti: composite: change clk_pll_round_rate() return logic
Date: Mon,  1 Jan 2018 19:34:53 +0000
Message-ID: <1514835300-381-13-git-send-email-pure.logic@nexus-software.ie>
References: <1514835300-381-1-git-send-email-pure.logic@nexus-software.ie>
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1514835300-381-1-git-send-email-pure.logic@nexus-software.ie>
Sender: linux-clk-owner@vger.kernel.org
To: mturquette@baylibre.com, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc: Bryan O'Donoghue <pure.logic@nexus-software.ie>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This patch updates the round_rate() logic here to return zero instead of a
negative number on error.

In conjunction with higher-level changes associated with acting on the
return value of clk_ops->round_rate() it is then possible to have
clk_ops->round_rate() return values from 1 Hz to ULONG_MAX Hz instead of
the current limitation of 1 Hz to LONG_MAX Hz.

Signed-off-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-omap@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/clk/ti/composite.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/ti/composite.c b/drivers/clk/ti/composite.c
index 2477cf1..0e82b61 100644
--- a/drivers/clk/ti/composite.c
+++ b/drivers/clk/ti/composite.c
@@ -38,7 +38,7 @@ static unsigned long ti_composite_round_rate(struct clk_hw *hw,
 					     unsigned long rate,
 					     unsigned long *prate)
 {
-	return -EINVAL;
+	return 0;
 }
 
 static int ti_composite_set_rate(struct clk_hw *hw, unsigned long rate,
-- 
2.7.4

