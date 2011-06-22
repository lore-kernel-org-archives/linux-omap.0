From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 08/25] ARM: pm: convert cpu_suspend() to a normal function
Date: Wed, 22 Jun 2011 16:11:12 +0100
Message-ID: <E1QZP5E-0002WG-KU@rmk-PC.arm.linux.org.uk>
References: <20110622150816.GT23234@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20110622150816.GT23234@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

cpu_suspend() has a weird calling method which makes it only possible to
call from assembly code: it returns with a modified stack pointer to
finish the suspend, but on resume, it 'returns' via a provided pointer.

We can make cpu_suspend() appear to be a normal function merely by
swapping the resume pointer argument and the link register.

Do so, and update all callers to take account of this more traditional
behaviour.

Acked-by: Frank Hofmann <frank.hofmann@tomtom.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/system.h |    2 ++
 arch/arm/kernel/sleep.S       |   10 ++++------
 arch/arm/mach-exynos4/sleep.S |    7 +++----
 arch/arm/mach-pxa/sleep.S     |   13 ++++++++++---
 arch/arm/mach-s3c64xx/sleep.S |    9 +++------
 arch/arm/mach-s5pv210/sleep.S |    7 +++----
 arch/arm/mach-sa1100/sleep.S  |   15 ++++-----------
 arch/arm/plat-s3c24xx/sleep.S |   10 +++-------
 8 files changed, 32 insertions(+), 41 deletions(-)

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 832888d..50be605 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -106,6 +106,8 @@ extern void __show_regs(struct pt_regs *);
 
 extern int cpu_architecture(void);
 extern void cpu_init(void);
+extern void cpu_suspend(int, long, unsigned long, void (*)(unsigned long));
+extern void cpu_resume(void);
 
 void arm_machine_restart(char mode, const char *cmd);
 extern void (*arm_pm_restart)(char str, const char *cmd);
diff --git a/arch/arm/kernel/sleep.S b/arch/arm/kernel/sleep.S
index b924bcc..e062677 100644
--- a/arch/arm/kernel/sleep.S
+++ b/arch/arm/kernel/sleep.S
@@ -11,13 +11,11 @@
  * Save CPU state for a suspend
  *  r1 = v:p offset
  *  r2 = suspend function arg0
- *  r3 = virtual return function
- * Note: sp is decremented to allocate space for CPU state on stack
- * r0-r3,ip,lr corrupted
+ *  r3 = suspend function
+ * Note: does not return until system resumes
  */
 ENTRY(cpu_suspend)
-	stmfd	sp!, {r3}
-	stmfd	sp!, {r4 - r11}
+	stmfd	sp!, {r4 - r11, lr}
 #ifdef MULTI_CPU
 	ldr	r10, =processor
 	ldr	r5, [r10, #CPU_SLEEP_SIZE] @ size of CPU sleep state
@@ -33,7 +31,7 @@ ENTRY(cpu_suspend)
 	stmfd	sp!, {r1, r6, ip}	@ save v:p, virt SP, phys resume fn
 	ldr	r5, =sleep_save_sp
 	add	r6, sp, r1		@ convert SP to phys
-	stmfd	sp!, {r2, lr}		@ save suspend func arg and pointer
+	stmfd	sp!, {r2, r3}		@ save suspend func arg and pointer
 #ifdef CONFIG_SMP
 	ALT_SMP(mrc p15, 0, lr, c0, c0, 5)
 	ALT_UP(mov lr, #0)
diff --git a/arch/arm/mach-exynos4/sleep.S b/arch/arm/mach-exynos4/sleep.S
index 6b62425..d9a2287 100644
--- a/arch/arm/mach-exynos4/sleep.S
+++ b/arch/arm/mach-exynos4/sleep.S
@@ -42,16 +42,15 @@
 ENTRY(s3c_cpu_save)
 
 	stmfd	sp!, { r3 - r12, lr }
-	ldr	r3, =resume_with_mmu
+	adr	r3, BSYM(exynos4_finish_suspend)
 	bl	cpu_suspend
+	ldmfd	sp!, { r3 - r12, pc }
 
+exynos4_finish_suspend:
 	ldr	r0, =pm_cpu_sleep
 	ldr	r0, [ r0 ]
 	mov	pc, r0
 
-resume_with_mmu:
-	ldmfd	sp!, { r3 - r12, pc }
-
 	.ltorg
 
 	/*
diff --git a/arch/arm/mach-pxa/sleep.S b/arch/arm/mach-pxa/sleep.S
index 613ddfa..3a67887 100644
--- a/arch/arm/mach-pxa/sleep.S
+++ b/arch/arm/mach-pxa/sleep.S
@@ -35,9 +35,11 @@ ENTRY(pxa3xx_cpu_suspend)
 #endif
 	stmfd	sp!, {r2 - r12, lr}	@ save registers on stack
 	mov	r1, r0
-	ldr	r3, =pxa_cpu_resume	@ resume function
+	adr	r3, BSYM(pxa3xx_finish_suspend)
 	bl	cpu_suspend
+	b	pxa_cpu_resume
 
+pxa3xx_finish_suspend:
 	mov	r0, #0x06		@ S2D3C4 mode
 	mcr	p14, 0, r0, c7, c0, 0	@ enter sleep
 
@@ -60,9 +62,11 @@ ENTRY(pxa27x_cpu_suspend)
 #endif
 	stmfd	sp!, {r2 - r12, lr}		@ save registers on stack
 	mov	r2, r0				@ save sleep mode
-	ldr	r3, =pxa_cpu_resume		@ resume function
+	adr	r3, BSYM(pxa27x_finish_suspend)
 	bl	cpu_suspend
+	b	pxa_cpu_resume
 
+pxa27x_finish_suspend:
 	@ Put the processor to sleep
 	@ (also workaround for sighting 28071)
 
@@ -110,8 +114,11 @@ ENTRY(pxa27x_cpu_suspend)
 ENTRY(pxa25x_cpu_suspend)
 	stmfd	sp!, {r2 - r12, lr}		@ save registers on stack
 	mov	r2, r0				@ save sleep mode
-	ldr	r3, =pxa_cpu_resume		@ resume function
+	adr	r3, BSYM(pxa25x_finish_suspend)
 	bl	cpu_suspend
+	b	pxa_cpu_resume
+
+pxa25x_finish_suspend:
 	@ prepare value for sleep mode
 	mov	r1, r0				@ sleep mode
 
diff --git a/arch/arm/mach-s3c64xx/sleep.S b/arch/arm/mach-s3c64xx/sleep.S
index 1f87732..dc4f582 100644
--- a/arch/arm/mach-s3c64xx/sleep.S
+++ b/arch/arm/mach-s3c64xx/sleep.S
@@ -36,18 +36,15 @@
 
 ENTRY(s3c_cpu_save)
 	stmfd	sp!, { r4 - r12, lr }
-	ldr	r3, =resume_with_mmu
+	adr	r3, BSYM(s3c64xx_finish_suspend)
 	bl	cpu_suspend
+	ldmfd	sp!, { r4 - r12, pc }
 
+s3c64xx_finish_suspend:
 	@@ call final suspend code
 	ldr	r0, =pm_cpu_sleep
 	ldr	pc, [r0]
 	
-	@@ return to the caller, after the MMU is turned on.
-	@@ restore the last bits of the stack and return.
-resume_with_mmu:
-	ldmfd	sp!, { r4 - r12, pc }	@ return, from sp from s3c_cpu_save
-
 	/* Sleep magic, the word before the resume entry point so that the
 	 * bootloader can check for a resumeable image. */
 
diff --git a/arch/arm/mach-s5pv210/sleep.S b/arch/arm/mach-s5pv210/sleep.S
index a3d6494..1182fc8 100644
--- a/arch/arm/mach-s5pv210/sleep.S
+++ b/arch/arm/mach-s5pv210/sleep.S
@@ -41,16 +41,15 @@
 ENTRY(s3c_cpu_save)
 
 	stmfd	sp!, { r3 - r12, lr }
-	ldr	r3, =resume_with_mmu
+	adr	r3, BSYM(s5pv210_finish_suspend)
 	bl	cpu_suspend
+	ldmfd	sp!, { r3 - r12, pc }
 
+s5pv210_finish_suspend:
 	ldr	r0, =pm_cpu_sleep
 	ldr	r0, [ r0 ]
 	mov	pc, r0
 
-resume_with_mmu:
-	ldmfd	sp!, { r3 - r12, pc }
-
 	.ltorg
 
 	/* sleep magic, to allow the bootloader to check for an valid
diff --git a/arch/arm/mach-sa1100/sleep.S b/arch/arm/mach-sa1100/sleep.S
index 04f2a61..214f4e2 100644
--- a/arch/arm/mach-sa1100/sleep.S
+++ b/arch/arm/mach-sa1100/sleep.S
@@ -31,9 +31,12 @@
 ENTRY(sa1100_cpu_suspend)
 	stmfd	sp!, {r4 - r12, lr}		@ save registers on stack
 	mov	r1, r0
-	ldr	r3, =sa1100_cpu_resume		@ return function
+	adr	r3, BSYM(sa1100_finish_suspend)
 	bl	cpu_suspend
+	mcr	p15, 0, r1, c15, c1, 2		@ enable clock switching
+	ldmfd	sp!, {r4 - r12, pc}		@ return to caller
 
+sa1100_finish_suspend:
 	@ disable clock switching
 	mcr	p15, 0, r1, c15, c2, 2
 
@@ -139,13 +142,3 @@ sa1110_sdram_controller_fix:
 	str	r13, [r12]
 
 20:	b	20b			@ loop waiting for sleep
-
-/*
- * cpu_sa1100_resume()
- *
- * entry point from bootloader into kernel during resume
- */
-	.align 5
-sa1100_cpu_resume:
-	mcr	p15, 0, r1, c15, c1, 2		@ enable clock switching
-	ldmfd	sp!, {r4 - r12, pc}		@ return to caller
diff --git a/arch/arm/plat-s3c24xx/sleep.S b/arch/arm/plat-s3c24xx/sleep.S
index fd7032f..f822e62 100644
--- a/arch/arm/plat-s3c24xx/sleep.S
+++ b/arch/arm/plat-s3c24xx/sleep.S
@@ -49,21 +49,17 @@
 
 ENTRY(s3c_cpu_save)
 	stmfd	sp!, { r4 - r12, lr }
-	ldr	r3, =resume_with_mmu
+	adr	r3, BSYM(s3c24xx_finish_suspend)
 	bl	cpu_suspend
+	ldmfd	sp!, { r4 - r12, pc }
 
+s3c24xx_finish_suspend:
 	@@ jump to final code to send system to sleep
 	ldr	r0, =pm_cpu_sleep
 	@@ldr	pc, [ r0 ]
 	ldr	r0, [ r0 ]
 	mov	pc, r0
 	
-	@@ return to the caller, after having the MMU
-	@@ turned on, this restores the last bits from the
-	@@ stack
-resume_with_mmu:
-	ldmfd	sp!, { r4 - r12, pc }
-
 	.ltorg
 
 	/* sleep magic, to allow the bootloader to check for an valid
-- 
1.7.4.4
