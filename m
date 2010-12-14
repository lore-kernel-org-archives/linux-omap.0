From: jean.pihet@newoldbits.com
Subject: [PATCH v3] OMAP3: clean up ASM idle code
Date: Tue, 14 Dec 2010 18:26:43 +0100
Message-ID: <1292347603-17703-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38270 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364Ab0LNR2G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 12:28:06 -0500
Received: by wwa36 with SMTP id 36so727288wwa.1
        for <linux-omap@vger.kernel.org>; Tue, 14 Dec 2010 09:28:05 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, Jean Pihet <j-pihet@ti.com>, Vishwanath BS <vishwanath.bs@ti.com>

From: Jean Pihet <j-pihet@ti.com>

This patch only contains clean-ups and cosmetic changes,
no functional change.

Clean up of the ASM code:
- reorganized the code in logical sections: defines, API
   functions, internal functions and variables,
- reworked and simplified the execution paths, for better
   readability and to avoid duplication of code,
- added comments on the entry and exit points and the interaction
   with the ROM code for OFF mode restore,
- reworked the existing comments for better readability,
- reworked the code formating, alignment and white spaces,
- added comments for the i443 erratum workarounds,
- changed the hardcoded values in favor of existing macros
   from include files,
- clean up of non used symbols.

Tested on OMAP3EVM and Beagleboard with full RET and OFF modes,
 using cpuidle and suspend.

Based on original patch from Vishwa.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
Cc: Vishwanath BS <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/control.c   |   10 +-
 arch/arm/mach-omap2/control.h   |    2 +
 arch/arm/mach-omap2/pm.h        |    1 -
 arch/arm/mach-omap2/pm34xx.c    |    4 +-
 arch/arm/mach-omap2/sleep34xx.S |  581 +++++++++++++++++++++------------------
 5 files changed, 329 insertions(+), 269 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 728f268..5cb7276 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -239,7 +239,15 @@ void omap3_save_scratchpad_contents(void)
 	struct omap3_scratchpad_prcm_block prcm_block_contents;
 	struct omap3_scratchpad_sdrc_block sdrc_block_contents;
 
-	/* Populate the Scratchpad contents */
+	/*
+	 * Populate the Scratchpad contents
+	 *
+	 * The get_*restore_pointer functions are used to get the resume
+	 *  function pointer to be called by the ROM code when back from WFI
+	 *  in OFF mode.
+	 * The restore pointer is stored into the scratchpad for later access
+	 *  by the ROM code.
+	 */
 	scratchpad_contents.boot_config_ptr = 0x0;
 	if (cpu_is_omap3630())
 		scratchpad_contents.public_restore_ptr =
diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index d7911c5..72efefb 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -274,6 +274,8 @@
 #define OMAP343X_SCRATCHPAD_ROM		(OMAP343X_CTRL_BASE + 0x860)
 #define OMAP343X_SCRATCHPAD		(OMAP343X_CTRL_BASE + 0x910)
 #define OMAP343X_SCRATCHPAD_ROM_OFFSET	0x19C
+#define OMAP343X_SCRATCHPAD_REGADDR(reg)	OMAP2_L4_IO_ADDRESS(\
+						OMAP343X_SCRATCHPAD + reg)
 
 /* AM35XX_CONTROL_IPSS_CLK_CTRL bits */
 #define AM35XX_USBOTG_VBUSP_CLK_SHIFT   0
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index aff39d0..e458b2a 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -80,7 +80,6 @@ extern void save_secure_ram_context(u32 *addr);
 extern void omap3_save_scratchpad_contents(void);
 
 extern unsigned int omap24xx_idle_loop_suspend_sz;
-extern unsigned int omap34xx_suspend_sz;
 extern unsigned int save_secure_ram_context_sz;
 extern unsigned int omap24xx_cpu_suspend_sz;
 extern unsigned int omap34xx_cpu_suspend_sz;
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index ba3c0d6..0e3cc35 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -135,7 +135,7 @@ static void omap3_core_save_context(void)
 
 	/*
 	 * Force write last pad into memory, as this can fail in some
-	 * cases according to erratas 1.157, 1.185
+	 * cases according to errata 1.157 & 1.185
 	 */
 	omap_ctrl_writel(omap_ctrl_readl(OMAP343X_PADCONF_ETK_D14),
 		OMAP343X_CONTROL_MEM_WKUP + 0x2a0);
@@ -432,7 +432,7 @@ void omap_sram_idle(void)
 	/*
 	* On EMU/HS devices ROM code restores a SRDC value
 	* from scratchpad which has automatic self refresh on timeout
-	* of AUTO_CNT = 1 enabled. This takes care of errata 1.142.
+	* of AUTO_CNT = 1 enabled. This takes care of erratum ID i443.
 	* Hence store/restore the SDRC_POWER register here.
 	*/
 	if (omap_rev() >= OMAP3430_REV_ES3_0 &&
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index d2eda01..ccf661e 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -33,24 +33,27 @@
 #include "sdrc.h"
 #include "control.h"
 
-#define SDRC_SCRATCHPAD_SEM_V	0xfa00291c
-
-#define PM_PREPWSTST_CORE_V	OMAP34XX_PRM_REGADDR(CORE_MOD, \
-				OMAP3430_PM_PREPWSTST)
-#define PM_PREPWSTST_CORE_P	0x48306AE8
-#define PM_PREPWSTST_MPU_V	OMAP34XX_PRM_REGADDR(MPU_MOD, \
-				OMAP3430_PM_PREPWSTST)
+/*
+ * Registers access definitions
+ */
+#define SDRC_SCRATCHPAD_SEM_OFFS	0xc
+#define SDRC_SCRATCHPAD_SEM_V	OMAP343X_SCRATCHPAD_REGADDR\
+					(SDRC_SCRATCHPAD_SEM_OFFS)
+#define PM_PREPWSTST_CORE_P	OMAP3430_PRM_BASE + CORE_MOD +\
+					OMAP3430_PM_PREPWSTST
 #define PM_PWSTCTRL_MPU_P	OMAP3430_PRM_BASE + MPU_MOD + OMAP2_PM_PWSTCTRL
 #define CM_IDLEST1_CORE_V	OMAP34XX_CM_REGADDR(CORE_MOD, CM_IDLEST1)
 #define CM_IDLEST_CKGEN_V	OMAP34XX_CM_REGADDR(PLL_MOD, CM_IDLEST)
 #define SRAM_BASE_P		0x40200000
-#define CONTROL_STAT		0x480022F0
-#define CONTROL_MEM_RTA_CTRL	(OMAP343X_CTRL_BASE\
-					+ OMAP36XX_CONTROL_MEM_RTA_CTRL)
-#define SCRATCHPAD_MEM_OFFS	0x310 /* Move this as correct place is
-				       * available */
-#define SCRATCHPAD_BASE_P	(OMAP343X_CTRL_BASE + OMAP343X_CONTROL_MEM_WKUP\
-						+ SCRATCHPAD_MEM_OFFS)
+#define CONTROL_STAT		OMAP343X_CTRL_BASE + OMAP343X_CONTROL_STATUS
+#define CONTROL_MEM_RTA_CTRL	(OMAP343X_CTRL_BASE +\
+					OMAP36XX_CONTROL_MEM_RTA_CTRL)
+
+/* Move this as correct place is available */
+#define SCRATCHPAD_MEM_OFFS	0x310
+#define SCRATCHPAD_BASE_P	(OMAP343X_CTRL_BASE +\
+					OMAP343X_CONTROL_MEM_WKUP +\
+					SCRATCHPAD_MEM_OFFS)
 #define SDRC_POWER_V		OMAP34XX_SDRC_REGADDR(SDRC_POWER)
 #define SDRC_SYSCONFIG_P	(OMAP343X_SDRC_BASE + SDRC_SYSCONFIG)
 #define SDRC_MR_0_P		(OMAP343X_SDRC_BASE + SDRC_MR_0)
@@ -62,6 +65,10 @@
 #define SDRC_DLLA_STATUS_V	OMAP34XX_SDRC_REGADDR(SDRC_DLLA_STATUS)
 #define SDRC_DLLA_CTRL_V	OMAP34XX_SDRC_REGADDR(SDRC_DLLA_CTRL)
 
+
+/*
+ * API functions
+ */
         .text
 /* Function to acquire the semaphore in scratchpad */
 ENTRY(lock_scratchpad_sem)
@@ -78,11 +85,11 @@ wait_loop:
 	beq	wait_sem	@ no - try again
 	ldmfd	sp!, {pc}	@ restore regs and return
 sdrc_scratchpad_sem:
-        .word SDRC_SCRATCHPAD_SEM_V
+	.word SDRC_SCRATCHPAD_SEM_V
 ENTRY(lock_scratchpad_sem_sz)
-        .word   . - lock_scratchpad_sem
+	.word   . - lock_scratchpad_sem
 
-        .text
+	.text
 /* Function to release the scratchpad semaphore */
 ENTRY(unlock_scratchpad_sem)
 	stmfd	sp!, {lr}	@ save registers on stack
@@ -91,95 +98,57 @@ ENTRY(unlock_scratchpad_sem)
 	str	r2,[r3]
 	ldmfd	sp!, {pc}	@ restore regs and return
 ENTRY(unlock_scratchpad_sem_sz)
-        .word   . - unlock_scratchpad_sem
+	.word   . - unlock_scratchpad_sem
 
+/*
+ * The get_*restore_pointer functions are returning the resume
+ *  function pointer to be called by the ROM code when back from WFI
+ *  in OFF mode.
+ */
 	.text
 /* Function call to get the restore pointer for resume from OFF */
 ENTRY(get_restore_pointer)
-        stmfd   sp!, {lr}     @ save registers on stack
+	stmfd   sp!, {lr}     @ save registers on stack
 	adr	r0, restore
-        ldmfd   sp!, {pc}     @ restore regs and return
+	ldmfd   sp!, {pc}     @ restore regs and return
 ENTRY(get_restore_pointer_sz)
-        .word   . - get_restore_pointer
+	.word   . - get_restore_pointer
+
 	.text
 /* Function call to get the restore pointer for 3630 resume from OFF */
 ENTRY(get_omap3630_restore_pointer)
-        stmfd   sp!, {lr}     @ save registers on stack
+	stmfd   sp!, {lr}     @ save registers on stack
 	adr	r0, restore_3630
-        ldmfd   sp!, {pc}     @ restore regs and return
+	ldmfd   sp!, {pc}     @ restore regs and return
 ENTRY(get_omap3630_restore_pointer_sz)
-        .word   . - get_omap3630_restore_pointer
+	.word   . - get_omap3630_restore_pointer
+
+	.text
+/* Function call to get the restore pointer for ES3 to resume from OFF */
+ENTRY(get_es3_restore_pointer)
+	stmfd	sp!, {lr}	@ save registers on stack
+	adr	r0, restore_es3
+	ldmfd	sp!, {pc}	@ restore regs and return
+ENTRY(get_es3_restore_pointer_sz)
+	.word	. - get_es3_restore_pointer
 
 	.text
 /*
  * L2 cache needs to be toggled for stable OFF mode functionality on 3630.
- * This function sets up a fflag that will allow for this toggling to take
+ * This function sets up a flag that will allow for this toggling to take
  * place on 3630. Hopefully some version in the future maynot need this
  */
 ENTRY(enable_omap3630_toggle_l2_on_restore)
-        stmfd   sp!, {lr}     @ save registers on stack
+	stmfd   sp!, {lr}     @ save registers on stack
 	/* Setup so that we will disable and enable l2 */
 	mov	r1, #0x1
 	str	r1, l2dis_3630
-        ldmfd   sp!, {pc}     @ restore regs and return
+	ldmfd   sp!, {pc}     @ restore regs and return
 
 	.text
-/* Function call to get the restore pointer for for ES3 to resume from OFF */
-ENTRY(get_es3_restore_pointer)
-	stmfd	sp!, {lr}	@ save registers on stack
-	adr	r0, restore_es3
-	ldmfd	sp!, {pc}	@ restore regs and return
-ENTRY(get_es3_restore_pointer_sz)
-	.word	. - get_es3_restore_pointer
-
-ENTRY(es3_sdrc_fix)
-	ldr	r4, sdrc_syscfg		@ get config addr
-	ldr	r5, [r4]		@ get value
-	tst	r5, #0x100		@ is part access blocked
-	it	eq
-	biceq	r5, r5, #0x100		@ clear bit if set
-	str	r5, [r4]		@ write back change
-	ldr	r4, sdrc_mr_0		@ get config addr
-	ldr	r5, [r4]		@ get value
-	str	r5, [r4]		@ write back change
-	ldr	r4, sdrc_emr2_0		@ get config addr
-	ldr	r5, [r4]		@ get value
-	str	r5, [r4]		@ write back change
-	ldr	r4, sdrc_manual_0	@ get config addr
-	mov	r5, #0x2		@ autorefresh command
-	str	r5, [r4]		@ kick off refreshes
-	ldr	r4, sdrc_mr_1		@ get config addr
-	ldr	r5, [r4]		@ get value
-	str	r5, [r4]		@ write back change
-	ldr	r4, sdrc_emr2_1		@ get config addr
-	ldr	r5, [r4]		@ get value
-	str	r5, [r4]		@ write back change
-	ldr	r4, sdrc_manual_1	@ get config addr
-	mov	r5, #0x2		@ autorefresh command
-	str	r5, [r4]		@ kick off refreshes
-	bx	lr
-sdrc_syscfg:
-	.word	SDRC_SYSCONFIG_P
-sdrc_mr_0:
-	.word	SDRC_MR_0_P
-sdrc_emr2_0:
-	.word	SDRC_EMR2_0_P
-sdrc_manual_0:
-	.word	SDRC_MANUAL_0_P
-sdrc_mr_1:
-	.word	SDRC_MR_1_P
-sdrc_emr2_1:
-	.word	SDRC_EMR2_1_P
-sdrc_manual_1:
-	.word	SDRC_MANUAL_1_P
-ENTRY(es3_sdrc_fix_sz)
-	.word	. - es3_sdrc_fix
-
 /* Function to call rom code to save secure ram context */
 ENTRY(save_secure_ram_context)
 	stmfd	sp!, {r1-r12, lr}	@ save registers on stack
-save_secure_ram_debug:
-	/* b save_secure_ram_debug */	@ enable to debug save code
 	adr	r3, api_params		@ r3 points to parameters
 	str	r0, [r3,#0x4]		@ r0 has sdram address
 	ldr	r12, high_mask
@@ -208,36 +177,152 @@ api_params:
 ENTRY(save_secure_ram_context_sz)
 	.word	. - save_secure_ram_context
 
+
+/*
+ * ======================
+ * == Idle entry point ==
+ * ======================
+ */
+
 /*
  * Forces OMAP into idle state
  *
- * omap34xx_suspend() - This bit of code just executes the WFI
- * for normal idles.
+ * omap34xx_suspend() - This bit of code saves the CPU context if needed
+ * and executes the WFI instruction
+ *
+ * Note: This code get's copied to internal SRAM at boot.
  *
- * Note: This code get's copied to internal SRAM at boot. When the OMAP
- *	 wakes up it continues execution at the point it went to sleep.
+ * Note: When the OMAP wakes up it continues at different execution points,
+ *  depending on the low power mode (non-OFF vs OFF modes),
+ *  cf. 'Resume path for xxx mode' comments.
  */
 ENTRY(omap34xx_cpu_suspend)
 	stmfd	sp!, {r0-r12, lr}		@ save registers on stack
-loop:
-	/*b	loop*/	@Enable to debug by stepping through code
+
 	/* r0 contains restore pointer in sdram */
-	/* r1 contains information about saving context */
-	ldr     r4, sdrc_power          @ read the SDRC_POWER register
-	ldr     r5, [r4]                @ read the contents of SDRC_POWER
-	orr     r5, r5, #0x40           @ enable self refresh on idle req
-	str     r5, [r4]                @ write back to SDRC_POWER register
+	/* r1 contains information about saving context: */
+	/*   1 - Only L1 and logic lost */
+	/*   2 - Only L2 lost */
+	/*   3 - Both L1 and L2 lost */
 
+	/* Save context only if required */
 	cmp	r1, #0x0
-	/* If context save is required, do that and execute wfi */
-	bne	save_context_wfi
+	beq	omap3_do_wfi
+
+save_context_wfi:
+	mov	r8, r0			@ Store SDRAM address in r8
+	mrc	p15, 0, r5, c1, c0, 1	@ Read Auxiliary Control Register
+	mov	r4, #0x1		@ Number of parameters for restore call
+	stmia	r8!, {r4-r5}		@ Push parameters for restore call
+	mrc	p15, 1, r5, c9, c0, 2	@ Read L2 AUX ctrl register
+	stmia	r8!, {r4-r5}		@ Push parameters for restore call
+
+        /* Check what that target sleep state is:stored in r1*/
+        /* 1 - Only L1 and logic lost */
+        /* 2 - Only L2 lost */
+        /* 3 - Both L1 and L2 lost */
+	cmp	r1, #0x2		@ Only L2 lost, no need to save context
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
+	mrc	p15, 0, r4, c1, c0, 0
+	/* save control register */
+	stmia	r8!, {r4}
+
+clean_caches:
+	/* Clean Data or unified cache to POU*/
+	/* How to invalidate only L1 cache???? - #FIX_ME# */
+	/* mcr	p15, 0, r11, c7, c11, 1 */
+	cmp	r1, #0x1 		@ Check whether L2 inval is required
+	beq	omap3_do_wfi
+
+clean_l2:
+	/*
+	 * jump out to kernel flush routine
+	 *  - reuse that code is better
+	 *  - it executes in a cached space so is faster than refetch per-block
+	 *  - should be faster and will change with kernel
+	 *  - 'might' have to copy address, load and jump to it
+	 */
+	ldr r1, kernel_flush
+	mov lr, pc
+	bx  r1
+
+omap3_do_wfi:
+	ldr	r4, sdrc_power		@ read the SDRC_POWER register
+	ldr	r5, [r4]		@ read the contents of SDRC_POWER
+	orr	r5, r5, #0x40		@ enable self refresh on idle req
+	str	r5, [r4]		@ write back to SDRC_POWER register
+
 	/* Data memory barrier and Data sync barrier */
 	mov	r1, #0
 	mcr	p15, 0, r1, c7, c10, 4
 	mcr	p15, 0, r1, c7, c10, 5
 
+/*
+ * ===================================
+ * == WFI instruction => Enter idle ==
+ * ===================================
+ */
 	wfi				@ wait for interrupt
 
+/*
+ * ===================================
+ * == Resume path for non-OFF modes ==
+ * ===================================
+ */
 	nop
 	nop
 	nop
@@ -250,9 +335,30 @@ loop:
 	nop
 	bl wait_sdrc_ok
 
-	ldmfd	sp!, {r0-r12, pc}		@ restore regs and return
+/*
+ * ===================================
+ * == Exit point from non-OFF modes ==
+ * ===================================
+ */
+	ldmfd	sp!, {r0-r12, pc}	@ restore regs and return
+
+
+/*
+ * ==============================
+ * == Resume path for OFF mode ==
+ * ==============================
+ */
+
+/*
+ * The restore_* functions are called by the ROM code
+ *  when back from WFI in OFF mode.
+ * Cf. the get_*restore_pointer functions.
+ *
+ *  restore_es3: applies to 34xx >= ES3.0
+ *  restore_3630: applies to 36xx
+ *  restore: common code for 3xxx
+ */
 restore_es3:
-	/*b restore_es3*/		@ Enable to debug restore code
 	ldr	r5, pm_prepwstst_core_p
 	ldr	r4, [r5]
 	and	r4, r4, #0x3
@@ -272,7 +378,6 @@ copy_to_sram:
 	b	restore
 
 restore_3630:
-	/*b restore_es3630*/		@ Enable to debug restore code
 	ldr	r1, pm_prepwstst_core_p
 	ldr	r2, [r1]
 	and	r2, r2, #0x3
@@ -282,18 +387,19 @@ restore_3630:
 	ldr	r1, control_mem_rta
 	mov	r2, #OMAP36XX_RTA_DISABLE
 	str	r2, [r1]
-	/* Fall thru for the remaining logic */
+
+	/* Fall thru to common code for the remaining logic */
+
 restore:
-	/* b restore*/  @ Enable to debug restore code
-        /* Check what was the reason for mpu reset and store the reason in r9*/
-        /* 1 - Only L1 and logic lost */
-        /* 2 - Only L2 lost - In this case, we wont be here */
-        /* 3 - Both L1 and L2 lost */
+	/* Check what was the reason for mpu reset and store the reason in r9*/
+	/* 1 - Only L1 and logic lost */
+	/* 2 - Only L2 lost - In this case, we wont be here */
+	/* 3 - Both L1 and L2 lost */
 	ldr     r1, pm_pwstctrl_mpu
 	ldr	r2, [r1]
 	and     r2, r2, #0x3
 	cmp     r2, #0x0	@ Check if target power state was OFF or RET
-        moveq   r9, #0x3        @ MPU OFF => L1 and L2 lost
+	moveq   r9, #0x3        @ MPU OFF => L1 and L2 lost
 	movne	r9, #0x1	@ Only L1 and L2 lost => avoid L2 invalidation
 	bne	logic_l1_restore
 
@@ -309,23 +415,23 @@ skipl2dis:
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
-	ldr	r3, [r4, #0xBC]	@ r3 points to parameters
+	ldr	r3, [r4, #0xBC]		@ r3 points to parameters
 	mcr	p15, 0, r0, c7, c10, 4	@ data write barrier
 	mcr	p15, 0, r0, c7, c10, 5	@ data memory barrier
 	.word	0xE1600071		@ call SMI monitor (smi #1)
@@ -334,41 +440,42 @@ skipl2dis:
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
-	adds	r3, r3, #8	@ r3 points to parameters
+	adds	r3, r3, #8		@ r3 points to parameters
 	mcr	p15, 0, r0, c7, c10, 4	@ data write barrier
 	mcr	p15, 0, r0, c7, c10, 5	@ data memory barrier
 	.word	0xE1600071		@ call SMI monitor (smi #1)
 #endif
 	b	logic_l1_restore
+
 l2_inv_api_params:
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
 	ldr	r1, l2dis_3630
-	cmp	r1, #0x1	@ Do we need to re-enable L2 on 3630?
+	cmp	r1, #0x1		@ Do we need to re-enable L2 on 3630?
 	bne	skipl2reen
 	mrc	p15, 0, r1, c1, c0, 1
-	orr	r1, r1, #2	@ re-enable L2 cache
+	orr	r1, r1, #2		@ re-enable L2 cache
 	mcr	p15, 0, r1, c1, c0, 1
 skipl2reen:
 	mov	r1, #0
@@ -439,11 +546,11 @@ skipl2reen:
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
@@ -491,119 +598,70 @@ usettbr0:
 	and	r4, r2
 	mcr	p15, 0, r4, c1, c0, 0
 
+/*
+ * ==============================
+ * == Exit point from OFF mode ==
+ * ==============================
+ */
 	ldmfd	sp!, {r0-r12, pc}		@ restore regs and return
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
 
-	/* Store current cpsr*/
-	mrs	r2, cpsr
-	stmia	r8!, {r2}
-
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
-	/*
-	 * Jump out to kernel flush routine
-	 *  - reuse that code is better
-	 *  - it executes in a cached space so is faster than refetch per-block
-	 *  - should be faster and will change with kernel
-	 *  - 'might' have to copy address, load and jump to it
-	 */
-	ldr r1, kernel_flush
-	mov lr, pc
-	bx  r1
+/*
+ * Internal functions, for erratum i443 WA
+ */
 
-skip_l2_inval:
-	/* Data memory barrier and Data sync barrier */
-	mov     r1, #0
-	mcr     p15, 0, r1, c7, c10, 4
-	mcr     p15, 0, r1, c7, c10, 5
+/* This function implements the Erratum ID i443 WA, applies to 34xx >= ES3.0 */
+ENTRY(es3_sdrc_fix)
+	ldr	r4, sdrc_syscfg		@ get config addr
+	ldr	r5, [r4]		@ get value
+	tst	r5, #0x100		@ is part access blocked
+	it	eq
+	biceq	r5, r5, #0x100		@ clear bit if set
+	str	r5, [r4]		@ write back change
+	ldr	r4, sdrc_mr_0		@ get config addr
+	ldr	r5, [r4]		@ get value
+	str	r5, [r4]		@ write back change
+	ldr	r4, sdrc_emr2_0		@ get config addr
+	ldr	r5, [r4]		@ get value
+	str	r5, [r4]		@ write back change
+	ldr	r4, sdrc_manual_0	@ get config addr
+	mov	r5, #0x2		@ autorefresh command
+	str	r5, [r4]		@ kick off refreshes
+	ldr	r4, sdrc_mr_1		@ get config addr
+	ldr	r5, [r4]		@ get value
+	str	r5, [r4]		@ write back change
+	ldr	r4, sdrc_emr2_1		@ get config addr
+	ldr	r5, [r4]		@ get value
+	str	r5, [r4]		@ write back change
+	ldr	r4, sdrc_manual_1	@ get config addr
+	mov	r5, #0x2		@ autorefresh command
+	str	r5, [r4]		@ kick off refreshes
+	bx	lr
+sdrc_syscfg:
+	.word	SDRC_SYSCONFIG_P
+sdrc_mr_0:
+	.word	SDRC_MR_0_P
+sdrc_emr2_0:
+	.word	SDRC_EMR2_0_P
+sdrc_manual_0:
+	.word	SDRC_MANUAL_0_P
+sdrc_mr_1:
+	.word	SDRC_MR_1_P
+sdrc_emr2_1:
+	.word	SDRC_EMR2_1_P
+sdrc_manual_1:
+	.word	SDRC_MANUAL_1_P
+ENTRY(es3_sdrc_fix_sz)
+	.word	. - es3_sdrc_fix
 
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
+/*
+ * Internal function, for SDRC state restore
+ * before accessing the SDRAM.
+ *
+ * Only used at return from non-OFF mode. For OFF
+ * mode the ROM code configures the SDRC and
+ * the DPLL before calling the restore code directly
+ * from DDR.
+ */
 
 /* Make sure SDRC accesses are ok */
 wait_sdrc_ok:
@@ -615,48 +673,50 @@ wait_dpll3_lock:
 	tst	r5, #1
 	beq	wait_dpll3_lock
 
-        ldr     r4, cm_idlest1_core
+	ldr	r4, cm_idlest1_core
 wait_sdrc_ready:
-        ldr     r5, [r4]
-        tst     r5, #0x2
-        bne     wait_sdrc_ready
+	ldr	r5, [r4]
+	tst	r5, #0x2
+	bne	wait_sdrc_ready
 	/* allow DLL powerdown upon hw idle req */
-        ldr     r4, sdrc_power
-        ldr     r5, [r4]
-        bic     r5, r5, #0x40
-        str     r5, [r4]
+	ldr	r4, sdrc_power
+	ldr	r5, [r4]
+	bic	r5, r5, #0x40
+	str	r5, [r4]
+
 is_dll_in_lock_mode:
+	/* Is dll in lock mode? */
+	ldr	r4, sdrc_dlla_ctrl
+	ldr	r5, [r4]
+	tst	r5, #0x4
+	bxne	lr		@ Return if locked
 
-        /* Is dll in lock mode? */
-        ldr     r4, sdrc_dlla_ctrl
-        ldr     r5, [r4]
-        tst     r5, #0x4
-        bxne    lr
-        /* wait till dll locks */
+	/* wait till dll locks */
 wait_dll_lock_timed:
 	ldr	r4, wait_dll_lock_counter
 	add	r4, r4, #1
 	str	r4, wait_dll_lock_counter
 	ldr	r4, sdrc_dlla_status
-        mov	r6, #8		/* Wait 20uS for lock */
+	mov	r6, #8		@ Wait 20uS for lock
+
 wait_dll_lock:
 	subs	r6, r6, #0x1
 	beq	kick_dll
-        ldr     r5, [r4]
-        and     r5, r5, #0x4
-        cmp     r5, #0x4
-        bne     wait_dll_lock
-        bx      lr
+	ldr	r5, [r4]
+	and	r5, r5, #0x4
+	cmp	r5, #0x4
+	bne	wait_dll_lock
+	bx	lr		@ Return when locked
 
 	/* disable/reenable DLL if not locked */
 kick_dll:
 	ldr	r4, sdrc_dlla_ctrl
 	ldr	r5, [r4]
 	mov	r6, r5
-	bic	r6, #(1<<3)	/* disable dll */
+	bic	r6, #(1<<3)	@ disable dll
 	str	r6, [r4]
 	dsb
-	orr	r6, r6, #(1<<3)	/* enable dll */
+	orr	r6, r6, #(1<<3)	@ enable dll
 	str	r6, [r4]
 	dsb
 	ldr	r4, kick_counter
@@ -672,12 +732,8 @@ sdrc_dlla_status:
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
@@ -686,12 +742,6 @@ sram_base:
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
@@ -713,5 +763,6 @@ kick_counter:
 	.word	0
 wait_dll_lock_counter:
 	.word	0
+
 ENTRY(omap34xx_cpu_suspend_sz)
 	.word	. - omap34xx_cpu_suspend
-- 
1.7.2.3

