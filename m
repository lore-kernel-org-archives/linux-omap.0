From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 7/7] OMAP3: ASM sleep code format rework
Date: Fri, 17 Dec 2010 16:07:50 +0530
Message-ID: <7366f0d457f1b364a36e5fd7ededf15e@mail.gmail.com>
References: <1292580506-4421-1-git-send-email-j-pihet@ti.com> <1292580506-4421-8-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:37721 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751177Ab0LQKhw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Dec 2010 05:37:52 -0500
Received: by yib12 with SMTP id 12so36813yib.24
        for <linux-omap@vger.kernel.org>; Fri, 17 Dec 2010 02:37:51 -0800 (PST)
In-Reply-To: <1292580506-4421-8-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com, linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org, Jean Pihet-XID <j-pihet@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of jean.pihet@newoldbits.com
> Sent: Friday, December 17, 2010 3:38 PM
> To: linux-omap@vger.kernel.org
> Cc: khilman@deeprootsystems.com; linux-arm-kernel@lists.infradead.org;
> Jean Pihet
> Subject: [PATCH 7/7] OMAP3: ASM sleep code format rework
>
> From: Jean Pihet <j-pihet@ti.com>
>
> Cosmetic fixes to the code:
> - white spaces and tabs,
> - alignement,
> - comments rephrase and typos,
> - multi-line comments
>
> Tested on N900 and Beagleboard with full RET and OFF modes,
> using cpuidle and suspend.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

> ---
>  arch/arm/mach-omap2/sleep34xx.S |  226
+++++++++++++++++++++-------------
> -----
>  1 files changed, 122 insertions(+), 104 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-
> omap2/sleep34xx.S
> index 8e5004a..6376427 100644
> --- a/arch/arm/mach-omap2/sleep34xx.S
> +++ b/arch/arm/mach-omap2/sleep34xx.S
> @@ -1,6 +1,10 @@
>  /*
>   * linux/arch/arm/mach-omap2/sleep.S
>   *
> + * (C) Copyright 2010
> + * Texas Instruments
> + * Jean Pihet <j-pihet@ti.com>
> + *
>   * (C) Copyright 2007
>   * Texas Instruments
>   * Karthik Dasu <karthik-dp@ti.com>
> @@ -81,20 +85,20 @@
>  	.text
>  /* Function call to get the restore pointer for resume from OFF */
>  ENTRY(get_restore_pointer)
> -        stmfd   sp!, {lr}     @ save registers on stack
> +	stmfd	sp!, {lr}	@ save registers on stack
>  	adr	r0, restore
> -        ldmfd   sp!, {pc}     @ restore regs and return
> +	ldmfd	sp!, {pc}	@ restore regs and return
>  ENTRY(get_restore_pointer_sz)
> -        .word   . - get_restore_pointer
> +	.word	. - get_restore_pointer
>
>  	.text
>  /* Function call to get the restore pointer for 3630 resume from OFF */
>  ENTRY(get_omap3630_restore_pointer)
> -        stmfd   sp!, {lr}     @ save registers on stack
> +	stmfd	sp!, {lr}	@ save registers on stack
>  	adr	r0, restore_3630
> -        ldmfd   sp!, {pc}     @ restore regs and return
> +	ldmfd	sp!, {pc}	@ restore regs and return
>  ENTRY(get_omap3630_restore_pointer_sz)
> -        .word   . - get_omap3630_restore_pointer
> +	.word	. - get_omap3630_restore_pointer
>
>  	.text
>  /* Function call to get the restore pointer for ES3 to resume from OFF
*/
> @@ -112,16 +116,16 @@ ENTRY(get_es3_restore_pointer_sz)
>   * place on 3630. Hopefully some version in the future may not need
this.
>   */
>  ENTRY(enable_omap3630_toggle_l2_on_restore)
> -        stmfd   sp!, {lr}     @ save registers on stack
> +	stmfd	sp!, {lr}	@ save registers on stack
>  	/* Setup so that we will disable and enable l2 */
>  	mov	r1, #0x1
>  	str	r1, l2dis_3630
> -        ldmfd   sp!, {pc}     @ restore regs and return
> +	ldmfd	sp!, {pc}	@ restore regs and return
>
> +	.text
>  /* Function to call rom code to save secure ram context */
>  ENTRY(save_secure_ram_context)
>  	stmfd	sp!, {r1-r12, lr}	@ save registers on stack
> -
>  	adr	r3, api_params		@ r3 points to parameters
>  	str	r0, [r3,#0x4]		@ r0 has sdram address
>  	ldr	r12, high_mask
> @@ -150,6 +154,7 @@ api_params:
>  ENTRY(save_secure_ram_context_sz)
>  	.word	. - save_secure_ram_context
>
> +
>  /*
>   * ======================
>   * == Idle entry point ==
> @@ -163,13 +168,14 @@ ENTRY(save_secure_ram_context_sz)
>   * and executes the WFI instruction
>   *
>   * Notes:
> - * - this code gets copied to internal SRAM at boot.
> + * - this code gets copied to internal SRAM at boot and after wake-up
> + *   from OFF mode
>   * - when the OMAP wakes up it continues at different execution points
>   *   depending on the low power mode (non-OFF vs OFF modes),
>   *   cf. 'Resume path for xxx mode' comments.
>   */
>  ENTRY(omap34xx_cpu_suspend)
> -	stmfd	sp!, {r0-r12, lr}		@ save registers on stack
> +	stmfd	sp!, {r0-r12, lr}	@ save registers on stack
>
>  	/*
>  	 * r0 contains restore pointer in sdram
> @@ -276,9 +282,9 @@ clean_l2:
>  	 *  - should be faster and will change with kernel
>  	 *  - 'might' have to copy address, load and jump to it
>  	 */
> -	ldr r1, kernel_flush
> -	mov lr, pc
> -	bx  r1
> +	ldr	r1, kernel_flush
> +	mov	lr, pc
> +	bx	r1
>
>  omap3_do_wfi:
>  	ldr	r4, sdrc_power		@ read the SDRC_POWER register
> @@ -371,18 +377,18 @@ restore_3630:
>  	/* Fall thru to common code for the remaining logic */
>
>  restore:
> -        /*
> +	/*
>  	 * Check what was the reason for mpu reset and store the reason in
> r9:
>  	 *  0 - No context lost
> -         *  1 - Only L1 and logic lost
> -         *  2 - Only L2 lost - In this case, we wont be here
> -         *  3 - Both L1 and L2 lost
> +	 *  1 - Only L1 and logic lost
> +	 *  2 - Only L2 lost - In this case, we wont be here
> +	 *  3 - Both L1 and L2 lost
>  	 */
> -	ldr     r1, pm_pwstctrl_mpu
> +	ldr	r1, pm_pwstctrl_mpu
>  	ldr	r2, [r1]
> -	and     r2, r2, #0x3
> -	cmp     r2, #0x0	@ Check if target power state was OFF or
RET
> -        moveq   r9, #0x3        @ MPU OFF => L1 and L2 lost
> +	and	r2, r2, #0x3
> +	cmp	r2, #0x0	@ Check if target power state was OFF or
RET
> +	moveq	r9, #0x3	@ MPU OFF => L1 and L2 lost
>  	movne	r9, #0x1	@ Only L1 and L2 lost => avoid L2
invalidation
>  	bne	logic_l1_restore
>
> @@ -398,71 +404,74 @@ skipl2dis:
>  	and	r1, #0x700
>  	cmp	r1, #0x300
>  	beq	l2_inv_gp
> -	mov	r0, #40		@ set service ID for PPA
> -	mov	r12, r0		@ copy secure Service ID in r12
> -	mov	r1, #0		@ set task id for ROM code in r1
> -	mov	r2, #4		@ set some flags in r2, r6
> +	mov	r0, #40			@ set service ID for PPA
> +	mov	r12, r0			@ copy secure Service ID in r12
> +	mov	r1, #0			@ set task id for ROM code in r1
> +	mov	r2, #4			@ set some flags in r2, r6
>  	mov	r6, #0xff
>  	adr	r3, l2_inv_api_params	@ r3 points to dummy parameters
>  	mcr	p15, 0, r0, c7, c10, 4	@ data write barrier
>  	mcr	p15, 0, r0, c7, c10, 5	@ data memory barrier
>  	.word	0xE1600071		@ call SMI monitor (smi #1)
>  	/* Write to Aux control register to set some bits */
> -	mov	r0, #42		@ set service ID for PPA
> -	mov	r12, r0		@ copy secure Service ID in r12
> -	mov	r1, #0		@ set task id for ROM code in r1
> -	mov	r2, #4		@ set some flags in r2, r6
> +	mov	r0, #42			@ set service ID for PPA
> +	mov	r12, r0			@ copy secure Service ID in r12
> +	mov	r1, #0			@ set task id for ROM code in r1
> +	mov	r2, #4			@ set some flags in r2, r6
>  	mov	r6, #0xff
>  	ldr	r4, scratchpad_base
> -	ldr	r3, [r4, #0xBC]	@ r3 points to parameters
> +	ldr	r3, [r4, #0xBC]		@ r3 points to parameters
>  	mcr	p15, 0, r0, c7, c10, 4	@ data write barrier
>  	mcr	p15, 0, r0, c7, c10, 5	@ data memory barrier
>  	.word	0xE1600071		@ call SMI monitor (smi #1)
>
>  #ifdef CONFIG_OMAP3_L2_AUX_SECURE_SAVE_RESTORE
>  	/* Restore L2 aux control register */
> -	@ set service ID for PPA
> +					@ set service ID for PPA
>  	mov	r0, #CONFIG_OMAP3_L2_AUX_SECURE_SERVICE_SET_ID
> -	mov	r12, r0		@ copy service ID in r12
> -	mov	r1, #0		@ set task ID for ROM code in r1
> -	mov	r2, #4		@ set some flags in r2, r6
> +	mov	r12, r0			@ copy service ID in r12
> +	mov	r1, #0			@ set task ID for ROM code in r1
> +	mov	r2, #4			@ set some flags in r2, r6
>  	mov	r6, #0xff
>  	ldr	r4, scratchpad_base
>  	ldr	r3, [r4, #0xBC]
> -	adds	r3, r3, #8	@ r3 points to parameters
> +	adds	r3, r3, #8		@ r3 points to parameters
>  	mcr	p15, 0, r0, c7, c10, 4	@ data write barrier
>  	mcr	p15, 0, r0, c7, c10, 5	@ data memory barrier
>  	.word	0xE1600071		@ call SMI monitor (smi #1)
>  #endif
>  	b	logic_l1_restore
> +
>  l2_inv_api_params:
> -	.word   0x1, 0x00
> +	.word	0x1, 0x00
>  l2_inv_gp:
>  	/* Execute smi to invalidate L2 cache */
> -	mov r12, #0x1                         @ set up to invalide L2
> -smi:    .word 0xE1600070		@ Call SMI monitor (smieq)
> +	mov r12, #0x1			@ set up to invalidate L2
> +	.word 0xE1600070		@ Call SMI monitor (smieq)
>  	/* Write to Aux control register to set some bits */
>  	ldr	r4, scratchpad_base
>  	ldr	r3, [r4,#0xBC]
>  	ldr	r0, [r3,#4]
>  	mov	r12, #0x3
> -	.word 0xE1600070	@ Call SMI monitor (smieq)
> +	.word	0xE1600070		@ Call SMI monitor (smieq)
>  	ldr	r4, scratchpad_base
>  	ldr	r3, [r4,#0xBC]
>  	ldr	r0, [r3,#12]
>  	mov	r12, #0x2
> -	.word 0xE1600070	@ Call SMI monitor (smieq)
> +	.word	0xE1600070		@ Call SMI monitor (smieq)
>  logic_l1_restore:
>  	ldr	r1, l2dis_3630
> -	cmp	r1, #0x1	@ Do we need to re-enable L2 on 3630?
> +	cmp	r1, #0x1		@ Test if L2 re-enable needed on
3630
>  	bne	skipl2reen
>  	mrc	p15, 0, r1, c1, c0, 1
> -	orr	r1, r1, #2	@ re-enable L2 cache
> +	orr	r1, r1, #2		@ re-enable L2 cache
>  	mcr	p15, 0, r1, c1, c0, 1
>  skipl2reen:
>  	mov	r1, #0
> -	/* Invalidate all instruction caches to PoU
> -	 * and flush branch target cache */
> +	/*
> +	 * Invalidate all instruction caches to PoU
> +	 * and flush branch target cache
> +	 */
>  	mcr	p15, 0, r1, c7, c5, 0
>
>  	ldr	r4, scratchpad_base
> @@ -483,33 +492,33 @@ skipl2reen:
>  	MCR p15, 0, r6, c2, c0, 1
>  	/* Translation table base control register */
>  	MCR p15, 0, r7, c2, c0, 2
> -	/*domain access Control Register */
> +	/* Domain access Control Register */
>  	MCR p15, 0, r8, c3, c0, 0
> -	/* data fault status Register */
> +	/* Data fault status Register */
>  	MCR p15, 0, r9, c5, c0, 0
>
> -	ldmia  r3!,{r4-r8}
> -	/* instruction fault status Register */
> +	ldmia	r3!,{r4-r8}
> +	/* Instruction fault status Register */
>  	MCR p15, 0, r4, c5, c0, 1
> -	/*Data Auxiliary Fault Status Register */
> +	/* Data Auxiliary Fault Status Register */
>  	MCR p15, 0, r5, c5, c1, 0
> -	/*Instruction Auxiliary Fault Status Register*/
> +	/* Instruction Auxiliary Fault Status Register*/
>  	MCR p15, 0, r6, c5, c1, 1
> -	/*Data Fault Address Register */
> +	/* Data Fault Address Register */
>  	MCR p15, 0, r7, c6, c0, 0
> -	/*Instruction Fault Address Register*/
> +	/* Instruction Fault Address Register*/
>  	MCR p15, 0, r8, c6, c0, 2
> -	ldmia  r3!,{r4-r7}
> +	ldmia	r3!,{r4-r7}
>
> -	/* user r/w thread and process ID */
> +	/* User r/w thread and process ID */
>  	MCR p15, 0, r4, c13, c0, 2
> -	/* user ro thread and process ID */
> +	/* User ro thread and process ID */
>  	MCR p15, 0, r5, c13, c0, 3
> -	/*Privileged only thread and process ID */
> +	/* Privileged only thread and process ID */
>  	MCR p15, 0, r6, c13, c0, 4
> -	/* cache size selection */
> +	/* Cache size selection */
>  	MCR p15, 2, r7, c0, c0, 0
> -	ldmia  r3!,{r4-r8}
> +	ldmia	r3!,{r4-r8}
>  	/* Data TLB lockdown registers */
>  	MCR p15, 0, r4, c10, c0, 0
>  	/* Instruction TLB lockdown registers */
> @@ -521,26 +530,27 @@ skipl2reen:
>  	/* Context PID */
>  	MCR p15, 0, r8, c13, c0, 1
>
> -	ldmia  r3!,{r4-r5}
> -	/* primary memory remap register */
> +	ldmia	r3!,{r4-r5}
> +	/* Primary memory remap register */
>  	MCR p15, 0, r4, c10, c2, 0
> -	/*normal memory remap register */
> +	/* Normal memory remap register */
>  	MCR p15, 0, r5, c10, c2, 1
>
>  	/* Restore cpsr */
> -	ldmia	r3!,{r4}	/*load CPSR from SDRAM*/
> -	msr	cpsr, r4	/*store cpsr */
> +	ldmia	r3!,{r4}		@ load CPSR from SDRAM
> +	msr	cpsr, r4		@ store cpsr
>
>  	/* Enabling MMU here */
> -	mrc	p15, 0, r7, c2, c0, 2 /* Read TTBRControl */
> -	/* Extract N (0:2) bits and decide whether to use TTBR0 or TTBR1*/
> +	mrc	p15, 0, r7, c2, c0, 2 	@ Read TTBRControl
> +	/* Extract N (0:2) bits and decide whether to use TTBR0 or TTBR1
*/
>  	and	r7, #0x7
>  	cmp	r7, #0x0
>  	beq	usettbr0
>  ttbr_error:
> -	/* More work needs to be done to support N[0:2] value other than 0
> -	* So looping here so that the error can be detected
> -	*/
> +	/*
> +	 * More work needs to be done to support N[0:2] value other than 0
> +	 * So looping here so that the error can be detected
> +	 */
>  	b	ttbr_error
>  usettbr0:
>  	mrc	p15, 0, r2, c2, c0, 0
> @@ -548,21 +558,25 @@ usettbr0:
>  	and	r2, r5
>  	mov	r4, pc
>  	ldr	r5, table_index_mask
> -	and	r4, r5 /* r4 = 31 to 20 bits of pc */
> +	and	r4, r5			@ r4 = 31 to 20 bits of pc
>  	/* Extract the value to be written to table entry */
>  	ldr	r1, table_entry
> -	add	r1, r1, r4 /* r1 has value to be written to table entry*/
> +	/* r1 has the value to be written to table entry*/
> +	add	r1, r1, r4
>  	/* Getting the address of table entry to modify */
>  	lsr	r4, #18
> -	add	r2, r4 /* r2 has the location which needs to be modified
*/
> +	/* r2 has the location which needs to be modified */
> +	add	r2, r4
>  	/* Storing previous entry of location being modified */
>  	ldr	r5, scratchpad_base
>  	ldr	r4, [r2]
>  	str	r4, [r5, #0xC0]
>  	/* Modify the table entry */
>  	str	r1, [r2]
> -	/* Storing address of entry being modified
> -	 * - will be restored after enabling MMU */
> +	/*
> +	 * Storing address of entry being modified
> +	 * - will be restored after enabling MMU
> +	 */
>  	ldr	r5, scratchpad_base
>  	str	r2, [r5, #0xC4]
>
> @@ -571,8 +585,11 @@ usettbr0:
>  	mcr	p15, 0, r0, c7, c5, 6	@ Invalidate branch predictor
array
>  	mcr	p15, 0, r0, c8, c5, 0	@ Invalidate instruction TLB
>  	mcr	p15, 0, r0, c8, c6, 0	@ Invalidate data TLB
> -	/* Restore control register  but dont enable caches here*/
> -	/* Caches will be enabled after restoring MMU table entry */
> +	/*
> +	 * Restore control register. This enables the MMU.
> +	 * The caches and prediction are not enabled here, they
> +	 * will be enabled after restoring the MMU table entry.
> +	 */
>  	ldmia	r3!, {r4}
>  	/* Store previous value of control register in scratchpad */
>  	str	r4, [r5, #0xC8]
> @@ -585,7 +602,7 @@ usettbr0:
>   * == Exit point from OFF mode ==
>   * ==============================
>   */
> -	ldmfd	sp!, {r0-r12, pc}		@ restore regs and return
> +	ldmfd	sp!, {r0-r12, pc}	@ restore regs and return
>
>
>  /*
> @@ -651,55 +668,56 @@ ENTRY(es3_sdrc_fix_sz)
>  /* Make sure SDRC accesses are ok */
>  wait_sdrc_ok:
>
> -/* DPLL3 must be locked before accessing the SDRC. Maybe the HW ensures
> this. */
> +/* DPLL3 must be locked before accessing the SDRC. Maybe the HW ensures
> this */
>  	ldr	r4, cm_idlest_ckgen
>  wait_dpll3_lock:
>  	ldr	r5, [r4]
>  	tst	r5, #1
>  	beq	wait_dpll3_lock
>
> -        ldr     r4, cm_idlest1_core
> +	ldr	r4, cm_idlest1_core
>  wait_sdrc_ready:
> -        ldr     r5, [r4]
> -        tst     r5, #0x2
> -        bne     wait_sdrc_ready
> +	ldr	r5, [r4]
> +	tst	r5, #0x2
> +	bne	wait_sdrc_ready
>  	/* allow DLL powerdown upon hw idle req */
> -        ldr     r4, sdrc_power
> -        ldr     r5, [r4]
> -        bic     r5, r5, #0x40
> -        str     r5, [r4]
> -is_dll_in_lock_mode:
> +	ldr	r4, sdrc_power
> +	ldr	r5, [r4]
> +	bic	r5, r5, #0x40
> +	str	r5, [r4]
>
> -        /* Is dll in lock mode? */
> -        ldr     r4, sdrc_dlla_ctrl
> -        ldr     r5, [r4]
> -        tst     r5, #0x4
> -        bxne    lr
> -        /* wait till dll locks */
> +is_dll_in_lock_mode:
> +	/* Is dll in lock mode? */
> +	ldr	r4, sdrc_dlla_ctrl
> +	ldr	r5, [r4]
> +	tst	r5, #0x4
> +	bxne	lr			@ Return if locked
> +	/* wait till dll locks */
>  wait_dll_lock_timed:
>  	ldr	r4, wait_dll_lock_counter
>  	add	r4, r4, #1
>  	str	r4, wait_dll_lock_counter
>  	ldr	r4, sdrc_dlla_status
> -        mov	r6, #8		/* Wait 20uS for lock */
> +	/* Wait 20uS for lock */
> +	mov	r6, #8
>  wait_dll_lock:
>  	subs	r6, r6, #0x1
>  	beq	kick_dll
> -        ldr     r5, [r4]
> -        and     r5, r5, #0x4
> -        cmp     r5, #0x4
> -        bne     wait_dll_lock
> -        bx      lr
> +	ldr	r5, [r4]
> +	and	r5, r5, #0x4
> +	cmp	r5, #0x4
> +	bne	wait_dll_lock
> +	bx	lr			@ Return when locked
>
>  	/* disable/reenable DLL if not locked */
>  kick_dll:
>  	ldr	r4, sdrc_dlla_ctrl
>  	ldr	r5, [r4]
>  	mov	r6, r5
> -	bic	r6, #(1<<3)	/* disable dll */
> +	bic	r6, #(1<<3)		@ disable dll
>  	str	r6, [r4]
>  	dsb
> -	orr	r6, r6, #(1<<3)	/* enable dll */
> +	orr	r6, r6, #(1<<3)		@ enable dll
>  	str	r6, [r4]
>  	dsb
>  	ldr	r4, kick_counter
> @@ -724,7 +742,7 @@ scratchpad_base:
>  sram_base:
>  	.word	SRAM_BASE_P + 0x8000
>  sdrc_power:
> -	.word SDRC_POWER_V
> +	.word	SDRC_POWER_V
>  ttbrbit_mask:
>  	.word	0xFFFFC000
>  table_index_mask:
> @@ -738,9 +756,9 @@ control_stat:
>  control_mem_rta:
>  	.word	CONTROL_MEM_RTA_CTRL
>  kernel_flush:
> -	.word v7_flush_dcache_all
> +	.word	v7_flush_dcache_all
>  l2dis_3630:
> -	.word 0
> +	.word	0
>  	/* these 2 words need to be at the end !!! */
>  kick_counter:
>  	.word	0
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
