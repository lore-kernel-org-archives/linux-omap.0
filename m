From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 16/35] ARM: OMAP2+: PRM: move SoC specific init calls within a generic API
Date: Fri, 20 Mar 2015 20:44:27 +0200
Message-ID: <1426877086-17131-17-git-send-email-t-kristo@ti.com>
References: <1426877086-17131-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56910 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbbCTSqG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2015 14:46:06 -0400
In-Reply-To: <1426877086-17131-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, sakari.ailus@iki.fi
Cc: linux-arm-kernel@lists.infradead.org

This gets rid of need for some exported driver APIs, and simplifies the
initialization of the PRM driver. Done in preparation to make PRM a
separate driver. The init data is now also passed to the SoC specific
implementations, allowing future expansion to add feature flags etc.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/io.c           |   21 ++++++-----
 arch/arm/mach-omap2/prcm-common.h  |    4 ++
 arch/arm/mach-omap2/prm.h          |    1 +
 arch/arm/mach-omap2/prm2xxx.c      |    3 +-
 arch/arm/mach-omap2/prm2xxx.h      |    2 +-
 arch/arm/mach-omap2/prm33xx.c      |    3 +-
 arch/arm/mach-omap2/prm33xx.h      |    2 +-
 arch/arm/mach-omap2/prm3xxx.c      |    4 +-
 arch/arm/mach-omap2/prm3xxx.h      |    2 +-
 arch/arm/mach-omap2/prm44xx.c      |    3 +-
 arch/arm/mach-omap2/prm44xx.h      |    1 -
 arch/arm/mach-omap2/prm44xx_54xx.h |    4 +-
 arch/arm/mach-omap2/prm54xx.h      |    1 -
 arch/arm/mach-omap2/prm7xx.h       |    2 +-
 arch/arm/mach-omap2/prm_common.c   |   72 ++++++++++++++++++++++++++++++------
 15 files changed, 87 insertions(+), 38 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 622ee3b..7632dfe 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -386,7 +386,7 @@ void __init omap2420_init_early(void)
 			       OMAP2_L3_IO_ADDRESS(OMAP2420_SMS_BASE));
 	omap2_control_base_init();
 	omap2xxx_check_revision();
-	omap2xxx_prm_init();
+	omap2_prcm_base_init();
 	omap2xxx_cm_init();
 	omap2xxx_voltagedomains_init();
 	omap242x_powerdomains_init();
@@ -413,7 +413,7 @@ void __init omap2430_init_early(void)
 			       OMAP2_L3_IO_ADDRESS(OMAP243X_SMS_BASE));
 	omap2_control_base_init();
 	omap2xxx_check_revision();
-	omap2xxx_prm_init();
+	omap2_prcm_base_init();
 	omap2xxx_cm_init();
 	omap2xxx_voltagedomains_init();
 	omap243x_powerdomains_init();
@@ -453,7 +453,8 @@ void __init omap3_init_early(void)
 	omap2_control_base_init();
 	omap3xxx_check_revision();
 	omap3xxx_check_features();
-	omap3xxx_prm_init();
+	omap2_prcm_base_init();
+	omap3xxx_prm_init(NULL);
 	omap3xxx_cm_init();
 	omap3xxx_voltagedomains_init();
 	omap3xxx_powerdomains_init();
@@ -551,7 +552,7 @@ void __init ti814x_init_early(void)
 	omap2_control_base_init();
 	omap3xxx_check_revision();
 	ti81xx_check_features();
-	am33xx_prm_init();
+	omap2_prcm_base_init();
 	am33xx_cm_init();
 	omap3xxx_voltagedomains_init();
 	omap3xxx_powerdomains_init();
@@ -569,7 +570,7 @@ void __init ti816x_init_early(void)
 	omap2_control_base_init();
 	omap3xxx_check_revision();
 	ti81xx_check_features();
-	am33xx_prm_init();
+	omap2_prcm_base_init();
 	am33xx_cm_init();
 	omap3xxx_voltagedomains_init();
 	omap3xxx_powerdomains_init();
@@ -589,7 +590,7 @@ void __init am33xx_init_early(void)
 	omap2_control_base_init();
 	omap3xxx_check_revision();
 	am33xx_check_features();
-	am33xx_prm_init();
+	omap2_prcm_base_init();
 	am33xx_cm_init();
 	am33xx_powerdomains_init();
 	am33xx_clockdomains_init();
@@ -612,7 +613,7 @@ void __init am43xx_init_early(void)
 	omap2_control_base_init();
 	omap3xxx_check_revision();
 	am33xx_check_features();
-	omap44xx_prm_init();
+	omap2_prcm_base_init();
 	omap4_cm_init();
 	am43xx_powerdomains_init();
 	am43xx_clockdomains_init();
@@ -638,7 +639,7 @@ void __init omap4430_init_early(void)
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP4430_PRCM_MPU_BASE));
 	omap4xxx_check_revision();
 	omap4xxx_check_features();
-	omap44xx_prm_init();
+	omap2_prcm_base_init();
 	omap4_cm_init();
 	omap4_pm_init_early();
 	omap44xx_voltagedomains_init();
@@ -667,7 +668,7 @@ void __init omap5_init_early(void)
 				  OMAP2_L4_IO_ADDRESS(OMAP54XX_CTRL_BASE));
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP54XX_PRCM_MPU_BASE));
 	omap4_pm_init_early();
-	omap44xx_prm_init();
+	omap2_prcm_base_init();
 	omap5xxx_check_revision();
 	omap4_cm_init();
 	omap54xx_voltagedomains_init();
@@ -694,7 +695,7 @@ void __init dra7xx_init_early(void)
 				  OMAP2_L4_IO_ADDRESS(DRA7XX_CTRL_BASE));
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP54XX_PRCM_MPU_BASE));
 	omap4_pm_init_early();
-	omap44xx_prm_init();
+	omap2_prcm_base_init();
 	dra7xxx_check_revision();
 	omap4_cm_init();
 	dra7xx_powerdomains_init();
diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index 9e4dd0b..461bdc4 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -524,12 +524,16 @@ struct omap_prcm_irq_setup {
  * @mem: IO mem pointer for this module
  * @offset: module base address offset from the IO base
  * @flags: PRCM module init flags
+ * @init: low level PRCM init function for this module
+ * @np: device node for this PRCM module
  */
 struct omap_prcm_init_data {
 	int index;
 	void __iomem *mem;
 	s16 offset;
 	u16 flags;
+	int (*init)(const struct omap_prcm_init_data *data);
+	struct device_node *np;
 };
 
 extern void omap_prcm_irq_cleanup(void);
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index 6707333..3936e6c 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -21,6 +21,7 @@ extern u16 prm_features;
 extern void omap2_set_globals_prm(void __iomem *prm);
 int omap_prcm_init(void);
 int omap2_prm_base_init(void);
+int omap2_prcm_base_init(void);
 # endif
 
 /*
diff --git a/arch/arm/mach-omap2/prm2xxx.c b/arch/arm/mach-omap2/prm2xxx.c
index 29e203f..752018ce 100644
--- a/arch/arm/mach-omap2/prm2xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx.c
@@ -220,9 +220,8 @@ static struct prm_ll_data omap2xxx_prm_ll_data = {
 	.clear_mod_irqs = &omap2xxx_prm_clear_mod_irqs,
 };
 
-int __init omap2xxx_prm_init(void)
+int __init omap2xxx_prm_init(const struct omap_prcm_init_data *data)
 {
-	omap2_prm_base_init();
 	return prm_register(&omap2xxx_prm_ll_data);
 }
 
diff --git a/arch/arm/mach-omap2/prm2xxx.h b/arch/arm/mach-omap2/prm2xxx.h
index 9c91f4f..9008a9e 100644
--- a/arch/arm/mach-omap2/prm2xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx.h
@@ -124,7 +124,7 @@
 extern int omap2xxx_clkdm_sleep(struct clockdomain *clkdm);
 extern int omap2xxx_clkdm_wakeup(struct clockdomain *clkdm);
 
-extern int __init omap2xxx_prm_init(void);
+int __init omap2xxx_prm_init(const struct omap_prcm_init_data *data);
 
 #endif
 
diff --git a/arch/arm/mach-omap2/prm33xx.c b/arch/arm/mach-omap2/prm33xx.c
index 1e052aa..dcb5001 100644
--- a/arch/arm/mach-omap2/prm33xx.c
+++ b/arch/arm/mach-omap2/prm33xx.c
@@ -378,9 +378,8 @@ static struct prm_ll_data am33xx_prm_ll_data = {
 	.reset_system			= am33xx_prm_global_warm_sw_reset,
 };
 
-int __init am33xx_prm_init(void)
+int __init am33xx_prm_init(const struct omap_prcm_init_data *data)
 {
-	omap2_prm_base_init();
 	return prm_register(&am33xx_prm_ll_data);
 }
 
diff --git a/arch/arm/mach-omap2/prm33xx.h b/arch/arm/mach-omap2/prm33xx.h
index 98ac41f..2bc4ec5 100644
--- a/arch/arm/mach-omap2/prm33xx.h
+++ b/arch/arm/mach-omap2/prm33xx.h
@@ -118,7 +118,7 @@
 #define AM33XX_PM_CEFUSE_PWRSTST		AM33XX_PRM_REGADDR(AM33XX_PRM_CEFUSE_MOD, 0x0004)
 
 #ifndef __ASSEMBLER__
-int am33xx_prm_init(void);
+int am33xx_prm_init(const struct omap_prcm_init_data *data);
 
 #endif /* ASSEMBLER */
 #endif
diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index a347993..62680aa 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -670,12 +670,10 @@ static struct prm_ll_data omap3xxx_prm_ll_data = {
 	.vp_clear_txdone = &omap3_prm_vp_clear_txdone,
 };
 
-int __init omap3xxx_prm_init(void)
+int __init omap3xxx_prm_init(const struct omap_prcm_init_data *data)
 {
 	omap2_clk_legacy_provider_init(TI_CLKM_PRM,
 				       prm_base + OMAP3430_IVA2_MOD);
-	omap2_prm_base_init();
-
 	if (omap3_has_io_wakeup())
 		prm_features |= PRM_HAS_IO_WAKEUP;
 
diff --git a/arch/arm/mach-omap2/prm3xxx.h b/arch/arm/mach-omap2/prm3xxx.h
index 55e4c89..5f095ee 100644
--- a/arch/arm/mach-omap2/prm3xxx.h
+++ b/arch/arm/mach-omap2/prm3xxx.h
@@ -140,7 +140,7 @@ extern u32 omap3_prm_vcvp_read(u8 offset);
 extern void omap3_prm_vcvp_write(u32 val, u8 offset);
 extern u32 omap3_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset);
 
-extern int __init omap3xxx_prm_init(void);
+int __init omap3xxx_prm_init(const struct omap_prcm_init_data *data);
 void omap3xxx_prm_iva_idle(void);
 void omap3_prm_reset_modem(void);
 int omap3xxx_prm_clear_global_cold_reset(void);
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index b479a33..e3f2d31 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -703,9 +703,8 @@ static struct prm_ll_data omap44xx_prm_ll_data = {
 	.vp_clear_txdone	= omap4_prm_vp_clear_txdone,
 };
 
-int __init omap44xx_prm_init(void)
+int __init omap44xx_prm_init(const struct omap_prcm_init_data *data)
 {
-	omap2_prm_base_init();
 	omap_prm_base_init();
 
 	if (cpu_is_omap44xx() || soc_is_omap54xx() || soc_is_dra7xx())
diff --git a/arch/arm/mach-omap2/prm44xx.h b/arch/arm/mach-omap2/prm44xx.h
index 7db2422..efd6035 100644
--- a/arch/arm/mach-omap2/prm44xx.h
+++ b/arch/arm/mach-omap2/prm44xx.h
@@ -26,7 +26,6 @@
 #define __ARCH_ARM_MACH_OMAP2_PRM44XX_H
 
 #include "prm44xx_54xx.h"
-#include "prcm-common.h"
 #include "prm.h"
 
 #define OMAP4430_PRM_BASE		0x4a306000
diff --git a/arch/arm/mach-omap2/prm44xx_54xx.h b/arch/arm/mach-omap2/prm44xx_54xx.h
index a470185..3f139eb 100644
--- a/arch/arm/mach-omap2/prm44xx_54xx.h
+++ b/arch/arm/mach-omap2/prm44xx_54xx.h
@@ -23,6 +23,8 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_PRM44XX_54XX_H
 #define __ARCH_ARM_MACH_OMAP2_PRM44XX_54XX_H
 
+#include "prcm-common.h"
+
 /* Function prototypes */
 #ifndef __ASSEMBLER__
 
@@ -34,7 +36,7 @@ extern u32 omap4_prm_vcvp_read(u8 offset);
 extern void omap4_prm_vcvp_write(u32 val, u8 offset);
 extern u32 omap4_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset);
 
-extern int __init omap44xx_prm_init(void);
+int __init omap44xx_prm_init(const struct omap_prcm_init_data *data);
 
 #endif
 
diff --git a/arch/arm/mach-omap2/prm54xx.h b/arch/arm/mach-omap2/prm54xx.h
index e441101..1eb22ff 100644
--- a/arch/arm/mach-omap2/prm54xx.h
+++ b/arch/arm/mach-omap2/prm54xx.h
@@ -22,7 +22,6 @@
 #define __ARCH_ARM_MACH_OMAP2_PRM54XX_H
 
 #include "prm44xx_54xx.h"
-#include "prcm-common.h"
 #include "prm.h"
 
 #define OMAP54XX_PRM_BASE		0x4ae06000
diff --git a/arch/arm/mach-omap2/prm7xx.h b/arch/arm/mach-omap2/prm7xx.h
index 4bb50fbf..cc1e6a2 100644
--- a/arch/arm/mach-omap2/prm7xx.h
+++ b/arch/arm/mach-omap2/prm7xx.h
@@ -22,8 +22,8 @@
 #ifndef __ARCH_ARM_MACH_OMAP2_PRM7XX_H
 #define __ARCH_ARM_MACH_OMAP2_PRM7XX_H
 
-#include "prm44xx_54xx.h"
 #include "prcm-common.h"
+#include "prm44xx_54xx.h"
 #include "prm.h"
 
 #define DRA7XX_PRM_BASE		0x4ae06000
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index a943e14..96002ef 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -32,6 +32,7 @@
 #include "prm2xxx_3xxx.h"
 #include "prm2xxx.h"
 #include "prm3xxx.h"
+#include "prm33xx.h"
 #include "prm44xx.h"
 #include "common.h"
 #include "clock.h"
@@ -633,12 +634,17 @@ int prm_unregister(struct prm_ll_data *pld)
 	return 0;
 }
 
-static struct omap_prcm_init_data prm_data = {
+#ifdef CONFIG_ARCH_OMAP2
+static struct omap_prcm_init_data omap2_prm_data __initdata = {
 	.index = TI_CLKM_PRM,
+	.init = omap2xxx_prm_init,
 };
+#endif
 
-static struct omap_prcm_init_data omap3_prm_data = {
+#ifdef CONFIG_ARCH_OMAP3
+static struct omap_prcm_init_data omap3_prm_data __initdata = {
 	.index = TI_CLKM_PRM,
+	.init = omap3xxx_prm_init,
 
 	/*
 	 * IVA2 offset is a negative value, must offset the prm_base
@@ -646,23 +652,55 @@ static struct omap_prcm_init_data omap3_prm_data = {
 	 */
 	.offset = -OMAP3430_IVA2_MOD,
 };
+#endif
 
-static struct omap_prcm_init_data scrm_data = {
+#if defined(CONFIG_SOC_AM33XX) || defined(CONFIG_SOC_TI81XX)
+static struct omap_prcm_init_data am3_prm_data __initdata = {
+	.index = TI_CLKM_PRM,
+	.init = am33xx_prm_init,
+};
+#endif
+
+#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || \
+	defined(CONFIG_SOC_DRA7XX) || defined(CONFIG_SOC_AM43XX)
+static struct omap_prcm_init_data omap4_prm_data __initdata = {
+	.index = TI_CLKM_PRM,
+	.init = omap44xx_prm_init,
+};
+#endif
+
+static struct omap_prcm_init_data scrm_data __initdata = {
 	.index = TI_CLKM_SCRM,
 };
 
-static const struct of_device_id omap_prcm_dt_match_table[] = {
-	{ .compatible = "ti,am3-prcm", .data = &prm_data },
-	{ .compatible = "ti,am4-prcm", .data = &prm_data },
-	{ .compatible = "ti,dm814-prcm", .data = &prm_data },
-	{ .compatible = "ti,dm816-prcm", .data = &prm_data },
-	{ .compatible = "ti,omap2-prcm", .data = &prm_data },
+static const struct of_device_id omap_prcm_dt_match_table[] __initconst = {
+#ifdef CONFIG_SOC_AM33XX
+	{ .compatible = "ti,am3-prcm", .data = &am3_prm_data },
+#endif
+#ifdef CONFIG_SOC_AM43XX
+	{ .compatible = "ti,am4-prcm", .data = &omap4_prm_data },
+#endif
+#ifdef CONFIG_SOC_TI81XX
+	{ .compatible = "ti,dm814-prcm", .data = &am3_prm_data },
+	{ .compatible = "ti,dm816-prcm", .data = &am3_prm_data },
+#endif
+#ifdef CONFIG_ARCH_OMAP2
+	{ .compatible = "ti,omap2-prcm", .data = &omap2_prm_data },
+#endif
+#ifdef CONFIG_ARCH_OMAP3
 	{ .compatible = "ti,omap3-prm", .data = &omap3_prm_data },
-	{ .compatible = "ti,omap4-prm", .data = &prm_data },
+#endif
+#ifdef CONFIG_ARCH_OMAP4
+	{ .compatible = "ti,omap4-prm", .data = &omap4_prm_data },
 	{ .compatible = "ti,omap4-scrm", .data = &scrm_data },
-	{ .compatible = "ti,omap5-prm", .data = &prm_data },
+#endif
+#ifdef CONFIG_SOC_OMAP5
+	{ .compatible = "ti,omap5-prm", .data = &omap4_prm_data },
 	{ .compatible = "ti,omap5-scrm", .data = &scrm_data },
-	{ .compatible = "ti,dra7-prm", .data = &prm_data },
+#endif
+#ifdef CONFIG_SOC_DRA7XX
+	{ .compatible = "ti,dra7-prm", .data = &omap4_prm_data },
+#endif
 	{ }
 };
 
@@ -691,11 +729,21 @@ int __init omap2_prm_base_init(void)
 			prm_base = mem + data->offset;
 
 		data->mem = mem;
+
+		data->np = np;
+
+		if (data->init)
+			data->init(data);
 	}
 
 	return 0;
 }
 
+int __init omap2_prcm_base_init(void)
+{
+	return omap2_prm_base_init();
+}
+
 /**
  * omap_prcm_init - low level init for the PRCM drivers
  *
-- 
1.7.9.5

