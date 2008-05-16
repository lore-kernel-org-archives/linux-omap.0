From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH 6/9] 34XX: Suspend: Use same naming convention in sleep34xx.S as in sleep24XX.S
Date: Fri, 16 May 2008 13:57:22 +0300
Message-ID: <1210935442-27657-1-git-send-email-jouni.hogander@nokia.com>
References: <878wyav7ti.fsf@trdhcp146196.ntc.nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:36588 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752887AbYEPK5v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 May 2008 06:57:51 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m4GAvCnk024549
	for <linux-omap@vger.kernel.org>; Fri, 16 May 2008 05:57:49 -0500
In-Reply-To: <878wyav7ti.fsf@trdhcp146196.ntc.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: jouni.hogander@nokia.com

Change omap34xx_suspend to omap34xx_cpu_suspend and
omap34xx_suspend_sz to omap34xx_cpu_suspend_sz.

Do not use PRM_BASE in sleep34xx.S because it is not defined in
linux-omap tree.

Use OMAP343X_SDRC_BASE in sleep34xx.S instead of SDRC_BASE.

Convert all IO_ADDRESS style definitions to OMAP34XX_PRM_REGADDR style
definitions.

Add omap34xx_cpu_suspend and omap34xx_cpu_suspend_sz to
include/asm-arm/arch-omap/pm.h

Do necessary modifications to be able to use arch/arm/mach-omap2/prm.h
and include/asm-arm/arch-omap/control.h ins asm files.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/prm.h           |    7 ++-----
 arch/arm/mach-omap2/sleep34xx.S     |   28 +++++++++++++++++++---------
 include/asm-arm/arch-omap/control.h |    6 ++++++
 include/asm-arm/arch-omap/pm.h      |    3 +++
 4 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index e1ce33e..f816165 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -14,9 +14,6 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/io.h>
-#include <linux/bitops.h>
-
 #include "prcm-common.h"
 
 #ifndef __ASSEMBLER__
@@ -156,6 +153,8 @@ static __inline__ u32 __attribute__((unused)) prm_rmw_reg_bits(u32 mask,
 #define OMAP3430_PRM_IRQSTATUS_IVA2			0x00f8
 #define OMAP3430_PRM_IRQENABLE_IVA2			0x00fc
 
+#ifndef __ASSEMBLER__
+
 /* Read-modify-write bits in a PRM register (by domain) */
 static u32 __attribute__((unused)) prm_rmw_mod_reg_bits(u32 mask, u32 bits,
 							s16 module, s16 idx)
@@ -183,8 +182,6 @@ static u32 __attribute__((unused)) prm_clear_mod_reg_bits(u32 bits, s16 module,
 #define OMAP24XX_PRCM_IRQSTATUS_IVA			0x00f8
 #define OMAP24XX_PRCM_IRQENABLE_IVA			0x00fc
 
-#ifndef __ASSEMBLER__
-
 /* Power/reset management domain register get/set */
 
 static __inline__ void __attribute__((unused)) prm_write_mod_reg(u32 val,
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index c9db507..ebc7eb3 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -28,12 +28,22 @@
 #include <asm/assembler.h>
 #include <asm/arch/io.h>
 #include <asm/arch/pm.h>
-
-#define PM_PREPWSTST_CORE_V	IO_ADDRESS(PRM_BASE + 0xAE8)
-#define PM_PREPWSTST_MPU_V	IO_ADDRESS(PRM_BASE + 0x9E8)
-#define PM_PWSTCTRL_MPU_P	(PRM_BASE + 0x9E0)
-#define SCRATCHPAD_BASE_P	0x48002910
-#define SDRC_POWER_V		IO_ADDRESS(SDRC_BASE + 0x070)
+#include <asm/arch/control.h>
+
+#include "prm.h"
+#include "sdrc.h"
+
+#define PM_PREPWSTST_CORE_V	OMAP34XX_PRM_REGADDR(CORE_MOD, \
+				OMAP3430_PM_PREPWSTST)
+#define PM_PREPWSTST_MPU_V	OMAP34XX_PRM_REGADDR(MPU_MOD, \
+				OMAP3430_PM_PREPWSTST)
+#define PM_PWSTCTRL_MPU_P	OMAP34XX_PRM_REGADDR(MPU_MOD, PM_PWSTCTRL)
+#define SCRATCHPAD_MEM_OFFS	0x310 /* Move this as correct place is
+				       * available */
+#define SCRATCHPAD_BASE_P	OMAP343X_CTRL_REGADDR(\
+				OMAP343X_CONTROL_MEM_WKUP +\
+				SCRATCHPAD_MEM_OFFS)
+#define SDRC_POWER_V		OMAP34XX_SDRC_REGADDR(SDRC_POWER)
 
 	.text
 /* Function call to get the restore pointer for resume from OFF */
@@ -52,7 +62,7 @@ ENTRY(get_restore_pointer_sz)
  * Note: This code get's copied to internal SRAM at boot. When the OMAP
  *	 wakes up it continues execution at the point it went to sleep.
  */
-ENTRY(omap34xx_suspend)
+ENTRY(omap34xx_cpu_suspend)
 	stmfd	sp!, {r0-r12, lr}		@ save registers on stack
 loop:
 	/*b	loop*/	@Enable to debug by stepping through code
@@ -530,5 +540,5 @@ table_entry:
 	.word	0x00000C02
 cache_pred_disable_mask:
 	.word	0xFFFFE7FB
-ENTRY(omap34xx_suspend_sz)
-	.word	. - omap34xx_suspend
+ENTRY(omap34xx_cpu_suspend_sz)
+	.word	. - omap34xx_cpu_suspend
diff --git a/include/asm-arm/arch-omap/control.h b/include/asm-arm/arch-omap/control.h
index 0832348..1d95cc2 100644
--- a/include/asm-arm/arch-omap/control.h
+++ b/include/asm-arm/arch-omap/control.h
@@ -18,12 +18,18 @@
 
 #include <asm/arch/io.h>
 
+#ifndef __ASSEMBLY__
 #define OMAP242X_CTRL_REGADDR(reg)					\
 	(__force void __iomem *)IO_ADDRESS(OMAP242X_CTRL_BASE + (reg))
 #define OMAP243X_CTRL_REGADDR(reg)					\
 	(__force void __iomem *)IO_ADDRESS(OMAP243X_CTRL_BASE + (reg))
 #define OMAP343X_CTRL_REGADDR(reg)					\
 	(__force void __iomem *)IO_ADDRESS(OMAP343X_CTRL_BASE + (reg))
+#else
+#define OMAP242X_CTRL_REGADDR(reg)	IO_ADDRESS(OMAP242X_CTRL_BASE + (reg))
+#define OMAP243X_CTRL_REGADDR(reg)	IO_ADDRESS(OMAP243X_CTRL_BASE + (reg))
+#define OMAP343X_CTRL_REGADDR(reg)	IO_ADDRESS(OMAP343X_CTRL_BASE + (reg))
+#endif /* __ASSEMBLY__ */
 
 /*
  * As elsewhere, the "OMAP2_" prefix indicates that the macro is valid for
diff --git a/include/asm-arm/arch-omap/pm.h b/include/asm-arm/arch-omap/pm.h
index 0ce03fd..d0c7d4d 100644
--- a/include/asm-arm/arch-omap/pm.h
+++ b/include/asm-arm/arch-omap/pm.h
@@ -146,6 +146,7 @@ extern void omap730_cpu_suspend(unsigned short, unsigned short);
 extern void omap1510_cpu_suspend(unsigned short, unsigned short);
 extern void omap1610_cpu_suspend(unsigned short, unsigned short);
 extern void omap24xx_cpu_suspend(u32 dll_ctrl, u32 cpu_revision);
+extern void omap34xx_cpu_suspend(u32 *addr, int save_state);
 extern void omap730_idle_loop_suspend(void);
 extern void omap1510_idle_loop_suspend(void);
 extern void omap1610_idle_loop_suspend(void);
@@ -155,10 +156,12 @@ extern unsigned int omap730_cpu_suspend_sz;
 extern unsigned int omap1510_cpu_suspend_sz;
 extern unsigned int omap1610_cpu_suspend_sz;
 extern unsigned int omap24xx_cpu_suspend_sz;
+extern unsigned int omap34xx_cpu_suspend_sz;
 extern unsigned int omap730_idle_loop_suspend_sz;
 extern unsigned int omap1510_idle_loop_suspend_sz;
 extern unsigned int omap1610_idle_loop_suspend_sz;
 extern unsigned int omap24xx_idle_loop_suspend_sz;
+extern unsigned int omap34xx_suspend_sz;
 
 #ifdef CONFIG_OMAP_SERIAL_WAKE
 extern void omap_serial_wake_trigger(int enable);
-- 
1.5.5

