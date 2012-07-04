From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/4] ARM: OMAP2+: Move the stubbed prm and cm functions
 to prcm.c file and make them __weak.
Date: Wed, 4 Jul 2012 09:19:26 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1207040431400.6760@utopia.booyaka.com>
References: <1336669615-16454-1-git-send-email-r.sricharan@ti.com> <1336669615-16454-3-git-send-email-r.sricharan@ti.com> <alpine.DEB.2.00.1205101140230.32719@utopia.booyaka.com> <CAJ7qFSdiMgM3S5Q+XaFAGrgcL5M5f8CLHyKSRtBKu4AK6ei-BA@mail.gmail.com>
 <CAJ7qFSfu3yyj8YqETTzx+wipi1Nbf5m5fDLC26Tfojav+Lb56Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41692 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841Ab2GDPT2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jul 2012 11:19:28 -0400
In-Reply-To: <CAJ7qFSfu3yyj8YqETTzx+wipi1Nbf5m5fDLC26Tfojav+Lb56Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "R, Sricharan" <r.sricharan@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, tony@atomide.com, b-cousson@ti.com

Hi

On Thu, 28 Jun 2012, R, Sricharan wrote:

>  Ping..

Since the prcm.c cleanup series isn't ready yet, I've queued this modified 
version of your patch.

Once the prcm.c cleanup series is ready, hopefully in the 3.7 time frame, 
we'll be able to get rid of all of these nasty stubs.


- Paul


From: R Sricharan <r.sricharan@ti.com>
Date: Thu, 10 May 2012 22:36:53 +0530
Subject: [PATCH] ARM: OMAP2+: PRM/CM: Move the stubbed prm and cm functions
 to prcm.c file and make them __weak

Some prm and cm registers read/write and status functions
are built only for some custom OMAP2+ builds and are stubbed
in header files for other builds under ifdef statements.
But this results in adding new CONFIG_ARCH_OMAPXXX
checks when SOCs are added in the future. So move them
to a common place for OMAP2+ and make them 'weak' implementations.

This way no new ifdefs would be required in the future and also
cleans up the existing code.

Signed-off-by: R Sricharan <r.sricharan@ti.com>
[paul@pwsan.com: unsplit quoted strings; moved PRM functions to
 mach-omap2/prm_common.c; resolved sparse warnings]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/cminst44xx.h   |   25 --------------
 arch/arm/mach-omap2/prcm.c         |   23 +++++++++++++
 arch/arm/mach-omap2/prm2xxx_3xxx.h |   65 ------------------------------------
 arch/arm/mach-omap2/prm_common.c   |   62 ++++++++++++++++++++++++++++++++++
 4 files changed, 85 insertions(+), 90 deletions(-)

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
index 480f40a..28cbfb2 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -35,6 +35,7 @@
 #include "prm2xxx_3xxx.h"
 #include "prm44xx.h"
 #include "prminst44xx.h"
+#include "cminst44xx.h"
 #include "prm-regbits-24xx.h"
 #include "prm-regbits-44xx.h"
 #include "control.h"
@@ -164,3 +165,25 @@ void __init omap2_set_globals_prcm(struct omap_globals *omap2_globals)
 		omap_cm_base_init();
 	}
 }
+
+/*
+ * Stubbed functions so that common files continue to build when
+ * custom builds are used
+ * XXX These are temporary and should be removed at the earliest possible
+ * opportunity
+ */
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
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index dfe00dd..663ade3 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -319,3 +319,65 @@ err:
 	omap_prcm_irq_cleanup();
 	return -ENOMEM;
 }
+
+/*
+ * Stubbed functions so that common files continue to build when
+ * custom builds are used
+ * XXX These are temporary and should be removed at the earliest possible
+ * opportunity
+ */
+u32 __weak omap2_prm_read_mod_reg(s16 module, u16 idx)
+{
+	WARN(1, "prm: omap2xxx/omap3xxx specific function called on non-omap2xxx/3xxx\n");
+	return 0;
+}
+
+void __weak omap2_prm_write_mod_reg(u32 val, s16 module, u16 idx)
+{
+	WARN(1, "prm: omap2xxx/omap3xxx specific function called on non-omap2xxx/3xxx\n");
+}
+
+u32 __weak omap2_prm_rmw_mod_reg_bits(u32 mask, u32 bits,
+		s16 module, s16 idx)
+{
+	WARN(1, "prm: omap2xxx/omap3xxx specific function called on non-omap2xxx/3xxx\n");
+	return 0;
+}
+
+u32 __weak omap2_prm_set_mod_reg_bits(u32 bits, s16 module, s16 idx)
+{
+	WARN(1, "prm: omap2xxx/omap3xxx specific function called on non-omap2xxx/3xxx\n");
+	return 0;
+}
+
+u32 __weak omap2_prm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
+{
+	WARN(1, "prm: omap2xxx/omap3xxx specific function called on non-omap2xxx/3xxx\n");
+	return 0;
+}
+
+u32 __weak omap2_prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask)
+{
+	WARN(1, "prm: omap2xxx/omap3xxx specific function called on non-omap2xxx/3xxx\n");
+	return 0;
+}
+
+int __weak omap2_prm_is_hardreset_asserted(s16 prm_mod, u8 shift)
+{
+	WARN(1, "prm: omap2xxx/omap3xxx specific function called on non-omap2xxx/3xxx\n");
+	return 0;
+}
+
+int __weak omap2_prm_assert_hardreset(s16 prm_mod, u8 shift)
+{
+	WARN(1, "prm: omap2xxx/omap3xxx specific function called on non-omap2xxx/3xxx\n");
+	return 0;
+}
+
+int __weak omap2_prm_deassert_hardreset(s16 prm_mod, u8 rst_shift,
+						u8 st_shift)
+{
+	WARN(1, "prm: omap2xxx/omap3xxx specific function called on non-omap2xxx/3xxx\n");
+	return 0;
+}
+
-- 
1.7.10

