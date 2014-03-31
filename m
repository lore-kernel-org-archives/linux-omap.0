From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 12/55] ARM: PRCM: split PRCM module init to their own driver files
Date: Mon, 31 Mar 2014 18:15:51 +0300
Message-ID: <1396278994-12624-13-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49806 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753522AbaCaPRh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Mar 2014 11:17:37 -0400
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

Previously this was done for all modules under prm_common.c.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cm_common.c   |   18 +++++++++++++
 arch/arm/mach-omap2/control.c     |   15 +++++++++++
 arch/arm/mach-omap2/control.h     |    1 +
 arch/arm/mach-omap2/io.c          |    4 +++
 arch/arm/mach-omap2/prcm-common.h |    4 +++
 arch/arm/mach-omap2/prm_common.c  |   54 +++++++++++++++++++++----------------
 6 files changed, 73 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-omap2/cm_common.c b/arch/arm/mach-omap2/cm_common.c
index 9e2482a..c334d38 100644
--- a/arch/arm/mach-omap2/cm_common.c
+++ b/arch/arm/mach-omap2/cm_common.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/errno.h>
+#include <linux/of.h>
 
 #include "cm2xxx.h"
 #include "cm3xxx.h"
@@ -137,3 +138,20 @@ int cm_unregister(struct cm_ll_data *cld)
 
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
index 5854b3c..90a7add 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -611,3 +611,18 @@ void __init omap3_ctrl_init(void)
 	omap3_ctrl_setup_d2d_padconf();
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
index ccbd70c..8a5c025 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -428,6 +428,7 @@ extern void omap_ctrl_write_dsp_boot_mode(u8 bootmode);
 extern void omap3630_ctrl_disable_rta(void);
 extern int omap3_ctrl_save_padconf(void);
 void omap3_ctrl_init(void);
+int of_scrm_init(void);
 extern void omap2_set_globals_control(void __iomem *ctrl,
 				      void __iomem *ctrl_pad);
 #else
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 251432f..dfba898 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -736,6 +736,10 @@ int __init omap_clk_init(void)
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
index 9da4c17..f356532 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -517,6 +517,8 @@ struct omap_prcm_irq_setup {
 	.priority = _priority				\
 	}
 
+struct of_device_id;
+
 extern void omap_prcm_irq_cleanup(void);
 extern int omap_prcm_register_chain_handler(
 	struct omap_prcm_irq_setup *irq_setup);
@@ -524,6 +526,8 @@ extern int omap_prcm_event_to_irq(const char *event);
 extern void omap_prcm_irq_prepare(void);
 extern void omap_prcm_irq_complete(void);
 void omap_pcs_legacy_init(int irq, void (*rearm)(void));
+int of_prcm_module_init(struct of_device_id *match_table);
+int of_cm_init(void);
 
 # endif
 
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 2d63196..080b3ed 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -466,27 +466,18 @@ int prm_unregister(struct prm_ll_data *pld)
 	return 0;
 }
 
-static struct of_device_id omap_prcm_dt_match_table[] = {
-	{ .compatible = "ti,am3-prcm" },
-	{ .compatible = "ti,am3-scrm" },
-	{ .compatible = "ti,am4-prcm" },
-	{ .compatible = "ti,am4-scrm" },
-	{ .compatible = "ti,omap2-prcm" },
-	{ .compatible = "ti,omap2-scrm" },
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
 
@@ -509,25 +500,42 @@ static struct ti_clk_ll_ops omap_clk_ll_ops = {
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
+
 static int __init prm_late_init(void)
 {
 	if (prm_ll_data->late_init)
-- 
1.7.9.5

