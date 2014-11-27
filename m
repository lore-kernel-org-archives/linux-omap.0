From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 13/23] ARM: OMAP2+: CM: determine CM base address from device tree
Date: Thu, 27 Nov 2014 17:51:44 +0200
Message-ID: <1417103514-17027-14-git-send-email-t-kristo@ti.com>
References: <1417103514-17027-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37127 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751366AbaK0PwJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Nov 2014 10:52:09 -0500
In-Reply-To: <1417103514-17027-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, paul@pwsan.com, nm@ti.com
Cc: linux-arm-kernel@lists.infradead.org

There is no need to provide the CM base address through a low-level API
from the low-level IO init, as this information is available through DT.
Re-routed the parsing function to be called from the CM drivers also to
simplify the implementation under io.c.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cm.h          |    1 +
 arch/arm/mach-omap2/cm2xxx.c      |    1 +
 arch/arm/mach-omap2/cm33xx.c      |    1 +
 arch/arm/mach-omap2/cm3xxx.c      |    1 +
 arch/arm/mach-omap2/cm_common.c   |   56 +++++++++++++++++++++++++++++++------
 arch/arm/mach-omap2/cminst44xx.c  |    1 +
 arch/arm/mach-omap2/io.c          |   12 ++------
 arch/arm/mach-omap2/prcm-common.h |    4 +++
 8 files changed, 58 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
index 748ac33..1fe3e6b 100644
--- a/arch/arm/mach-omap2/cm.h
+++ b/arch/arm/mach-omap2/cm.h
@@ -71,6 +71,7 @@ int omap_cm_module_disable(u8 part, u16 inst, u16 clkctrl_offs);
 extern int cm_register(struct cm_ll_data *cld);
 extern int cm_unregister(struct cm_ll_data *cld);
 int omap_cm_init(void);
+int omap2_cm_base_init(void);
 
 # endif
 
diff --git a/arch/arm/mach-omap2/cm2xxx.c b/arch/arm/mach-omap2/cm2xxx.c
index ef62ac9..f18c844 100644
--- a/arch/arm/mach-omap2/cm2xxx.c
+++ b/arch/arm/mach-omap2/cm2xxx.c
@@ -395,6 +395,7 @@ static struct cm_ll_data omap2xxx_cm_ll_data = {
 
 int __init omap2xxx_cm_init(void)
 {
+	omap2_cm_base_init();
 	return cm_register(&omap2xxx_cm_ll_data);
 }
 
diff --git a/arch/arm/mach-omap2/cm33xx.c b/arch/arm/mach-omap2/cm33xx.c
index b9ad463..4c5038c 100644
--- a/arch/arm/mach-omap2/cm33xx.c
+++ b/arch/arm/mach-omap2/cm33xx.c
@@ -375,6 +375,7 @@ static struct cm_ll_data am33xx_cm_ll_data = {
 
 int __init am33xx_cm_init(void)
 {
+	omap2_cm_base_init();
 	return cm_register(&am33xx_cm_ll_data);
 }
 
diff --git a/arch/arm/mach-omap2/cm3xxx.c b/arch/arm/mach-omap2/cm3xxx.c
index ebead8f..8e91f38 100644
--- a/arch/arm/mach-omap2/cm3xxx.c
+++ b/arch/arm/mach-omap2/cm3xxx.c
@@ -673,6 +673,7 @@ static struct cm_ll_data omap3xxx_cm_ll_data = {
 
 int __init omap3xxx_cm_init(void)
 {
+	omap2_cm_base_init();
 	return cm_register(&omap3xxx_cm_ll_data);
 }
 
diff --git a/arch/arm/mach-omap2/cm_common.c b/arch/arm/mach-omap2/cm_common.c
index ff76cb7..c2d7c7b 100644
--- a/arch/arm/mach-omap2/cm_common.c
+++ b/arch/arm/mach-omap2/cm_common.c
@@ -216,16 +216,26 @@ int cm_unregister(struct cm_ll_data *cld)
 	return 0;
 }
 
-static const struct omap_prcm_init_data cm_data = {
+static struct omap_prcm_init_data cm_data = {
 	.index = CLK_MEMMAP_INDEX_CM1,
 };
 
-static const struct omap_prcm_init_data cm2_data = {
+static struct omap_prcm_init_data cm2_data = {
 	.index = CLK_MEMMAP_INDEX_CM2,
 };
 
+static struct omap_prcm_init_data omap3_cm_data = {
+	.index = CLK_MEMMAP_INDEX_CM1,
+
+	/*
+	 * IVA2 offset is negative value, must offset the cm_base address
+	 * by this to get it to positive
+	 */
+	.offset = -OMAP3430_IVA2_MOD,
+};
+
 static struct of_device_id omap_cm_dt_match_table[] = {
-	{ .compatible = "ti,omap3-cm", .data = &cm_data },
+	{ .compatible = "ti,omap3-cm", .data = &omap3_cm_data },
 	{ .compatible = "ti,omap4-cm1", .data = &cm_data },
 	{ .compatible = "ti,omap4-cm2", .data = &cm2_data },
 	{ .compatible = "ti,omap5-cm-core-aon", .data = &cm_data },
@@ -236,6 +246,39 @@ static struct of_device_id omap_cm_dt_match_table[] = {
 };
 
 /**
+ * omap2_cm_base_init - initialize iomappings for the CM drivers
+ *
+ * Detects and initializes the iomappings for the CM driver, based
+ * on the DT data. Returns 0 in success, negative error value
+ * otherwise.
+ */
+int __init omap2_cm_base_init(void)
+{
+	struct device_node *np;
+	const struct of_device_id *match;
+	struct omap_prcm_init_data *data;
+	void __iomem *mem;
+
+	for_each_matching_node_and_match(np, omap_cm_dt_match_table, &match) {
+		data = (struct omap_prcm_init_data *)match->data;
+
+		mem = of_iomap(np, 0);
+		if (!mem)
+			return -ENOMEM;
+
+		if (data->index == CLK_MEMMAP_INDEX_CM1)
+			cm_base = mem + data->offset;
+
+		if (data->index == CLK_MEMMAP_INDEX_CM2)
+			cm2_base = mem + data->offset;
+
+		data->mem = mem;
+	}
+
+	return 0;
+}
+
+/**
  * omap_cm_init - low level init for the CM drivers
  *
  * Initializes the low level clock infrastructure for CM drivers.
@@ -246,17 +289,12 @@ int __init omap_cm_init(void)
 	struct device_node *np;
 	const struct of_device_id *match;
 	const struct omap_prcm_init_data *data;
-	void __iomem *mem;
 	int ret;
 
 	for_each_matching_node_and_match(np, omap_cm_dt_match_table, &match) {
 		data = match->data;
 
-		mem = of_iomap(np, 0);
-		if (!mem)
-			return -ENOMEM;
-
-		ret = omap2_clk_provider_init(np, data->index, mem);
+		ret = omap2_clk_provider_init(np, data->index, data->mem);
 		if (ret)
 			return ret;
 	}
diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index 9319034..4aed22d 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -516,6 +516,7 @@ static struct cm_ll_data omap4xxx_cm_ll_data = {
 
 int __init omap4_cm_init(void)
 {
+	omap2_cm_base_init();
 	omap_cm_base_init();
 
 	return cm_register(&omap4xxx_cm_ll_data);
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 1147320..9014eca 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -387,7 +387,6 @@ void __init omap2420_init_early(void)
 	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP242X_CTRL_BASE),
 				  NULL);
 	omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(OMAP2420_PRM_BASE));
-	omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(OMAP2420_CM_BASE), NULL);
 	omap2xxx_check_revision();
 	omap2xxx_prm_init();
 	omap2xxx_cm_init();
@@ -417,7 +416,6 @@ void __init omap2430_init_early(void)
 	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP243X_CTRL_BASE),
 				  NULL);
 	omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(OMAP2430_PRM_BASE));
-	omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(OMAP2430_CM_BASE), NULL);
 	omap2xxx_check_revision();
 	omap2xxx_prm_init();
 	omap2xxx_cm_init();
@@ -451,6 +449,8 @@ void __init omap3_init_early(void)
 	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP343X_CTRL_BASE),
 				  NULL);
 	omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(OMAP3430_PRM_BASE));
+
+	/* XXX: remove this once OMAP3 is DT only */
 	omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(OMAP3430_CM_BASE), NULL);
 	omap3xxx_check_revision();
 	omap3xxx_check_features();
@@ -564,7 +564,6 @@ void __init am33xx_init_early(void)
 	omap2_set_globals_control(AM33XX_L4_WK_IO_ADDRESS(AM33XX_CTRL_BASE),
 				  NULL);
 	omap2_set_globals_prm(AM33XX_L4_WK_IO_ADDRESS(AM33XX_PRCM_BASE));
-	omap2_set_globals_cm(AM33XX_L4_WK_IO_ADDRESS(AM33XX_PRCM_BASE), NULL);
 	omap3xxx_check_revision();
 	am33xx_check_features();
 	am33xx_prm_init();
@@ -590,7 +589,6 @@ void __init am43xx_init_early(void)
 	omap2_set_globals_control(AM33XX_L4_WK_IO_ADDRESS(AM33XX_CTRL_BASE),
 				  NULL);
 	omap2_set_globals_prm(AM33XX_L4_WK_IO_ADDRESS(AM43XX_PRCM_BASE));
-	omap2_set_globals_cm(AM33XX_L4_WK_IO_ADDRESS(AM43XX_PRCM_BASE), NULL);
 	omap3xxx_check_revision();
 	am33xx_check_features();
 	omap44xx_prm_init();
@@ -617,8 +615,6 @@ void __init omap4430_init_early(void)
 	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP443X_SCM_BASE),
 				  OMAP2_L4_IO_ADDRESS(OMAP443X_CTRL_BASE));
 	omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(OMAP4430_PRM_BASE));
-	omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(OMAP4430_CM_BASE),
-			     OMAP2_L4_IO_ADDRESS(OMAP4430_CM2_BASE));
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP4430_PRCM_MPU_BASE));
 	omap4xxx_check_revision();
 	omap4xxx_check_features();
@@ -650,8 +646,6 @@ void __init omap5_init_early(void)
 	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE),
 				  OMAP2_L4_IO_ADDRESS(OMAP54XX_CTRL_BASE));
 	omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(OMAP54XX_PRM_BASE));
-	omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(OMAP54XX_CM_CORE_AON_BASE),
-			     OMAP2_L4_IO_ADDRESS(OMAP54XX_CM_CORE_BASE));
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP54XX_PRCM_MPU_BASE));
 	omap4_pm_init_early();
 	omap44xx_prm_init();
@@ -680,8 +674,6 @@ void __init dra7xx_init_early(void)
 	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE),
 				  OMAP2_L4_IO_ADDRESS(DRA7XX_CTRL_BASE));
 	omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(OMAP54XX_PRM_BASE));
-	omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(DRA7XX_CM_CORE_AON_BASE),
-			     OMAP2_L4_IO_ADDRESS(OMAP54XX_CM_CORE_BASE));
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP54XX_PRCM_MPU_BASE));
 	omap4_pm_init_early();
 	omap44xx_prm_init();
diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index e260567..6a103c9 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -522,9 +522,13 @@ struct of_device_id;
 /**
  * struct omap_prcm_init_data - PRCM driver init data
  * @index: clock memory mapping index to be used
+ * @mem: IO mem pointer for this module
+ * @offset: module base address offset from the IO base
  */
 struct omap_prcm_init_data {
 	int index;
+	void __iomem *mem;
+	s16 offset;
 };
 
 extern void omap_prcm_irq_cleanup(void);
-- 
1.7.9.5

