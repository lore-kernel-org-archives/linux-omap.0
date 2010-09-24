From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCH 2/2] OMAP3 PM: sleep code clean up
Date: Fri, 24 Sep 2010 16:17:19 +0530
Message-ID: <1285325239-6110-3-git-send-email-vishwanath.bs@ti.com>
References: <1285325239-6110-1-git-send-email-vishwanath.bs@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54036 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754106Ab0IXKtu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 06:49:50 -0400
In-Reply-To: <1285325239-6110-1-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vishwanath BS <vishwanath.bs@ti.com>, Kevin Hillman <khilman@deeprootsystems.com>

This patch has done some clean up of omap3 sleep code.
Basically all possible hardcodings are removed and code is Reorganized
into more logical buckets for better readability and instrumentation.

Tested on ZOOM3.

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
Cc: Kevin Hillman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/sleep34xx.S           |  377 ++++++++++++++---------------
 arch/arm/plat-omap/include/plat/control.h |    2 +
 2 files changed, 189 insertions(+), 190 deletions(-)

diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index ba53191..734f82a
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -33,17 +33,20 @@
 #include "prm.h"
 #include "sdrc.h"
 
-#define SDRC_SCRATCHPAD_SEM_V	0xfa00291c
+#define SDRC_SCRATCHPAD_SEM_OFFS	0xc
+#define SDRC_SCRATCHPAD_SEM_V	OMAP343X_SCRATCHPAD_REGADDR \
+							(SDRC_SCRATCHPAD_SEM_OFFS)
 
 #define PM_PREPWSTST_CORE_V	OMAP34XX_PRM_REGADDR(CORE_MOD, \
-				OMAP3430_PM_PREPWSTST)
-#define PM_PREPWSTST_CORE_P	0x48306AE8
+							OMAP3430_PM_PREPWSTST)
+#define PM_PREPWSTST_CORE_P	OMAP3430_PRM_BASE + CORE_MOD + \
+								OMAP3430_PM_PREPWSTST
 #define PM_PREPWSTST_MPU_V	OMAP34XX_PRM_REGADDR(MPU_MOD, \
 				OMAP3430_PM_PREPWSTST)
 #define PM_PWSTCTRL_MPU_P	OMAP3430_PRM_BASE + MPU_MOD + OMAP2_PM_PWSTCTRL
 #define CM_IDLEST1_CORE_V	OMAP34XX_CM_REGADDR(CORE_MOD, CM_IDLEST1)
-#define SRAM_BASE_P		0x40200000
-#define CONTROL_STAT		0x480022F0
+#define SRAM_BASE_P			0x40200000
+#define CONTROL_STAT		OMAP343X_CTRL_BASE + OMAP343X_CONTROL_STATUS
 #define SCRATCHPAD_MEM_OFFS	0x310 /* Move this as correct place is
 				       * available */
 #define SCRATCHPAD_BASE_P	(OMAP343X_CTRL_BASE + OMAP343X_CONTROL_MEM_WKUP\
@@ -184,29 +187,16 @@ api_params:
 ENTRY(save_secure_ram_context_sz)
 	.word	. - save_secure_ram_context
 
-/*
- * Forces OMAP into idle state
- *
- * omap34xx_suspend() - This bit of code just executes the WFI
- * for normal idles.
- *
- * Note: This code get's copied to internal SRAM at boot. When the OMAP
- *	 wakes up it continues execution at the point it went to sleep.
- */
-ENTRY(omap34xx_cpu_suspend)
+/* Function to execute WFI. When the MPU wakes up from retention
+ * or inactive mode, it continues execution just after wfi */
+ENTRY(omap34xx_do_wfi)
 	stmfd	sp!, {r0-r12, lr}		@ save registers on stack
-loop:
-	/*b	loop*/	@Enable to debug by stepping through code
-	/* r0 contains restore pointer in sdram */
-	/* r1 contains information about saving context */
+
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
@@ -225,8 +215,182 @@ loop:
 	nop
 	nop
 	bl wait_sdrc_ok
+	ldmfd	sp!, {r0-r12, pc}		@ restore regs and return
+
+/*
+ * Forces OMAP into idle state
+ *
+ * omap34xx_cpu_suspend() - This bit of code just executes the WFI
+ * for normal idles and saves the context before WFI on off modes.
+ *
+ */
+
+ENTRY(omap34xx_cpu_suspend)
+	stmfd	sp!, {r0-r12, lr}		@ save registers on stack
+loop:
+	/*b	loop*/	@Enable to debug by stepping through code
+	/* r0 contains restore pointer in sdram */
+	/* r1 contains information about saving context */
+
+	cmp	r1, #0x0
+	/* If context save is required, do that and execute wfi */
+	bne	save_context_wfi
+	bl omap34xx_do_wfi
 
 	ldmfd	sp!, {r0-r12, pc}		@ restore regs and return
+
+save_context_wfi:
+	/*b	save_context_wfi*/	@ enable to debug save code
+	mov	r8, r0 /* Store SDRAM address in r8 */
+	mrc	p15, 0, r5, c1, c0, 1	@ Read Auxiliary Control Register
+	mov	r4, #0x1		@ Number of parameters for restore call
+	stmia	r8!, {r4-r5}		@ Push parameters for restore call
+	mrc	p15, 1, r5, c9, c0, 2	@ Read L2 AUX ctrl register
+	stmia	r8!, {r4-r5}		@ Push parameters for restore call
+        /* Check what that target sleep state is:stored in r1*/
+        /* 1 - Only L1 and logic lost */
+        /* 2 - Only L2 lost */
+        /* 3 - Both L1 and L2 lost */
+	cmp	r1, #0x2 /* Only L2 lost */
+	beq	clean_l2
+	cmp	r1, #0x1 /* L2 retained */
+	/* r9 stores whether to clean L2 or not*/
+	moveq	r9, #0x0 /* Dont Clean L2 */
+	movne	r9, #0x1 /* Clean L2 */
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
+clean_caches:
+	/* Clean Data or unified cache to POU*/
+	/* How to invalidate only L1 cache???? - #FIX_ME# */
+	/* mcr	p15, 0, r11, c7, c11, 1 */
+	cmp	r9, #1 /* Check whether L2 inval is required or not*/
+	bne	skip_l2_inval
+clean_l2:
+	/* read clidr */
+	mrc     p15, 1, r0, c0, c0, 1
+	/* extract loc from clidr */
+	ands    r3, r0, #0x7000000
+	/* left align loc bit field */
+	mov     r3, r3, lsr #23
+	/* if loc is 0, then no need to clean */
+	beq     finished
+	/* start clean at cache level 0 */
+	mov     r10, #0
+loop1:
+	/* work out 3x current cache level */
+	add     r2, r10, r10, lsr #1
+	/* extract cache type bits from clidr*/
+	mov     r1, r0, lsr r2
+	/* mask of the bits for current cache only */
+	and     r1, r1, #7
+	/* see what cache we have at this level */
+	cmp     r1, #2
+	/* skip if no cache, or just i-cache */
+	blt     skip
+	/* select current cache level in cssr */
+	mcr     p15, 2, r10, c0, c0, 0
+	/* isb to sych the new cssr&csidr */
+	isb
+	/* read the new csidr */
+	mrc     p15, 1, r1, c0, c0, 0
+	/* extract the length of the cache lines */
+	and     r2, r1, #7
+	/* add 4 (line length offset) */
+	add     r2, r2, #4
+	ldr     r4, assoc_mask
+	/* find maximum number on the way size */
+	ands    r4, r4, r1, lsr #3
+	/* find bit position of way size increment */
+	clz     r5, r4
+	ldr     r7, numset_mask
+	/* extract max number of the index size*/
+	ands    r7, r7, r1, lsr #13
+loop2:
+	mov     r9, r4
+	/* create working copy of max way size*/
+loop3:
+	/* factor way and cache number into r11 */
+	orr     r11, r10, r9, lsl r5
+	/* factor index number into r11 */
+	orr     r11, r11, r7, lsl r2
+	/*clean & invalidate by set/way */
+	mcr     p15, 0, r11, c7, c10, 2
+	/* decrement the way*/
+	subs    r9, r9, #1
+	bge     loop3
+	/*decrement the index */
+	subs    r7, r7, #1
+	bge     loop2
+skip:
+	add     r10, r10, #2
+	/* increment cache number */
+	cmp     r3, r10
+	bgt     loop1
+finished:
+	/*swith back to cache level 0 */
+	mov     r10, #0
+	/* select current cache level in cssr */
+	mcr     p15, 2, r10, c0, c0, 0
+	isb
+skip_l2_inval:
+	bl omap34xx_do_wfi
+	ldmfd   sp!, {r0-r12, pc}
+
+/* This is where ROM code jumps when MPU comes out of off mode */
 restore_es3:
 	/*b restore_es3*/		@ Enable to debug restore code
 	ldr	r5, pm_prepwstst_core_p
@@ -437,175 +601,8 @@ usettbr0:
 	ldr	r2, cache_pred_disable_mask
 	and	r4, r2
 	mcr	p15, 0, r4, c1, c0, 0
-
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
-
-	/* Store current cpsr*/
-	mrs	r2, cpsr
-	stmia	r8!, {r2}
 
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
@@ -669,4 +666,4 @@ cache_pred_disable_mask:
 control_stat:
 	.word	CONTROL_STAT
 ENTRY(omap34xx_cpu_suspend_sz)
-	.word	. - omap34xx_cpu_suspend
+	.word   . - omap34xx_cpu_suspend
diff --git a/arch/arm/plat-omap/include/plat/control.h b/arch/arm/plat-omap/include/plat/control.h
index 46e166d..306259e 100644
--- a/arch/arm/plat-omap/include/plat/control.h
+++ b/arch/arm/plat-omap/include/plat/control.h
@@ -314,6 +314,8 @@
 #define OMAP343X_SCRATCHPAD_ROM		(OMAP343X_CTRL_BASE + 0x860)
 #define OMAP343X_SCRATCHPAD		(OMAP343X_CTRL_BASE + 0x910)
 #define OMAP343X_SCRATCHPAD_ROM_OFFSET	0x19C
+#define OMAP343X_SCRATCHPAD_REGADDR(reg)	\
+			OMAP2_L4_IO_ADDRESS(OMAP343X_SCRATCHPAD + reg)
 
 /* AM35XX_CONTROL_IPSS_CLK_CTRL bits */
 #define AM35XX_USBOTG_VBUSP_CLK_SHIFT   0
-- 
1.7.0.4

