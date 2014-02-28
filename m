From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 10/12] ARM: OMAP2: clock: add DT boot support for cpufreq_ck
Date: Fri, 28 Feb 2014 11:23:02 +0200
Message-ID: <1393579384-23440-11-git-send-email-t-kristo@ti.com>
References: <1393579384-23440-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59093 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751240AbaB1JYb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 28 Feb 2014 04:24:31 -0500
In-Reply-To: <1393579384-23440-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

The clock and clkdev for this are added manually.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c |   46 ++++++++++++++++++++++++++
 drivers/clk/ti/clk-2xxx.c                    |    2 ++
 include/linux/clk/ti.h                       |    1 +
 3 files changed, 49 insertions(+)

diff --git a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
index b935ed2..09af46c 100644
--- a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
+++ b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
@@ -208,3 +208,56 @@ void omap2xxx_clkt_vps_late_init(void)
 		clk_put(c);
 	}
 }
+
+#ifdef CONFIG_OF
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+
+static const struct clk_ops virt_prcm_set_ops = {
+	.recalc_rate	= &omap2_table_mpu_recalc,
+	.set_rate	= &omap2_select_table_rate,
+	.round_rate	= &omap2_round_to_table_rate,
+};
+
+/**
+ * omap2xxx_clkt_vps_init - initialize virt_prcm_set clock
+ *
+ * Does a manual init for the virtual prcm DVFS clock for OMAP2. This
+ * function is called only from omap2 DT clock init, as the virtual
+ * node is not modelled in the DT clock data.
+ */
+void omap2xxx_clkt_vps_init(void)
+{
+	struct clk_init_data init = { NULL };
+	struct clk_hw_omap *hw = NULL;
+	struct clk *clk;
+	const char *parent_name = "mpu_ck";
+	struct clk_lookup *lookup = NULL;
+
+	omap2xxx_clkt_vps_late_init();
+	omap2xxx_clkt_vps_check_bootloader_rates();
+
+	hw = kzalloc(sizeof(*hw), GFP_KERNEL);
+	lookup = kzalloc(sizeof(*lookup), GFP_KERNEL);
+	if (!hw || !lookup)
+		goto cleanup;
+	init.name = "virt_prcm_set";
+	init.ops = &virt_prcm_set_ops;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+
+	hw->hw.init = &init;
+
+	clk = clk_register(NULL, &hw->hw);
+
+	lookup->dev_id = NULL;
+	lookup->con_id = "cpufreq_ck";
+	lookup->clk = clk;
+
+	clkdev_add(lookup);
+	return;
+cleanup:
+	kfree(hw);
+	kfree(lookup);
+}
+#endif
diff --git a/drivers/clk/ti/clk-2xxx.c b/drivers/clk/ti/clk-2xxx.c
index f6400fb..c808ab3 100644
--- a/drivers/clk/ti/clk-2xxx.c
+++ b/drivers/clk/ti/clk-2xxx.c
@@ -229,6 +229,8 @@ static int __init omap2xxx_dt_clk_init(int soc_type)
 	else
 		ti_dt_clocks_register(omap2430_clks);
 
+	omap2xxx_clkt_vps_init();
+
 	omap2_clk_disable_autoidle_all();
 
 	omap2_clk_enable_init_clocks(enable_init_clks,
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index a5aec68..03decc2 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -279,6 +279,7 @@ unsigned long omap2_dpllcore_recalc(struct clk_hw *hw,
 int omap2_reprogram_dpllcore(struct clk_hw *clk, unsigned long rate,
 			     unsigned long parent_rate);
 void omap2xxx_clkt_dpllcore_init(struct clk_hw *hw);
+void omap2xxx_clkt_vps_init(void);
 
 void __iomem *ti_clk_get_reg_addr(struct device_node *node, int index);
 void ti_dt_clocks_register(struct ti_dt_clk *oclks);
-- 
1.7.9.5

