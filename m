From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 7/9] OMAP3 SRAM: remove unused functions; rename remainder
Date: Mon, 07 Jul 2008 20:55:10 -0600
Message-ID: <20080708025508.11646.85778.stgit@localhost.localdomain>
References: <20080708025225.11646.55912.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40863 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755833AbYGHC4i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jul 2008 22:56:38 -0400
In-Reply-To: <20080708025225.11646.55912.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The only SRAM function currently used on OMAP3 is the CORE DPLL M2 divider
reprogramming function; remove the rest of the stubs.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h |    2 -
 arch/arm/mach-omap2/sram34xx.S                    |   82 +++++++--------------
 arch/arm/plat-omap/sram.c                         |   63 ++++++----------
 include/asm-arm/arch-omap/sram.h                  |   25 ++----
 4 files changed, 57 insertions(+), 115 deletions(-)

diff --git a/arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h b/arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h
index f0ec104..d7c4193 100644
--- a/arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h
+++ b/arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h
@@ -18,7 +18,7 @@
 
 /* Micron MT46H32M32LF-6 */
 /* XXX Using ARE = 0x1 (no autorefresh burst) -- can this be changed? */
-static struct omap_sdrc_params mt46h32m32lf_sdrc_params[] = {
+static struct omap_sdrc_params mt46h32m32lf6_sdrc_params[] = {
 	[0] = {
 		.rate	     = 165941176,
 		.actim_ctrla = 0x9a9db4c6,
diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-omap2/sram34xx.S
index 74873df..63db781 100644
--- a/arch/arm/mach-omap2/sram34xx.S
+++ b/arch/arm/mach-omap2/sram34xx.S
@@ -37,31 +37,11 @@
 
 	.text
 
-ENTRY(omap34xx_sram_ddr_init)
-	stmfd	sp!, {r0 - r12, lr}	@ save registers on stack
-	ldmfd	sp!, {r0 - r12, pc}	@ restore regs and return
-ENTRY(omap34xx_sram_ddr_init_sz)
-	.word	. - omap34xx_sram_ddr_init
-
-ENTRY(omap34xx_sram_reprogram_sdrc)
-	stmfd	sp!, {r0 - r10, lr}	@ save registers on stack
-	ldmfd	sp!, {r0 - r10, pc}	@ restore regs and return
-ENTRY(omap34xx_sram_reprogram_sdrc_sz)
-	.word	. - omap34xx_sram_reprogram_sdrc
-
-/*
- * Set dividers and pll. Also recalculate DLL value for DDR and unlock mode.
- */
-ENTRY(omap34xx_sram_set_prcm)
-	stmfd	sp!, {r0-r12, lr}	@ regs to stack
-ENTRY(omap34xx_sram_set_prcm_sz)
-	.word	. - omap34xx_sram_set_prcm
-
 /*
  * Change frequency of core dpll
  * r0 = sdrc_rfr_ctrl r1 = sdrc_actim_ctrla r2 = sdrc_actim_ctrlb r3 = M2
  */
-ENTRY(omap34xx_sram_configure_core_dpll)
+ENTRY(omap3_sram_configure_core_dpll)
 	stmfd	sp!, {r1-r12, lr}	@ store regs to stack
 	cmp	r3, #0x2
 	blne	configure_sdrc
@@ -81,13 +61,13 @@ ENTRY(omap34xx_sram_configure_core_dpll)
 	mov 	r0, #0 			@ return value
 	ldmfd	sp!, {r1-r12, pc}	@ restore regs and return
 unlock_dll:
-	ldr	r4, omap34xx_sdrc_dlla_ctrl
+	ldr	r4, omap3_sdrc_dlla_ctrl
 	ldr	r5, [r4]
 	orr	r5, r5, #0x4
 	str	r5, [r4]
 	bx	lr
 lock_dll:
-	ldr	r4, omap34xx_sdrc_dlla_ctrl
+	ldr	r4, omap3_sdrc_dlla_ctrl
 	ldr	r5, [r4]
 	bic	r5, r5, #0x4
 	str	r5, [r4]
@@ -95,23 +75,23 @@ lock_dll:
 sdram_in_selfrefresh:
 	mov	r5, #0x0		@ Move 0 to R5
 	mcr	p15, 0, r5, c7, c10, 5	@ memory barrier
-	ldr	r4, omap34xx_sdrc_power	@ read the SDRC_POWER register
+	ldr	r4, omap3_sdrc_power	@ read the SDRC_POWER register
 	ldr	r5, [r4]		@ read the contents of SDRC_POWER
 	orr 	r5, r5, #0x40		@ enable self refresh on idle req
 	str 	r5, [r4]		@ write back to SDRC_POWER register
-	ldr	r4, omap34xx_cm_iclken1_core	@ read the CM_ICLKEN1_CORE reg
+	ldr	r4, omap3_cm_iclken1_core	@ read the CM_ICLKEN1_CORE reg
 	ldr	r5, [r4]
 	bic	r5, r5, #0x2		@ disable iclk bit for SRDC
 	str 	r5, [r4]
 wait_sdrc_idle:
-	ldr 	r4, omap34xx_cm_idlest1_core
+	ldr 	r4, omap3_cm_idlest1_core
 	ldr 	r5, [r4]
 	and 	r5, r5, #0x2		@ check for SDRC idle
 	cmp 	r5, #2
 	bne 	wait_sdrc_idle
 	bx 	lr
 configure_core_dpll:
-	ldr 	r4, omap34xx_cm_clksel1_pll
+	ldr 	r4, omap3_cm_clksel1_pll
 	ldr	r5, [r4]
 	ldr	r6, core_m2_mask_val	@ modify m2 for core dpll
 	and	r5, r5, r6
@@ -136,74 +116,64 @@ wait_clk_stable:
 	nop
 	bx	lr
 enable_sdrc:
-	ldr 	r4, omap34xx_cm_iclken1_core
+	ldr 	r4, omap3_cm_iclken1_core
 	ldr	r5, [r4]
 	orr 	r5, r5, #0x2		@ enable iclk bit for SDRC
 	str 	r5, [r4]
 wait_sdrc_idle1:
-	ldr 	r4, omap34xx_cm_idlest1_core
+	ldr 	r4, omap3_cm_idlest1_core
 	ldr	r5, [r4]
 	and 	r5, r5, #0x2
 	cmp	r5, #0
 	bne	wait_sdrc_idle1
-	ldr	r4, omap34xx_sdrc_power
+	ldr	r4, omap3_sdrc_power
 	ldr	r5, [r4]
 	bic 	r5, r5, #0x40
 	str 	r5, [r4]
 	bx	lr
 wait_dll_lock:
-	ldr	r4, omap34xx_sdrc_dlla_status
+	ldr	r4, omap3_sdrc_dlla_status
 	ldr	r5, [r4]
 	and 	r5, r5, #0x4
 	cmp	r5, #0x4
 	bne	wait_dll_lock
 	bx	lr
 wait_dll_unlock:
-	ldr	r4, omap34xx_sdrc_dlla_status
+	ldr	r4, omap3_sdrc_dlla_status
 	ldr	r5, [r4]
 	and	r5, r5, #0x4
 	cmp	r5, #0x0
 	bne	wait_dll_unlock
 	bx	lr
 configure_sdrc:
-	ldr	r4, omap34xx_sdrc_rfr_ctrl
+	ldr	r4, omap3_sdrc_rfr_ctrl
 	str	r0, [r4]
-	ldr	r4, omap34xx_sdrc_actim_ctrla
+	ldr	r4, omap3_sdrc_actim_ctrla
 	str	r1, [r4]
-	ldr	r4, omap34xx_sdrc_actim_ctrlb
+	ldr	r4, omap3_sdrc_actim_ctrlb
 	str	r2, [r4]
 	bx	lr
 
-omap34xx_sdrc_power:
+omap3_sdrc_power:
 	.word OMAP34XX_SDRC_REGADDR(SDRC_POWER)
-omap34xx_cm_clksel1_pll:
+omap3_cm_clksel1_pll:
 	.word OMAP34XX_CM_REGADDR(PLL_MOD, CM_CLKSEL1)
-omap34xx_cm_idlest1_core:
+omap3_cm_idlest1_core:
 	.word OMAP34XX_CM_REGADDR(CORE_MOD, CM_IDLEST)
-omap34xx_cm_iclken1_core:
+omap3_cm_iclken1_core:
 	.word OMAP34XX_CM_REGADDR(CORE_MOD, CM_ICLKEN1)
-omap34xx_sdrc_rfr_ctrl:
+omap3_sdrc_rfr_ctrl:
 	.word OMAP34XX_SDRC_REGADDR(SDRC_RFR_CTRL_0)
-omap34xx_sdrc_actim_ctrla:
+omap3_sdrc_actim_ctrla:
 	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_A)
-omap34xx_sdrc_actim_ctrlb:
+omap3_sdrc_actim_ctrlb:
 	.word OMAP34XX_SDRC_REGADDR(SDRC_ACTIM_CTRL_B)
-omap34xx_sdrc_dlla_status:
+omap3_sdrc_dlla_status:
 	.word OMAP34XX_SDRC_REGADDR(SDRC_DLLA_STATUS)
-omap34xx_sdrc_dlla_ctrl:
+omap3_sdrc_dlla_ctrl:
 	.word OMAP34XX_SDRC_REGADDR(SDRC_DLLA_CTRL)
 core_m2_mask_val:
 	.word 0xE7FFFFFF
 
-ENTRY(omap34xx_sram_configure_core_dpll_sz)
-	.word	. - omap34xx_sram_configure_core_dpll
-
-/*
- * Reprogram GPMC
- */
-ENTRY(omap34xx_sram_reprogram_gpmc)
-	stmfd	sp!, {r0-r12, lr}	@ regs to stack
-	ldmfd	sp!, {r0-r12, pc}	@ restore regs and return
-
-ENTRY(omap34xx_sram_reprogram_gpmc_sz)
-	.word	. - omap34xx_sram_reprogram_gpmc
+ENTRY(omap3_sram_configure_core_dpll_sz)
+	.word	. - omap3_sram_configure_core_dpll
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 554ee58..71472b2 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -271,7 +271,7 @@ int __init omap1_sram_init(void)
 #define omap1_sram_init()	do {} while (0)
 #endif
 
-#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
+#if defined(CONFIG_ARCH_OMAP2)
 
 static void (*_omap2_sram_ddr_init)(u32 *slow_dll_ctrl, u32 fast_dll_ctrl,
 			      u32 base_cs, u32 force_unlock);
@@ -352,60 +352,41 @@ static inline int omap243x_sram_init(void)
 
 #ifdef CONFIG_ARCH_OMAP3
 
-static u32 (*_omap2_sram_reprogram_gpmc)(u32 perf_level);
-u32 omap2_sram_reprogram_gpmc(u32 perf_level)
-{
-	if (!_omap2_sram_reprogram_gpmc)
+static u32 (*_omap3_sram_configure_core_dpll)(u32 sdrc_rfr_ctrl,
+					      u32 sdrc_actim_ctrla,
+					      u32 sdrc_actim_ctrlb,
+					      u32 m2);
+u32 omap3_configure_core_dpll(u32 sdrc_rfr_ctrl, u32 sdrc_actim_ctrla,
+			      u32 sdrc_actim_ctrlb, u32 m2)
+ {
+	if (!_omap3_sram_configure_core_dpll)
 		omap_sram_error();
 
-	return _omap2_sram_reprogram_gpmc(perf_level);
-}
-
-static u32 (*_omap2_sram_configure_core_dpll)(u32 m, u32 n,
-						u32 freqsel, u32 m2);
-u32 omap2_sram_configure_core_dpll(u32 m, u32 n, u32 freqsel, u32 m2)
-{
-	if (!_omap2_sram_configure_core_dpll)
-		omap_sram_error();
-
-	return _omap2_sram_configure_core_dpll(m, n, freqsel, m2);
-}
+	return _omap3_sram_configure_core_dpll(sdrc_rfr_ctrl,
+					       sdrc_actim_ctrla,
+					       sdrc_actim_ctrlb, m2);
+ }
 
 /* REVISIT: Should this be same as omap34xx_sram_init() after off-idle? */
 void restore_sram_functions(void)
 {
 	omap_sram_ceil = omap_sram_base + omap_sram_size;
 
-	_omap2_sram_reprogram_gpmc = omap_sram_push(omap34xx_sram_reprogram_gpmc,
-		omap34xx_sram_reprogram_gpmc_sz);
-
-	_omap2_sram_configure_core_dpll =
-			omap_sram_push(omap34xx_sram_configure_core_dpll,
-					omap34xx_sram_configure_core_dpll_sz);
+	_omap3_sram_configure_core_dpll =
+		omap_sram_push(omap3_sram_configure_core_dpll,
+			       omap3_sram_configure_core_dpll_sz);
 }
 
-int __init omap34xx_sram_init(void)
+int __init omap3_sram_init(void)
 {
-	_omap2_sram_ddr_init = omap_sram_push(omap34xx_sram_ddr_init,
-					omap34xx_sram_ddr_init_sz);
-
-	_omap2_sram_reprogram_sdrc = omap_sram_push(omap34xx_sram_reprogram_sdrc,
-					omap34xx_sram_reprogram_sdrc_sz);
-
-	_omap2_set_prcm = omap_sram_push(omap34xx_sram_set_prcm,
-					omap34xx_sram_set_prcm_sz);
-
-	_omap2_sram_reprogram_gpmc = omap_sram_push(omap34xx_sram_reprogram_gpmc,
-					omap34xx_sram_reprogram_gpmc_sz);
-
-	_omap2_sram_configure_core_dpll =
-				omap_sram_push(omap34xx_sram_configure_core_dpll,
-					omap34xx_sram_configure_core_dpll_sz);
+	_omap3_sram_configure_core_dpll =
+		omap_sram_push(omap3_sram_configure_core_dpll,
+			       omap3_sram_configure_core_dpll_sz);
 
 	return 0;
 }
 #else
-static inline int omap34xx_sram_init(void)
+static inline int omap3_sram_init(void)
 {
 	return 0;
 }
@@ -423,7 +404,7 @@ int __init omap_sram_init(void)
 	else if (cpu_is_omap2430())
 		omap243x_sram_init();
 	else if (cpu_is_omap34xx())
-		omap34xx_sram_init();
+		omap3_sram_init();
 
 	return 0;
 }
diff --git a/include/asm-arm/arch-omap/sram.h b/include/asm-arm/arch-omap/sram.h
index 6c577f7..79c386a 100644
--- a/include/asm-arm/arch-omap/sram.h
+++ b/include/asm-arm/arch-omap/sram.h
@@ -21,6 +21,10 @@ extern void omap2_sram_reprogram_sdrc(u32 perf_level, u32 dll_val,
 				      u32 mem_type);
 extern u32 omap2_set_prcm(u32 dpll_ctrl_val, u32 sdrc_rfr_val, int bypass);
 
+extern u32 omap3_configure_core_dpll(u32 sdrc_rfr_ctrl,
+				     u32 sdrc_actim_ctrla,
+				     u32 sdrc_actim_ctrlb, u32 m2);
+
 /* Do not use these */
 extern void omap1_sram_reprogram_clock(u32 ckctl, u32 dpllctl);
 extern unsigned long omap1_sram_reprogram_clock_sz;
@@ -54,22 +58,9 @@ extern void omap243x_sram_reprogram_sdrc(u32 perf_level, u32 dll_val,
 extern unsigned long omap243x_sram_reprogram_sdrc_sz;
 
 
-extern void omap34xx_sram_ddr_init(u32 *slow_dll_ctrl, u32 fast_dll_ctrl,
-						u32 base_cs, u32 force_unlock);
-extern unsigned long omap34xx_sram_ddr_init_sz;
-
-extern void omap34xx_sram_reprogram_sdrc(u32 perf_level, u32 dll_val,
-						u32 mem_type);
-extern unsigned long omap34xx_sram_reprogram_sdrc_sz;
-
-extern u32 omap34xx_sram_set_prcm(u32 dpll_ctrl_val, u32 sdrc_rfr_val,
-						int bypass);
-extern unsigned long omap34xx_sram_set_prcm_sz;
-
-extern u32 omap34xx_sram_reprogram_gpmc(u32 perf_level);
-extern unsigned long omap34xx_sram_reprogram_gpmc_sz;
-
-extern u32 omap34xx_sram_configure_core_dpll(u32 m, u32 n, u32 freqsel, u32 m2);
-extern unsigned long omap34xx_sram_configure_core_dpll_sz;
+extern u32 omap3_sram_configure_core_dpll(u32 sdrc_rfr_ctrl,
+					  u32 sdrc_actim_ctrla,
+					  u32 sdrc_actim_ctrlb, u32 m2);
+extern unsigned long omap3_sram_configure_core_dpll_sz;
 
 #endif


