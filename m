From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv9 38/43] ARM: OMAP2+: PRM: add support for initializing PRCM clock modules from DT
Date: Fri, 25 Oct 2013 18:57:32 +0300
Message-ID: <1382716658-6964-39-git-send-email-t-kristo@ti.com>
References: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37692 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751864Ab3JYQAX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Oct 2013 12:00:23 -0400
In-Reply-To: <1382716658-6964-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, bcousson@baylibre.com, rnayak@ti.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

This patch provides top level functionality for the DT clock initialization.
Clock tree is initialized hierarchically starting from IP modules (CM/PRM/PRCM)
going down towards individual clock nodes, and finally initializing
clockdomains once all the clocks are ready.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/prm.h        |    1 +
 arch/arm/mach-omap2/prm_common.c |  133 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 134 insertions(+)

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
index 228b850..6fa74c6 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -23,12 +23,18 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/clk-provider.h>
+#include <linux/clk/ti.h>
+#include <linux/of_platform.h>
 
 #include "prm2xxx_3xxx.h"
 #include "prm2xxx.h"
 #include "prm3xxx.h"
 #include "prm44xx.h"
 #include "common.h"
+#include "soc.h"
 
 /*
  * OMAP_PRCM_MAX_NR_PENDING_REG: maximum number of PRM_IRQ*_MPU regs
@@ -453,3 +459,130 @@ int prm_unregister(struct prm_ll_data *pld)
 
 	return 0;
 }
+
+static struct of_device_id omap_prcm_dt_match_table[] __initdata = {
+	{ .compatible = "ti,prcm" },
+	{ .compatible = "ti,prm" },
+	{ .compatible = "ti,cm" },
+	{ .compatible = "ti,cm2" },
+	{ .compatible = "ti,scrm" },
+	{ }
+};
+
+
+/*
+ * XXX: implementation for the regmap read/write should be moved to
+ * individual PRCM IP drivers, once those are available.
+ */
+static int ti_clk_regmap_read(void *context, unsigned int reg,
+			      unsigned int *val)
+{
+	void __iomem *mem = context;
+	*val = __raw_readl(mem + reg);
+	return 0;
+}
+
+static int ti_clk_regmap_write(void *context, unsigned int reg,
+			       unsigned int val)
+{
+	void __iomem *mem = context;
+	__raw_writel(val, mem + reg);
+	return 0;
+}
+
+static struct regmap_config ti_clk_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.reg_read = ti_clk_regmap_read,
+	.reg_write = ti_clk_regmap_write,
+	.fast_io = true,
+	.cache_type = REGCACHE_NONE,
+	.reg_format_endian = REGMAP_ENDIAN_NATIVE,
+	.val_format_endian = REGMAP_ENDIAN_NATIVE,
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
+int __init of_prcm_init(void)
+{
+	struct device_node *np;
+	void __iomem *mem;
+	struct regmap *regmap;
+	struct platform_device *pdev;
+	struct prcm_early_dev *edev;
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
+		regmap = regmap_init(&pdev->dev, NULL, mem,
+				     &ti_clk_regmap_config);
+		ti_dt_clk_init_provider(np, regmap);
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

