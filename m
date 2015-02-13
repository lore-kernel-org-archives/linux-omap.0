From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 15/33] ARM: OMAP2+: PRM: determine PRM base address from device tree
Date: Fri, 13 Feb 2015 18:12:34 +0200
Message-ID: <1423843973-6050-13-git-send-email-t-kristo@ti.com>
References: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54287 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753686AbbBMQOJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Feb 2015 11:14:09 -0500
In-Reply-To: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, tomi.valkeinen@ti.com, nm@ti.com
Cc: linux-arm-kernel@lists.infradead.org

There is no need to provide the PRM base address through a low-level API
from the low-level IO init, as this information is available through DT.
Re-routed the parsing function to be called from the PRM drivers also to
simplify the implementation under io.c.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/io.c         |   11 ++------
 arch/arm/mach-omap2/prm.h        |    1 +
 arch/arm/mach-omap2/prm2xxx.c    |    1 +
 arch/arm/mach-omap2/prm33xx.c    |    1 +
 arch/arm/mach-omap2/prm3xxx.c    |    2 ++
 arch/arm/mach-omap2/prm44xx.c    |    1 +
 arch/arm/mach-omap2/prm_common.c |   53 +++++++++++++++++++++++++++++++-------
 7 files changed, 52 insertions(+), 18 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index cb0630f..56492f2 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -386,7 +386,6 @@ void __init omap2420_init_early(void)
 			       OMAP2_L3_IO_ADDRESS(OMAP2420_SMS_BASE));
 	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP242X_CTRL_BASE),
 				  NULL);
-	omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(OMAP2420_PRM_BASE));
 	omap2xxx_check_revision();
 	omap2xxx_prm_init();
 	omap2xxx_cm_init();
@@ -415,7 +414,6 @@ void __init omap2430_init_early(void)
 			       OMAP2_L3_IO_ADDRESS(OMAP243X_SMS_BASE));
 	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP243X_CTRL_BASE),
 				  NULL);
-	omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(OMAP2430_PRM_BASE));
 	omap2xxx_check_revision();
 	omap2xxx_prm_init();
 	omap2xxx_cm_init();
@@ -448,9 +446,8 @@ void __init omap3_init_early(void)
 			       OMAP2_L3_IO_ADDRESS(OMAP343X_SMS_BASE));
 	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP343X_CTRL_BASE),
 				  NULL);
+	/* XXX: remove these two once OMAP3 is DT only */
 	omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(OMAP3430_PRM_BASE));
-
-	/* XXX: remove this once OMAP3 is DT only */
 	omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(OMAP3430_CM_BASE), NULL);
 	omap3xxx_check_revision();
 	omap3xxx_check_features();
@@ -498,6 +495,7 @@ void __init ti81xx_init_early(void)
 			      OMAP2_L4_IO_ADDRESS(TI81XX_TAP_BASE));
 	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(TI81XX_CTRL_BASE),
 				  NULL);
+	/* XXX: remove these two once TI81xx is DT only */
 	omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(TI81XX_PRCM_BASE));
 	omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(TI81XX_PRCM_BASE), NULL);
 	omap3xxx_check_revision();
@@ -563,7 +561,6 @@ void __init am33xx_init_early(void)
 			      AM33XX_L4_WK_IO_ADDRESS(AM33XX_TAP_BASE));
 	omap2_set_globals_control(AM33XX_L4_WK_IO_ADDRESS(AM33XX_CTRL_BASE),
 				  NULL);
-	omap2_set_globals_prm(AM33XX_L4_WK_IO_ADDRESS(AM33XX_PRCM_BASE));
 	omap3xxx_check_revision();
 	am33xx_check_features();
 	am33xx_prm_init();
@@ -588,7 +585,6 @@ void __init am43xx_init_early(void)
 			      AM33XX_L4_WK_IO_ADDRESS(AM33XX_TAP_BASE));
 	omap2_set_globals_control(AM33XX_L4_WK_IO_ADDRESS(AM33XX_CTRL_BASE),
 				  NULL);
-	omap2_set_globals_prm(AM33XX_L4_WK_IO_ADDRESS(AM43XX_PRCM_BASE));
 	omap3xxx_check_revision();
 	am33xx_check_features();
 	omap44xx_prm_init();
@@ -614,7 +610,6 @@ void __init omap4430_init_early(void)
 			      OMAP2_L4_IO_ADDRESS(OMAP443X_SCM_BASE));
 	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP443X_SCM_BASE),
 				  OMAP2_L4_IO_ADDRESS(OMAP443X_CTRL_BASE));
-	omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(OMAP4430_PRM_BASE));
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP4430_PRCM_MPU_BASE));
 	omap4xxx_check_revision();
 	omap4xxx_check_features();
@@ -645,7 +640,6 @@ void __init omap5_init_early(void)
 			      OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE));
 	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE),
 				  OMAP2_L4_IO_ADDRESS(OMAP54XX_CTRL_BASE));
-	omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(OMAP54XX_PRM_BASE));
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP54XX_PRCM_MPU_BASE));
 	omap4_pm_init_early();
 	omap44xx_prm_init();
@@ -673,7 +667,6 @@ void __init dra7xx_init_early(void)
 	omap2_set_globals_tap(-1, OMAP2_L4_IO_ADDRESS(DRA7XX_TAP_BASE));
 	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE),
 				  OMAP2_L4_IO_ADDRESS(DRA7XX_CTRL_BASE));
-	omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(OMAP54XX_PRM_BASE));
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP54XX_PRCM_MPU_BASE));
 	omap4_pm_init_early();
 	omap44xx_prm_init();
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index 6521eaa..6707333 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -20,6 +20,7 @@ extern void __iomem *prm_base;
 extern u16 prm_features;
 extern void omap2_set_globals_prm(void __iomem *prm);
 int omap_prcm_init(void);
+int omap2_prm_base_init(void);
 # endif
 
 /*
diff --git a/arch/arm/mach-omap2/prm2xxx.c b/arch/arm/mach-omap2/prm2xxx.c
index bacb05e..29e203f 100644
--- a/arch/arm/mach-omap2/prm2xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx.c
@@ -222,6 +222,7 @@ static struct prm_ll_data omap2xxx_prm_ll_data = {
 
 int __init omap2xxx_prm_init(void)
 {
+	omap2_prm_base_init();
 	return prm_register(&omap2xxx_prm_ll_data);
 }
 
diff --git a/arch/arm/mach-omap2/prm33xx.c b/arch/arm/mach-omap2/prm33xx.c
index 02f6286..1e052aa 100644
--- a/arch/arm/mach-omap2/prm33xx.c
+++ b/arch/arm/mach-omap2/prm33xx.c
@@ -380,6 +380,7 @@ static struct prm_ll_data am33xx_prm_ll_data = {
 
 int __init am33xx_prm_init(void)
 {
+	omap2_prm_base_init();
 	return prm_register(&am33xx_prm_ll_data);
 }
 
diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index 8993ab7..994fb8b 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -671,6 +671,8 @@ static struct prm_ll_data omap3xxx_prm_ll_data = {
 
 int __init omap3xxx_prm_init(void)
 {
+	omap2_prm_base_init();
+
 	if (omap3_has_io_wakeup())
 		prm_features |= PRM_HAS_IO_WAKEUP;
 
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 2692339..016759f 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -704,6 +704,7 @@ static struct prm_ll_data omap44xx_prm_ll_data = {
 
 int __init omap44xx_prm_init(void)
 {
+	omap2_prm_base_init();
 	omap_prm_base_init();
 
 	if (cpu_is_omap44xx() || soc_is_omap54xx() || soc_is_dra7xx())
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 637780e..f4392e5 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -622,11 +622,21 @@ int prm_unregister(struct prm_ll_data *pld)
 	return 0;
 }
 
-static const struct omap_prcm_init_data prm_data = {
+static struct omap_prcm_init_data prm_data = {
 	.index = CLK_MEMMAP_INDEX_PRM,
 };
 
-static const struct omap_prcm_init_data scrm_data = {
+static struct omap_prcm_init_data omap3_prm_data = {
+	.index = CLK_MEMMAP_INDEX_PRM,
+
+	/*
+	 * IVA2 offset is negative value, must offset the cm_base address
+	 * by this to get it to positive
+	 */
+	.offset = -OMAP3430_IVA2_MOD,
+};
+
+static struct omap_prcm_init_data scrm_data = {
 	.index = CLK_MEMMAP_INDEX_SCRM,
 };
 
@@ -634,7 +644,7 @@ static const struct of_device_id omap_prcm_dt_match_table[] = {
 	{ .compatible = "ti,am3-prcm", .data = &prm_data },
 	{ .compatible = "ti,am4-prcm", .data = &prm_data },
 	{ .compatible = "ti,omap2-prcm", .data = &prm_data },
-	{ .compatible = "ti,omap3-prm", .data = &prm_data },
+	{ .compatible = "ti,omap3-prm", .data = &omap3_prm_data },
 	{ .compatible = "ti,omap4-prm", .data = &prm_data },
 	{ .compatible = "ti,omap4-scrm", .data = &scrm_data },
 	{ .compatible = "ti,omap5-prm", .data = &prm_data },
@@ -644,6 +654,36 @@ static const struct of_device_id omap_prcm_dt_match_table[] = {
 };
 
 /**
+ * omap2_prm_base_init - initialize iomappings for the PRM driver
+ *
+ * Detects and initializes the iomappings for the PRM driver, based
+ * on the DT data. Returns 0 in success, negative error value
+ * otherwise.
+ */
+int __init omap2_prm_base_init(void)
+{
+	struct device_node *np;
+	const struct of_device_id *match;
+	struct omap_prcm_init_data *data;
+	void __iomem *mem;
+
+	for_each_matching_node_and_match(np, omap_prcm_dt_match_table, &match) {
+		data = (struct omap_prcm_init_data *)match->data;
+
+		mem = of_iomap(np, 0);
+		if (!mem)
+			return -ENOMEM;
+
+		if (data->index == CLK_MEMMAP_INDEX_PRM)
+			prm_base = mem + data->offset;
+
+		data->mem = mem;
+	}
+
+	return 0;
+}
+
+/**
  * omap_prcm_init - low level init for the PRCM drivers
  *
  * Initializes the low level clock infrastructure for PRCM drivers.
@@ -654,17 +694,12 @@ int __init omap_prcm_init(void)
 	struct device_node *np;
 	const struct of_device_id *match;
 	const struct omap_prcm_init_data *data;
-	void __iomem *mem;
 	int ret;
 
 	for_each_matching_node_and_match(np, omap_prcm_dt_match_table, &match) {
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
-- 
1.7.9.5

