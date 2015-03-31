From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv6 12/34] ARM: OMAP2+: CM: determine CM base address from device tree
Date: Tue, 31 Mar 2015 22:14:05 +0300
Message-ID: <1427829267-32077-13-git-send-email-t-kristo@ti.com>
References: <1427829267-32077-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56419 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752705AbbCaTOv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 31 Mar 2015 15:14:51 -0400
In-Reply-To: <1427829267-32077-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
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
 arch/arm/mach-omap2/cm3xxx.c      |    2 +
 arch/arm/mach-omap2/cm_common.c   |   73 ++++++++++++++++++++++++++++++++++---
 arch/arm/mach-omap2/cminst44xx.c  |    1 +
 arch/arm/mach-omap2/io.c          |   14 +------
 arch/arm/mach-omap2/prcm-common.h |    6 +++
 arch/arm/mach-omap2/prm_common.c  |    1 -
 9 files changed, 81 insertions(+), 19 deletions(-)

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
index cc5aac7..221bca3 100644
--- a/arch/arm/mach-omap2/cm33xx.c
+++ b/arch/arm/mach-omap2/cm33xx.c
@@ -354,6 +354,7 @@ static struct cm_ll_data am33xx_cm_ll_data = {
 
 int __init am33xx_cm_init(void)
 {
+	omap2_cm_base_init();
 	return cm_register(&am33xx_cm_ll_data);
 }
 
diff --git a/arch/arm/mach-omap2/cm3xxx.c b/arch/arm/mach-omap2/cm3xxx.c
index ebead8f..88e6cb6 100644
--- a/arch/arm/mach-omap2/cm3xxx.c
+++ b/arch/arm/mach-omap2/cm3xxx.c
@@ -673,6 +673,8 @@ static struct cm_ll_data omap3xxx_cm_ll_data = {
 
 int __init omap3xxx_cm_init(void)
 {
+	omap2_clk_legacy_provider_init(TI_CLKM_CM, cm_base + OMAP3430_IVA2_MOD);
+	omap2_cm_base_init();
 	return cm_register(&omap3xxx_cm_ll_data);
 }
 
diff --git a/arch/arm/mach-omap2/cm_common.c b/arch/arm/mach-omap2/cm_common.c
index f3d578b..32af8fc 100644
--- a/arch/arm/mach-omap2/cm_common.c
+++ b/arch/arm/mach-omap2/cm_common.c
@@ -36,6 +36,8 @@ void __iomem *cm_base;
 /* cm2_base: base virtual address of the CM2 IP block (OMAP44xx only) */
 void __iomem *cm2_base;
 
+#define CM_NO_CLOCKS		0x1
+
 /**
  * omap2_set_globals_cm - set the CM/CM2 base addresses (for early use)
  * @cm: CM base virtual address
@@ -224,18 +226,79 @@ static struct omap_prcm_init_data cm2_data = {
 	.index = TI_CLKM_CM2,
 };
 
+static struct omap_prcm_init_data omap2_prcm_data = {
+	.index = TI_CLKM_CM,
+	.flags = CM_NO_CLOCKS,
+};
+
+static struct omap_prcm_init_data omap3_cm_data = {
+	.index = TI_CLKM_CM,
+
+	/*
+	 * IVA2 offset is a negative value, must offset the cm_base address
+	 * by this to get it to positive side on the iomap
+	 */
+	.offset = -OMAP3430_IVA2_MOD,
+};
+
+static struct omap_prcm_init_data am3_prcm_data = {
+	.index = TI_CLKM_CM,
+	.flags = CM_NO_CLOCKS,
+};
+
+static struct omap_prcm_init_data am4_prcm_data = {
+	.index = TI_CLKM_CM,
+	.flags = CM_NO_CLOCKS,
+};
+
 static const struct of_device_id omap_cm_dt_match_table[] = {
-	{ .compatible = "ti,omap3-cm", .data = &cm_data },
+	{ .compatible = "ti,omap2-prcm", .data = &omap2_prcm_data },
+	{ .compatible = "ti,omap3-cm", .data = &omap3_cm_data },
 	{ .compatible = "ti,omap4-cm1", .data = &cm_data },
 	{ .compatible = "ti,omap4-cm2", .data = &cm2_data },
 	{ .compatible = "ti,omap5-cm-core-aon", .data = &cm_data },
 	{ .compatible = "ti,omap5-cm-core", .data = &cm2_data },
 	{ .compatible = "ti,dra7-cm-core-aon", .data = &cm_data },
 	{ .compatible = "ti,dra7-cm-core", .data = &cm2_data },
+	{ .compatible = "ti,am3-prcm", .data = &am3_prcm_data },
+	{ .compatible = "ti,am4-prcm", .data = &am4_prcm_data },
 	{ }
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
+		if (data->index == TI_CLKM_CM)
+			cm_base = mem + data->offset;
+
+		if (data->index == TI_CLKM_CM2)
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
@@ -244,7 +307,6 @@ static const struct of_device_id omap_cm_dt_match_table[] = {
 int __init omap_cm_init(void)
 {
 	struct device_node *np;
-	void __iomem *mem;
 	const struct of_device_id *match;
 	const struct omap_prcm_init_data *data;
 	int ret;
@@ -252,11 +314,10 @@ int __init omap_cm_init(void)
 	for_each_matching_node_and_match(np, omap_cm_dt_match_table, &match) {
 		data = match->data;
 
-		mem = of_iomap(np, 0);
-		if (!mem)
-			return -ENOMEM;
+		if (data->flags & CM_NO_CLOCKS)
+			continue;
 
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
index 46640c0..b43e09d 100644
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
@@ -552,7 +552,6 @@ void __init ti814x_init_early(void)
 	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(TI81XX_CTRL_BASE),
 				  NULL);
 	omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(TI81XX_PRCM_BASE));
-	omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(TI81XX_PRCM_BASE), NULL);
 	omap3xxx_check_revision();
 	ti81xx_check_features();
 	am33xx_prm_init();
@@ -573,7 +572,6 @@ void __init ti816x_init_early(void)
 	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(TI81XX_CTRL_BASE),
 				  NULL);
 	omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(TI81XX_PRCM_BASE));
-	omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(TI81XX_PRCM_BASE), NULL);
 	omap3xxx_check_revision();
 	ti81xx_check_features();
 	am33xx_prm_init();
@@ -596,7 +594,6 @@ void __init am33xx_init_early(void)
 	omap2_set_globals_control(AM33XX_L4_WK_IO_ADDRESS(AM33XX_CTRL_BASE),
 				  NULL);
 	omap2_set_globals_prm(AM33XX_L4_WK_IO_ADDRESS(AM33XX_PRCM_BASE));
-	omap2_set_globals_cm(AM33XX_L4_WK_IO_ADDRESS(AM33XX_PRCM_BASE), NULL);
 	omap3xxx_check_revision();
 	am33xx_check_features();
 	am33xx_prm_init();
@@ -622,7 +619,6 @@ void __init am43xx_init_early(void)
 	omap2_set_globals_control(AM33XX_L4_WK_IO_ADDRESS(AM33XX_CTRL_BASE),
 				  NULL);
 	omap2_set_globals_prm(AM33XX_L4_WK_IO_ADDRESS(AM43XX_PRCM_BASE));
-	omap2_set_globals_cm(AM33XX_L4_WK_IO_ADDRESS(AM43XX_PRCM_BASE), NULL);
 	omap3xxx_check_revision();
 	am33xx_check_features();
 	omap44xx_prm_init();
@@ -649,8 +645,6 @@ void __init omap4430_init_early(void)
 	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP443X_SCM_BASE),
 				  OMAP2_L4_IO_ADDRESS(OMAP443X_CTRL_BASE));
 	omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(OMAP4430_PRM_BASE));
-	omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(OMAP4430_CM_BASE),
-			     OMAP2_L4_IO_ADDRESS(OMAP4430_CM2_BASE));
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP4430_PRCM_MPU_BASE));
 	omap4xxx_check_revision();
 	omap4xxx_check_features();
@@ -682,8 +676,6 @@ void __init omap5_init_early(void)
 	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE),
 				  OMAP2_L4_IO_ADDRESS(OMAP54XX_CTRL_BASE));
 	omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(OMAP54XX_PRM_BASE));
-	omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(OMAP54XX_CM_CORE_AON_BASE),
-			     OMAP2_L4_IO_ADDRESS(OMAP54XX_CM_CORE_BASE));
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP54XX_PRCM_MPU_BASE));
 	omap4_pm_init_early();
 	omap44xx_prm_init();
@@ -712,8 +704,6 @@ void __init dra7xx_init_early(void)
 	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE),
 				  OMAP2_L4_IO_ADDRESS(DRA7XX_CTRL_BASE));
 	omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(OMAP54XX_PRM_BASE));
-	omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(DRA7XX_CM_CORE_AON_BASE),
-			     OMAP2_L4_IO_ADDRESS(OMAP54XX_CM_CORE_BASE));
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP54XX_PRCM_MPU_BASE));
 	omap4_pm_init_early();
 	omap44xx_prm_init();
diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index ee38356..9e4dd0b 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -521,9 +521,15 @@ struct omap_prcm_irq_setup {
 /**
  * struct omap_prcm_init_data - PRCM driver init data
  * @index: clock memory mapping index to be used
+ * @mem: IO mem pointer for this module
+ * @offset: module base address offset from the IO base
+ * @flags: PRCM module init flags
  */
 struct omap_prcm_init_data {
 	int index;
+	void __iomem *mem;
+	s16 offset;
+	u16 flags;
 };
 
 extern void omap_prcm_irq_cleanup(void);
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 6cbebbe..9f9c816 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -689,7 +689,6 @@ int __init omap_prcm_init(void)
 
 void __init omap3_prcm_legacy_iomaps_init(void)
 {
-	omap2_clk_legacy_provider_init(TI_CLKM_CM, cm_base + OMAP3430_IVA2_MOD);
 	omap2_clk_legacy_provider_init(TI_CLKM_PRM,
 				       prm_base + OMAP3430_IVA2_MOD);
 	omap2_clk_legacy_provider_init(TI_CLKM_SCRM, omap_ctrl_base_get());
-- 
1.7.9.5

