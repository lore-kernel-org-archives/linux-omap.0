From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 03/27] clk: ti: add support for clkctrl aliases
Date: Mon, 30 Oct 2017 15:04:21 +0200
Message-ID: <1509368685-29112-4-git-send-email-t-kristo@ti.com>
References: <1509368685-29112-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1509368685-29112-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

hwmod core still depends on certain clocks being found by name, so we
need to add support for adding clkctrl clock aliases. This patch can
be reverted when no longer needed by hwmod core code.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/clk.c | 58 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index e5a1c82..10a7045 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -108,18 +108,70 @@ void __init ti_dt_clocks_register(struct ti_dt_clk oclks[])
 	struct device_node *node;
 	struct clk *clk;
 	struct of_phandle_args clkspec;
+	char buf[64];
+	char *ptr;
+	char *tags[2];
+	int i;
+	int num_args;
+	int ret;
+	static bool clkctrl_nodes_missing;
+	static bool has_clkctrl_data;
 
 	for (c = oclks; c->node_name != NULL; c++) {
-		node = of_find_node_by_name(NULL, c->node_name);
+		strcpy(buf, c->node_name);
+		ptr = buf;
+		for (i = 0; i < 2; i++)
+			tags[i] = NULL;
+		num_args = 0;
+		while (*ptr) {
+			if (*ptr == ':') {
+				if (num_args >= 2) {
+					pr_warn("Bad number of tags on %s\n",
+						c->node_name);
+					return;
+				}
+				tags[num_args++] = ptr + 1;
+				*ptr = 0;
+			}
+			ptr++;
+		}
+
+		if (num_args && clkctrl_nodes_missing)
+			continue;
+
+		node = of_find_node_by_name(NULL, buf);
+		if (num_args)
+			node = of_find_node_by_name(node, "clk");
 		clkspec.np = node;
+		clkspec.args_count = num_args;
+		for (i = 0; i < num_args; i++) {
+			ret = kstrtoint(tags[i], i ? 10 : 16, clkspec.args + i);
+			if (ret) {
+				pr_warn("Bad tag in %s at %d: %s\n",
+					c->node_name, i, tags[i]);
+				return;
+			}
+		}
 		clk = of_clk_get_from_provider(&clkspec);
 
 		if (!IS_ERR(clk)) {
 			c->lk.clk = clk;
 			clkdev_add(&c->lk);
 		} else {
-			pr_warn("failed to lookup clock node %s\n",
-				c->node_name);
+			if (num_args && !has_clkctrl_data) {
+				if (of_find_compatible_node(NULL, NULL,
+							    "ti,clkctrl")) {
+					has_clkctrl_data = true;
+				} else {
+					clkctrl_nodes_missing = true;
+
+					pr_warn("missing clkctrl nodes, please update your dts.\n");
+					continue;
+				}
+			}
+
+			pr_warn("failed to lookup clock node %s, ret=%ld\n",
+				c->node_name, PTR_ERR(clk));
 		}
 	}
 }
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
