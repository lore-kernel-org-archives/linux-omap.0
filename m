From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv4 05/15] clk: ti: create clock aliases automatically for simple clock types
Date: Tue, 18 Oct 2016 18:45:58 +0300
Message-ID: <1476805568-19264-6-git-send-email-t-kristo@ti.com>
References: <1476805568-19264-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1476805568-19264-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, tony@atomide.com, mturquette@baylibre.com, sboyd@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

This patch generates clock aliases automatically for simple clock types
(fixed-clock, fixed-factor-clock), so that we don't need to add the data
for these statically into tables.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/clk.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index 91bad55..7fd9d8e 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -355,12 +355,20 @@ struct clk __init *ti_clk_register_clk(struct ti_clk *setup)
 	return clk;
 }
 
+static const struct of_device_id simple_clk_match_table[] __initconst = {
+	{ .compatible = "fixed-clock" },
+	{ .compatible = "fixed-factor-clock" },
+	{ }
+};
+
 int __init ti_clk_register_legacy_clks(struct ti_clk_alias *clks)
 {
 	struct clk *clk;
 	bool retry;
 	struct ti_clk_alias *retry_clk;
 	struct ti_clk_alias *tmp;
+	struct device_node *np;
+	int ret = 0;
 
 	while (clks->clk) {
 		clk = ti_clk_register_clk(clks->clk);
@@ -370,7 +378,14 @@ int __init ti_clk_register_legacy_clks(struct ti_clk_alias *clks)
 			} else {
 				pr_err("register for %s failed: %ld\n",
 				       clks->clk->name, PTR_ERR(clk));
-				return PTR_ERR(clk);
+				ret = PTR_ERR(clk);
+				/*
+				 * Aliases still need to be added here,
+				 * as we might be running on a
+				 * transitional system that has old DT
+				 * clock data in place.
+				 */
+				goto add_aliases;
 			}
 		} else {
 			clks->lk.clk = clk;
@@ -404,6 +419,18 @@ int __init ti_clk_register_legacy_clks(struct ti_clk_alias *clks)
 		}
 	}
 
+add_aliases:
+	/* add clock aliases for any fixed-clocks / fixed-factor-clocks */
+	if (of_have_populated_dt())
+		for_each_matching_node(np, simple_clk_match_table) {
+			struct of_phandle_args clkspec;
+
+			clkspec.np = np;
+			clk = of_clk_get_from_provider(&clkspec);
+
+			ti_clk_add_alias(NULL, clk, np->name);
+		}
+
 	return 0;
 }
 #endif
-- 
1.9.1

