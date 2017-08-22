From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] clk: ti: make clk_ops const
Date: Tue, 22 Aug 2017 18:41:15 +0530
Message-ID: <1503407475-11620-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, t-kristo@ti.com, mturquette@baylibre.com, sboyd@codeaurora.org, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: linux-omap@vger.kernel.org

Make these const as they are only stored in the const field of a
clk_init_data structure.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/clk/ti/adpll.c | 2 +-
 drivers/clk/ti/apll.c  | 2 +-
 drivers/clk/ti/fapll.c | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/ti/adpll.c b/drivers/clk/ti/adpll.c
index 255cafb..d5c6db4 100644
--- a/drivers/clk/ti/adpll.c
+++ b/drivers/clk/ti/adpll.c
@@ -486,7 +486,7 @@ static u8 ti_adpll_get_parent(struct clk_hw *hw)
 	return 0;
 }
 
-static struct clk_ops ti_adpll_ops = {
+static const struct clk_ops ti_adpll_ops = {
 	.prepare = ti_adpll_prepare,
 	.unprepare = ti_adpll_unprepare,
 	.is_prepared = ti_adpll_is_prepared,
diff --git a/drivers/clk/ti/apll.c b/drivers/clk/ti/apll.c
index 06f486b..83b148f 100644
--- a/drivers/clk/ti/apll.c
+++ b/drivers/clk/ti/apll.c
@@ -304,7 +304,7 @@ static void omap2_apll_disable(struct clk_hw *hw)
 	ti_clk_ll_ops->clk_writel(v, &ad->control_reg);
 }
 
-static struct clk_ops omap2_apll_ops = {
+static const struct clk_ops omap2_apll_ops = {
 	.enable		= &omap2_apll_enable,
 	.disable	= &omap2_apll_disable,
 	.is_enabled	= &omap2_apll_is_enabled,
diff --git a/drivers/clk/ti/fapll.c b/drivers/clk/ti/fapll.c
index 66a0d0e..071af44 100644
--- a/drivers/clk/ti/fapll.c
+++ b/drivers/clk/ti/fapll.c
@@ -268,7 +268,7 @@ static int ti_fapll_set_rate(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
-static struct clk_ops ti_fapll_ops = {
+static const struct clk_ops ti_fapll_ops = {
 	.enable = ti_fapll_enable,
 	.disable = ti_fapll_disable,
 	.is_enabled = ti_fapll_is_enabled,
@@ -478,7 +478,7 @@ static int ti_fapll_synth_set_rate(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }
 
-static struct clk_ops ti_fapll_synt_ops = {
+static const struct clk_ops ti_fapll_synt_ops = {
 	.enable = ti_fapll_synth_enable,
 	.disable = ti_fapll_synth_disable,
 	.is_enabled = ti_fapll_synth_is_enabled,
-- 
1.9.1
