From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/2] ARCH: OMAP3: Make SRAM code from TI CDP compile and work
Date: Fri, 28 Mar 2008 13:46:37 +0200
Message-ID: <1206704800-6768-3-git-send-email-tony@atomide.com>
References: <1206704800-6768-1-git-send-email-tony@atomide.com>
 <1206704800-6768-2-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64490 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753116AbYC1Lqt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Mar 2008 07:46:49 -0400
In-Reply-To: <1206704800-6768-2-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>

Make SRAM code from TI CDP compile and work.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/sram34xx.S   |  112 ++++++++++++++++++--------------------
 arch/arm/plat-omap/sram.c        |   63 +++++++++++++++++++++
 include/asm-arm/arch-omap/sdrc.h |    2 +
 include/asm-arm/arch-omap/sram.h |   19 +++++++
 4 files changed, 136 insertions(+), 60 deletions(-)

diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
index 803f60d..74873df 100644
--- a/arch/arm/mach-omap2/sram34xx.S
+++ b/arch/arm/mach-omap2/sram34xx.S
@@ -28,21 +28,12 @@
  */
 #include <linux/linkage.h>
 #include <asm/assembler.h>
-#include <asm/arch/io.h>
 #include <asm/hardware.h>
 
-#include "prcm-regs.h"
-
-#define CM_CLKSEL1_PLL_V	IO_ADDRESS(CM_BASE + 0xD40)
-#define	CM_ICLKEN1_CORE_V	IO_ADDRESS(CM_BASE + 0xA10)
-#define CM_IDLEST1_CORE_V	IO_ADDRESS(CM_BASE + 0xA20)
+#include <asm/arch/io.h>
 
-#define	SDRC_POWER_V		IO_ADDRESS(SDRC_BASE + 0x070)
-#define SDRC_RFR_CTRL		IO_ADDRESS(SDRC_BASE + 0x0A4)
-#define SDRC_ACTIM_CTRL_A	IO_ADDRESS(SDRC_BASE + 0x09C)
-#define	SDRC_ACTIM_CTRL_B	IO_ADDRESS(SDRC_BASE + 0x0A0)
-#define	SDRC_DLLA_STATUS	IO_ADDRESS(SDRC_BASE + 0x064)
-#define	SDRC_DLLA_CTRL		IO_ADDRESS(SDRC_BASE + 0x060)
+#include "sdrc.h"
+#include "cm.h"
 
 	.text
 
@@ -68,7 +59,7 @@ ENTRY(omap34xx_sram_set_prcm_sz)
 
 /*
  * Change frequency of core dpll
- * r0 = sdrc_rfr_ctrl r1 = sdrc_actim_ctrla  r2 = sdrc_actim_ctrlb r3 = M2
+ * r0 = sdrc_rfr_ctrl r1 = sdrc_actim_ctrla r2 = sdrc_actim_ctrlb r3 = M2
  */
 ENTRY(omap34xx_sram_configure_core_dpll)
 	stmfd	sp!, {r1-r12, lr}	@ store regs to stack
@@ -90,37 +81,37 @@ ENTRY(omap34xx_sram_configure_core_dpll)
 	mov 	r0, #0 			@ return value
 	ldmfd	sp!, {r1-r12, pc}	@ restore regs and return
 unlock_dll:
-	ldr     r4, sdrc_dlla_ctrl
-	ldr     r5, [r4]
+	ldr	r4, omap34xx_sdrc_dlla_ctrl
+	ldr	r5, [r4]
 	orr	r5, r5, #0x4
 	str	r5, [r4]
 	bx	lr
 lock_dll:
-	ldr     r4, sdrc_dlla_ctrl
-	ldr     r5, [r4]
+	ldr	r4, omap34xx_sdrc_dlla_ctrl
+	ldr	r5, [r4]
 	bic	r5, r5, #0x4
-	str     r5, [r4]
-	bx      lr
+	str	r5, [r4]
+	bx	lr
 sdram_in_selfrefresh:
 	mov	r5, #0x0		@ Move 0 to R5
-	mcr	p15, 0, r5, c7, c10, 5  @ memory barrier
-	ldr 	r4, sdrc_power		@ read the SDRC_POWER register
-	ldr 	r5, [r4]		@ read the contents of SDRC_POWER
+	mcr	p15, 0, r5, c7, c10, 5	@ memory barrier
+	ldr	r4, omap34xx_sdrc_power	@ read the SDRC_POWER register
+	ldr	r5, [r4]		@ read the contents of SDRC_POWER
 	orr 	r5, r5, #0x40		@ enable self refresh on idle req
 	str 	r5, [r4]		@ write back to SDRC_POWER register
-	ldr	r4, cm_iclken1_core	@ read the CM_ICLKEN1_CORE reg
+	ldr	r4, omap34xx_cm_iclken1_core	@ read the CM_ICLKEN1_CORE reg
 	ldr	r5, [r4]
 	bic	r5, r5, #0x2		@ disable iclk bit for SRDC
 	str 	r5, [r4]
 wait_sdrc_idle:
-	ldr 	r4, cm_idlest1_core
+	ldr 	r4, omap34xx_cm_idlest1_core
 	ldr 	r5, [r4]
 	and 	r5, r5, #0x2		@ check for SDRC idle
 	cmp 	r5, #2
 	bne 	wait_sdrc_idle
 	bx 	lr
 configure_core_dpll:
-	ldr 	r4, cm_clksel1_pll
+	ldr 	r4, omap34xx_cm_clksel1_pll
 	ldr	r5, [r4]
 	ldr	r6, core_m2_mask_val	@ modify m2 for core dpll
 	and	r5, r5, r6
@@ -145,61 +136,62 @@ wait_clk_stable:
 	nop
 	bx	lr
 enable_sdrc:
-	ldr 	r4, cm_iclken1_core
+	ldr 	r4, omap34xx_cm_iclken1_core
 	ldr	r5, [r4]
 	orr 	r5, r5, #0x2		@ enable iclk bit for SDRC
 	str 	r5, [r4]
 wait_sdrc_idle1:
-	ldr 	r4, cm_idlest1_core
+	ldr 	r4, omap34xx_cm_idlest1_core
 	ldr	r5, [r4]
 	and 	r5, r5, #0x2
 	cmp	r5, #0
 	bne	wait_sdrc_idle1
-	ldr	r4, sdrc_power
+	ldr	r4, omap34xx_sdrc_power
 	ldr	r5, [r4]
 	bic 	r5, r5, #0x40
 	str 	r5, [r4]
 	bx	lr
 wait_dll_lock:
-	ldr	r4, sdrc_dlla_status
+	ldr	r4, omap34xx_sdrc_dlla_status
 	ldr	r5, [r4]
 	and 	r5, r5, #0x4
 	cmp	r5, #0x4
 	bne	wait_dll_lock
 	bx	lr
 wait_dll_unlock:
-	ldr     r4, sdrc_dlla_status
-	ldr     r5, [r4]
-	and     r5, r5, #0x4
-	cmp     r5, #0x0
-	bne     wait_dll_unlock
-	bx      lr
+	ldr	r4, omap34xx_sdrc_dlla_status
+	ldr	r5, [r4]
+	and	r5, r5, #0x4
+	cmp	r5, #0x0
+	bne	wait_dll_unlock
+	bx	lr
 configure_sdrc:
-	ldr     r4, sdrc_rfr_ctrl
-	str     r0, [r4]
-	ldr 	r4, sdrc_actim_ctrla
-	str     r1, [r4]
-	ldr     r4, sdrc_actim_ctrlb
-	str     r2, [r4]
-	bx      lr
-sdrc_power:
-	.word SDRC_POWER_V
-cm_clksel1_pll:
-	.word CM_CLKSEL1_PLL_V
-cm_idlest1_core:
-	.word CM_IDLEST1_CORE_V
-cm_iclken1_core:
-	.word CM_ICLKEN1_CORE_V
-sdrc_rfr_ctrl:
-        .word SDRC_RFR_CTRL
-sdrc_actim_ctrla:
-	.word SDRC_ACTIM_CTRL_A
-sdrc_actim_ctrlb:
-	.word SDRC_ACTIM_CTRL_B
-sdrc_dlla_status:
-	.word SDRC_DLLA_STATUS
-sdrc_dlla_ctrl:
-	.word SDRC_DLLA_CTRL
+	ldr	r4, omap34xx_sdrc_rfr_ctrl
+	str	r0, [r4]
+	ldr	r4, omap34xx_sdrc_actim_ctrla
+	str	r1, [r4]
+	ldr	r4, omap34xx_sdrc_actim_ctrlb
+	str	r2, [r4]
+	bx	lr
+
+omap34xx_sdrc_power:
+	.word OMAP34XX_SDRC_REGADDR(SDRC_POWER)
+omap34xx_cm_clksel1_pll:
+	.word OMAP34XX_CM_REGADDR(PLL_MOD, CM_CLKSEL1)
+omap34xx_cm_idlest1_core:
+	.word OMAP34XX_CM_REGADDR(CORE_MOD, CM_IDLEST)
+omap34xx_cm_iclken1_core:
+	.word OMAP34XX_CM_REGADDR(CORE_MOD, CM_ICLKEN1)
+omap34xx_sdrc_rfr_ctrl:
+	.word OMAP34XX_SDRC_REGADDR(SDRC_RFR_CTRL_0)
+omap34xx_sdrc_actim_ctrla:
+	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_A)
+omap34xx_sdrc_actim_ctrlb:
+	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_B)
+omap34xx_sdrc_dlla_status:
+	.word OMAP34XX_SDRC_REGADDR(SDRC_DLLA_STATUS)
+omap34xx_sdrc_dlla_ctrl:
+	.word OMAP34XX_SDRC_REGADDR(SDRC_DLLA_CTRL)
 core_m2_mask_val:
 	.word 0xE7FFFFFF
 
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 2fc8f61..fb3f0d1 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -461,6 +461,67 @@ static inline int omap24xx_sram_init(void)
 }
 #endif
 
+#ifdef CONFIG_ARCH_OMAP3
+
+static u32 (*_omap2_sram_reprogram_gpmc)(u32 perf_level);
+u32 omap2_sram_reprogram_gpmc(u32 perf_level)
+{
+	if (!_omap2_sram_reprogram_gpmc)
+		omap_sram_error();
+
+	return _omap2_sram_reprogram_gpmc(perf_level);
+}
+
+static u32 (*_omap2_sram_configure_core_dpll)(u32 m, u32 n,
+						u32 freqsel, u32 m2);
+u32 omap2_sram_configure_core_dpll(u32 m, u32 n, u32 freqsel, u32 m2)
+{
+	if (!_omap2_sram_configure_core_dpll)
+		omap_sram_error();
+
+	return _omap2_sram_configure_core_dpll(m, n, freqsel, m2);
+}
+
+/* REVISIT: Should this be same as omap34xx_sram_init() after off-idle? */
+void restore_sram_functions(void)
+{
+	omap_sram_ceil = omap_sram_base + omap_sram_size;
+
+	_omap2_sram_reprogram_gpmc = omap_sram_push(omap34xx_sram_reprogram_gpmc,
+		omap34xx_sram_reprogram_gpmc_sz);
+
+	_omap2_sram_configure_core_dpll =
+			omap_sram_push(omap34xx_sram_configure_core_dpll,
+					omap34xx_sram_configure_core_dpll_sz);
+}
+
+int __init omap34xx_sram_init(void)
+{
+	_omap2_sram_ddr_init = omap_sram_push(omap34xx_sram_ddr_init,
+					omap34xx_sram_ddr_init_sz);
+
+	_omap2_sram_reprogram_sdrc = omap_sram_push(omap34xx_sram_reprogram_sdrc,
+					omap34xx_sram_reprogram_sdrc_sz);
+
+	_omap2_set_prcm = omap_sram_push(omap34xx_sram_set_prcm,
+					omap34xx_sram_set_prcm_sz);
+
+	_omap2_sram_reprogram_gpmc = omap_sram_push(omap34xx_sram_reprogram_gpmc,
+					omap34xx_sram_reprogram_gpmc_sz);
+
+	_omap2_sram_configure_core_dpll =
+				omap_sram_push(omap34xx_sram_configure_core_dpll,
+					omap34xx_sram_configure_core_dpll_sz);
+
+	return 0;
+}
+#else
+static inline int omap34xx_sram_init(void)
+{
+	return 0;
+}
+#endif
+
 int __init omap_sram_init(void)
 {
 	omap_detect_sram();
@@ -470,6 +531,8 @@ int __init omap_sram_init(void)
 		omap1_sram_init();
 	else if (cpu_is_omap24xx())
 		omap24xx_sram_init();
+	else if (cpu_is_omap34xx())
+		omap34xx_sram_init();
 
 	return 0;
 }
diff --git a/include/asm-arm/arch-omap/sdrc.h b/include/asm-arm/arch-omap/sdrc.h
index 673b396..660da4d 100644
--- a/include/asm-arm/arch-omap/sdrc.h
+++ b/include/asm-arm/arch-omap/sdrc.h
@@ -25,6 +25,8 @@
 #define SDRC_DLLB_STATUS	0x06C
 #define SDRC_POWER		0x070
 #define SDRC_MR_0		0x084
+#define SDRC_ACTIM_CTRL_A	0x09c
+#define SDRC_ACTIM_CTRL_B	0x0a0
 #define SDRC_RFR_CTRL_0		0x0a4
 
 /*
diff --git a/include/asm-arm/arch-omap/sram.h b/include/asm-arm/arch-omap/sram.h
index c55df46..9c2863b 100644
--- a/include/asm-arm/arch-omap/sram.h
+++ b/include/asm-arm/arch-omap/sram.h
@@ -42,4 +42,23 @@ extern void omap24xx_sram_reprogram_sdrc(u32 perf_level, u32 dll_val,
 						u32 mem_type);
 extern unsigned long omap24xx_sram_reprogram_sdrc_sz;
 
+
+extern void omap34xx_sram_ddr_init(u32 *slow_dll_ctrl, u32 fast_dll_ctrl,
+						u32 base_cs, u32 force_unlock);
+extern unsigned long omap34xx_sram_ddr_init_sz;
+
+extern void omap34xx_sram_reprogram_sdrc(u32 perf_level, u32 dll_val,
+						u32 mem_type);
+extern unsigned long omap34xx_sram_reprogram_sdrc_sz;
+
+extern u32 omap34xx_sram_set_prcm(u32 dpll_ctrl_val, u32 sdrc_rfr_val,
+						int bypass);
+extern unsigned long omap34xx_sram_set_prcm_sz;
+
+extern u32 omap34xx_sram_reprogram_gpmc(u32 perf_level);
+extern unsigned long omap34xx_sram_reprogram_gpmc_sz;
+
+extern u32 omap34xx_sram_configure_core_dpll(u32 m, u32 n, u32 freqsel, u32 m2);
+extern unsigned long omap34xx_sram_configure_core_dpll_sz;
+
 #endif
-- 
1.5.3.6

