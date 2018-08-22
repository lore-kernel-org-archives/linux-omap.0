From: Johan Hovold <johan@kernel.org>
Subject: [PATCH] clk: ti: fix OF child-node lookup
Date: Wed, 22 Aug 2018 11:03:19 +0200
Message-ID: <20180822090319.29167-1-johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
List-Id: linux-omap@vger.kernel.org

Fix child-node lookup which by using the wrong OF helper was searching
the whole tree depth-first, something which could end up matching an
unrelated node.

Also fix the related node-reference leaks.

Fixes: 5b385a45e001 ("clk: ti: add support for clkctrl aliases")
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/clk/ti/clk.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index 7d22e1af2247..27e0979b3158 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -129,7 +129,7 @@ int ti_clk_setup_ll_ops(struct ti_clk_ll_ops *ops)
 void __init ti_dt_clocks_register(struct ti_dt_clk oclks[])
 {
 	struct ti_dt_clk *c;
-	struct device_node *node;
+	struct device_node *node, *parent;
 	struct clk *clk;
 	struct of_phandle_args clkspec;
 	char buf[64];
@@ -164,8 +164,12 @@ void __init ti_dt_clocks_register(struct ti_dt_clk oclks[])
 			continue;
 
 		node = of_find_node_by_name(NULL, buf);
-		if (num_args)
-			node = of_find_node_by_name(node, "clk");
+		if (num_args) {
+			parent = node;
+			node = of_get_child_by_name(parent, "clk");
+			of_node_put(parent);
+		}
+
 		clkspec.np = node;
 		clkspec.args_count = num_args;
 		for (i = 0; i < num_args; i++) {
@@ -173,11 +177,12 @@ void __init ti_dt_clocks_register(struct ti_dt_clk oclks[])
 			if (ret) {
 				pr_warn("Bad tag in %s at %d: %s\n",
 					c->node_name, i, tags[i]);
+				of_node_put(node);
 				return;
 			}
 		}
 		clk = of_clk_get_from_provider(&clkspec);
-
+		of_node_put(node);
 		if (!IS_ERR(clk)) {
 			c->lk.clk = clk;
 			clkdev_add(&c->lk);
-- 
2.18.0
