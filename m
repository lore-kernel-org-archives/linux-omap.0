From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv12 43/49] ARM: OMAP2+: PRM: add support for initializing PRCM clock modules from DT
Date: Fri, 20 Dec 2013 18:34:34 +0200
Message-ID: <1387557274-22583-16-git-send-email-t-kristo@ti.com>
References: <1387557274-22583-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42684 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756156Ab3LTQgL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Dec 2013 11:36:11 -0500
In-Reply-To: <1387557274-22583-1-git-send-email-t-kristo@ti.com>
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
 arch/arm/mach-omap2/prm.h        |    1 +
 arch/arm/mach-omap2/prm_common.c |   66 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

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
index a2e1174..f568502 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -23,6 +23,10 @@
 #include <linux/irq.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/clk-provider.h>
+#include <linux/clk/ti.h>
 
 #include "soc.h"
 #include "prm2xxx_3xxx.h"
@@ -30,6 +34,7 @@
 #include "prm3xxx.h"
 #include "prm44xx.h"
 #include "common.h"
+#include "clock.h"
 
 /*
  * OMAP_PRCM_MAX_NR_PENDING_REG: maximum number of PRM_IRQ*_MPU regs
@@ -464,3 +469,64 @@ int prm_unregister(struct prm_ll_data *pld)
 
 	return 0;
 }
+
+static struct of_device_id omap_prcm_dt_match_table[] = {
+	{ .compatible = "ti,am3-prcm" },
+	{ .compatible = "ti,am3-scrm" },
+	{ .compatible = "ti,am4-prcm" },
+	{ .compatible = "ti,am4-scrm" },
+	{ .compatible = "ti,omap3-prm" },
+	{ .compatible = "ti,omap3-cm" },
+	{ .compatible = "ti,omap3-scrm" },
+	{ .compatible = "ti,omap4-cm1" },
+	{ .compatible = "ti,omap4-prm" },
+	{ .compatible = "ti,omap4-cm2" },
+	{ .compatible = "ti,omap4-scrm" },
+	{ .compatible = "ti,omap5-prm" },
+	{ .compatible = "ti,omap5-cm-core-aon" },
+	{ .compatible = "ti,omap5-scrm" },
+	{ .compatible = "ti,omap5-cm-core" },
+	{ .compatible = "ti,dra7-prm" },
+	{ .compatible = "ti,dra7-cm-core-aon" },
+	{ .compatible = "ti,dra7-cm-core" },
+	{ }
+};
+
+static struct clk_hw_omap memmap_dummy_ck = {
+	.flags = MEMMAP_ADDRESSING,
+};
+
+static u32 prm_clk_readl(void __iomem *reg)
+{
+	return omap2_clk_readl(&memmap_dummy_ck, reg);
+}
+
+static void prm_clk_writel(u32 val, void __iomem *reg)
+{
+	omap2_clk_writel(val, &memmap_dummy_ck, reg);
+}
+
+static struct clk_ll_ops omap_clk_ll_ops = {
+	.clk_readl = prm_clk_readl,
+	.clk_writel = prm_clk_writel,
+};
+
+int __init of_prcm_init(void)
+{
+	struct device_node *np;
+	void __iomem *mem;
+	int memmap_index = 0;
+
+	ti_clk_ll_ops = &omap_clk_ll_ops;
+
+	for_each_matching_node(np, omap_prcm_dt_match_table) {
+		mem = of_iomap(np, 0);
+		clk_memmaps[memmap_index] = mem;
+		ti_dt_clk_init_provider(np, memmap_index);
+		memmap_index++;
+	}
+
+	ti_dt_clockdomains_setup();
+
+	return 0;
+}
-- 
1.7.9.5

