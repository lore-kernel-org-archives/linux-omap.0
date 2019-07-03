From: Fuqian Huang <huangfq.daxian@gmail.com>
Subject: [PATCH v2 05/35] clk/ti: Use kmemdup rather than duplicating its implementation
Date: Thu,  4 Jul 2019 00:27:00 +0800
Message-ID: <20190703162700.32091-1-huangfq.daxian@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Tero Kristo <t-kristo@ti.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Fuqian Huang <huangfq.daxian@gmail.com>
List-Id: linux-omap@vger.kernel.org

kmemdup is introduced to duplicate a region of memory in a neat way.
Rather than kmalloc/kzalloc + memcpy, which the programmer needs to
write the size twice (sometimes lead to mistakes), kmemdup improves
readability, leads to smaller code and also reduce the chances of mistakes.
Suggestion to use kmemdup rather than using kmalloc/kzalloc + memcpy.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v2:
  - Fix a typo in commit message (memset -> memcpy)

 drivers/clk/ti/dpll.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
index 659dadb23279..f728d987ebac 100644
--- a/drivers/clk/ti/dpll.c
+++ b/drivers/clk/ti/dpll.c
@@ -291,14 +291,12 @@ static void __init of_ti_dpll_setup(struct device_node *node,
 	struct dpll_data *dd = NULL;
 	u8 dpll_mode = 0;
 
-	dd = kzalloc(sizeof(*dd), GFP_KERNEL);
+	dd = kmemdup(ddt, sizeof(*dd), GFP_KERNEL);
 	clk_hw = kzalloc(sizeof(*clk_hw), GFP_KERNEL);
 	init = kzalloc(sizeof(*init), GFP_KERNEL);
 	if (!dd || !clk_hw || !init)
 		goto cleanup;
 
-	memcpy(dd, ddt, sizeof(*dd));
-
 	clk_hw->dpll_data = dd;
 	clk_hw->ops = &clkhwops_omap3_dpll;
 	clk_hw->hw.init = init;
-- 
2.11.0
