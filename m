From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 52/55] ARM: OMAP2+: PRCM: add prcm_base init call for DT boot
Date: Mon, 31 Mar 2014 18:16:31 +0300
Message-ID: <1396278994-12624-53-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58877 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753287AbaCaPTK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 31 Mar 2014 11:19:10 -0400
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

This parses the prm, cm and scrm base addresses from DT if available,
avoiding the need for various omap2_set_globals_* calls.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cm_common.c        |   57 ++++++++++++++++---
 arch/arm/mach-omap2/control.c          |   36 ++++++++++--
 arch/arm/mach-omap2/io.c               |   50 ++++++++--------
 arch/arm/mach-omap2/prm_common.c       |   97 ++++++++++++++++++++++++--------
 include/linux/power/omap/prcm-common.h |   18 ++++++
 5 files changed, 196 insertions(+), 62 deletions(-)

diff --git a/arch/arm/mach-omap2/cm_common.c b/arch/arm/mach-omap2/cm_common.c
index 0a21fa9..67d4888 100644
--- a/arch/arm/mach-omap2/cm_common.c
+++ b/arch/arm/mach-omap2/cm_common.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 
 #include <linux/power/omap/cm2xxx.h>
 #include <linux/power/omap/cm3xxx.h>
@@ -140,14 +141,32 @@ int cm_unregister(struct cm_ll_data *cld)
 	return 0;
 }
 
+static const struct prcm_match_data cm_base_data = {
+	.flags = PRCM_REGISTER_CLOCKS,
+	.index = PRCM_CLK_MEMMAP_INDEX_CM1,
+};
+
+static const struct prcm_match_data cm2_base_data = {
+	.flags = PRCM_REGISTER_CLOCKS,
+	.index = PRCM_CLK_MEMMAP_INDEX_CM2,
+};
+
+static const struct prcm_match_data omap3_cm_data = {
+	.flags = PRCM_REGISTER_CLOCKS,
+	.index = PRCM_CLK_MEMMAP_INDEX_CM1,
+	.offset = 0x800,
+};
+
 static struct of_device_id omap_cm_dt_match_table[] = {
-	{ .compatible = "ti,omap3-cm" },
-	{ .compatible = "ti,omap4-cm1" },
-	{ .compatible = "ti,omap4-cm2" },
-	{ .compatible = "ti,omap5-cm-core-aon" },
-	{ .compatible = "ti,omap5-cm-core" },
-	{ .compatible = "ti,dra7-cm-core-aon" },
-	{ .compatible = "ti,dra7-cm-core" },
+	{ .compatible = "ti,omap3-cm", .data = &omap3_cm_data },
+	{ .compatible = "ti,omap4-cm1", .data = &cm_base_data },
+	{ .compatible = "ti,omap4-cm2", .data = &cm2_base_data },
+	{ .compatible = "ti,omap5-cm-core-aon", .data = &cm_base_data },
+	{ .compatible = "ti,omap5-cm-core", .data = &cm2_base_data },
+	{ .compatible = "ti,dra7-cm-core-aon", .data = &cm_base_data },
+	{ .compatible = "ti,dra7-cm-core", .data = &cm2_base_data },
+	{ .compatible = "ti,am3-prcm", .data = &cm_base_data },
+	{ .compatible = "ti,am4-prcm", .data = &cm_base_data },
 	{ }
 };
 
@@ -156,3 +175,27 @@ int __init of_cm_init(void)
 {
 	return of_prcm_module_init(omap_cm_dt_match_table);
 }
+
+int __init of_cm_base_init(void)
+{
+	struct device_node *np;
+	const struct of_device_id *match;
+	const struct prcm_match_data *data;
+
+	for_each_matching_node_and_match(np, omap_cm_dt_match_table, &match) {
+		data = match->data;
+		if (clk_memmaps[data->index])
+			pr_warn("WARNING: multiple cm compatible mods %d\n",
+				data->index);
+
+		clk_memmaps[data->index] = of_iomap(np, 0);
+
+		if (data->index == PRCM_CLK_MEMMAP_INDEX_CM1)
+			cm_base = clk_memmaps[data->index] + data->offset;
+
+		if (data->index == PRCM_CLK_MEMMAP_INDEX_CM2)
+			cm2_base = clk_memmaps[data->index] + data->offset;
+	}
+
+	return 0;
+}
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 90a7add..c404987 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -14,6 +14,8 @@
 
 #include <linux/kernel.h>
 #include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
 
 #include "soc.h"
 #include "iomap.h"
@@ -612,13 +614,16 @@ void __init omap3_ctrl_init(void)
 }
 #endif /* CONFIG_ARCH_OMAP3 && CONFIG_PM */
 
+static const struct prcm_match_data scrm_base_data = {
+	.flags = PRCM_REGISTER_CLOCKS,
+	.index = PRCM_CLK_MEMMAP_INDEX_SCRM,
+};
+
 static struct of_device_id omap_scrm_dt_match_table[] = {
-	{ .compatible = "ti,am3-scrm" },
-	{ .compatible = "ti,am4-scrm" },
-	{ .compatible = "ti,omap2-scrm" },
-	{ .compatible = "ti,omap3-scrm" },
-	{ .compatible = "ti,omap4-scrm" },
-	{ .compatible = "ti,omap5-scrm" },
+	{ .compatible = "ti,am3-scrm", .data = &scrm_base_data },
+	{ .compatible = "ti,am4-scrm", .data = &scrm_base_data },
+	{ .compatible = "ti,omap2-scrm", .data = &scrm_base_data },
+	{ .compatible = "ti,omap3-scrm", .data = &scrm_base_data },
 	{ }
 };
 
@@ -626,3 +631,22 @@ int __init of_scrm_init(void)
 {
 	return of_prcm_module_init(omap_scrm_dt_match_table);
 }
+
+int __init of_scrm_base_init(void)
+{
+	struct device_node *np;
+	const struct of_device_id *match;
+	const struct prcm_match_data *data;
+
+	for_each_matching_node_and_match(np, omap_scrm_dt_match_table, &match) {
+		data = match->data;
+
+		if (clk_memmaps[data->index])
+			pr_warn("WARN: multiple scrm compatible mods\n");
+
+		clk_memmaps[data->index] = of_iomap(np, 0);
+		omap2_ctrl_base = clk_memmaps[data->index];
+	}
+
+	return 0;
+}
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 08dd6de..6072f4a 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -398,10 +398,15 @@ void __init omap2420_init_early(void)
 	omap2_set_globals_tap(OMAP242X_CLASS, OMAP2_L4_IO_ADDRESS(0x48014000));
 	omap2_set_globals_sdrc(OMAP2_L3_IO_ADDRESS(OMAP2420_SDRC_BASE),
 			       OMAP2_L3_IO_ADDRESS(OMAP2420_SMS_BASE));
+	/*
+	 * XXX: following three set_globals_* calls can be removed
+	 * once omap2 is DT only boot
+	 */
 	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP242X_CTRL_BASE),
 				  NULL);
 	omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(OMAP2420_PRM_BASE));
 	omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(OMAP2420_CM_BASE), NULL);
+	of_prcm_base_init();
 	omap2xxx_check_revision();
 	omap2xxx_prm_init();
 	omap2xxx_cm_init();
@@ -428,10 +433,15 @@ void __init omap2430_init_early(void)
 	omap2_set_globals_tap(OMAP243X_CLASS, OMAP2_L4_IO_ADDRESS(0x4900a000));
 	omap2_set_globals_sdrc(OMAP2_L3_IO_ADDRESS(OMAP243X_SDRC_BASE),
 			       OMAP2_L3_IO_ADDRESS(OMAP243X_SMS_BASE));
+	/*
+	 * XXX: following three set_globals_* calls can be removed
+	 * once omap2 is DT only boot
+	 */
 	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP243X_CTRL_BASE),
 				  NULL);
 	omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(OMAP2430_PRM_BASE));
 	omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(OMAP2430_CM_BASE), NULL);
+	of_prcm_base_init();
 	omap2xxx_check_revision();
 	omap2xxx_prm_init();
 	omap2xxx_cm_init();
@@ -471,10 +481,15 @@ void __init omap3_init_early(void)
 	omap2_set_globals_tap(OMAP343X_CLASS, OMAP2_L4_IO_ADDRESS(0x4830A000));
 	omap2_set_globals_sdrc(OMAP2_L3_IO_ADDRESS(OMAP343X_SDRC_BASE),
 			       OMAP2_L3_IO_ADDRESS(OMAP343X_SMS_BASE));
+	/*
+	 * XXX: following three set_globals_* calls can be removed
+	 * once omap3 is DT only boot
+	 */
 	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP343X_CTRL_BASE),
 				  NULL);
 	omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(OMAP3430_PRM_BASE));
 	omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(OMAP3430_CM_BASE), NULL);
+	of_prcm_base_init();
 	omap3xxx_check_revision();
 	omap3xxx_check_features();
 	omap3xxx_prm_init(omap3_prm_type());
@@ -519,10 +534,15 @@ void __init ti81xx_init_early(void)
 {
 	omap2_set_globals_tap(OMAP343X_CLASS,
 			      OMAP2_L4_IO_ADDRESS(TI81XX_TAP_BASE));
+	/*
+	 * XXX: following three set_globals_control calls can be removed
+	 * once ti81xx is DT only boot
+	 */
 	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(TI81XX_CTRL_BASE),
 				  NULL);
 	omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(TI81XX_PRCM_BASE));
 	omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(TI81XX_PRCM_BASE), NULL);
+	of_prcm_base_init();
 	omap3xxx_check_revision();
 	ti81xx_check_features();
 	omap3xxx_voltagedomains_init();
@@ -584,10 +604,7 @@ void __init am33xx_init_early(void)
 {
 	omap2_set_globals_tap(AM335X_CLASS,
 			      AM33XX_L4_WK_IO_ADDRESS(AM33XX_TAP_BASE));
-	omap2_set_globals_control(AM33XX_L4_WK_IO_ADDRESS(AM33XX_CTRL_BASE),
-				  NULL);
-	omap2_set_globals_prm(AM33XX_L4_WK_IO_ADDRESS(AM33XX_PRCM_BASE));
-	omap2_set_globals_cm(AM33XX_L4_WK_IO_ADDRESS(AM33XX_PRCM_BASE), NULL);
+	of_prcm_base_init();
 	omap3xxx_check_revision();
 	am33xx_check_features();
 	am33xx_powerdomains_init();
@@ -608,12 +625,7 @@ void __init am43xx_init_early(void)
 {
 	omap2_set_globals_tap(AM335X_CLASS,
 			      AM33XX_L4_WK_IO_ADDRESS(AM33XX_TAP_BASE));
-	omap2_set_globals_control(AM33XX_L4_WK_IO_ADDRESS(AM33XX_CTRL_BASE),
-				  NULL);
-	omap2_set_globals_prm(AM33XX_L4_WK_IO_ADDRESS(AM43XX_PRCM_BASE));
-	omap2_set_globals_cm(AM33XX_L4_WK_IO_ADDRESS(AM43XX_PRCM_BASE), NULL);
-	omap_prm_base_init();
-	omap_cm_base_init();
+	of_prcm_base_init();
 	omap3xxx_check_revision();
 	am43xx_powerdomains_init();
 	am43xx_clockdomains_init();
@@ -635,12 +647,8 @@ void __init omap4430_init_early(void)
 			      OMAP2_L4_IO_ADDRESS(OMAP443X_SCM_BASE));
 	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP443X_SCM_BASE),
 				  OMAP2_L4_IO_ADDRESS(OMAP443X_CTRL_BASE));
-	omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(OMAP4430_PRM_BASE));
-	omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(OMAP4430_CM_BASE),
-			     OMAP2_L4_IO_ADDRESS(OMAP4430_CM2_BASE));
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP4430_PRCM_MPU_BASE));
-	omap_prm_base_init();
-	omap_cm_base_init();
+	of_prcm_base_init();
 	omap4xxx_check_revision();
 	omap4xxx_check_features();
 	omap4_pm_init_early();
@@ -668,12 +676,8 @@ void __init omap5_init_early(void)
 			      OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE));
 	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE),
 				  OMAP2_L4_IO_ADDRESS(OMAP54XX_CTRL_BASE));
-	omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(OMAP54XX_PRM_BASE));
-	omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(OMAP54XX_CM_CORE_AON_BASE),
-			     OMAP2_L4_IO_ADDRESS(OMAP54XX_CM_CORE_BASE));
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP54XX_PRCM_MPU_BASE));
-	omap_prm_base_init();
-	omap_cm_base_init();
+	of_prcm_base_init();
 	omap44xx_prm_init(PRM_OMAP5);
 	omap5xxx_check_revision();
 	omap54xx_voltagedomains_init();
@@ -696,12 +700,8 @@ void __init dra7xx_init_early(void)
 	omap2_set_globals_tap(-1, OMAP2_L4_IO_ADDRESS(DRA7XX_TAP_BASE));
 	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE),
 				  OMAP2_L4_IO_ADDRESS(DRA7XX_CTRL_BASE));
-	omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(OMAP54XX_PRM_BASE));
-	omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(DRA7XX_CM_CORE_AON_BASE),
-			     OMAP2_L4_IO_ADDRESS(OMAP54XX_CM_CORE_BASE));
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP54XX_PRCM_MPU_BASE));
-	omap_prm_base_init();
-	omap_cm_base_init();
+	of_prcm_base_init();
 	omap44xx_prm_init(PRM_DRA7);
 	dra7xx_powerdomains_init();
 	dra7xx_clockdomains_init();
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index fb377e1..cc1e0d2 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -32,6 +32,7 @@
 #include <linux/power/omap/prm2xxx.h>
 #include <linux/power/omap/prm3xxx.h>
 #include <linux/power/omap/prm44xx.h>
+#include <linux/power/omap/cm44xx.h>
 
 #include <linux/power/omap/prm.h>
 #include <linux/power/omap/prcm-common.h>
@@ -468,18 +469,38 @@ int prm_unregister(struct prm_ll_data *pld)
 	return 0;
 }
 
-static struct of_device_id omap_prm_dt_match_table[] = {
-	{ .compatible = "ti,omap3-prm" },
-	{ .compatible = "ti,omap4-prm" },
-	{ .compatible = "ti,omap5-prm" },
-	{ .compatible = "ti,dra7-prm" },
-	{ }
+static const struct prcm_match_data prm_base_data = {
+	.flags = PRCM_REGISTER_CLOCKS,
+	.index = PRCM_CLK_MEMMAP_INDEX_PRM,
+};
+
+static const struct prcm_match_data prcm_base_data = {
+	.flags = 0,
+	.index = PRCM_CLK_MEMMAP_INDEX_PRM,
+};
+
+static const struct prcm_match_data scrm_base_data = {
+	.flags = PRCM_REGISTER_CLOCKS,
+	.index = PRCM_CLK_MEMMAP_INDEX_SCRM,
+};
+
+static const struct prcm_match_data omap3_prm_data = {
+	.flags = PRCM_REGISTER_CLOCKS,
+	.index = PRCM_CLK_MEMMAP_INDEX_PRM,
+	.offset = 0x800,
 };
 
-static struct of_device_id omap_prcm_dt_match_table[] = {
-	{ .compatible = "ti,am3-prcm" },
-	{ .compatible = "ti,am4-prcm" },
-	{ .compatible = "ti,omap2-prcm" },
+
+static struct of_device_id omap_prm_dt_match_table[] = {
+	{ .compatible = "ti,omap3-prm", .data = &omap3_prm_data },
+	{ .compatible = "ti,omap4-prm", .data = &prm_base_data },
+	{ .compatible = "ti,omap5-prm", .data = &prm_base_data },
+	{ .compatible = "ti,dra7-prm", .data = &prm_base_data },
+	{ .compatible = "ti,am3-prcm", .data = &prcm_base_data },
+	{ .compatible = "ti,am4-prcm", .data = &prcm_base_data },
+	{ .compatible = "ti,omap2-prcm", .data = &prcm_base_data },
+	{ .compatible = "ti,omap4-scrm", .data = &scrm_base_data },
+	{ .compatible = "ti,omap5-scrm", .data = &scrm_base_data },
 	{ }
 };
 
@@ -500,38 +521,66 @@ static struct ti_clk_ll_ops omap_clk_ll_ops = {
 	.clk_writel = prm_clk_writel,
 };
 
-static int prcm_memmap_index;
-
 int __init of_prcm_module_init(struct of_device_id *match_table)
 {
 	struct device_node *np;
-	void __iomem *mem;
+	const struct of_device_id *match;
+	const struct prcm_match_data *data;
 
 	ti_clk_ll_ops = &omap_clk_ll_ops;
 
-	for_each_matching_node(np, match_table) {
-		mem = of_iomap(np, 0);
-		clk_memmaps[prcm_memmap_index] = mem;
-		ti_dt_clk_init_provider(np, prcm_memmap_index);
+	for_each_matching_node_and_match(np, match_table, &match) {
+		data = match->data;
+		if (!(data->flags & PRCM_REGISTER_CLOCKS))
+			continue;
+		ti_dt_clk_init_provider(np, data->index);
 		ti_dt_clockdomains_setup(np);
-		prcm_memmap_index++;
 	}
 
 	return 0;
 }
 
-int __init of_prm_init(void)
+int __init of_prcm_init(void)
+{
+	int ret;
+
+	ret = of_prcm_module_init(omap_prm_dt_match_table);
+	ret |= of_cm_init();
+	return ret;
+}
+
+static int of_prm_base_init(void)
 {
-	return of_prcm_module_init(omap_prm_dt_match_table);
+	struct device_node *np;
+	const struct of_device_id *match;
+	const struct prcm_match_data *data;
+
+	for_each_matching_node_and_match(np, omap_prm_dt_match_table, &match) {
+		data = match->data;
+		if (clk_memmaps[data->index])
+			pr_warn("WARNING: multiple prcm compatible mods, %d\n",
+				data->index);
+
+		clk_memmaps[data->index] = of_iomap(np, 0);
+
+		if (data->index == PRCM_CLK_MEMMAP_INDEX_PRM)
+			prm_base = clk_memmaps[data->index] + data->offset;
+	}
+
+	return 0;
 }
 
-int __init of_prcm_init(void)
+
+int __init of_prcm_base_init(void)
 {
 	int ret;
 
-	ret = of_prm_init();
-	ret |= of_cm_init();
-	ret |= of_prcm_module_init(omap_prcm_dt_match_table);
+	ret = of_prm_base_init();
+	ret |= of_cm_base_init();
+	ret |= of_scrm_base_init();
+
+	omap_prm_base_init();
+	omap_cm_base_init();
 
 	return ret;
 }
diff --git a/include/linux/power/omap/prcm-common.h b/include/linux/power/omap/prcm-common.h
index 67143a2..b9cce23 100644
--- a/include/linux/power/omap/prcm-common.h
+++ b/include/linux/power/omap/prcm-common.h
@@ -519,6 +519,21 @@ struct omap_prcm_irq_setup {
 
 struct of_device_id;
 
+#define PRCM_REGISTER_CLOCKS			0x1
+
+struct prcm_match_data {
+	u32 flags;
+	u16 index;
+	u16 offset;
+};
+
+enum {
+	PRCM_CLK_MEMMAP_INDEX_PRM = 0,
+	PRCM_CLK_MEMMAP_INDEX_CM1,
+	PRCM_CLK_MEMMAP_INDEX_CM2,
+	PRCM_CLK_MEMMAP_INDEX_SCRM,
+};
+
 extern void __iomem *clk_memmaps[];
 
 void omap_prcm_irq_cleanup(void);
@@ -529,6 +544,9 @@ void omap_prcm_irq_complete(void);
 void omap_pcs_legacy_init(int irq, void (*rearm)(void));
 int of_prcm_module_init(struct of_device_id *match_table);
 int of_cm_init(void);
+int of_cm_base_init(void);
+int of_prcm_base_init(void);
+int of_scrm_base_init(void);
 
 # endif
 
-- 
1.7.9.5

