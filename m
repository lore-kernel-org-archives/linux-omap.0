From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 01/27] clk: ti: clkctrl: fix error messages to print out node name properly
Date: Mon, 30 Oct 2017 15:04:19 +0200
Message-ID: <1509368685-29112-2-git-send-email-t-kristo@ti.com>
References: <1509368685-29112-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1509368685-29112-1-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: linux-clk@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

Current node name does not convey any information, as it is always "clk".
Instead, print out the full node path, which will tell us better where
something went wrong.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 drivers/clk/ti/clkctrl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
index 53e71d0..2db7d40 100644
--- a/drivers/clk/ti/clkctrl.c
+++ b/drivers/clk/ti/clkctrl.c
@@ -351,8 +351,8 @@ static struct clk_hw *_ti_omap4_clkctrl_xlate(struct of_phandle_args *clkspec,
 	if (ti_clk_parse_divider_data((int *)div_data->dividers,
 				      div_data->max_div, 0, 0,
 				      &div->width, &div->table)) {
-		pr_err("%s: Data parsing for %s:%04x:%d failed\n", __func__,
-		       node->name, offset, data->bit);
+		pr_err("%s: Data parsing for %pOF:%04x:%d failed\n", __func__,
+		       node, offset, data->bit);
 		kfree(div);
 		return;
 	}
@@ -428,7 +428,7 @@ static void __init _ti_omap4_clkctrl_setup(struct device_node *node)
 	}
 
 	if (!data->addr) {
-		pr_err("%s not found from clkctrl data.\n", node->name);
+		pr_err("%pOF not found from clkctrl data.\n", node);
 		return;
 	}
 
-- 
1.9.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
