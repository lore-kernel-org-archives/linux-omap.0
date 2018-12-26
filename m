From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] clk: ti: fix refcount leak in ti_dt_clocks_register()
Date: Wed, 26 Dec 2018 08:21:31 -0500
Message-ID: <20181226132131.4619-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: t-kristo@ti.com, mturquette@baylibre.com, sboyd@kernel.org
Cc: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-omap@vger.kernel.org

The of_find_compatible_node() returns a node pointer with refcount
incremented, but there is the lack of use of the of_node_put() when
done. Add the missing of_node_put() to release the refcount.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/clk/ti/clk.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index d0cd58534781..6c640838cdaa 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -191,9 +191,13 @@ void __init ti_dt_clocks_register(struct ti_dt_clk oclks[])
 			clkdev_add(&c->lk);
 		} else {
 			if (num_args && !has_clkctrl_data) {
-				if (of_find_compatible_node(NULL, NULL,
-							    "ti,clkctrl")) {
+				struct device_node *np;
+
+				np = of_find_compatible_node(NULL, NULL,
+					       		     "ti,clkctrl");	
+				if (np) {
 					has_clkctrl_data = true;
+					of_node_put(np);
 				} else {
 					clkctrl_nodes_missing = true;
 
-- 
2.17.0
