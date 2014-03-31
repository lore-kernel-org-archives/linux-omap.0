From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 11/55] CLK: TI: clockdomain: add support for retrying init
Date: Mon, 31 Mar 2014 18:15:50 +0300
Message-ID: <1396278994-12624-12-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49799 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753424AbaCaPRf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Mar 2014 11:17:35 -0400
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Retry init is needed if clockdomains are registered before the corresponding
clocks are ready. In this case, the clockdomain info is added to a list
which will be processed once the clockdomains for next PRCM module are
processed.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/prm_common.c |    3 +-
 drivers/clk/ti/clockdomain.c     |   77 ++++++++++++++++++++++++++++++++------
 include/linux/clk/ti.h           |    2 +-
 3 files changed, 68 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index b4ef9e4..2d63196 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -521,11 +521,10 @@ int __init of_prcm_init(void)
 		mem = of_iomap(np, 0);
 		clk_memmaps[memmap_index] = mem;
 		ti_dt_clk_init_provider(np, memmap_index);
+		ti_dt_clockdomains_setup(np);
 		memmap_index++;
 	}
 
-	ti_dt_clockdomains_setup();
-
 	return 0;
 }
 
diff --git a/drivers/clk/ti/clockdomain.c b/drivers/clk/ti/clockdomain.c
index f1e0038..29fa543 100644
--- a/drivers/clk/ti/clockdomain.c
+++ b/drivers/clk/ti/clockdomain.c
@@ -24,26 +24,60 @@
 #undef pr_fmt
 #define pr_fmt(fmt) "%s: " fmt, __func__
 
-static void __init of_ti_clockdomain_setup(struct device_node *node)
+struct clkdm_init_item {
+	struct device_node *node;
+	int index;
+	struct list_head link;
+};
+
+static LIST_HEAD(retry_list);
+
+static int of_ti_init_clk_clkdm(struct device_node *node, int index)
 {
 	struct clk *clk;
 	struct clk_hw *clk_hw;
-	const char *clkdm_name = node->name;
+
+	clk = of_clk_get(node, index);
+
+	if (IS_ERR_OR_NULL(clk)) {
+		pr_debug("%s[%d] = %08x\n", node->name, index, (u32)clk);
+		return -EBUSY;
+	}
+
+	if (__clk_get_flags(clk) & CLK_IS_BASIC) {
+		pr_warn("can't setup clkdm for basic clk %s\n",
+			__clk_get_name(clk));
+		return -EINVAL;
+	}
+
+	clk_hw = __clk_get_hw(clk);
+	to_clk_hw_omap(clk_hw)->clkdm_name = node->name;
+	omap2_init_clk_clkdm(clk_hw);
+
+	return 0;
+}
+
+static void __init of_ti_clockdomain_setup(struct device_node *node)
+{
 	int i;
 	int num_clks;
+	struct clkdm_init_item *retry;
+	int ret;
 
 	num_clks = of_count_phandle_with_args(node, "clocks", "#clock-cells");
 
 	for (i = 0; i < num_clks; i++) {
-		clk = of_clk_get(node, i);
-		if (__clk_get_flags(clk) & CLK_IS_BASIC) {
-			pr_warn("can't setup clkdm for basic clk %s\n",
-				__clk_get_name(clk));
+		ret = of_ti_init_clk_clkdm(node, i);
+
+		if (ret == -EBUSY) {
+			retry = kzalloc(sizeof(*retry), GFP_KERNEL);
+			if (!retry)
+				return;
+			retry->node = node;
+			retry->index = i;
+			list_add(&retry->link, &retry_list);
 			continue;
 		}
-		clk_hw = __clk_get_hw(clk);
-		to_clk_hw_omap(clk_hw)->clkdm_name = clkdm_name;
-		omap2_init_clk_clkdm(clk_hw);
 	}
 }
 
@@ -61,10 +95,31 @@ static struct of_device_id ti_clkdm_match_table[] __initdata = {
  * called after rest of the DT clock init has completed and all
  * clock nodes have been registered.
  */
-void __init ti_dt_clockdomains_setup(void)
+void __init ti_dt_clockdomains_setup(struct device_node *node)
 {
 	struct device_node *np;
-	for_each_matching_node(np, ti_clkdm_match_table) {
+	struct device_node *clkdms;
+	struct clkdm_init_item *retry, *tmp;
+	int ret;
+
+	clkdms = of_get_child_by_name(node, "clockdomains");
+	if (!clkdms)
+		return;
+
+	list_for_each_entry_safe(retry, tmp, &retry_list, link) {
+		pr_debug("retry-init: %s [%d]\n", retry->node->name,
+			 retry->index);
+		ret = of_ti_init_clk_clkdm(retry->node, retry->index);
+		if (!ret) {
+			list_del(&retry->link);
+			kfree(retry);
+		}
+	}
+
+	for_each_child_of_node(clkdms, np) {
+		if (!of_match_node(ti_clkdm_match_table, np))
+			continue;
+
 		of_ti_clockdomain_setup(np);
 	}
 }
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 03decc2..86e8ae4 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -284,7 +284,7 @@ void omap2xxx_clkt_vps_init(void);
 void __iomem *ti_clk_get_reg_addr(struct device_node *node, int index);
 void ti_dt_clocks_register(struct ti_dt_clk *oclks);
 void ti_dt_clk_init_provider(struct device_node *np, int index);
-void ti_dt_clockdomains_setup(void);
+void ti_dt_clockdomains_setup(struct device_node *node);
 int ti_clk_retry_init(struct device_node *node, struct clk_hw *hw,
 		      ti_of_clk_init_cb_t func);
 int of_ti_clk_autoidle_setup(struct device_node *node);
-- 
1.7.9.5

