From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH] clk: ti: omap3+: dpll: use non-locking version of clk_get_rate
Date: Thu, 28 Jan 2016 13:37:47 +0200
Message-ID: <1453981067-8618-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, tony@atomide.com, mturquette@baylibre.com, sboyd@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

As the code in this file is being executed within irq context in some
cases, we must avoid the clk_get_rate which uses mutex internally.
Switch the code to use clk_hw_get_rate instead which is non-locking.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/dpll3xxx.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ti/dpll3xxx.c b/drivers/clk/ti/dpll3xxx.c
index f4dec00..7ed24bc 100644
--- a/drivers/clk/ti/dpll3xxx.c
+++ b/drivers/clk/ti/dpll3xxx.c
@@ -437,7 +437,8 @@ int omap3_noncore_dpll_enable(struct clk_hw *hw)
 
 	parent = clk_hw_get_parent(hw);
 
-	if (clk_hw_get_rate(hw) == clk_get_rate(dd->clk_bypass)) {
+	if (clk_hw_get_rate(hw) ==
+	    clk_hw_get_rate(__clk_get_hw(dd->clk_bypass))) {
 		WARN_ON(parent != __clk_get_hw(dd->clk_bypass));
 		r = _omap3_noncore_dpll_bypass(clk);
 	} else {
-- 
1.7.9.5

