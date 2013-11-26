From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv10 35/41] ARM: OMAP2+: PRM: add support for initializing PRCM clock modules from DT
Date: Tue, 26 Nov 2013 10:06:16 +0200
Message-ID: <1385453182-24421-36-git-send-email-t-kristo@ti.com>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60615 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754849Ab3KZIKh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Nov 2013 03:10:37 -0500
In-Reply-To: <1385453182-24421-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

This patch provides top level functionality for the DT clock initialization.
Clock tree is initialized hierarchically starting from IP modules (CM/PRM/PRCM)
going down towards individual clock nodes, and finally initializing
clockdomains once all the clocks are ready.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/Kconfig      |    1 +
 arch/arm/mach-omap2/clock.h      |    2 +
 arch/arm/mach-omap2/prm.h        |    1 +
 arch/arm/mach-omap2/prm_common.c |  128 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 132 insertions(+)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index dc21df1..4fccbbe 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -95,6 +95,7 @@ config ARCH_OMAP2PLUS
 	select SPARSE_IRQ
 	select TI_PRIV_EDMA
 	select USE_OF
+	select REGMAP_MMIO
 	help
 	  Systems based on OMAP2, OMAP3, OMAP4 or OMAP5
 
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 9595d72..10efab8 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -291,6 +291,8 @@ extern const struct clksel_rate div_1_3_rates[];
 extern const struct clksel_rate div_1_4_rates[];
 extern const struct clksel_rate div31_1to31_rates[];
 
+extern struct regmap *clk_regmaps[];
+
 extern int am33xx_clk_init(void);
 
 extern int omap2_clkops_enable_clkdm(struct clk_hw *hw);
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index ac25ae6..623db40 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -18,6 +18,7 @@
 # ifndef __ASSEMBLER__
 extern void __iomem *prm_base;
 extern void omap2_set_globals_prm(void __iomem *prm);
+int of_prcm_init(void);
 # endif
 
 
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index a2e1174..16ab63c 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -23,6 +23,12 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/clk-provider.h>
+#include <linux/clk/ti.h>
+#include <linux/of_platform.h>
+#include <linux/regmap.h>
 
 #include "soc.h"
 #include "prm2xxx_3xxx.h"
@@ -30,6 +36,7 @@
 #include "prm3xxx.h"
 #include "prm44xx.h"
 #include "common.h"
+#include "clock.h"
 
 /*
  * OMAP_PRCM_MAX_NR_PENDING_REG: maximum number of PRM_IRQ*_MPU regs
@@ -464,3 +471,124 @@ int prm_unregister(struct prm_ll_data *pld)
 
 	return 0;
 }
+
+static struct of_device_id omap_prcm_dt_match_table[] = {
+	{ .compatible = "ti,clock-master" },
+	{ }
+};
+
+static struct regmap_config ti_clk_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.cache_type = REGCACHE_NONE,
+};
+
+static LIST_HEAD(prcm_early_devs);
+
+struct prcm_early_dev {
+	struct device_node *node;
+	struct platform_device *dev;
+	struct list_head link;
+};
+
+static struct clk_hw_omap regmap_dummy_ck = {
+	.flags = REGMAP_ADDRESSING,
+};
+
+static u32 prm_clk_readl(u32 *reg)
+{
+	return omap2_clk_readl(&regmap_dummy_ck, reg);
+}
+
+static void prm_clk_writel(u32 val, u32 *reg)
+{
+	omap2_clk_writel(val, &regmap_dummy_ck, reg);
+}
+
+static struct clk_reg_ops omap_clk_reg_ops = {
+	.clk_readl = prm_clk_readl,
+	.clk_writel = prm_clk_writel,
+};
+
+int __init of_prcm_init(void)
+{
+	struct device_node *np;
+	void __iomem *mem;
+	struct regmap *regmap;
+	struct platform_device *pdev;
+	struct prcm_early_dev *edev;
+	int regmap_index = 0;
+
+	clk_register_reg_ops(&omap_clk_reg_ops);
+
+	for_each_matching_node(np, omap_prcm_dt_match_table) {
+		pdev = platform_device_alloc(np->name, 0);
+		dev_set_name(&pdev->dev, "%s", pdev->name);
+		edev = kzalloc(sizeof(*edev), GFP_KERNEL);
+		edev->dev = pdev;
+		edev->node = np;
+		list_add(&edev->link, &prcm_early_devs);
+		mem = of_iomap(np, 0);
+		ti_clk_regmap_config.name = "0";
+		regmap = regmap_init_mmio(&pdev->dev, mem,
+					  &ti_clk_regmap_config);
+		clk_regmaps[regmap_index] = regmap;
+		ti_dt_clk_init_provider(np, regmap_index);
+		regmap_index++;
+	}
+
+	ti_dt_clockdomains_setup();
+
+	return 0;
+}
+
+static int prcm_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *of_id =
+		of_match_device(omap_prcm_dt_match_table, &pdev->dev);
+	struct prcm_early_dev *edev;
+	int ret;
+
+	if (!of_id)
+		return 0;
+
+	list_for_each_entry(edev, &prcm_early_devs, link) {
+		if (edev->node == pdev->dev.of_node) {
+			platform_device_add(edev->dev);
+			edev->dev->dev.driver = pdev->dev.driver;
+			ret = device_bind_driver(&edev->dev->dev);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int prcm_remove(struct platform_device *pdev)
+{
+	return 0;
+}
+
+static struct platform_driver prcm_driver = {
+	.probe		= prcm_probe,
+	.remove		= prcm_remove,
+	.driver		= {
+		.name	= "prcm-driver",
+		.owner	= THIS_MODULE,
+		.of_match_table	= of_match_ptr(omap_prcm_dt_match_table),
+	},
+};
+
+static __init int prcm_init(void)
+{
+	return platform_driver_register(&prcm_driver);
+}
+
+static __exit void prcm_exit(void)
+{
+	platform_driver_unregister(&prcm_driver);
+}
+omap_postcore_initcall(prcm_init);
+module_exit(prcm_exit);
-- 
1.7.9.5

