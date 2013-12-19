From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: [PATCHv11 43/49] ARM: OMAP2+: PRM: add support for initializing PRCM clock modules from DT
Date: Thu, 19 Dec 2013 13:24:14 +0200
Message-ID: <1387452260-23276-44-git-send-email-t-kristo@ti.com>
References: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1387452260-23276-1-git-send-email-t-kristo-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This patch provides top level functionality for the DT clock initialization.
Clock tree is initialized hierarchically starting from IP modules (CM/PRM/PRCM)
going down towards individual clock nodes, and finally initializing
clockdomains once all the clocks are ready.

Signed-off-by: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
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
index a2e1174..835eb7d 100644
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
+static u32 prm_clk_readl(u32 *reg)
+{
+	return omap2_clk_readl(&memmap_dummy_ck, reg);
+}
+
+static void prm_clk_writel(u32 val, u32 *reg)
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
