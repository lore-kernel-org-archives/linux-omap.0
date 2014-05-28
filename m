From: Archit Taneja <archit@ti.com>
Subject: [RFC v2 2/6] ARM: PRCM: split PRCM module init to their own driver files
Date: Wed, 28 May 2014 16:20:51 +0530
Message-ID: <1401274255-16845-3-git-send-email-archit@ti.com>
References: <1397654063-8055-1-git-send-email-archit@ti.com>
 <1401274255-16845-1-git-send-email-archit@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35252 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752098AbaE1Kw0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 May 2014 06:52:26 -0400
In-Reply-To: <1401274255-16845-1-git-send-email-archit@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, t-kristo@ti.com, rnayak@ti.com
Cc: linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

Currently, clock providers coming from CM, PRM, and SCRM are all initialized in
prm_common.c.

Move the DT-match tables to their respective files, and create separate init
functions for each module.

Originally worked on by: Tero Kristo <t-kristo@ti.com>

Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Archit Taneja <archit@ti.com>
---
 arch/arm/mach-omap2/cm_common.c   | 18 ++++++++++++++
 arch/arm/mach-omap2/control.c     | 15 +++++++++++
 arch/arm/mach-omap2/control.h     |  1 +
 arch/arm/mach-omap2/io.c          |  4 +++
 arch/arm/mach-omap2/prcm-common.h |  5 ++++
 arch/arm/mach-omap2/prm_common.c  | 52 +++++++++++++++++++++++----------------
 6 files changed, 74 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/cm_common.c b/arch/arm/mach-omap2/cm_common.c
index 40b3b5a..8506990 100644
--- a/arch/arm/mach-omap2/cm_common.c
+++ b/arch/arm/mach-omap2/cm_common.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/errno.h>
+#include <linux/of.h>
 
 #include "cm2xxx.h"
 #include "cm3xxx.h"
@@ -138,3 +139,20 @@ int cm_unregister(struct cm_ll_data *cld)
 
 	return 0;
 }
+
+static struct of_device_id omap_cm_dt_match_table[] = {
+	{ .compatible = "ti,omap3-cm" },
+	{ .compatible = "ti,omap4-cm1" },
+	{ .compatible = "ti,omap4-cm2" },
+	{ .compatible = "ti,omap5-cm-core-aon" },
+	{ .compatible = "ti,omap5-cm-core" },
+	{ .compatible = "ti,dra7-cm-core-aon" },
+	{ .compatible = "ti,dra7-cm-core" },
+	{ }
+};
+
+
+int __init of_cm_init(void)
+{
+	return of_prcm_module_init(omap_cm_dt_match_table);
+}
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 44bb4d5..12cd736 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -581,3 +581,18 @@ void omap3_ctrl_set_iva_bootmode_idle(void)
 			 OMAP343X_CONTROL_IVA2_BOOTMOD);
 }
 #endif /* CONFIG_ARCH_OMAP3 && CONFIG_PM */
+
+static struct of_device_id omap_scrm_dt_match_table[] = {
+	{ .compatible = "ti,am3-scrm" },
+	{ .compatible = "ti,am4-scrm" },
+	{ .compatible = "ti,omap2-scrm" },
+	{ .compatible = "ti,omap3-scrm" },
+	{ .compatible = "ti,omap4-scrm" },
+	{ .compatible = "ti,omap5-scrm" },
+	{ }
+};
+
+int __init of_scrm_init(void)
+{
+	return of_prcm_module_init(omap_scrm_dt_match_table);
+}
diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index da05480..5d695f1 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -428,6 +428,7 @@ extern void omap_ctrl_write_dsp_boot_mode(u8 bootmode);
 extern void omap3630_ctrl_disable_rta(void);
 extern int omap3_ctrl_save_padconf(void);
 extern void omap3_ctrl_set_iva_bootmode_idle(void);
+int of_scrm_init(void);
 extern void omap2_set_globals_control(void __iomem *ctrl,
 				      void __iomem *ctrl_pad);
 #else
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index f14f9ac..c78e2b8 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -725,6 +725,10 @@ int __init omap_clk_init(void)
 	if (!omap_clk_soc_init)
 		return 0;
 
+	ret = of_scrm_init();
+	if (ret)
+		return ret;
+
 	ret = of_prcm_init();
 	if (!ret)
 		ret = omap_clk_soc_init();
diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index 0e841fd..a68d98e 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -493,6 +493,8 @@ struct omap_prcm_irq_setup {
 	.priority = _priority				\
 	}
 
+struct of_device_id;
+
 extern void omap_prcm_irq_cleanup(void);
 extern int omap_prcm_register_chain_handler(
 	struct omap_prcm_irq_setup *irq_setup);
@@ -500,6 +502,9 @@ extern int omap_prcm_event_to_irq(const char *event);
 extern void omap_prcm_irq_prepare(void);
 extern void omap_prcm_irq_complete(void);
 
+int of_prcm_module_init(struct of_device_id *match_table);
+int of_cm_init(void);
+
 # endif
 
 #endif
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 56462af..85fc9f9 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -470,25 +470,18 @@ int prm_unregister(struct prm_ll_data *pld)
 	return 0;
 }
 
-static struct of_device_id omap_prcm_dt_match_table[] = {
-	{ .compatible = "ti,am3-prcm" },
-	{ .compatible = "ti,am3-scrm" },
-	{ .compatible = "ti,am4-prcm" },
-	{ .compatible = "ti,am4-scrm" },
+static struct of_device_id omap_prm_dt_match_table[] = {
 	{ .compatible = "ti,omap3-prm" },
-	{ .compatible = "ti,omap3-cm" },
-	{ .compatible = "ti,omap3-scrm" },
-	{ .compatible = "ti,omap4-cm1" },
 	{ .compatible = "ti,omap4-prm" },
-	{ .compatible = "ti,omap4-cm2" },
-	{ .compatible = "ti,omap4-scrm" },
 	{ .compatible = "ti,omap5-prm" },
-	{ .compatible = "ti,omap5-cm-core-aon" },
-	{ .compatible = "ti,omap5-scrm" },
-	{ .compatible = "ti,omap5-cm-core" },
 	{ .compatible = "ti,dra7-prm" },
-	{ .compatible = "ti,dra7-cm-core-aon" },
-	{ .compatible = "ti,dra7-cm-core" },
+	{ }
+};
+
+static struct of_device_id omap_prcm_dt_match_table[] = {
+	{ .compatible = "ti,am3-prcm" },
+	{ .compatible = "ti,am4-prcm" },
+	{ .compatible = "ti,omap2-prcm" },
 	{ }
 };
 
@@ -511,21 +504,38 @@ static struct ti_clk_ll_ops omap_clk_ll_ops = {
 	.clk_writel = prm_clk_writel,
 };
 
-int __init of_prcm_init(void)
+static int prcm_memmap_index;
+
+int __init of_prcm_module_init(struct of_device_id *match_table)
 {
 	struct device_node *np;
 	void __iomem *mem;
-	int memmap_index = 0;
 
 	ti_clk_ll_ops = &omap_clk_ll_ops;
 
-	for_each_matching_node(np, omap_prcm_dt_match_table) {
+	for_each_matching_node(np, match_table) {
 		mem = of_iomap(np, 0);
-		clk_memmaps[memmap_index] = mem;
-		ti_dt_clk_init_provider(np, memmap_index);
+		clk_memmaps[prcm_memmap_index] = mem;
+		ti_dt_clk_init_provider(np, prcm_memmap_index);
 		ti_dt_clockdomains_setup(np);
-		memmap_index++;
+		prcm_memmap_index++;
 	}
 
 	return 0;
 }
+
+int __init of_prm_init(void)
+{
+	return of_prcm_module_init(omap_prm_dt_match_table);
+}
+
+int __init of_prcm_init(void)
+{
+	int ret;
+
+	ret = of_prm_init();
+	ret |= of_cm_init();
+	ret |= of_prcm_module_init(omap_prcm_dt_match_table);
+
+	return ret;
+}
-- 
1.8.3.2

