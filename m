From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 07/55] ARM: OMAP3+: PRM: add cpu-type as parameter to prm_init calls
Date: Mon, 31 Mar 2014 18:15:46 +0300
Message-ID: <1396278994-12624-8-git-send-email-t-kristo@ti.com>
References: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49789 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752627AbaCaPRa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Mar 2014 11:17:30 -0400
In-Reply-To: <1396278994-12624-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

This helps to get rid of cpu_is_X checks from within the PRM driver.
Done in preparation to make PRM a separate driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/io.c           |   17 +++++++++++++----
 arch/arm/mach-omap2/prm.h          |   11 +++++++++++
 arch/arm/mach-omap2/prm3xxx.c      |    4 ++--
 arch/arm/mach-omap2/prm3xxx.h      |    2 +-
 arch/arm/mach-omap2/prm44xx.c      |    4 ++--
 arch/arm/mach-omap2/prm44xx_54xx.h |    2 +-
 6 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 5b19efd..251432f 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -458,6 +458,15 @@ void __init omap2430_init_late(void)
  * same machine_id for 34xx and 36xx beagle.. Will get fixed with DT.
  */
 #ifdef CONFIG_ARCH_OMAP3
+static inline u16 omap3_prm_type(void)
+{
+	if (cpu_is_omap3430())
+		return PRM_OMAP3430;
+	if (cpu_is_omap3630())
+		return PRM_OMAP3630;
+	return PRM_OMAP3_OTHER;
+}
+
 void __init omap3_init_early(void)
 {
 	omap2_set_globals_tap(OMAP343X_CLASS, OMAP2_L4_IO_ADDRESS(0x4830A000));
@@ -469,7 +478,7 @@ void __init omap3_init_early(void)
 	omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(OMAP3430_CM_BASE), NULL);
 	omap3xxx_check_revision();
 	omap3xxx_check_features();
-	omap3xxx_prm_init();
+	omap3xxx_prm_init(omap3_prm_type());
 	omap3xxx_cm_init();
 	omap3xxx_voltagedomains_init();
 	omap3xxx_powerdomains_init();
@@ -636,7 +645,7 @@ void __init omap4430_init_early(void)
 	omap4xxx_check_revision();
 	omap4xxx_check_features();
 	omap4_pm_init_early();
-	omap44xx_prm_init();
+	omap44xx_prm_init(PRM_OMAP4);
 	omap44xx_voltagedomains_init();
 	omap44xx_powerdomains_init();
 	omap44xx_clockdomains_init();
@@ -666,7 +675,7 @@ void __init omap5_init_early(void)
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP54XX_PRCM_MPU_BASE));
 	omap_prm_base_init();
 	omap_cm_base_init();
-	omap44xx_prm_init();
+	omap44xx_prm_init(PRM_OMAP5);
 	omap5xxx_check_revision();
 	omap54xx_voltagedomains_init();
 	omap54xx_powerdomains_init();
@@ -694,7 +703,7 @@ void __init dra7xx_init_early(void)
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP54XX_PRCM_MPU_BASE));
 	omap_prm_base_init();
 	omap_cm_base_init();
-	omap44xx_prm_init();
+	omap44xx_prm_init(PRM_DRA7);
 	dra7xx_powerdomains_init();
 	dra7xx_clockdomains_init();
 	dra7xx_hwmod_init();
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index 48480d5..fd5123e 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -30,6 +30,17 @@ int of_prcm_init(void);
  */
 #define PRM_HAS_IO_WAKEUP	(1 << 0)
 
+#ifndef __ASSEMBLER__
+enum {
+	PRM_OMAP3430 = 0,
+	PRM_OMAP3630,
+	PRM_OMAP3_OTHER,
+	PRM_OMAP4,
+	PRM_OMAP5,
+	PRM_DRA7,
+};
+#endif
+
 /*
  * MAX_MODULE_SOFTRESET_WAIT: Maximum microseconds to wait for OMAP
  * module to softreset
diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index f92de79..9915cd6 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -641,9 +641,9 @@ static struct prm_ll_data omap3xxx_prm_ll_data = {
 	.late_init = &omap3xxx_prm_late_init,
 };
 
-int __init omap3xxx_prm_init(void)
+int __init omap3xxx_prm_init(u16 cpu_type)
 {
-	if (omap3_has_io_wakeup())
+	if (cpu_type == PRM_OMAP3430 || cpu_type == PRM_OMAP3630)
 		prm_features |= PRM_HAS_IO_WAKEUP;
 
 	return prm_register(&omap3xxx_prm_ll_data);
diff --git a/arch/arm/mach-omap2/prm3xxx.h b/arch/arm/mach-omap2/prm3xxx.h
index 7120af9..0e759bc 100644
--- a/arch/arm/mach-omap2/prm3xxx.h
+++ b/arch/arm/mach-omap2/prm3xxx.h
@@ -160,7 +160,7 @@ extern void omap3xxx_prm_restore_irqen(u32 *saved_mask);
 
 extern void omap3xxx_prm_dpll3_reset(void);
 
-extern int __init omap3xxx_prm_init(void);
+int __init omap3xxx_prm_init(u16 cpu_type);
 extern u32 omap3xxx_prm_get_reset_sources(void);
 int omap3xxx_prm_clear_mod_irqs(s16 module, u8 regs, u32 ignore_bits);
 void omap3xxx_prm_iva_idle(void);
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 60b9b05..18fae1dd 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -662,9 +662,9 @@ static struct prm_ll_data omap44xx_prm_ll_data = {
 	.late_init = &omap44xx_prm_late_init,
 };
 
-int __init omap44xx_prm_init(void)
+int __init omap44xx_prm_init(u16 cpu_type)
 {
-	if (cpu_is_omap44xx())
+	if (cpu_type == PRM_OMAP4)
 		prm_features |= PRM_HAS_IO_WAKEUP;
 
 	return prm_register(&omap44xx_prm_ll_data);
diff --git a/arch/arm/mach-omap2/prm44xx_54xx.h b/arch/arm/mach-omap2/prm44xx_54xx.h
index 8d95aa5..73734b2 100644
--- a/arch/arm/mach-omap2/prm44xx_54xx.h
+++ b/arch/arm/mach-omap2/prm44xx_54xx.h
@@ -57,7 +57,7 @@ extern void omap44xx_prm_ocp_barrier(void);
 extern void omap44xx_prm_save_and_clear_irqen(u32 *saved_mask);
 extern void omap44xx_prm_restore_irqen(u32 *saved_mask);
 
-extern int __init omap44xx_prm_init(void);
+int __init omap44xx_prm_init(u16 cpu_type);
 extern u32 omap44xx_prm_get_reset_sources(void);
 
 #endif
-- 
1.7.9.5

