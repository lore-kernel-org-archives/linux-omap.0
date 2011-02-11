From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 3/6] ARM: pm: convert PXA to generic suspend/resume support
Date: Fri, 11 Feb 2011 16:18:15 +0000
Message-ID: <E1PnvhH-0002yg-2M@rmk-PC.arm.linux.org.uk>
References: <20110211161626.GA31356@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34508 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757424Ab1BKQSc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Feb 2011 11:18:32 -0500
In-Reply-To: <20110211161626.GA31356@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>, Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-pxa/include/mach/pm.h |    5 +-
 arch/arm/mach-pxa/palmz72.c         |    2 +-
 arch/arm/mach-pxa/pm.c              |    5 -
 arch/arm/mach-pxa/pxa25x.c          |    4 +-
 arch/arm/mach-pxa/pxa27x.c          |    4 +-
 arch/arm/mach-pxa/pxa3xx.c          |    7 +-
 arch/arm/mach-pxa/sleep.S           |  191 +++--------------------------------
 arch/arm/mach-pxa/zeus.c            |    2 +-
 8 files changed, 26 insertions(+), 194 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/pm.h b/arch/arm/mach-pxa/include/mach/pm.h
index fd8360c..f15afe0 100644
--- a/arch/arm/mach-pxa/include/mach/pm.h
+++ b/arch/arm/mach-pxa/include/mach/pm.h
@@ -22,9 +22,8 @@ struct pxa_cpu_pm_fns {
 extern struct pxa_cpu_pm_fns *pxa_cpu_pm_fns;
 
 /* sleep.S */
-extern void pxa25x_cpu_suspend(unsigned int);
-extern void pxa27x_cpu_suspend(unsigned int);
-extern void pxa_cpu_resume(void);
+extern void pxa25x_cpu_suspend(unsigned int, long);
+extern void pxa27x_cpu_suspend(unsigned int, long);
 
 extern int pxa_pm_enter(suspend_state_t state);
 extern int pxa_pm_prepare(void);
diff --git a/arch/arm/mach-pxa/palmz72.c b/arch/arm/mach-pxa/palmz72.c
index 7bf4017..3010193 100644
--- a/arch/arm/mach-pxa/palmz72.c
+++ b/arch/arm/mach-pxa/palmz72.c
@@ -212,7 +212,7 @@ static unsigned long store_ptr;
 static int palmz72_pm_suspend(struct sys_device *dev, pm_message_t msg)
 {
 	/* setup the resume_info struct for the original bootloader */
-	palmz72_resume_info.resume_addr = (u32) pxa_cpu_resume;
+	palmz72_resume_info.resume_addr = (u32) cpu_resume;
 
 	/* Storing memory touched by ROM */
 	store_ptr = *PALMZ72_SAVE_DWORD;
diff --git a/arch/arm/mach-pxa/pm.c b/arch/arm/mach-pxa/pm.c
index 978e1b2..f377f0d 100644
--- a/arch/arm/mach-pxa/pm.c
+++ b/arch/arm/mach-pxa/pm.c
@@ -67,11 +67,6 @@ int pxa_pm_enter(suspend_state_t state)
 
 EXPORT_SYMBOL_GPL(pxa_pm_enter);
 
-unsigned long sleep_phys_sp(void *sp)
-{
-	return virt_to_phys(sp);
-}
-
 static int pxa_pm_valid(suspend_state_t state)
 {
 	if (pxa_cpu_pm_fns)
diff --git a/arch/arm/mach-pxa/pxa25x.c b/arch/arm/mach-pxa/pxa25x.c
index fbc5b77..0727e48 100644
--- a/arch/arm/mach-pxa/pxa25x.c
+++ b/arch/arm/mach-pxa/pxa25x.c
@@ -244,7 +244,7 @@ static void pxa25x_cpu_pm_enter(suspend_state_t state)
 
 	switch (state) {
 	case PM_SUSPEND_MEM:
-		pxa25x_cpu_suspend(PWRMODE_SLEEP);
+		pxa25x_cpu_suspend(PWRMODE_SLEEP, PLAT_PHYS_OFFSET - PAGE_OFFSET);
 		break;
 	}
 }
@@ -252,7 +252,7 @@ static void pxa25x_cpu_pm_enter(suspend_state_t state)
 static int pxa25x_cpu_pm_prepare(void)
 {
 	/* set resume return address */
-	PSPR = virt_to_phys(pxa_cpu_resume);
+	PSPR = virt_to_phys(cpu_resume);
 	return 0;
 }
 
diff --git a/arch/arm/mach-pxa/pxa27x.c b/arch/arm/mach-pxa/pxa27x.c
index 987301f..28b11be 100644
--- a/arch/arm/mach-pxa/pxa27x.c
+++ b/arch/arm/mach-pxa/pxa27x.c
@@ -300,7 +300,7 @@ void pxa27x_cpu_pm_enter(suspend_state_t state)
 		pxa_cpu_standby();
 		break;
 	case PM_SUSPEND_MEM:
-		pxa27x_cpu_suspend(pwrmode);
+		pxa27x_cpu_suspend(pwrmode, PLAT_PHYS_OFFSET - PAGE_OFFSET);
 		break;
 	}
 }
@@ -313,7 +313,7 @@ static int pxa27x_cpu_pm_valid(suspend_state_t state)
 static int pxa27x_cpu_pm_prepare(void)
 {
 	/* set resume return address */
-	PSPR = virt_to_phys(pxa_cpu_resume);
+	PSPR = virt_to_phys(cpu_resume);
 	return 0;
 }
 
diff --git a/arch/arm/mach-pxa/pxa3xx.c b/arch/arm/mach-pxa/pxa3xx.c
index a7a19e1..1230343 100644
--- a/arch/arm/mach-pxa/pxa3xx.c
+++ b/arch/arm/mach-pxa/pxa3xx.c
@@ -142,8 +142,7 @@ static void pxa3xx_cpu_pm_suspend(void)
 	volatile unsigned long *p = (volatile void *)0xc0000000;
 	unsigned long saved_data = *p;
 
-	extern void pxa3xx_cpu_suspend(void);
-	extern void pxa3xx_cpu_resume(void);
+	extern void pxa3xx_cpu_suspend(long);
 
 	/* resuming from D2 requires the HSIO2/BOOT/TPM clocks enabled */
 	CKENA |= (1 << CKEN_BOOT) | (1 << CKEN_TPM);
@@ -161,9 +160,9 @@ static void pxa3xx_cpu_pm_suspend(void)
 	PSPR = 0x5c014000;
 
 	/* overwrite with the resume address */
-	*p = virt_to_phys(pxa3xx_cpu_resume);
+	*p = virt_to_phys(cpu_resume);
 
-	pxa3xx_cpu_suspend();
+	pxa3xx_cpu_suspend(PLAT_PHYS_OFFSET - PAGE_OFFSET);
 
 	*p = saved_data;
 
diff --git a/arch/arm/mach-pxa/sleep.S b/arch/arm/mach-pxa/sleep.S
index c551da8..6f53688 100644
--- a/arch/arm/mach-pxa/sleep.S
+++ b/arch/arm/mach-pxa/sleep.S
@@ -22,133 +22,26 @@
 
 		.text
 
-pxa_cpu_save_cp:
-	@ get coprocessor registers
-	mrc	p14, 0, r3, c6, c0, 0		@ clock configuration, for turbo mode
-	mrc	p15, 0, r4, c15, c1, 0		@ CP access reg
-	mrc	p15, 0, r5, c13, c0, 0		@ PID
-	mrc 	p15, 0, r6, c3, c0, 0		@ domain ID
-	mrc 	p15, 0, r7, c2, c0, 0		@ translation table base addr
-	mrc	p15, 0, r8, c1, c1, 0           @ auxiliary control reg
-	mrc 	p15, 0, r9, c1, c0, 0		@ control reg
-
-	bic	r3, r3, #2			@ clear frequency change bit
-
-	@ store them plus current virtual stack ptr on stack
-	mov	r10, sp
-	stmfd	sp!, {r3 - r10}
-
-	mov	pc, lr
-
-pxa_cpu_save_sp:
-	@ preserve phys address of stack
-	mov	r0, sp
-	str	lr, [sp, #-4]!
-	bl	sleep_phys_sp
-	ldr	r1, =sleep_save_sp
-	str	r0, [r1]
-	ldr	pc, [sp], #4
-
 #ifdef CONFIG_PXA3xx
 /*
  * pxa3xx_cpu_suspend() - forces CPU into sleep state (S2D3C4)
  *
- * NOTE:  unfortunately, pxa_cpu_save_cp can not be reused here since
- * the auxiliary control register address is different between pxa3xx
- * and pxa{25x,27x}
+ * r0 = v:p offset
  */
-
 ENTRY(pxa3xx_cpu_suspend)
 
 #ifndef CONFIG_IWMMXT
 	mra	r2, r3, acc0
 #endif
 	stmfd	sp!, {r2 - r12, lr}	@ save registers on stack
-
-	mrc	p14, 0, r3, c6, c0, 0		@ clock configuration, for turbo mode
-	mrc	p15, 0, r4, c15, c1, 0		@ CP access reg
-	mrc	p15, 0, r5, c13, c0, 0		@ PID
-	mrc 	p15, 0, r6, c3, c0, 0		@ domain ID
-	mrc 	p15, 0, r7, c2, c0, 0		@ translation table base addr
-	mrc	p15, 0, r8, c1, c0, 1           @ auxiliary control reg
-	mrc 	p15, 0, r9, c1, c0, 0		@ control reg
-
-	bic	r3, r3, #2			@ clear frequency change bit
-
-	@ store them plus current virtual stack ptr on stack
-	mov	r10, sp
-	stmfd	sp!, {r3 - r10}
-
-	@ store physical address of stack pointer
-	mov	r0, sp
-	bl	sleep_phys_sp
-	ldr	r1, =sleep_save_sp
-	str	r0, [r1]
-
-	@ clean data cache
-	bl	xsc3_flush_kern_cache_all
+	mov	r1, r0
+	ldr	r3, =pxa_cpu_resume	@ resume function
+	bl	cpu_suspend
 
 	mov	r0, #0x06		@ S2D3C4 mode
 	mcr	p14, 0, r0, c7, c0, 0	@ enter sleep
 
 20:	b	20b			@ waiting for sleep
-
-	.data
-	.align 5
-/*
- * pxa3xx_cpu_resume
- */
-
-ENTRY(pxa3xx_cpu_resume)
-
-	mov	r0, #PSR_I_BIT | PSR_F_BIT | SVC_MODE	@ set SVC, irqs off
-	msr	cpsr_c, r0
-
-	ldr	r0, sleep_save_sp		@ stack phys addr
-	ldmfd	r0, {r3 - r9, sp}		@ CP regs + virt stack ptr
-
-	mov	r1, #0
-	mcr	p15, 0, r1, c7, c7, 0		@ invalidate I & D caches, BTB
-	mcr	p15, 0, r1, c7, c10, 4		@ drain write (&fill) buffer
-	mcr	p15, 0, r1, c7, c5, 4		@ flush prefetch buffer
-	mcr	p15, 0, r1, c8, c7, 0   	@ invalidate I & D TLBs
-
-	mcr	p14, 0, r3, c6, c0, 0		@ clock configuration, turbo mode.
-	mcr	p15, 0, r4, c15, c1, 0		@ CP access reg
-	mcr	p15, 0, r5, c13, c0, 0		@ PID
-	mcr 	p15, 0, r6, c3, c0, 0		@ domain ID
-	mcr 	p15, 0, r7, c2, c0, 0		@ translation table base addr
-	mcr	p15, 0, r8, c1, c0, 1           @ auxiliary control reg
-
-	@ temporarily map resume_turn_on_mmu into the page table,
-	@ otherwise prefetch abort occurs after MMU is turned on
-	mov	r1, r7
-	bic	r1, r1, #0x00ff
-	bic	r1, r1, #0x3f00
-	ldr	r2, =0x542e
-
-	adr	r3, resume_turn_on_mmu
-	mov	r3, r3, lsr #20
-	orr	r4, r2, r3, lsl #20
-	ldr	r5, [r1, r3, lsl #2]
-	str     r4, [r1, r3, lsl #2]
-
-	@ Mapping page table address in the page table
-	mov	r6, r1, lsr #20
-	orr	r7, r2, r6, lsl #20
-	ldr	r8, [r1, r6, lsl #2]
-	str	r7, [r1, r6, lsl #2]
-
-	ldr	r2, =pxa3xx_resume_after_mmu	@ absolute virtual address
-	b	resume_turn_on_mmu		@ cache align execution
-
-	.text
-pxa3xx_resume_after_mmu:
-	/* restore the temporary mapping */
-	str	r5, [r1, r3, lsl #2]
-	str	r8, [r1, r6, lsl #2]
-	b	resume_after_mmu
-
 #endif /* CONFIG_PXA3xx */
 
 #ifdef CONFIG_PXA27x
@@ -158,28 +51,23 @@ pxa3xx_resume_after_mmu:
  * Forces CPU into sleep state.
  *
  * r0 = value for PWRMODE M field for desired sleep state
+ * r1 = v:p offset
  */
-
 ENTRY(pxa27x_cpu_suspend)
 
 #ifndef CONFIG_IWMMXT
 	mra	r2, r3, acc0
 #endif
 	stmfd	sp!, {r2 - r12, lr}		@ save registers on stack
-
-	bl	pxa_cpu_save_cp
-
-	mov	r5, r0				@ save sleep mode
-	bl	pxa_cpu_save_sp
-
-	@ clean data cache
-	bl	xscale_flush_kern_cache_all
+	mov	r4, r0				@ save sleep mode
+	ldr	r3, =pxa_cpu_resume		@ resume function
+	bl	cpu_suspend
 
 	@ Put the processor to sleep
 	@ (also workaround for sighting 28071)
 
 	@ prepare value for sleep mode
-	mov	r1, r5				@ sleep mode
+	mov	r1, r4				@ sleep mode
 
 	@ prepare pointer to physical address 0 (virtual mapping in generic.c)
 	mov	r2, #UNCACHED_PHYS_0
@@ -216,21 +104,16 @@ ENTRY(pxa27x_cpu_suspend)
  * Forces CPU into sleep state.
  *
  * r0 = value for PWRMODE M field for desired sleep state
+ * r1 = v:p offset
  */
 
 ENTRY(pxa25x_cpu_suspend)
 	stmfd	sp!, {r2 - r12, lr}		@ save registers on stack
-
-	bl	pxa_cpu_save_cp
-
-	mov	r5, r0				@ save sleep mode
-	bl	pxa_cpu_save_sp
-
-	@ clean data cache
-	bl	xscale_flush_kern_cache_all
-
+	mov	r4, r0				@ save sleep mode
+	ldr	r3, =pxa_cpu_resume		@ resume function
+	bl	cpu_suspend
 	@ prepare value for sleep mode
-	mov	r1, r5				@ sleep mode
+	mov	r1, r4				@ sleep mode
 
 	@ prepare pointer to physical address 0 (virtual mapping in generic.c)
 	mov	r2, #UNCACHED_PHYS_0
@@ -317,53 +200,9 @@ pxa_cpu_do_suspend:
  * pxa_cpu_resume()
  *
  * entry point from bootloader into kernel during resume
- *
- * Note: Yes, part of the following code is located into the .data section.
- *       This is to allow sleep_save_sp to be accessed with a relative load
- *       while we can't rely on any MMU translation.  We could have put
- *       sleep_save_sp in the .text section as well, but some setups might
- *       insist on it to be truly read-only.
  */
-
-	.data
-	.align 5
-ENTRY(pxa_cpu_resume)
-	mov	r0, #PSR_I_BIT | PSR_F_BIT | SVC_MODE	@ set SVC, irqs off
-	msr	cpsr_c, r0
-
-	ldr	r0, sleep_save_sp		@ stack phys addr
-	ldr	r2, =resume_after_mmu		@ its absolute virtual address
-	ldmfd	r0, {r3 - r9, sp}		@ CP regs + virt stack ptr
-
-	mov	r1, #0
-	mcr	p15, 0, r1, c8, c7, 0   	@ invalidate I & D TLBs
-	mcr	p15, 0, r1, c7, c7, 0		@ invalidate I & D caches, BTB
-
-	mcr	p14, 0, r3, c6, c0, 0		@ clock configuration, turbo mode.
-	mcr	p15, 0, r4, c15, c1, 0		@ CP access reg
-	mcr	p15, 0, r5, c13, c0, 0		@ PID
-	mcr 	p15, 0, r6, c3, c0, 0		@ domain ID
-	mcr 	p15, 0, r7, c2, c0, 0		@ translation table base addr
-	mcr	p15, 0, r8, c1, c1, 0           @ auxiliary control reg
-	b	resume_turn_on_mmu		@ cache align execution
-
 	.align 5
-resume_turn_on_mmu:
-	mcr 	p15, 0, r9, c1, c0, 0		@ turn on MMU, caches, etc.
-
-	@ Let us ensure we jump to resume_after_mmu only when the mcr above
-	@ actually took effect.  They call it the "cpwait" operation.
-	mrc	p15, 0, r0, c2, c0, 0		@ queue a dependency on CP15
-	sub	pc, r2, r0, lsr #32		@ jump to virtual addr
-	nop
-	nop
-	nop
-
-sleep_save_sp:
-	.word	0				@ preserve stack phys ptr here
-
-	.text
-resume_after_mmu:
+pxa_cpu_resume:
 	ldmfd	sp!, {r2, r3}
 #ifndef CONFIG_IWMMXT
 	mar	acc0, r2, r3
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index f4b053b..b92aa3b 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -676,7 +676,7 @@ static struct pxa2xx_udc_mach_info zeus_udc_info = {
 static void zeus_power_off(void)
 {
 	local_irq_disable();
-	pxa27x_cpu_suspend(PWRMODE_DEEPSLEEP);
+	pxa27x_cpu_suspend(PWRMODE_DEEPSLEEP, PLAT_PHYS_OFFSET - PAGE_OFFSET);
 }
 #else
 #define zeus_power_off   NULL
-- 
1.6.2.5

