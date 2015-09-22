From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] clk: ti: Fix FAPLL udelay in clk_enable with clk_prepare
Date: Tue, 22 Sep 2015 14:23:05 -0700
Message-ID: <1442956985-32642-1-git-send-email-tony@atomide.com>
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, Brian Hutchinson <b.hutchman@gmail.com>, Felipe Balbi <balbi@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

As recently pointed out (again) by Thomas and Russell, we must not
wait in in clk_enable. The wait for PLL to lock needs to happen
in clk_prepare instead.

It seems this is a common copy paste error with the PLL drivers,
and similar fixes should be applied to other PLL drivers after
testing.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/clk/ti/fapll.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/ti/fapll.c b/drivers/clk/ti/fapll.c
index f4b2e98..e1db74a 100644
--- a/drivers/clk/ti/fapll.c
+++ b/drivers/clk/ti/fapll.c
@@ -37,7 +37,7 @@
 #define FAPLL_PWD_OFFSET	4
 
 #define MAX_FAPLL_OUTPUTS	7
-#define FAPLL_MAX_RETRIES	1000
+#define FAPLL_MAX_RETRIES	5
 
 #define to_fapll(_hw)		container_of(_hw, struct fapll_data, hw)
 #define to_synth(_hw)		container_of(_hw, struct fapll_synth, hw)
@@ -126,7 +126,7 @@ static int ti_fapll_wait_lock(struct fapll_data *fd)
 		if (retries-- <= 0)
 			break;
 
-		udelay(1);
+		usleep_range(200, 300);
 	}
 
 	pr_err("%s failed to lock\n", fd->name);
@@ -134,7 +134,7 @@ static int ti_fapll_wait_lock(struct fapll_data *fd)
 	return -ETIMEDOUT;
 }
 
-static int ti_fapll_enable(struct clk_hw *hw)
+static int ti_fapll_prepare(struct clk_hw *hw)
 {
 	struct fapll_data *fd = to_fapll(hw);
 	u32 v = readl_relaxed(fd->base);
@@ -146,7 +146,7 @@ static int ti_fapll_enable(struct clk_hw *hw)
 	return 0;
 }
 
-static void ti_fapll_disable(struct clk_hw *hw)
+static void ti_fapll_unprepare(struct clk_hw *hw)
 {
 	struct fapll_data *fd = to_fapll(hw);
 	u32 v = readl_relaxed(fd->base);
@@ -155,7 +155,7 @@ static void ti_fapll_disable(struct clk_hw *hw)
 	writel_relaxed(v, fd->base);
 }
 
-static int ti_fapll_is_enabled(struct clk_hw *hw)
+static int ti_fapll_is_prepared(struct clk_hw *hw)
 {
 	struct fapll_data *fd = to_fapll(hw);
 	u32 v = readl_relaxed(fd->base);
@@ -261,7 +261,7 @@ static int ti_fapll_set_rate(struct clk_hw *hw, unsigned long rate,
 	v |= pre_div_p << FAPLL_MAIN_DIV_P_SHIFT;
 	v |= mult_n << FAPLL_MAIN_MULT_N_SHIFT;
 	writel_relaxed(v, fd->base);
-	if (ti_fapll_is_enabled(hw))
+	if (ti_fapll_is_prepared(hw))
 		ti_fapll_wait_lock(fd);
 	ti_fapll_clear_bypass(fd);
 
@@ -269,9 +269,9 @@ static int ti_fapll_set_rate(struct clk_hw *hw, unsigned long rate,
 }
 
 static struct clk_ops ti_fapll_ops = {
-	.enable = ti_fapll_enable,
-	.disable = ti_fapll_disable,
-	.is_enabled = ti_fapll_is_enabled,
+	.prepare = ti_fapll_prepare,
+	.unprepare = ti_fapll_unprepare,
+	.is_prepared = ti_fapll_is_prepared,
 	.recalc_rate = ti_fapll_recalc_rate,
 	.get_parent = ti_fapll_get_parent,
 	.round_rate = ti_fapll_round_rate,
-- 
2.1.4

