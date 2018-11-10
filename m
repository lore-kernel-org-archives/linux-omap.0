From: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2 2/3] clk: ti: check clock type before doing autoidle ops
Date: Sat, 10 Nov 2018 21:31:14 +0100
Message-ID: <20181110203115.13335-3-andreas@kemnade.info>
References: <20181110203115.13335-1-andreas@kemnade.info>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181110203115.13335-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
To: t-kristo@ti.com, mturquette@baylibre.com, sboyd@kernel.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, bcousson@baylibre.com, paul@pwsan.com, tony@atomide.com, letux-kernel@openphoenux.org
Cc: Andreas Kemnade <andreas@kemnade.info>
List-Id: linux-omap@vger.kernel.org

Code might use autoidle api with clocks not being omap2 clocks,
so check if clock type is not basic

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
New in v2
---
 drivers/clk/ti/autoidle.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/ti/autoidle.c b/drivers/clk/ti/autoidle.c
index 161f67850393..5bdae5552d38 100644
--- a/drivers/clk/ti/autoidle.c
+++ b/drivers/clk/ti/autoidle.c
@@ -54,8 +54,12 @@ static DEFINE_SPINLOCK(autoidle_spinlock);
 int omap2_clk_deny_idle(struct clk *clk)
 {
 	struct clk_hw_omap *c;
+	struct clk_hw *hw = __clk_get_hw(clk);
 
-	c = to_clk_hw_omap(__clk_get_hw(clk));
+	if (clk_hw_get_flags(hw) & CLK_IS_BASIC)
+		return -EINVAL;
+
+	c = to_clk_hw_omap(hw);
 	if (c->ops && c->ops->deny_idle) {
 		unsigned long irqflags;
 
@@ -77,8 +81,12 @@ int omap2_clk_deny_idle(struct clk *clk)
 int omap2_clk_allow_idle(struct clk *clk)
 {
 	struct clk_hw_omap *c;
+	struct clk_hw *hw = __clk_get_hw(clk);
 
-	c = to_clk_hw_omap(__clk_get_hw(clk));
+	if (clk_hw_get_flags(hw) & CLK_IS_BASIC)
+		return -EINVAL;
+
+	c = to_clk_hw_omap(hw);
 	if (c->ops && c->ops->allow_idle) {
 		unsigned long irqflags;
 
-- 
2.11.0
