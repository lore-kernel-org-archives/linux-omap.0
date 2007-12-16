From: Vivek Kutal <vivek.kutal@celunite.com>
Subject: [PATCH] Remove omap_sram_idle()
Date: Sun, 16 Dec 2007 13:27:04 +0530
Message-ID: <11977918242059-git-send-email-vivek.kutal@celunite.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

	This patch removes omap_sram_idle().

Signed-off-by: Vivek Kutal <vivek.kutal@celunite.com>
---
 arch/arm/mach-omap1/pm.c    |    8 +--
 arch/arm/mach-omap1/sleep.S |  161 -------------------------------------------
 2 files changed, 1 insertions(+), 168 deletions(-)

diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
index 647c58e..c5a89cd 100644
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -676,23 +676,17 @@ static int __init omap_pm_init(void)
 	 * memory the MPU can see when it wakes up.
 	 */
 	if (cpu_is_omap730()) {
-		omap_sram_idle = omap_sram_push(omap730_idle_loop_suspend,
-						omap730_idle_loop_suspend_sz);
 		omap_sram_suspend = omap_sram_push(omap730_cpu_suspend,
 						   omap730_cpu_suspend_sz);
 	} else if (cpu_is_omap15xx()) {
-		omap_sram_idle = omap_sram_push(omap1510_idle_loop_suspend,
-						omap1510_idle_loop_suspend_sz);
 		omap_sram_suspend = omap_sram_push(omap1510_cpu_suspend,
 						   omap1510_cpu_suspend_sz);
 	} else if (cpu_is_omap16xx()) {
-		omap_sram_idle = omap_sram_push(omap1610_idle_loop_suspend,
-						omap1610_idle_loop_suspend_sz);
 		omap_sram_suspend = omap_sram_push(omap1610_cpu_suspend,
 						   omap1610_cpu_suspend_sz);
 	}
 
-	if (omap_sram_idle == NULL || omap_sram_suspend == NULL) {
+	if (omap_sram_suspend == NULL) {
 		printk(KERN_ERR "PM not initialized: Missing SRAM support\n");
 		return -ENODEV;
 	}
diff --git a/arch/arm/mach-omap1/sleep.S b/arch/arm/mach-omap1/sleep.S
index abef33d..68f5b39 100644
--- a/arch/arm/mach-omap1/sleep.S
+++ b/arch/arm/mach-omap1/sleep.S
@@ -39,167 +39,6 @@
 
 		.text
 
-/*
- * Forces OMAP into idle state
- *
- * omapXXXX_idle_loop_suspend()
- *
- * Note: This code get's copied to internal SRAM at boot. When the OMAP
- *	 wakes up it continues execution at the point it went to sleep.
- *
- * Note: Because of slightly different configuration values we have
- *       processor specific functions here.
- */
-
-#if defined(CONFIG_ARCH_OMAP730)
-ENTRY(omap730_idle_loop_suspend)
-
-	stmfd	sp!, {r0 - r12, lr}		@ save registers on stack
-
-	@ load base address of ARM_IDLECT1 and ARM_IDLECT2
-	mov	r4, #CLKGEN_REG_ASM_BASE & 0xff000000
-	orr	r4, r4, #CLKGEN_REG_ASM_BASE & 0x00ff0000
-	orr	r4, r4, #CLKGEN_REG_ASM_BASE & 0x0000ff00
-
-	@ turn off clock domains
-	@ get ARM_IDLECT2 into r2
-	ldrh	r2, [r4, #ARM_IDLECT2_ASM_OFFSET & 0xff]
-	mov	r5, #OMAP730_IDLECT2_SLEEP_VAL & 0xff
-	orr	r5, r5, #OMAP730_IDLECT2_SLEEP_VAL & 0xff00
-	strh	r5, [r4, #ARM_IDLECT2_ASM_OFFSET & 0xff]
-
-	@ request ARM idle
-	@ get ARM_IDLECT1 into r1
-	ldrh	r1, [r4, #ARM_IDLECT1_ASM_OFFSET & 0xff]
-	orr	r3, r1, #OMAP730_IDLE_LOOP_REQUEST & 0xffff
-	strh	r3, [r4, #ARM_IDLECT1_ASM_OFFSET & 0xff]
-
-	mov	r5, #IDLE_WAIT_CYCLES & 0xff
-	orr	r5, r5, #IDLE_WAIT_CYCLES & 0xff00
-l_730:	subs	r5, r5, #1
-	bne	l_730
-/*
- * Let's wait for the next clock tick to wake us up.
- */
-	mov	r0, #0
-	mcr	p15, 0, r0, c7, c0, 4		@ wait for interrupt
-/*
- * omap730_idle_loop_suspend()'s resume point.
- *
- * It will just start executing here, so we'll restore stuff from the
- * stack, reset the ARM_IDLECT1 and ARM_IDLECT2.
- */
-
-	@ restore ARM_IDLECT1 and ARM_IDLECT2 and return
-	@ r1 has ARM_IDLECT1 and r2 still has ARM_IDLECT2
-	strh	r2, [r4, #ARM_IDLECT2_ASM_OFFSET & 0xff]
-	strh	r1, [r4, #ARM_IDLECT1_ASM_OFFSET & 0xff]
-
-	ldmfd	sp!, {r0 - r12, pc}		@ restore regs and return
-
-ENTRY(omap730_idle_loop_suspend_sz)
-	.word	. - omap730_idle_loop_suspend
-#endif /* CONFIG_ARCH_OMAP730 */
-
-#ifdef CONFIG_ARCH_OMAP15XX
-ENTRY(omap1510_idle_loop_suspend)
-
-	stmfd	sp!, {r0 - r12, lr}		@ save registers on stack
-
-	@ load base address of ARM_IDLECT1 and ARM_IDLECT2
-	mov	r4, #CLKGEN_REG_ASM_BASE & 0xff000000
-	orr	r4, r4, #CLKGEN_REG_ASM_BASE & 0x00ff0000
-	orr	r4, r4, #CLKGEN_REG_ASM_BASE & 0x0000ff00
-
-	@ turn off clock domains
-	@ get ARM_IDLECT2 into r2
-	ldrh	r2, [r4, #ARM_IDLECT2_ASM_OFFSET & 0xff]
-	mov	r5, #OMAP1510_IDLE_CLOCK_DOMAINS & 0xff
-	orr	r5, r5, #OMAP1510_IDLE_CLOCK_DOMAINS & 0xff00
-	strh	r5, [r4, #ARM_IDLECT2_ASM_OFFSET & 0xff]
-
-	@ request ARM idle
-	@ get ARM_IDLECT1 into r1
-	ldrh	r1, [r4, #ARM_IDLECT1_ASM_OFFSET & 0xff]
-	orr	r3, r1, #OMAP1510_IDLE_LOOP_REQUEST & 0xffff
-	strh	r3, [r4, #ARM_IDLECT1_ASM_OFFSET & 0xff]
-
-	mov	r5, #IDLE_WAIT_CYCLES & 0xff
-	orr	r5, r5, #IDLE_WAIT_CYCLES & 0xff00
-l_1510:	subs	r5, r5, #1
-	bne	l_1510
-/*
- * Let's wait for the next clock tick to wake us up.
- */
-	mov	r0, #0
-	mcr	p15, 0, r0, c7, c0, 4		@ wait for interrupt
-/*
- * omap1510_idle_loop_suspend()'s resume point.
- *
- * It will just start executing here, so we'll restore stuff from the
- * stack, reset the ARM_IDLECT1 and ARM_IDLECT2.
- */
-
-	@ restore ARM_IDLECT1 and ARM_IDLECT2 and return
-	@ r1 has ARM_IDLECT1 and r2 still has ARM_IDLECT2
-	strh	r2, [r4, #ARM_IDLECT2_ASM_OFFSET & 0xff]
-	strh	r1, [r4, #ARM_IDLECT1_ASM_OFFSET & 0xff]
-
-	ldmfd	sp!, {r0 - r12, pc}		@ restore regs and return
-
-ENTRY(omap1510_idle_loop_suspend_sz)
-	.word	. - omap1510_idle_loop_suspend
-#endif /* CONFIG_ARCH_OMAP15XX */
-
-#if defined(CONFIG_ARCH_OMAP16XX)
-ENTRY(omap1610_idle_loop_suspend)
-
-	stmfd	sp!, {r0 - r12, lr}		@ save registers on stack
-
-	@ load base address of ARM_IDLECT1 and ARM_IDLECT2
-	mov	r4, #CLKGEN_REG_ASM_BASE & 0xff000000
-	orr	r4, r4, #CLKGEN_REG_ASM_BASE & 0x00ff0000
-	orr	r4, r4, #CLKGEN_REG_ASM_BASE & 0x0000ff00
-
-	@ turn off clock domains
-	@ get ARM_IDLECT2 into r2
-	ldrh	r2, [r4, #ARM_IDLECT2_ASM_OFFSET & 0xff]
-	mov	r5, #OMAP1610_IDLECT2_SLEEP_VAL & 0xff
-	orr	r5, r5, #OMAP1610_IDLECT2_SLEEP_VAL & 0xff00
-	strh	r5, [r4, #ARM_IDLECT2_ASM_OFFSET & 0xff]
-
-	@ request ARM idle
-	@ get ARM_IDLECT1 into r1
-	ldrh	r1, [r4, #ARM_IDLECT1_ASM_OFFSET & 0xff]
-	orr	r3, r1, #OMAP1610_IDLE_LOOP_REQUEST & 0xffff
-	strh	r3, [r4, #ARM_IDLECT1_ASM_OFFSET & 0xff]
-
-	mov	r5, #IDLE_WAIT_CYCLES & 0xff
-	orr	r5, r5, #IDLE_WAIT_CYCLES & 0xff00
-l_1610:	subs	r5, r5, #1
-	bne	l_1610
-/*
- * Let's wait for the next clock tick to wake us up.
- */
-	mov	r0, #0
-	mcr	p15, 0, r0, c7, c0, 4		@ wait for interrupt
-/*
- * omap1610_idle_loop_suspend()'s resume point.
- *
- * It will just start executing here, so we'll restore stuff from the
- * stack, reset the ARM_IDLECT1 and ARM_IDLECT2.
- */
-
-	@ restore ARM_IDLECT1 and ARM_IDLECT2 and return
-	@ r1 has ARM_IDLECT1 and r2 still has ARM_IDLECT2
-	strh	r2, [r4, #ARM_IDLECT2_ASM_OFFSET & 0xff]
-	strh	r1, [r4, #ARM_IDLECT1_ASM_OFFSET & 0xff]
-
-	ldmfd	sp!, {r0 - r12, pc}		@ restore regs and return
-
-ENTRY(omap1610_idle_loop_suspend_sz)
-	.word	. - omap1610_idle_loop_suspend
-#endif /* CONFIG_ARCH_OMAP16XX */
 
 /*
  * Forces OMAP into deep sleep state
-- 
1.5.2.5
