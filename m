From: R Sricharan <r.sricharan@ti.com>
Subject: [PATCH 2/4] ARM: OMAP2+: Move the stubbed prm and cm functions to prcm.c file and make them __weak.
Date: Thu, 10 May 2012 22:36:53 +0530
Message-ID: <1336669615-16454-3-git-send-email-r.sricharan@ti.com>
References: <1336669615-16454-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47782 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754327Ab2EJRHK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 10 May 2012 13:07:10 -0400
In-Reply-To: <1336669615-16454-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, tony@atomide.com, b-cousson@ti.com, r.sricharan@ti.com, paul@pswan.com

Some prm and cm registers read/write and status functions
are built only for some custom OMAP2+ builds and are stubbed
in header files for other builds under ifdef statements.
But this results in adding new CONFIG_ARCH_OMAPXXX
checks when SOCs are added in the future. So move them
to a common place for OMAP2+ and make them 'weak' implementations.

This way no new ifdefs would be required in the future and also
cleans up the existing code.

Signed-off-by: R Sricharan <r.sricharan@ti.com>
---
 arch/arm/mach-omap2/cminst44xx.h   |   25 ------------
 arch/arm/mach-omap2/prcm.c         |   77 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prm2xxx_3xxx.h |   65 ------------------------------
 3 files changed, 77 insertions(+), 90 deletions(-)

diff --git a/arch/arm/mach-omap2/cminst44xx.h b/arch/arm/mach-omap2/cminst44xx.h
index a018a73..d69fdef 100644
--- a/arch/arm/mach-omap2/cminst44xx.h
+++ b/arch/arm/mach-omap2/cminst44xx.h
@@ -16,38 +16,13 @@ extern void omap4_cminst_clkdm_enable_hwsup(u8 part, s16 inst, u16 cdoffs);
 extern void omap4_cminst_clkdm_disable_hwsup(u8 part, s16 inst, u16 cdoffs);
 extern void omap4_cminst_clkdm_force_sleep(u8 part, s16 inst, u16 cdoffs);
 extern void omap4_cminst_clkdm_force_wakeup(u8 part, s16 inst, u16 cdoffs);
-
 extern int omap4_cminst_wait_module_ready(u8 part, u16 inst, s16 cdoffs, u16 clkctrl_offs);
-
-# ifdef CONFIG_ARCH_OMAP4
 extern int omap4_cminst_wait_module_idle(u8 part, u16 inst, s16 cdoffs,
 					 u16 clkctrl_offs);
-
 extern void omap4_cminst_module_enable(u8 mode, u8 part, u16 inst, s16 cdoffs,
 				       u16 clkctrl_offs);
 extern void omap4_cminst_module_disable(u8 part, u16 inst, s16 cdoffs,
 					u16 clkctrl_offs);
-
-# else
-
-static inline int omap4_cminst_wait_module_idle(u8 part, u16 inst, s16 cdoffs,
-					u16 clkctrl_offs)
-{
-	return 0;
-}
-
-static inline void omap4_cminst_module_enable(u8 mode, u8 part, u16 inst,
-				s16 cdoffs, u16 clkctrl_offs)
-{
-}
-
-static inline void omap4_cminst_module_disable(u8 part, u16 inst, s16 cdoffs,
-				 u16 clkctrl_offs)
-{
-}
-
-# endif
-
 /*
  * In an ideal world, we would not export these low-level functions,
  * but this will probably take some time to fix properly
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 480f40a..9bc3f5d 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -164,3 +164,80 @@ void __init omap2_set_globals_prcm(struct omap_globals *omap2_globals)
 		omap_cm_base_init();
 	}
 }
+
+/*
+ * Stubbed functions so that common files
+ * continue to build when custom builds are used
+ */
+u32 __weak omap2_prm_read_mod_reg(s16 module, u16 idx)
+{
+	WARN(1, "prm: omap2xxx/omap3xxx specific function and "
+		"not suppose to be used on omap4\n");
+	return 0;
+}
+
+void __weak omap2_prm_write_mod_reg(u32 val, s16 module, u16 idx)
+{
+	WARN(1, "prm: omap2xxx/omap3xxx specific function and "
+		"not suppose to be used on omap4\n");
+}
+u32 __weak omap2_prm_rmw_mod_reg_bits(u32 mask, u32 bits,
+		s16 module, s16 idx)
+{
+	WARN(1, "prm: omap2xxx/omap3xxx specific function and "
+		"not suppose to be used on omap4\n");
+	return 0;
+}
+u32 __weak omap2_prm_set_mod_reg_bits(u32 bits, s16 module, s16 idx)
+{
+	WARN(1, "prm: omap2xxx/omap3xxx specific function and "
+		"not suppose to be used on omap4\n");
+	return 0;
+}
+u32 __weak omap2_prm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
+{
+	WARN(1, "prm: omap2xxx/omap3xxx specific function and "
+		"not suppose to be used on omap4\n");
+	return 0;
+}
+u32 __weak omap2_prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask)
+{
+	WARN(1, "prm: omap2xxx/omap3xxx specific function and "
+		"not suppose to be used on omap4\n");
+	return 0;
+}
+int __weak omap2_prm_is_hardreset_asserted(s16 prm_mod, u8 shift)
+{
+	WARN(1, "prm: omap2xxx/omap3xxx specific function and "
+		"not suppose to be used on omap4\n");
+	return 0;
+}
+int __weak omap2_prm_assert_hardreset(s16 prm_mod, u8 shift)
+{
+	WARN(1, "prm: omap2xxx/omap3xxx specific function and "
+		"not suppose to be used on omap4\n");
+	return 0;
+}
+int __weak omap2_prm_deassert_hardreset(s16 prm_mod, u8 rst_shift,
+						u8 st_shift)
+{
+	WARN(1, "prm: omap2xxx/omap3xxx specific function and "
+		"not suppose to be used on omap4\n");
+	return 0;
+}
+
+int __weak omap4_cminst_wait_module_idle(u8 part, u16 inst, s16 cdoffs,
+					u16 clkctrl_offs)
+{
+	return 0;
+}
+
+void __weak omap4_cminst_module_enable(u8 mode, u8 part, u16 inst,
+				s16 cdoffs, u16 clkctrl_offs)
+{
+}
+
+void __weak omap4_cminst_module_disable(u8 part, u16 inst, s16 cdoffs,
+				 u16 clkctrl_offs)
+{
+}
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.h b/arch/arm/mach-omap2/prm2xxx_3xxx.h
index 70ac2a1..f7bb57f 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.h
@@ -228,68 +228,6 @@
 
 
 #ifndef __ASSEMBLER__
-/*
- * Stub omap2xxx/omap3xxx functions so that common files
- * continue to build when custom builds are used
- */
-#if defined(CONFIG_ARCH_OMAP4) && !(defined(CONFIG_ARCH_OMAP2) ||	\
-					defined(CONFIG_ARCH_OMAP3))
-static inline u32 omap2_prm_read_mod_reg(s16 module, u16 idx)
-{
-	WARN(1, "prm: omap2xxx/omap3xxx specific function and "
-		"not suppose to be used on omap4\n");
-	return 0;
-}
-static inline void omap2_prm_write_mod_reg(u32 val, s16 module, u16 idx)
-{
-	WARN(1, "prm: omap2xxx/omap3xxx specific function and "
-		"not suppose to be used on omap4\n");
-}
-static inline u32 omap2_prm_rmw_mod_reg_bits(u32 mask, u32 bits,
-		s16 module, s16 idx)
-{
-	WARN(1, "prm: omap2xxx/omap3xxx specific function and "
-		"not suppose to be used on omap4\n");
-	return 0;
-}
-static inline u32 omap2_prm_set_mod_reg_bits(u32 bits, s16 module, s16 idx)
-{
-	WARN(1, "prm: omap2xxx/omap3xxx specific function and "
-		"not suppose to be used on omap4\n");
-	return 0;
-}
-static inline u32 omap2_prm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
-{
-	WARN(1, "prm: omap2xxx/omap3xxx specific function and "
-		"not suppose to be used on omap4\n");
-	return 0;
-}
-static inline u32 omap2_prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask)
-{
-	WARN(1, "prm: omap2xxx/omap3xxx specific function and "
-		"not suppose to be used on omap4\n");
-	return 0;
-}
-static inline int omap2_prm_is_hardreset_asserted(s16 prm_mod, u8 shift)
-{
-	WARN(1, "prm: omap2xxx/omap3xxx specific function and "
-		"not suppose to be used on omap4\n");
-	return 0;
-}
-static inline int omap2_prm_assert_hardreset(s16 prm_mod, u8 shift)
-{
-	WARN(1, "prm: omap2xxx/omap3xxx specific function and "
-		"not suppose to be used on omap4\n");
-	return 0;
-}
-static inline int omap2_prm_deassert_hardreset(s16 prm_mod, u8 rst_shift,
-						u8 st_shift)
-{
-	WARN(1, "prm: omap2xxx/omap3xxx specific function and "
-		"not suppose to be used on omap4\n");
-	return 0;
-}
-#else
 /* Power/reset management domain register get/set */
 extern u32 omap2_prm_read_mod_reg(s16 module, u16 idx);
 extern void omap2_prm_write_mod_reg(u32 val, s16 module, u16 idx);
@@ -320,9 +258,6 @@ extern void omap3xxx_prm_read_pending_irqs(unsigned long *events);
 extern void omap3xxx_prm_ocp_barrier(void);
 extern void omap3xxx_prm_save_and_clear_irqen(u32 *saved_mask);
 extern void omap3xxx_prm_restore_irqen(u32 *saved_mask);
-
-#endif	/* CONFIG_ARCH_OMAP4 */
-
 #endif
 
 /*
-- 
1.7.1

