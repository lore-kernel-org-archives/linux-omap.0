From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 32/39] clk: ti: fix OF child-node lookup
Date: Tue, 13 Nov 2018 00:50:46 -0500
Message-ID: <20181113055053.78352-32-sashal@kernel.org>
References: <20181113055053.78352-1-sashal@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181113055053.78352-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 00a461cc32ec27fa7bd9c874a7b36b0c6c542c12 ]

Fix child-node lookup which by using the wrong OF helper was searching
the whole tree depth-first, something which could end up matching an
unrelated node.

Also fix the related node-reference leaks.

Fixes: 5b385a45e001 ("clk: ti: add support for clkctrl aliases")
Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
2.17.1
