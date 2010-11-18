From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 2/2] OMAP3: clean up ASM idle code
Date: Thu, 18 Nov 2010 15:51:46 +0100
Message-ID: <1290091906-32539-3-git-send-email-j-pihet@ti.com>
References: <1290091906-32539-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55955 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757513Ab0KROwx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Nov 2010 09:52:53 -0500
Received: by mail-ww0-f44.google.com with SMTP id 36so3423123wwa.1
        for <linux-omap@vger.kernel.org>; Thu, 18 Nov 2010 06:52:52 -0800 (PST)
In-Reply-To: <1290091906-32539-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vishwanath BS <vishwanath.bs@ti.com>, Jean Pihet <j-pihet@ti.com>

From: Vishwanath BS <vishwanath.bs@ti.com>

Clean up of the ASM code:
- reworked and simplified the execution paths, for better
   readability and to avoid duplication of code,
- reworked the comments for better readability,
- reworked the code formating and alignment,
- added comments for the i443 errata workarounds,
- replaced the cache flush code by a call to the kernel
   common code for ARMv7 (v7_flush_kern_cache_all), which is
   better maintained and so more mature,
- clean up of non used symbols.

Tested on Zoom3, OMAP3EVM, Beagleboard, n900
with full RET and OFF mode.

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>

Heavily reworked from Vishwa's original patch.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/control.h   |    2 +
 arch/arm/mach-omap2/pm.h        |    6 +-
 arch/arm/mach-omap2/pm34xx.c    |    4 +-
 arch/arm/mach-omap2/sleep34xx.S |  354 +++++++++++++++------------------------
 4 files changed, 143 insertions(+), 223 deletions(-)

diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index b6c6b7c..78f7f19 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -270,6 +270,8 @@
 #define OMAP343X_SCRATCHPAD_ROM		(OMAP343X_CTRL_BASE + 0x860)
 #define OMAP343X_SCRATCHPAD		(OMAP343X_CTRL_BASE + 0x910)
 #define OMAP343X_SCRATCHPAD_ROM_OFFSET	0x19C
+#define OMAP343X_SCRATCHPAD_REGADDR(reg)	OMAP2_L4_IO_ADDRESS(\
+						OMAP343X_SCRATCHPAD + reg)
 
 /* AM35XX_CONTROL_IPSS_CLK_CTRL bits */
 #define AM35XX_USBOTG_VBUSP_CLK_SHIFT   0
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 0d75bfd..9ff051d 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -75,14 +75,12 @@ extern void omap24xx_idle_loop_suspend(void);
 
 extern void omap24xx_cpu_suspend(u32 dll_ctrl, void __iomem *sdrc_dlla_ctrl,
 					void __iomem *sdrc_power);
-extern void omap34xx_cpu_suspend(u32 *addr, int save_state);
+
+extern void omap34xx_save_cpu_context_wfi(u32 *addr, int save_state);
 extern void save_secure_ram_context(u32 *addr);
 extern void omap3_save_scratchpad_contents(void);
 
 extern unsigned int omap24xx_idle_loop_suspend_sz;
-extern unsigned int omap34xx_suspend_sz;
 extern unsigned int save_secure_ram_context_sz;
 extern unsigned int omap24xx_cpu_suspend_sz;
-extern unsigned int omap34xx_cpu_suspend_sz;
-
 #endif
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 035ca47..18ad1ed 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -404,7 +404,7 @@ void omap_sram_idle(void)
 	/*
 	* On EMU/HS devices ROM code restores a SRDC value
 	* from scratchpad which has automatic self refresh on timeout
-	* of AUTO_CNT = 1 enabled. This takes care of errata 1.142.
+	* of AUTO_CNT = 1 enabled. This takes care of errata ID i443.
 	* Hence store/restore the SDRC_POWER register here.
 	*/
 	if (omap_rev() >= OMAP3430_REV_ES3_0 &&
@@ -417,7 +417,7 @@ void omap_sram_idle(void)
 	 * get saved. The restore path then reads from this
 	 * location and restores them back.
 	 */
-	omap34xx_cpu_suspend(omap3_arm_context, save_state);
+	omap34xx_save_cpu_context_wfi(omap3_arm_context, save_state);
 	cpu_init();
 
 	/* Restore normal SDRC POWER settings */
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 2fb205a..47a0d36 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -33,21 +33,21 @@
 #include "sdrc.h"
 #include "control.h"
 
-#define SDRC_SCRATCHPAD_SEM_V	0xfa00291c
-
-#define PM_PREPWSTST_CORE_V	OMAP34XX_PRM_REGADDR(CORE_MOD, \
-				OMAP3430_PM_PREPWSTST)
-#define PM_PREPWSTST_CORE_P	0x48306AE8
-#define PM_PREPWSTST_MPU_V	OMAP34XX_PRM_REGADDR(MPU_MOD, \
-				OMAP3430_PM_PREPWSTST)
+#define SDRC_SCRATCHPAD_SEM_OFFS	0xc
+#define SDRC_SCRATCHPAD_SEM_V	OMAP343X_SCRATCHPAD_REGADDR\
+					(SDRC_SCRATCHPAD_SEM_OFFS)
+#define PM_PREPWSTST_CORE_P	OMAP3430_PRM_BASE + CORE_MOD +\
+					OMAP3430_PM_PREPWSTST
 #define PM_PWSTCTRL_MPU_P	OMAP3430_PRM_BASE + MPU_MOD + OMAP2_PM_PWSTCTRL
 #define CM_IDLEST1_CORE_V	OMAP34XX_CM_REGADDR(CORE_MOD, CM_IDLEST1)
 #define SRAM_BASE_P		0x40200000
-#define CONTROL_STAT		0x480022F0
-#define SCRATCHPAD_MEM_OFFS	0x310 /* Move this as correct place is
-				       * available */
+#define CONTROL_STAT		OMAP343X_CTRL_BASE + OMAP343X_CONTROL_STATUS
+
+/* Move this as correct place is available */
+#define SCRATCHPAD_MEM_OFFS	0x310
+
 #define SCRATCHPAD_BASE_P	(OMAP343X_CTRL_BASE + OMAP343X_CONTROL_MEM_WKUP\
-						+ SCRATCHPAD_MEM_OFFS)
+					+ SCRATCHPAD_MEM_OFFS)
 #define SDRC_POWER_V		OMAP34XX_SDRC_REGADDR(SDRC_POWER)
 #define SDRC_SYSCONFIG_P	(OMAP343X_SDRC_BASE + SDRC_SYSCONFIG)
 #define SDRC_MR_0_P		(OMAP343X_SDRC_BASE + SDRC_MR_0)
@@ -108,6 +108,7 @@ ENTRY(get_es3_restore_pointer)
 ENTRY(get_es3_restore_pointer_sz)
 	.word	. - get_es3_restore_pointer
 
+/* This function is needed for Errata ID i443 (34xx >= ES3.0) */
 ENTRY(es3_sdrc_fix)
 	ldr	r4, sdrc_syscfg		@ get config addr
 	ldr	r5, [r4]		@ get value
@@ -187,26 +188,112 @@ ENTRY(save_secure_ram_context_sz)
 /*
  * Forces OMAP into idle state
  *
- * omap34xx_suspend() - This bit of code just executes the WFI
- * for normal idles.
+ * omap34xx_save_cpu_context_wfi() - This bit of code saves the CPU context
+ *  and executes the WFI instruction
  *
- * Note: This code get's copied to internal SRAM at boot. When the OMAP
- *	 wakes up it continues execution at the point it went to sleep.
+ * This is the low power idle code entry point
  */
-ENTRY(omap34xx_cpu_suspend)
+ENTRY(omap34xx_save_cpu_context_wfi)
 	stmfd	sp!, {r0-r12, lr}		@ save registers on stack
 loop:
 	/*b	loop*/	@Enable to debug by stepping through code
+
 	/* r0 contains restore pointer in sdram */
-	/* r1 contains information about saving context */
+	/* r1 contains information about saving context: */
+        /*   1 - Only L1 and logic lost */
+        /*   2 - Only L2 lost */
+        /*   3 - Both L1 and L2 lost */
+
+	/* Save context only if required */
+	cmp	r1, #0x0
+	beq	omap3_do_wfi
+
+save_context_wfi:
+	/*b	save_context_wfi*/	@ enable to debug save code
+
+	mov	r8, r0 			@ Store SDRAM address in r8
+	mrc	p15, 0, r5, c1, c0, 1	@ Read Auxiliary Control Register
+	mov	r4, #0x1		@ Number of parameters for restore call
+	stmia	r8!, {r4-r5}		@ Push parameters for restore call
+	mrc	p15, 1, r5, c9, c0, 2	@ Read L2 AUX ctrl register
+	stmia	r8!, {r4-r5}		@ Push parameters for restore call
+
+        /* Check what that target sleep state is from r1 */
+	cmp	r1, #0x2 		@ Only L2 lost, no need to save context
+	beq	clean_caches
+
+l1_logic_lost:
+	/* Store sp and spsr to SDRAM */
+	mov	r4, sp
+	mrs	r5, spsr
+	mov	r6, lr
+	stmia	r8!, {r4-r6}
+	/* Save all ARM registers */
+	/* Coprocessor access control register */
+	mrc	p15, 0, r6, c1, c0, 2
+	stmia	r8!, {r6}
+	/* TTBR0, TTBR1 and Translation table base control */
+	mrc	p15, 0, r4, c2, c0, 0
+	mrc	p15, 0, r5, c2, c0, 1
+	mrc	p15, 0, r6, c2, c0, 2
+	stmia	r8!, {r4-r6}
+	/* Domain access control register, data fault status register,
+	and instruction fault status register */
+	mrc	p15, 0, r4, c3, c0, 0
+	mrc	p15, 0, r5, c5, c0, 0
+	mrc	p15, 0, r6, c5, c0, 1
+	stmia	r8!, {r4-r6}
+	/* Data aux fault status register, instruction aux fault status,
+	datat fault address register and instruction fault address register*/
+	mrc	p15, 0, r4, c5, c1, 0
+	mrc	p15, 0, r5, c5, c1, 1
+	mrc	p15, 0, r6, c6, c0, 0
+	mrc	p15, 0, r7, c6, c0, 2
+	stmia	r8!, {r4-r7}
+	/* user r/w thread and process ID, user r/o thread and process ID,
+	priv only thread and process ID, cache size selection */
+	mrc	p15, 0, r4, c13, c0, 2
+	mrc	p15, 0, r5, c13, c0, 3
+	mrc	p15, 0, r6, c13, c0, 4
+	mrc	p15, 2, r7, c0, c0, 0
+	stmia	r8!, {r4-r7}
+	/* Data TLB lockdown, instruction TLB lockdown registers */
+	mrc	p15, 0, r5, c10, c0, 0
+	mrc	p15, 0, r6, c10, c0, 1
+	stmia	r8!, {r5-r6}
+	/* Secure or non secure vector base address, FCSE PID, Context PID*/
+	mrc	p15, 0, r4, c12, c0, 0
+	mrc	p15, 0, r5, c13, c0, 0
+	mrc	p15, 0, r6, c13, c0, 1
+	stmia	r8!, {r4-r6}
+	/* Primary remap, normal remap registers */
+	mrc	p15, 0, r4, c10, c2, 0
+	mrc	p15, 0, r5, c10, c2, 1
+	stmia	r8!,{r4-r5}
+
+	/* Store current cpsr*/
+	mrs	r2, cpsr
+	stmia	r8!, {r2}
+
+	/* save control register */
+	mrc	p15, 0, r4, c1, c0, 0
+	stmia	r8!, {r4}
+
+clean_caches:
+	/* Clean Data or unified cache to POU*/
+	/* How to invalidate only L1 cache???? - #FIX_ME# */
+	/* mcr	p15, 0, r11, c7, c11, 1 */
+
+        /* Check what that target sleep state is from r1 */
+	cmp	r1, #0x1 		@ if L2 retained, no need to clean
+	blne v7_flush_kern_cache_all	@ Flush the entire cache system
+
+omap3_do_wfi:
 	ldr     r4, sdrc_power          @ read the SDRC_POWER register
 	ldr     r5, [r4]                @ read the contents of SDRC_POWER
 	orr     r5, r5, #0x40           @ enable self refresh on idle req
 	str     r5, [r4]                @ write back to SDRC_POWER register
 
-	cmp	r1, #0x0
-	/* If context save is required, do that and execute wfi */
-	bne	save_context_wfi
 	/* Data memory barrier and Data sync barrier */
 	mov	r1, #0
 	mcr	p15, 0, r1, c7, c10, 4
@@ -226,9 +313,15 @@ loop:
 	nop
 	bl wait_sdrc_ok
 
-	ldmfd	sp!, {r0-r12, pc}		@ restore regs and return
+	/*
+	 * This is the exit point from the non-OFF modes
+	 */
+	ldmfd	sp!, {r0-r12, pc}	@ restore regs and return
+
+
 restore_es3:
 	/*b restore_es3*/		@ Enable to debug restore code
+
 	ldr	r5, pm_prepwstst_core_p
 	ldr	r4, [r5]
 	and	r4, r4, #0x3
@@ -247,6 +340,7 @@ copy_to_sram:
 	blx	r1
 restore:
 	/* b restore*/  @ Enable to debug restore code
+
         /* Check what was the reason for mpu reset and store the reason in r9*/
         /* 1 - Only L1 and logic lost */
         /* 2 - Only L2 lost - In this case, we wont be here */
@@ -263,20 +357,20 @@ restore:
 	and	r1, #0x700
 	cmp	r1, #0x300
 	beq	l2_inv_gp
-	mov	r0, #40		@ set service ID for PPA
-	mov	r12, r0		@ copy secure Service ID in r12
-	mov	r1, #0		@ set task id for ROM code in r1
-	mov	r2, #4		@ set some flags in r2, r6
+	mov	r0, #40			@ set service ID for PPA
+	mov	r12, r0			@ copy secure Service ID in r12
+	mov	r1, #0			@ set task id for ROM code in r1
+	mov	r2, #4			@ set some flags in r2, r6
 	mov	r6, #0xff
 	adr	r3, l2_inv_api_params	@ r3 points to dummy parameters
 	mcr	p15, 0, r0, c7, c10, 4	@ data write barrier
 	mcr	p15, 0, r0, c7, c10, 5	@ data memory barrier
 	.word	0xE1600071		@ call SMI monitor (smi #1)
 	/* Write to Aux control register to set some bits */
-	mov	r0, #42		@ set service ID for PPA
-	mov	r12, r0		@ copy secure Service ID in r12
-	mov	r1, #0		@ set task id for ROM code in r1
-	mov	r2, #4		@ set some flags in r2, r6
+	mov	r0, #42			@ set service ID for PPA
+	mov	r12, r0			@ copy secure Service ID in r12
+	mov	r1, #0			@ set task id for ROM code in r1
+	mov	r2, #4			@ set some flags in r2, r6
 	mov	r6, #0xff
 	ldr	r4, scratchpad_base
 	ldr	r3, [r4, #0xBC]	@ r3 points to parameters
@@ -288,9 +382,9 @@ restore:
 	/* Restore L2 aux control register */
 	@ set service ID for PPA
 	mov	r0, #CONFIG_OMAP3_L2_AUX_SECURE_SERVICE_SET_ID
-	mov	r12, r0		@ copy service ID in r12
-	mov	r1, #0		@ set task ID for ROM code in r1
-	mov	r2, #4		@ set some flags in r2, r6
+	mov	r12, r0			@ copy service ID in r12
+	mov	r1, #0			@ set task ID for ROM code in r1
+	mov	r2, #4			@ set some flags in r2, r6
 	mov	r6, #0xff
 	ldr	r4, scratchpad_base
 	ldr	r3, [r4, #0xBC]
@@ -304,19 +398,19 @@ l2_inv_api_params:
 	.word   0x1, 0x00
 l2_inv_gp:
 	/* Execute smi to invalidate L2 cache */
-	mov r12, #0x1                         @ set up to invalide L2
+	mov r12, #0x1			@ set up to invalide L2
 smi:    .word 0xE1600070		@ Call SMI monitor (smieq)
 	/* Write to Aux control register to set some bits */
 	ldr	r4, scratchpad_base
 	ldr	r3, [r4,#0xBC]
 	ldr	r0, [r3,#4]
 	mov	r12, #0x3
-	.word 0xE1600070	@ Call SMI monitor (smieq)
+	.word 0xE1600070		@ Call SMI monitor (smieq)
 	ldr	r4, scratchpad_base
 	ldr	r3, [r4,#0xBC]
 	ldr	r0, [r3,#12]
 	mov	r12, #0x2
-	.word 0xE1600070	@ Call SMI monitor (smieq)
+	.word 0xE1600070		@ Call SMI monitor (smieq)
 logic_l1_restore:
 	mov	r1, #0
 	/* Invalidate all instruction caches to PoU
@@ -386,11 +480,11 @@ logic_l1_restore:
 	MCR p15, 0, r5, c10, c2, 1
 
 	/* Restore cpsr */
-	ldmia	r3!,{r4}	/*load CPSR from SDRAM*/
-	msr	cpsr, r4	/*store cpsr */
+	ldmia	r3!,{r4}		@ load CPSR from SDRAM
+	msr	cpsr, r4		@ store cpsr
 
 	/* Enabling MMU here */
-	mrc	p15, 0, r7, c2, c0, 2 /* Read TTBRControl */
+	mrc	p15, 0, r7, c2, c0, 2 	@ Read TTBRControl
 	/* Extract N (0:2) bits and decide whether to use TTBR0 or TTBR1*/
 	and	r7, #0x7
 	cmp	r7, #0x0
@@ -438,174 +532,12 @@ usettbr0:
 	and	r4, r2
 	mcr	p15, 0, r4, c1, c0, 0
 
-	ldmfd	sp!, {r0-r12, pc}		@ restore regs and return
-save_context_wfi:
-	/*b	save_context_wfi*/	@ enable to debug save code
-	mov	r8, r0 /* Store SDRAM address in r8 */
-	mrc	p15, 0, r5, c1, c0, 1	@ Read Auxiliary Control Register
-	mov	r4, #0x1		@ Number of parameters for restore call
-	stmia	r8!, {r4-r5}		@ Push parameters for restore call
-	mrc	p15, 1, r5, c9, c0, 2	@ Read L2 AUX ctrl register
-	stmia	r8!, {r4-r5}		@ Push parameters for restore call
-        /* Check what that target sleep state is:stored in r1*/
-        /* 1 - Only L1 and logic lost */
-        /* 2 - Only L2 lost */
-        /* 3 - Both L1 and L2 lost */
-	cmp	r1, #0x2 /* Only L2 lost */
-	beq	clean_l2
-	cmp	r1, #0x1 /* L2 retained */
-	/* r9 stores whether to clean L2 or not*/
-	moveq	r9, #0x0 /* Dont Clean L2 */
-	movne	r9, #0x1 /* Clean L2 */
-l1_logic_lost:
-	/* Store sp and spsr to SDRAM */
-	mov	r4, sp
-	mrs	r5, spsr
-	mov	r6, lr
-	stmia	r8!, {r4-r6}
-	/* Save all ARM registers */
-	/* Coprocessor access control register */
-	mrc	p15, 0, r6, c1, c0, 2
-	stmia	r8!, {r6}
-	/* TTBR0, TTBR1 and Translation table base control */
-	mrc	p15, 0, r4, c2, c0, 0
-	mrc	p15, 0, r5, c2, c0, 1
-	mrc	p15, 0, r6, c2, c0, 2
-	stmia	r8!, {r4-r6}
-	/* Domain access control register, data fault status register,
-	and instruction fault status register */
-	mrc	p15, 0, r4, c3, c0, 0
-	mrc	p15, 0, r5, c5, c0, 0
-	mrc	p15, 0, r6, c5, c0, 1
-	stmia	r8!, {r4-r6}
-	/* Data aux fault status register, instruction aux fault status,
-	datat fault address register and instruction fault address register*/
-	mrc	p15, 0, r4, c5, c1, 0
-	mrc	p15, 0, r5, c5, c1, 1
-	mrc	p15, 0, r6, c6, c0, 0
-	mrc	p15, 0, r7, c6, c0, 2
-	stmia	r8!, {r4-r7}
-	/* user r/w thread and process ID, user r/o thread and process ID,
-	priv only thread and process ID, cache size selection */
-	mrc	p15, 0, r4, c13, c0, 2
-	mrc	p15, 0, r5, c13, c0, 3
-	mrc	p15, 0, r6, c13, c0, 4
-	mrc	p15, 2, r7, c0, c0, 0
-	stmia	r8!, {r4-r7}
-	/* Data TLB lockdown, instruction TLB lockdown registers */
-	mrc	p15, 0, r5, c10, c0, 0
-	mrc	p15, 0, r6, c10, c0, 1
-	stmia	r8!, {r5-r6}
-	/* Secure or non secure vector base address, FCSE PID, Context PID*/
-	mrc	p15, 0, r4, c12, c0, 0
-	mrc	p15, 0, r5, c13, c0, 0
-	mrc	p15, 0, r6, c13, c0, 1
-	stmia	r8!, {r4-r6}
-	/* Primary remap, normal remap registers */
-	mrc	p15, 0, r4, c10, c2, 0
-	mrc	p15, 0, r5, c10, c2, 1
-	stmia	r8!,{r4-r5}
-
-	/* Store current cpsr*/
-	mrs	r2, cpsr
-	stmia	r8!, {r2}
+	/*
+	 * This is the exit point of omap34xx_save_cpu_context_wfi
+	 * from the OFF mode, after context restore
+	 */
+	ldmfd	sp!, {r0-r12, pc}	@ restore regs and return
 
-	mrc	p15, 0, r4, c1, c0, 0
-	/* save control register */
-	stmia	r8!, {r4}
-clean_caches:
-	/* Clean Data or unified cache to POU*/
-	/* How to invalidate only L1 cache???? - #FIX_ME# */
-	/* mcr	p15, 0, r11, c7, c11, 1 */
-	cmp	r9, #1 /* Check whether L2 inval is required or not*/
-	bne	skip_l2_inval
-clean_l2:
-	/* read clidr */
-	mrc     p15, 1, r0, c0, c0, 1
-	/* extract loc from clidr */
-	ands    r3, r0, #0x7000000
-	/* left align loc bit field */
-	mov     r3, r3, lsr #23
-	/* if loc is 0, then no need to clean */
-	beq     finished
-	/* start clean at cache level 0 */
-	mov     r10, #0
-loop1:
-	/* work out 3x current cache level */
-	add     r2, r10, r10, lsr #1
-	/* extract cache type bits from clidr*/
-	mov     r1, r0, lsr r2
-	/* mask of the bits for current cache only */
-	and     r1, r1, #7
-	/* see what cache we have at this level */
-	cmp     r1, #2
-	/* skip if no cache, or just i-cache */
-	blt     skip
-	/* select current cache level in cssr */
-	mcr     p15, 2, r10, c0, c0, 0
-	/* isb to sych the new cssr&csidr */
-	isb
-	/* read the new csidr */
-	mrc     p15, 1, r1, c0, c0, 0
-	/* extract the length of the cache lines */
-	and     r2, r1, #7
-	/* add 4 (line length offset) */
-	add     r2, r2, #4
-	ldr     r4, assoc_mask
-	/* find maximum number on the way size */
-	ands    r4, r4, r1, lsr #3
-	/* find bit position of way size increment */
-	clz     r5, r4
-	ldr     r7, numset_mask
-	/* extract max number of the index size*/
-	ands    r7, r7, r1, lsr #13
-loop2:
-	mov     r9, r4
-	/* create working copy of max way size*/
-loop3:
-	/* factor way and cache number into r11 */
-	orr     r11, r10, r9, lsl r5
-	/* factor index number into r11 */
-	orr     r11, r11, r7, lsl r2
-	/*clean & invalidate by set/way */
-	mcr     p15, 0, r11, c7, c10, 2
-	/* decrement the way*/
-	subs    r9, r9, #1
-	bge     loop3
-	/*decrement the index */
-	subs    r7, r7, #1
-	bge     loop2
-skip:
-	add     r10, r10, #2
-	/* increment cache number */
-	cmp     r3, r10
-	bgt     loop1
-finished:
-	/*swith back to cache level 0 */
-	mov     r10, #0
-	/* select current cache level in cssr */
-	mcr     p15, 2, r10, c0, c0, 0
-	isb
-skip_l2_inval:
-	/* Data memory barrier and Data sync barrier */
-	mov     r1, #0
-	mcr     p15, 0, r1, c7, c10, 4
-	mcr     p15, 0, r1, c7, c10, 5
-
-	wfi                             @ wait for interrupt
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	nop
-	bl wait_sdrc_ok
-	/* restore regs and return */
-	ldmfd   sp!, {r0-r12, pc}
 
 /* Make sure SDRC accesses are ok */
 wait_sdrc_ok:
@@ -638,12 +570,8 @@ sdrc_dlla_status:
 	.word	SDRC_DLLA_STATUS_V
 sdrc_dlla_ctrl:
 	.word	SDRC_DLLA_CTRL_V
-pm_prepwstst_core:
-	.word	PM_PREPWSTST_CORE_V
 pm_prepwstst_core_p:
 	.word	PM_PREPWSTST_CORE_P
-pm_prepwstst_mpu:
-	.word	PM_PREPWSTST_MPU_V
 pm_pwstctrl_mpu:
 	.word	PM_PWSTCTRL_MPU_P
 scratchpad_base:
@@ -652,12 +580,6 @@ sram_base:
 	.word	SRAM_BASE_P + 0x8000
 sdrc_power:
 	.word SDRC_POWER_V
-clk_stabilize_delay:
-	.word 0x000001FF
-assoc_mask:
-	.word	0x3ff
-numset_mask:
-	.word	0x7fff
 ttbrbit_mask:
 	.word	0xFFFFC000
 table_index_mask:
@@ -668,5 +590,3 @@ cache_pred_disable_mask:
 	.word	0xFFFFE7FB
 control_stat:
 	.word	CONTROL_STAT
-ENTRY(omap34xx_cpu_suspend_sz)
-	.word	. - omap34xx_cpu_suspend
-- 
1.7.2.3

