From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 5/7] OMAP3: rework of the ASM sleep code execution paths
Date: Fri, 17 Dec 2010 10:34:15 +0530
Message-ID: <001905ac88dd754f5426cfa2dc76ddc2@mail.gmail.com>
References: <1292521858-3810-1-git-send-email-j-pihet@ti.com> <1292521858-3810-6-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:54312 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1749667Ab0LQFES (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Dec 2010 00:04:18 -0500
Received: by mail-yw0-f50.google.com with SMTP id 7so146321ywo.23
        for <linux-omap@vger.kernel.org>; Thu, 16 Dec 2010 21:04:17 -0800 (PST)
In-Reply-To: <1292521858-3810-6-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com, linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org, Jean Pihet-XID <j-pihet@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of jean.pihet@newoldbits.com
> Sent: Thursday, December 16, 2010 11:21 PM
> To: linux-omap@vger.kernel.org
> Cc: khilman@deeprootsystems.com; linux-arm-kernel@lists.infradead.org;
> Jean Pihet
> Subject: [PATCH 5/7] OMAP3: rework of the ASM sleep code execution paths
>
> From: Jean Pihet <j-pihet@ti.com>
>
> - Reworked and simplified the execution paths for better
>   readability and to avoid duplication of code,
> - Added comments on the entry and exit points and the interaction
>   with the ROM code for OFF mode restore,
> - Reworked the existing comments for better readability.
>
> Tested on N900 and Beagleboard with full RET and OFF modes,
> using cpuidle and suspend.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> ---
>  arch/arm/mach-omap2/control.c   |   10 +-
>  arch/arm/mach-omap2/sleep34xx.S |  309
++++++++++++++++++++++------------
> ----
>  2 files changed, 188 insertions(+), 131 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/control.c
b/arch/arm/mach-omap2/control.c
> index 728f268..5cb7276 100644
> --- a/arch/arm/mach-omap2/control.c
> +++ b/arch/arm/mach-omap2/control.c
> @@ -239,7 +239,15 @@ void omap3_save_scratchpad_contents(void)
>  	struct omap3_scratchpad_prcm_block prcm_block_contents;
>  	struct omap3_scratchpad_sdrc_block sdrc_block_contents;
>
> -	/* Populate the Scratchpad contents */
> +	/*
> +	 * Populate the Scratchpad contents
> +	 *
> +	 * The get_*restore_pointer functions are used to get the resume
> +	 *  function pointer to be called by the ROM code when back from
WFI
> +	 *  in OFF mode.
Align your text here.
> +	 * The restore pointer is stored into the scratchpad for later
> access
> +	 *  by the ROM code.
The text needs to be reworked a bit.

The "get_*restore_pointer" functions are used to provide a physical
restore
address where ROM code jumps while waking up from MPU OFF/OSWR state.
The restore pointer is stored into the scratchpad

> +	 */
>  	scratchpad_contents.boot_config_ptr = 0x0;
>  	if (cpu_is_omap3630())
>  		scratchpad_contents.public_restore_ptr =
> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-
> omap2/sleep34xx.S
> index 426af02..55ddd5a 100644
> --- a/arch/arm/mach-omap2/sleep34xx.S
> +++ b/arch/arm/mach-omap2/sleep34xx.S
> @@ -70,6 +70,11 @@
>   * API functions
>   */
>
> +/*
> + * The get_*restore_pointer functions are returning the resume
> + *  function pointer to be called by the ROM code when back from WFI
> + *  in OFF mode.
Ditto
The "get_*restore_pointer" functions are used to provide a physical
restore
address where ROM code jumps while waking up from MPU OFF/OSWR state.
The restore pointer is stored into the scratchpad

> + */
>  	.text
>  /* Function call to get the restore pointer for resume from OFF */
>  ENTRY(get_restore_pointer)
> @@ -101,7 +106,7 @@ ENTRY(get_es3_restore_pointer_sz)
>  /*
>   * L2 cache needs to be toggled for stable OFF mode functionality on
3630.
>   * This function sets up a flag that will allow for this toggling to
take
> - * place on 3630. Hopefully some version in the future maynot need this
> + * place on 3630. Hopefully some version in the future maynot need
this.
'maynot' ..... may not
>   */
>  ENTRY(enable_omap3630_toggle_l2_on_restore)
>          stmfd   sp!, {lr}     @ save registers on stack
> @@ -143,34 +148,156 @@ ENTRY(save_secure_ram_context_sz)
>  	.word	. - save_secure_ram_context
>
>  /*
> + * ======================
> + * == Idle entry point ==
> + * ======================
> + */
> +
> +/*
>   * Forces OMAP into idle state
>   *
> - * omap34xx_suspend() - This bit of code just executes the WFI
> - * for normal idles.
> + * omap34xx_suspend() - This bit of code saves the CPU context if
needed
> + * and executes the WFI instruction
>   *
> - * Note: This code get's copied to internal SRAM at boot. When the OMAP
> - *	 wakes up it continues execution at the point it went to sleep.
> + * Notes:
> + * - this code gets copied to internal SRAM at boot.
> + * - when the OMAP wakes up it continues at different execution points
> + *   depending on the low power mode (non-OFF vs OFF modes),
> + *   cf. 'Resume path for xxx mode' comments.
>   */
>  ENTRY(omap34xx_cpu_suspend)
>  	stmfd	sp!, {r0-r12, lr}		@ save registers on stack
>
> -	/* r0 contains restore pointer in sdram */
> -	/* r1 contains information about saving context */
> -	ldr     r4, sdrc_power          @ read the SDRC_POWER register
> -	ldr     r5, [r4]                @ read the contents of SDRC_POWER
> -	orr     r5, r5, #0x40           @ enable self refresh on idle req
> -	str     r5, [r4]                @ write back to SDRC_POWER
register
> +	/*
> +	 * r0 contains restore pointer in sdram
> +	 * r1 contains information about saving context:
> +	 *   0 - No context lost
> +	 *   1 - Only L1 and logic lost
> +	 *   2 - Only L2 lost
> +	 *   3 - Both L1 and L2 lost
> +	 */
>
> +	/* Save context only if required */
>  	cmp	r1, #0x0
> -	/* If context save is required, do that and execute wfi */
> -	bne	save_context_wfi
> +	beq	omap3_do_wfi
> +
> +save_context_wfi:
> +	mov	r8, r0			@ Store SDRAM address in r8
> +	mrc	p15, 0, r5, c1, c0, 1	@ Read Auxiliary Control Register
> +	mov	r4, #0x1		@ Number of parameters for restore
call
> +	stmia	r8!, {r4-r5}		@ Push parameters for restore call
> +	mrc	p15, 1, r5, c9, c0, 2	@ Read L2 AUX ctrl register
> +	stmia	r8!, {r4-r5}		@ Push parameters for restore call
> +
> +        /* Check what that target sleep state is from r1 */
> +	cmp	r1, #0x2		@ Only L2 lost, no need to save
context
> +	beq	clean_caches
> +
> +l1_logic_lost:
> +	/* Store sp and spsr to SDRAM */
> +	mov	r4, sp
> +	mrs	r5, spsr
> +	mov	r6, lr
> +	stmia	r8!, {r4-r6}
> +	/* Save all ARM registers */
> +	/* Coprocessor access control register */
You might want to fix above commenting style as well
> +	mrc	p15, 0, r6, c1, c0, 2
> +	stmia	r8!, {r6}
> +	/* TTBR0, TTBR1 and Translation table base control */
> +	mrc	p15, 0, r4, c2, c0, 0
> +	mrc	p15, 0, r5, c2, c0, 1
> +	mrc	p15, 0, r6, c2, c0, 2
> +	stmia	r8!, {r4-r6}
> +	/*
> +	 * Domain access control register, data fault status register,
> +	 * and instruction fault status register
> +	 */
> +	mrc	p15, 0, r4, c3, c0, 0
> +	mrc	p15, 0, r5, c5, c0, 0
> +	mrc	p15, 0, r6, c5, c0, 1
> +	stmia	r8!, {r4-r6}
> +	/*
> +	 * Data aux fault status register, instruction aux fault status,
> +	 * data fault address register and instruction fault address
> register
> +	 */
> +	mrc	p15, 0, r4, c5, c1, 0
> +	mrc	p15, 0, r5, c5, c1, 1
> +	mrc	p15, 0, r6, c6, c0, 0
> +	mrc	p15, 0, r7, c6, c0, 2
> +	stmia	r8!, {r4-r7}
> +	/*
> +	 * user r/w thread and process ID, user r/o thread and process ID,
> +	 * priv only thread and process ID, cache size selection
> +	 */
> +	mrc	p15, 0, r4, c13, c0, 2
> +	mrc	p15, 0, r5, c13, c0, 3
> +	mrc	p15, 0, r6, c13, c0, 4
> +	mrc	p15, 2, r7, c0, c0, 0
> +	stmia	r8!, {r4-r7}
> +	/* Data TLB lockdown, instruction TLB lockdown registers */
> +	mrc	p15, 0, r5, c10, c0, 0
> +	mrc	p15, 0, r6, c10, c0, 1
> +	stmia	r8!, {r5-r6}
> +	/* Secure or non secure vector base address, FCSE PID, Context
PID*/
> +	mrc	p15, 0, r4, c12, c0, 0
> +	mrc	p15, 0, r5, c13, c0, 0
> +	mrc	p15, 0, r6, c13, c0, 1
> +	stmia	r8!, {r4-r6}
> +	/* Primary remap, normal remap registers */
> +	mrc	p15, 0, r4, c10, c2, 0
> +	mrc	p15, 0, r5, c10, c2, 1
> +	stmia	r8!,{r4-r5}
> +
> +	/* Store current cpsr*/
> +	mrs	r2, cpsr
> +	stmia	r8!, {r2}
> +
> +	mrc	p15, 0, r4, c1, c0, 0
> +	/* save control register */
> +	stmia	r8!, {r4}
> +
> +clean_caches:
> +	/* Clean Data or unified cache to POU*/
> +	/* How to invalidate only L1 cache???? - #FIX_ME# */
> +	/* mcr	p15, 0, r11, c7, c11, 1 */
And this one too...
> +	cmp	r1, #0x1 		@ Check whether L2 inval is
required
> +	beq	omap3_do_wfi
> +
> +clean_l2:
> +	/*
> +	 * jump out to kernel flush routine
> +	 *  - reuse that code is better
> +	 *  - it executes in a cached space so is faster than refetch per-
> block
> +	 *  - should be faster and will change with kernel
> +	 *  - 'might' have to copy address, load and jump to it
> +	 */
> +	ldr r1, kernel_flush
> +	mov lr, pc
> +	bx  r1
> +
> +omap3_do_wfi:
> +	ldr	r4, sdrc_power		@ read the SDRC_POWER register
> +	ldr	r5, [r4]		@ read the contents of SDRC_POWER
> +	orr	r5, r5, #0x40		@ enable self refresh on idle req
> +	str	r5, [r4]		@ write back to SDRC_POWER
register
> +
>  	/* Data memory barrier and Data sync barrier */
>  	mov	r1, #0
>  	mcr	p15, 0, r1, c7, c10, 4
>  	mcr	p15, 0, r1, c7, c10, 5
>
> +/*
> + * ===================================
> + * == WFI instruction => Enter idle ==
> + * ===================================
> + */
>  	wfi				@ wait for interrupt
>
> +/*
> + * ===================================
> + * == Resume path for non-OFF modes ==
> + * ===================================
> + */
>  	nop
>  	nop
>  	nop
> @@ -183,7 +310,29 @@ ENTRY(omap34xx_cpu_suspend)
>  	nop
>  	bl wait_sdrc_ok
>
> -	ldmfd	sp!, {r0-r12, pc}		@ restore regs and return
> +/*
> + * ===================================
> + * == Exit point from non-OFF modes ==
> + * ===================================
> + */
> +	ldmfd	sp!, {r0-r12, pc}	@ restore regs and return
> +
> +
> +/*
> + * ==============================
> + * == Resume path for OFF mode ==
> + * ==============================
> + */
> +
> +/*
> + * The restore_* functions are called by the ROM code
> + *  when back from WFI in OFF mode.
> + * Cf. the get_*restore_pointer functions.
> + *
> + *  restore_es3: applies to 34xx >= ES3.0
> + *  restore_3630: applies to 36xx
> + *  restore: common code for 3xxx
> + */
>  restore_es3:
>  	ldr	r5, pm_prepwstst_core_p
>  	ldr	r4, [r5]
> @@ -213,12 +362,17 @@ restore_3630:
>  	ldr	r1, control_mem_rta
>  	mov	r2, #OMAP36XX_RTA_DISABLE
>  	str	r2, [r1]
> -	/* Fall thru for the remaining logic */
> +
> +	/* Fall thru to common code for the remaining logic */
> +
>  restore:
> -        /* Check what was the reason for mpu reset and store the reason
> in r9*/
> -        /* 1 - Only L1 and logic lost */
> -        /* 2 - Only L2 lost - In this case, we wont be here */
> -        /* 3 - Both L1 and L2 lost */
> +        /*
> +	 * Check what was the reason for mpu reset and store the reason in
> r9:
> +	 *  0 - No context lost
> +         *  1 - Only L1 and logic lost
> +         *  2 - Only L2 lost - In this case, we wont be here
> +         *  3 - Both L1 and L2 lost
> +	 */
>  	ldr     r1, pm_pwstctrl_mpu
>  	ldr	r2, [r1]
>  	and     r2, r2, #0x3
> @@ -421,118 +575,12 @@ usettbr0:
>  	and	r4, r2
>  	mcr	p15, 0, r4, c1, c0, 0
>
> +/*
> + * ==============================
> + * == Exit point from OFF mode ==
> + * ==============================
> + */
>  	ldmfd	sp!, {r0-r12, pc}		@ restore regs and return
> -save_context_wfi:
> -	mov	r8, r0 /* Store SDRAM address in r8 */
> -	mrc	p15, 0, r5, c1, c0, 1	@ Read Auxiliary Control Register
> -	mov	r4, #0x1		@ Number of parameters for restore
call
> -	stmia	r8!, {r4-r5}		@ Push parameters for restore call
> -	mrc	p15, 1, r5, c9, c0, 2	@ Read L2 AUX ctrl register
> -	stmia	r8!, {r4-r5}		@ Push parameters for restore call
> -        /* Check what that target sleep state is:stored in r1*/
> -        /* 1 - Only L1 and logic lost */
> -        /* 2 - Only L2 lost */
> -        /* 3 - Both L1 and L2 lost */
> -	cmp	r1, #0x2 /* Only L2 lost */
> -	beq	clean_l2
> -	cmp	r1, #0x1 /* L2 retained */
> -	/* r9 stores whether to clean L2 or not*/
> -	moveq	r9, #0x0 /* Dont Clean L2 */
> -	movne	r9, #0x1 /* Clean L2 */
> -l1_logic_lost:
> -	/* Store sp and spsr to SDRAM */
> -	mov	r4, sp
> -	mrs	r5, spsr
> -	mov	r6, lr
> -	stmia	r8!, {r4-r6}
> -	/* Save all ARM registers */
> -	/* Coprocessor access control register */
> -	mrc	p15, 0, r6, c1, c0, 2
> -	stmia	r8!, {r6}
> -	/* TTBR0, TTBR1 and Translation table base control */
> -	mrc	p15, 0, r4, c2, c0, 0
> -	mrc	p15, 0, r5, c2, c0, 1
> -	mrc	p15, 0, r6, c2, c0, 2
> -	stmia	r8!, {r4-r6}
> -	/* Domain access control register, data fault status register,
> -	and instruction fault status register */
> -	mrc	p15, 0, r4, c3, c0, 0
> -	mrc	p15, 0, r5, c5, c0, 0
> -	mrc	p15, 0, r6, c5, c0, 1
> -	stmia	r8!, {r4-r6}
> -	/* Data aux fault status register, instruction aux fault status,
> -	datat fault address register and instruction fault address
> register*/
> -	mrc	p15, 0, r4, c5, c1, 0
> -	mrc	p15, 0, r5, c5, c1, 1
> -	mrc	p15, 0, r6, c6, c0, 0
> -	mrc	p15, 0, r7, c6, c0, 2
> -	stmia	r8!, {r4-r7}
> -	/* user r/w thread and process ID, user r/o thread and process ID,
> -	priv only thread and process ID, cache size selection */
> -	mrc	p15, 0, r4, c13, c0, 2
> -	mrc	p15, 0, r5, c13, c0, 3
> -	mrc	p15, 0, r6, c13, c0, 4
> -	mrc	p15, 2, r7, c0, c0, 0
> -	stmia	r8!, {r4-r7}
> -	/* Data TLB lockdown, instruction TLB lockdown registers */
> -	mrc	p15, 0, r5, c10, c0, 0
> -	mrc	p15, 0, r6, c10, c0, 1
> -	stmia	r8!, {r5-r6}
> -	/* Secure or non secure vector base address, FCSE PID, Context
PID*/
> -	mrc	p15, 0, r4, c12, c0, 0
> -	mrc	p15, 0, r5, c13, c0, 0
> -	mrc	p15, 0, r6, c13, c0, 1
> -	stmia	r8!, {r4-r6}
> -	/* Primary remap, normal remap registers */
> -	mrc	p15, 0, r4, c10, c2, 0
> -	mrc	p15, 0, r5, c10, c2, 1
> -	stmia	r8!,{r4-r5}
> -
> -	/* Store current cpsr*/
> -	mrs	r2, cpsr
> -	stmia	r8!, {r2}
> -
> -	mrc	p15, 0, r4, c1, c0, 0
> -	/* save control register */
> -	stmia	r8!, {r4}
> -clean_caches:
> -	/* Clean Data or unified cache to POU*/
> -	/* How to invalidate only L1 cache???? - #FIX_ME# */
> -	/* mcr	p15, 0, r11, c7, c11, 1 */
> -	cmp	r9, #1 /* Check whether L2 inval is required or not*/
> -	bne	skip_l2_inval
> -clean_l2:
> -	/*
> -	 * Jump out to kernel flush routine
> -	 *  - reuse that code is better
> -	 *  - it executes in a cached space so is faster than refetch per-
> block
> -	 *  - should be faster and will change with kernel
> -	 *  - 'might' have to copy address, load and jump to it
> -	 */
> -	ldr r1, kernel_flush
> -	mov lr, pc
> -	bx  r1
> -
> -skip_l2_inval:
> -	/* Data memory barrier and Data sync barrier */
> -	mov     r1, #0
> -	mcr     p15, 0, r1, c7, c10, 4
> -	mcr     p15, 0, r1, c7, c10, 5
> -
> -	wfi                             @ wait for interrupt
> -	nop
> -	nop
> -	nop
> -	nop
> -	nop
> -	nop
> -	nop
> -	nop
> -	nop
> -	nop
> -	bl wait_sdrc_ok
> -	/* restore regs and return */
> -	ldmfd   sp!, {r0-r12, pc}
>
>
>  /*
> @@ -682,5 +730,6 @@ kick_counter:
>  	.word	0
>  wait_dll_lock_counter:
>  	.word	0
> +
>  ENTRY(omap34xx_cpu_suspend_sz)
>  	.word	. - omap34xx_cpu_suspend
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
