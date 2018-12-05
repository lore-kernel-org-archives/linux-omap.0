From: Rob Herring <robh@kernel.org>
Subject: [PATCH] clk: Use of_node_name_eq for node name comparisons
Date: Wed,  5 Dec 2018 13:50:21 -0600
Message-ID: <20181205195050.4759-5-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Stephen Boyd <sboyd@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

For instances using of_node_cmp, this has the side effect of now using
case sensitive comparisons. This should not matter for any FDT based
system which all of these are.

Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-renesas-soc@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Cc: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/clk/renesas/clk-mstp.c   |  2 +-
 drivers/clk/ti/clkctrl.c         |  2 +-
 drivers/clk/ti/dpll.c            |  2 +-
 drivers/clk/ux500/u8500_of_clk.c | 10 +++++-----
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/renesas/clk-mstp.c b/drivers/clk/renesas/clk-mstp.c
index 1c1768c2cc82..765175d1148a 100644
--- a/drivers/clk/renesas/clk-mstp.c
+++ b/drivers/clk/renesas/clk-mstp.c
@@ -280,7 +280,7 @@ int cpg_mstp_attach_dev(struct generic_pm_domain *unused, struct device *dev)
 			goto found;
 
 		/* BSC on r8a73a4/sh73a0 uses zb_clk instead of an mstp clock */
-		if (!strcmp(clkspec.np->name, "zb_clk"))
+		if (of_node_name_eq(clkspec.np, "zb_clk"))
 			goto found;
 
 		of_node_put(clkspec.np);
diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
index 469f560ae1cf..40630eb950fc 100644
--- a/drivers/clk/ti/clkctrl.c
+++ b/drivers/clk/ti/clkctrl.c
@@ -448,7 +448,7 @@ static void __init _ti_omap4_clkctrl_setup(struct device_node *node)
 	char *c;
 
 	if (!(ti_clk_get_features()->flags & TI_CLK_CLKCTRL_COMPAT) &&
-	    !strcmp(node->name, "clk"))
+	    of_node_name_eq(node, "clk"))
 		ti_clk_features.flags |= TI_CLK_CLKCTRL_COMPAT;
 
 	addrp = of_get_address(node, 0, NULL, NULL);
diff --git a/drivers/clk/ti/dpll.c b/drivers/clk/ti/dpll.c
index 92e28af7afba..6c3329bc116f 100644
--- a/drivers/clk/ti/dpll.c
+++ b/drivers/clk/ti/dpll.c
@@ -410,7 +410,7 @@ static void __init of_ti_omap3_dpll_setup(struct device_node *node)
 
 	if ((of_machine_is_compatible("ti,omap3630") ||
 	     of_machine_is_compatible("ti,omap36xx")) &&
-	    !strcmp(node->name, "dpll5_ck"))
+	     of_node_name_eq(node, "dpll5_ck"))
 		of_ti_dpll_setup(node, &omap3_dpll5_ck_ops, &dd);
 	else
 		of_ti_dpll_setup(node, &omap3_dpll_ck_ops, &dd);
diff --git a/drivers/clk/ux500/u8500_of_clk.c b/drivers/clk/ux500/u8500_of_clk.c
index d5888591e1a9..18a3c4522831 100644
--- a/drivers/clk/ux500/u8500_of_clk.c
+++ b/drivers/clk/ux500/u8500_of_clk.c
@@ -545,21 +545,21 @@ static void u8500_clk_init(struct device_node *np)
 	for_each_child_of_node(np, child) {
 		static struct clk_onecell_data clk_data;
 
-		if (!of_node_cmp(child->name, "prcmu-clock")) {
+		if (of_node_name_eq(child, "prcmu-clock")) {
 			clk_data.clks = prcmu_clk;
 			clk_data.clk_num = ARRAY_SIZE(prcmu_clk);
 			of_clk_add_provider(child, of_clk_src_onecell_get, &clk_data);
 		}
-		if (!of_node_cmp(child->name, "prcc-periph-clock"))
+		if (of_node_name_eq(child, "prcc-periph-clock"))
 			of_clk_add_provider(child, ux500_twocell_get, prcc_pclk);
 
-		if (!of_node_cmp(child->name, "prcc-kernel-clock"))
+		if (of_node_name_eq(child, "prcc-kernel-clock"))
 			of_clk_add_provider(child, ux500_twocell_get, prcc_kclk);
 
-		if (!of_node_cmp(child->name, "rtc32k-clock"))
+		if (of_node_name_eq(child, "rtc32k-clock"))
 			of_clk_add_provider(child, of_clk_src_simple_get, rtc_clk);
 
-		if (!of_node_cmp(child->name, "smp-twd-clock"))
+		if (of_node_name_eq(child, "smp-twd-clock"))
 			of_clk_add_provider(child, of_clk_src_simple_get, twd_clk);
 	}
 }
-- 
2.19.1
