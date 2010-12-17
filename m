From: jean.pihet@newoldbits.com
Subject: [PATCH 1/7] OMAP3: remove unused code from the ASM sleep code
Date: Fri, 17 Dec 2010 11:08:20 +0100
Message-ID: <1292580506-4421-2-git-send-email-j-pihet@ti.com>
References: <1292580506-4421-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:58496 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903Ab0LQKIn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Dec 2010 05:08:43 -0500
Received: by wyb28 with SMTP id 28so447858wyb.19
        for <linux-omap@vger.kernel.org>; Fri, 17 Dec 2010 02:08:41 -0800 (PST)
In-Reply-To: <1292580506-4421-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Remove unused code:
- macros,
- variables,
- unused semaphore locking API. This API shall be added back
  when needed,
- infinite loops for debug.

Tested on N900 and Beagleboard with full RET and OFF modes,
using cpuidle and suspend.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/pm.h        |    1 -
 arch/arm/mach-omap2/sleep34xx.S |   58 ++++-----------------------------------
 2 files changed, 6 insertions(+), 53 deletions(-)

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
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index d2eda01..2191576 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -35,11 +35,7 @@
 
 #define SDRC_SCRATCHPAD_SEM_V	0xfa00291c
 
-#define PM_PREPWSTST_CORE_V	OMAP34XX_PRM_REGADDR(CORE_MOD, \
-				OMAP3430_PM_PREPWSTST)
 #define PM_PREPWSTST_CORE_P	0x48306AE8
-#define PM_PREPWSTST_MPU_V	OMAP34XX_PRM_REGADDR(MPU_MOD, \
-				OMAP3430_PM_PREPWSTST)
 #define PM_PWSTCTRL_MPU_P	OMAP3430_PRM_BASE + MPU_MOD + OMAP2_PM_PWSTCTRL
 #define CM_IDLEST1_CORE_V	OMAP34XX_CM_REGADDR(CORE_MOD, CM_IDLEST1)
 #define CM_IDLEST_CKGEN_V	OMAP34XX_CM_REGADDR(PLL_MOD, CM_IDLEST)
@@ -62,36 +58,10 @@
 #define SDRC_DLLA_STATUS_V	OMAP34XX_SDRC_REGADDR(SDRC_DLLA_STATUS)
 #define SDRC_DLLA_CTRL_V	OMAP34XX_SDRC_REGADDR(SDRC_DLLA_CTRL)
 
-        .text
-/* Function to acquire the semaphore in scratchpad */
-ENTRY(lock_scratchpad_sem)
-	stmfd	sp!, {lr}	@ save registers on stack
-wait_sem:
-	mov	r0,#1
-	ldr	r1, sdrc_scratchpad_sem
-wait_loop:
-	ldr	r2, [r1]	@ load the lock value
-	cmp	r2, r0		@ is the lock free ?
-	beq	wait_loop	@ not free...
-	swp	r2, r0, [r1]	@ semaphore free so lock it and proceed
-	cmp	r2, r0		@ did we succeed ?
-	beq	wait_sem	@ no - try again
-	ldmfd	sp!, {pc}	@ restore regs and return
-sdrc_scratchpad_sem:
-        .word SDRC_SCRATCHPAD_SEM_V
-ENTRY(lock_scratchpad_sem_sz)
-        .word   . - lock_scratchpad_sem
-
-        .text
-/* Function to release the scratchpad semaphore */
-ENTRY(unlock_scratchpad_sem)
-	stmfd	sp!, {lr}	@ save registers on stack
-	ldr	r3, sdrc_scratchpad_sem
-	mov	r2,#0
-	str	r2,[r3]
-	ldmfd	sp!, {pc}	@ restore regs and return
-ENTRY(unlock_scratchpad_sem_sz)
-        .word   . - unlock_scratchpad_sem
+
+/*
+ * API functions
+ */
 
 	.text
 /* Function call to get the restore pointer for resume from OFF */
@@ -178,8 +148,7 @@ ENTRY(es3_sdrc_fix_sz)
 /* Function to call rom code to save secure ram context */
 ENTRY(save_secure_ram_context)
 	stmfd	sp!, {r1-r12, lr}	@ save registers on stack
-save_secure_ram_debug:
-	/* b save_secure_ram_debug */	@ enable to debug save code
+
 	adr	r3, api_params		@ r3 points to parameters
 	str	r0, [r3,#0x4]		@ r0 has sdram address
 	ldr	r12, high_mask
@@ -219,8 +188,7 @@ ENTRY(save_secure_ram_context_sz)
  */
 ENTRY(omap34xx_cpu_suspend)
 	stmfd	sp!, {r0-r12, lr}		@ save registers on stack
-loop:
-	/*b	loop*/	@Enable to debug by stepping through code
+
 	/* r0 contains restore pointer in sdram */
 	/* r1 contains information about saving context */
 	ldr     r4, sdrc_power          @ read the SDRC_POWER register
@@ -252,7 +220,6 @@ loop:
 
 	ldmfd	sp!, {r0-r12, pc}		@ restore regs and return
 restore_es3:
-	/*b restore_es3*/		@ Enable to debug restore code
 	ldr	r5, pm_prepwstst_core_p
 	ldr	r4, [r5]
 	and	r4, r4, #0x3
@@ -272,7 +239,6 @@ copy_to_sram:
 	b	restore
 
 restore_3630:
-	/*b restore_es3630*/		@ Enable to debug restore code
 	ldr	r1, pm_prepwstst_core_p
 	ldr	r2, [r1]
 	and	r2, r2, #0x3
@@ -284,7 +250,6 @@ restore_3630:
 	str	r2, [r1]
 	/* Fall thru for the remaining logic */
 restore:
-	/* b restore*/  @ Enable to debug restore code
         /* Check what was the reason for mpu reset and store the reason in r9*/
         /* 1 - Only L1 and logic lost */
         /* 2 - Only L2 lost - In this case, we wont be here */
@@ -493,7 +458,6 @@ usettbr0:
 
 	ldmfd	sp!, {r0-r12, pc}		@ restore regs and return
 save_context_wfi:
-	/*b	save_context_wfi*/	@ enable to debug save code
 	mov	r8, r0 /* Store SDRAM address in r8 */
 	mrc	p15, 0, r5, c1, c0, 1	@ Read Auxiliary Control Register
 	mov	r4, #0x1		@ Number of parameters for restore call
@@ -672,12 +636,8 @@ sdrc_dlla_status:
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
@@ -686,12 +646,6 @@ sram_base:
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
-- 
1.7.1

