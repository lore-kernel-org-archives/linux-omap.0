From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: [PATCH 25/25] ARM: pm: omap34xx: convert to generic suspend/resume
 support
Date: Wed, 22 Jun 2011 16:16:58 +0100
Message-ID: <E1QZPAo-0002XO-9G@rmk-PC.arm.linux.org.uk>
References: <20110622150816.GT23234@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20110622150816.GT23234@n2100.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Convert sa11x0 to use the generic CPU suspend/resume support, rather
than implementing its own version.  Tested on 3430 LDP.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/pm34xx.c    |   39 ++----------
 arch/arm/mach-omap2/sleep34xx.S |  130 +-------------------------------------
 2 files changed, 11 insertions(+), 158 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index c155c9d..09e14cb 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -64,11 +64,6 @@ static inline bool is_suspending(void)
 }
 #endif
 
-/* Scratchpad offsets */
-#define OMAP343X_TABLE_ADDRESS_OFFSET	   0xc4
-#define OMAP343X_TABLE_VALUE_OFFSET	   0xc0
-#define OMAP343X_CONTROL_REG_VALUE_OFFSET  0xc8
-
 /* pm34xx errata defined in pm.h */
 u16 pm34xx_errata;
 
@@ -312,28 +307,9 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-/* Function to restore the table entry that was modified for enabling MMU */
-static void restore_table_entry(void)
+static void omap34xx_do_sram_idle(unsigned long save_state)
 {
-	void __iomem *scratchpad_address;
-	u32 previous_value, control_reg_value;
-	u32 *address;
-
-	scratchpad_address = OMAP2_L4_IO_ADDRESS(OMAP343X_SCRATCHPAD);
-
-	/* Get address of entry that was modified */
-	address = (u32 *)__raw_readl(scratchpad_address +
-				     OMAP343X_TABLE_ADDRESS_OFFSET);
-	/* Get the previous value which needs to be restored */
-	previous_value = __raw_readl(scratchpad_address +
-				     OMAP343X_TABLE_VALUE_OFFSET);
-	address = __va(address);
-	*address = previous_value;
-	flush_tlb_all();
-	control_reg_value = __raw_readl(scratchpad_address
-					+ OMAP343X_CONTROL_REG_VALUE_OFFSET);
-	/* This will enable caches and prediction */
-	set_cr(control_reg_value);
+	_omap_sram_idle(omap3_arm_context, save_state);
 }
 
 void omap_sram_idle(void)
@@ -436,8 +412,11 @@ void omap_sram_idle(void)
 	 * get saved. The restore path then reads from this
 	 * location and restores them back.
 	 */
-	_omap_sram_idle(omap3_arm_context, save_state);
-	cpu_init();
+	if (save_state == 1 || save_state == 3)
+		cpu_suspend(0, PHYS_OFFSET - PAGE_OFFSET, save_state,
+			    omap34xx_do_sram_idle);
+	else
+		omap34xx_do_sram_idle(save_state);
 
 	/* Restore normal SDRC POWER settings */
 	if (omap_rev() >= OMAP3430_REV_ES3_0 &&
@@ -445,10 +424,6 @@ void omap_sram_idle(void)
 	    core_next_state == PWRDM_POWER_OFF)
 		sdrc_write_reg(sdrc_pwr, SDRC_POWER);
 
-	/* Restore table entry modified during MMU restoration */
-	if (pwrdm_read_prev_pwrst(mpu_pwrdm) == PWRDM_POWER_OFF)
-		restore_table_entry();
-
 	/* CORE */
 	if (core_next_state < PWRDM_POWER_ON) {
 		core_prev_state = pwrdm_read_prev_pwrst(core_pwrdm);
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 12e9da2..6d1d083 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -211,37 +211,6 @@ save_context_wfi:
 	mrc	p15, 1, r5, c9, c0, 2	@ Read L2 AUX ctrl register
 	stmia	r8!, {r4-r5}		@ Push parameters for restore call
 
-        /* Check what that target sleep state is from r1 */
-	cmp	r1, #0x2		@ Only L2 lost, no need to save context
-	beq	clean_caches
-
-l1_logic_lost:
-	mov	r4, sp			@ Store sp
-	mrs	r5, spsr		@ Store spsr
-	mov	r6, lr			@ Store lr
-	stmia	r8!, {r4-r6}
-
-	mrc	p15, 0, r4, c1, c0, 2	@ Coprocessor access control register
-	mrc	p15, 0, r5, c2, c0, 0	@ TTBR0
-	mrc	p15, 0, r6, c2, c0, 1	@ TTBR1
-	mrc	p15, 0, r7, c2, c0, 2	@ TTBCR
-	stmia	r8!, {r4-r7}
-
-	mrc	p15, 0, r4, c3, c0, 0	@ Domain access Control Register
-	mrc	p15, 0, r5, c10, c2, 0	@ PRRR
-	mrc	p15, 0, r6, c10, c2, 1	@ NMRR
-	stmia	r8!,{r4-r6}
-
-	mrc	p15, 0, r4, c13, c0, 1	@ Context ID
-	mrc	p15, 0, r5, c13, c0, 2	@ User r/w thread and process ID
-	mrc	p15, 0, r6, c12, c0, 0	@ Secure or NS vector base address
-	mrs	r7, cpsr		@ Store current cpsr
-	stmia	r8!, {r4-r7}
-
-	mrc	p15, 0, r4, c1, c0, 0	@ save control register
-	stmia	r8!, {r4}
-
-clean_caches:
 	/*
 	 * jump out to kernel flush routine
 	 *  - reuse that code is better
@@ -473,102 +442,11 @@ skipl2reen:
 	 */
 	mcr	p15, 0, r1, c7, c5, 0
 
-	ldr	r4, scratchpad_base
-	ldr	r3, [r4,#0xBC]
-	adds	r3, r3, #16
-
-	ldmia	r3!, {r4-r6}
-	mov	sp, r4			@ Restore sp
-	msr	spsr_cxsf, r5		@ Restore spsr
-	mov	lr, r6			@ Restore lr
-
-	ldmia	r3!, {r4-r7}
-	mcr	p15, 0, r4, c1, c0, 2	@ Coprocessor access Control Register
-	mcr	p15, 0, r5, c2, c0, 0	@ TTBR0
-	mcr	p15, 0, r6, c2, c0, 1	@ TTBR1
-	mcr	p15, 0, r7, c2, c0, 2	@ TTBCR
-
-	ldmia	r3!,{r4-r6}
-	mcr	p15, 0, r4, c3, c0, 0	@ Domain access Control Register
-	mcr	p15, 0, r5, c10, c2, 0	@ PRRR
-	mcr	p15, 0, r6, c10, c2, 1	@ NMRR
-
-
-	ldmia	r3!,{r4-r7}
-	mcr	p15, 0, r4, c13, c0, 1	@ Context ID
-	mcr	p15, 0, r5, c13, c0, 2	@ User r/w thread and process ID
-	mrc	p15, 0, r6, c12, c0, 0	@ Secure or NS vector base address
-	msr	cpsr, r7		@ store cpsr
-
-	/* Enabling MMU here */
-	mrc	p15, 0, r7, c2, c0, 2 	@ Read TTBRControl
-	/* Extract N (0:2) bits and decide whether to use TTBR0 or TTBR1 */
-	and	r7, #0x7
-	cmp	r7, #0x0
-	beq	usettbr0
-ttbr_error:
-	/*
-	 * More work needs to be done to support N[0:2] value other than 0
-	 * So looping here so that the error can be detected
-	 */
-	b	ttbr_error
-usettbr0:
-	mrc	p15, 0, r2, c2, c0, 0
-	ldr	r5, ttbrbit_mask
-	and	r2, r5
-	mov	r4, pc
-	ldr	r5, table_index_mask
-	and	r4, r5			@ r4 = 31 to 20 bits of pc
-	/* Extract the value to be written to table entry */
-	ldr	r1, table_entry
-	/* r1 has the value to be written to table entry*/
-	add	r1, r1, r4
-	/* Getting the address of table entry to modify */
-	lsr	r4, #18
-	/* r2 has the location which needs to be modified */
-	add	r2, r4
-	/* Storing previous entry of location being modified */
-	ldr	r5, scratchpad_base
-	ldr	r4, [r2]
-	str	r4, [r5, #0xC0]
-	/* Modify the table entry */
-	str	r1, [r2]
-	/*
-	 * Storing address of entry being modified
-	 * - will be restored after enabling MMU
-	 */
-	ldr	r5, scratchpad_base
-	str	r2, [r5, #0xC4]
-
-	mov	r0, #0
-	mcr	p15, 0, r0, c7, c5, 4	@ Flush prefetch buffer
-	mcr	p15, 0, r0, c7, c5, 6	@ Invalidate branch predictor array
-	mcr	p15, 0, r0, c8, c5, 0	@ Invalidate instruction TLB
-	mcr	p15, 0, r0, c8, c6, 0	@ Invalidate data TLB
-	/*
-	 * Restore control register. This enables the MMU.
-	 * The caches and prediction are not enabled here, they
-	 * will be enabled after restoring the MMU table entry.
-	 */
-	ldmia	r3!, {r4}
-	/* Store previous value of control register in scratchpad */
-	str	r4, [r5, #0xC8]
-	ldr	r2, cache_pred_disable_mask
-	and	r4, r2
-	mcr	p15, 0, r4, c1, c0, 0
-	dsb
-	isb
-	ldr     r0, =restoremmu_on
-	bx      r0
-
-/*
- * ==============================
- * == Exit point from OFF mode ==
- * ==============================
- */
-restoremmu_on:
-	ldmfd	sp!, {r4 - r11, pc}	@ restore regs and return
+	/* Now branch to the common CPU resume function */
+	ldr	r0, =cpu_resume
+	bx	r0
 
+	.ltorg
 
 /*
  * Internal functions
-- 
1.7.4.4
