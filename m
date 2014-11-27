From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 19/23] ARM: OMAP2+: PRM: move SoC specific init calls within a generic API
Date: Thu, 27 Nov 2014 17:51:50 +0200
Message-ID: <1417103514-17027-20-git-send-email-t-kristo@ti.com>
References: <1417103514-17027-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40603 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbaK0PwS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Nov 2014 10:52:18 -0500
In-Reply-To: <1417103514-17027-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, paul@pwsan.com, nm@ti.com
Cc: linux-arm-kernel@lists.infradead.org

This gets rid of need for some exported driver APIs, and simplifies the
initialization of the PRM driver. Done in preparation to make PRM a
separate driver. The init data is now also passed to the SoC specific
implementations, allowing future expansion to add feature flags etc.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/io.c           |   17 +++++++-------
 arch/arm/mach-omap2/prcm-common.h  |    4 ++++
 arch/arm/mach-omap2/prm.h          |    1 +
 arch/arm/mach-omap2/prm2xxx.c      |    3 +--
 arch/arm/mach-omap2/prm2xxx.h      |    2 +-
 arch/arm/mach-omap2/prm33xx.c      |    3 +--
 arch/arm/mach-omap2/prm33xx.h      |    2 +-
 arch/arm/mach-omap2/prm3xxx.c      |    4 +---
 arch/arm/mach-omap2/prm3xxx.h      |    2 +-
 arch/arm/mach-omap2/prm44xx.c      |    3 +--
 arch/arm/mach-omap2/prm44xx.h      |    1 -
 arch/arm/mach-omap2/prm44xx_54xx.h |    4 +++-
 arch/arm/mach-omap2/prm54xx.h      |    1 -
 arch/arm/mach-omap2/prm7xx.h       |    2 +-
 arch/arm/mach-omap2/prm_common.c   |   43 +++++++++++++++++++++++++++---------
 15 files changed, 58 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 89b7762..cab93d5 100644
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
@@ -568,7 +569,7 @@ void __init am33xx_init_early(void)
 	omap2_control_base_init();
 	omap3xxx_check_revision();
 	am33xx_check_features();
-	am33xx_prm_init();
+	omap2_prcm_base_init();
 	am33xx_cm_init();
 	am33xx_powerdomains_init();
 	am33xx_clockdomains_init();
@@ -591,7 +592,7 @@ void __init am43xx_init_early(void)
 	omap2_control_base_init();
 	omap3xxx_check_revision();
 	am33xx_check_features();
-	omap44xx_prm_init();
+	omap2_prcm_base_init();
 	omap4_cm_init();
 	am43xx_powerdomains_init();
 	am43xx_clockdomains_init();
@@ -616,7 +617,7 @@ void __init omap4430_init_early(void)
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP4430_PRCM_MPU_BASE));
 	omap4xxx_check_revision();
 	omap4xxx_check_features();
-	omap44xx_prm_init();
+	omap2_prcm_base_init();
 	omap4_cm_init();
 	omap4_pm_init_early();
 	omap44xx_voltagedomains_init();
@@ -644,7 +645,7 @@ void __init omap5_init_early(void)
 	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE));
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP54XX_PRCM_MPU_BASE));
 	omap4_pm_init_early();
-	omap44xx_prm_init();
+	omap2_prcm_base_init();
 	omap5xxx_check_revision();
 	omap4_cm_init();
 	omap54xx_voltagedomains_init();
@@ -670,7 +671,7 @@ void __init dra7xx_init_early(void)
 	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(OMAP54XX_SCM_BASE));
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP54XX_PRCM_MPU_BASE));
 	omap4_pm_init_early();
-	omap44xx_prm_init();
+	omap2_prcm_base_init();
 	dra7xxx_check_revision();
 	omap4_cm_init();
 	dra7xx_powerdomains_init();
diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index 6a103c9..d0d81d0 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -524,11 +524,15 @@ struct of_device_id;
  * @index: clock memory mapping index to be used
  * @mem: IO mem pointer for this module
  * @offset: module base address offset from the IO base
+ * @init: low level PRCM init function for this module
+ * @np: device node for this PRCM module
  */
 struct omap_prcm_init_data {
 	int index;
 	void __iomem *mem;
 	s16 offset;
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
index 29e203f..752018c 100644
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
index 994fb8b..72bfdab 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -669,10 +669,8 @@ static struct prm_ll_data omap3xxx_prm_ll_data = {
 	.vp_clear_txdone = &omap3_prm_vp_clear_txdone,
 };
 
-int __init omap3xxx_prm_init(void)
+int __init omap3xxx_prm_init(const struct omap_prcm_init_data *data)
 {
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
index 016759f..e179dbe 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -702,9 +702,8 @@ static struct prm_ll_data omap44xx_prm_ll_data = {
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
index 7d4a97a..b2e1eee 100644
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
@@ -622,12 +623,14 @@ int prm_unregister(struct prm_ll_data *pld)
 	return 0;
 }
 
-static struct omap_prcm_init_data prm_data = {
+static struct omap_prcm_init_data omap2_prm_data __initdata = {
 	.index = CLK_MEMMAP_INDEX_PRM,
+	.init = omap2xxx_prm_init,
 };
 
-static struct omap_prcm_init_data omap3_prm_data = {
+static struct omap_prcm_init_data omap3_prm_data __initdata = {
 	.index = CLK_MEMMAP_INDEX_PRM,
+	.init = omap3xxx_prm_init,
 
 	/*
 	 * IVA2 offset is negative value, must offset the cm_base address
@@ -636,20 +639,30 @@ static struct omap_prcm_init_data omap3_prm_data = {
 	.offset = -OMAP3430_IVA2_MOD,
 };
 
-static struct omap_prcm_init_data scrm_data = {
+static struct omap_prcm_init_data am3_prm_data __initdata = {
+	.index = CLK_MEMMAP_INDEX_PRM,
+	.init = am33xx_prm_init,
+};
+
+static struct omap_prcm_init_data omap4_prm_data __initdata = {
+	.index = CLK_MEMMAP_INDEX_PRM,
+	.init = omap44xx_prm_init,
+};
+
+static struct omap_prcm_init_data scrm_data __initdata = {
 	.index = CLK_MEMMAP_INDEX_SCRM,
 };
 
-static struct of_device_id omap_prcm_dt_match_table[] = {
-	{ .compatible = "ti,am3-prcm", .data = &prm_data },
-	{ .compatible = "ti,am4-prcm", .data = &prm_data },
-	{ .compatible = "ti,omap2-prcm", .data = &prm_data },
+static struct of_device_id omap_prcm_dt_match_table[] __initdata = {
+	{ .compatible = "ti,am3-prcm", .data = &am3_prm_data },
+	{ .compatible = "ti,am4-prcm", .data = &omap4_prm_data },
+	{ .compatible = "ti,omap2-prcm", .data = &omap2_prm_data },
 	{ .compatible = "ti,omap3-prm", .data = &omap3_prm_data },
-	{ .compatible = "ti,omap4-prm", .data = &prm_data },
+	{ .compatible = "ti,omap4-prm", .data = &omap4_prm_data },
 	{ .compatible = "ti,omap4-scrm", .data = &scrm_data },
-	{ .compatible = "ti,omap5-prm", .data = &prm_data },
+	{ .compatible = "ti,omap5-prm", .data = &omap4_prm_data },
 	{ .compatible = "ti,omap5-scrm", .data = &scrm_data },
-	{ .compatible = "ti,dra7-prm", .data = &prm_data },
+	{ .compatible = "ti,dra7-prm", .data = &omap4_prm_data },
 	{ }
 };
 
@@ -678,11 +691,21 @@ int __init omap2_prm_base_init(void)
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

