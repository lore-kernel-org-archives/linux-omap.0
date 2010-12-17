From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 5/7] OMAP3: rework of the ASM sleep code execution paths
Date: Fri, 17 Dec 2010 09:35:52 -0600
Message-ID: <4D0B8358.3030804@ti.com>
References: <1292580506-4421-1-git-send-email-j-pihet@ti.com> <1292580506-4421-6-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:37421 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755338Ab0LQPf4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 Dec 2010 10:35:56 -0500
Received: by mail-yx0-f181.google.com with SMTP id 39so417302yxd.26
        for <linux-omap@vger.kernel.org>; Fri, 17 Dec 2010 07:35:55 -0800 (PST)
In-Reply-To: <1292580506-4421-6-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org, Jean Pihet <j-pihet@ti.com>

jean.pihet@newoldbits.com had written, on 12/17/2010 04:08 AM, the 
following:
> From: Jean Pihet <j-pihet@ti.com>
> 
> - Reworked and simplified the execution paths for better
>   readability and to avoid duplication of code,
is it possible to split this good rewrite into logical chunks for better 
and easier reviewability?

my suggestion clean each of the paths independently - like the code upto 
wfi.. and then we can clean up the resume path as well separately.

> - Added comments on the entry and exit points and the interaction
>   with the ROM code for OFF mode restore,
> - Reworked the existing comments for better readability.
thanks for doing this, but, just my suggestion, looking at the amount of 
changes done in this patch -> if you can keep one patch for functional 
change which is separate from cosmetic change (such as comment cleanup 
and addition), it makes a reviewer's life easier :)

> 
> Tested on N900 and Beagleboard with full RET and OFF modes,
> using cpuidle and suspend.
> 
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> ---
>  arch/arm/mach-omap2/control.c   |    9 +-
>  arch/arm/mach-omap2/sleep34xx.S |  313 +++++++++++++++++++++++----------------
>  2 files changed, 191 insertions(+), 131 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
> index 728f268..f4b19ed 100644
> --- a/arch/arm/mach-omap2/control.c
> +++ b/arch/arm/mach-omap2/control.c
> @@ -239,7 +239,14 @@ void omap3_save_scratchpad_contents(void)
>  	struct omap3_scratchpad_prcm_block prcm_block_contents;
>  	struct omap3_scratchpad_sdrc_block sdrc_block_contents;
>  
> -	/* Populate the Scratchpad contents */
> +	/*
> +	 * Populate the Scratchpad contents
> +	 *
> +	 * The "get_*restore_pointer" functions are used to provide a
> +	 * physical restore address where the ROM code jumps while waking
> +	 * up from MPU OFF/OSWR state.
Just curious: we dont have OSWR(open switch retention) in l-o unless I 
am mistaken.. we have cswr (closed switch retention).

> +	 * The restore pointer is stored into the scratchpad.
> +	 */
>  	scratchpad_contents.boot_config_ptr = 0x0;
>  	if (cpu_is_omap3630())
>  		scratchpad_contents.public_restore_ptr =
> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
> index beeb682..12061fd 100644
> --- a/arch/arm/mach-omap2/sleep34xx.S
> +++ b/arch/arm/mach-omap2/sleep34xx.S
> @@ -71,6 +71,13 @@
>   * API functions
>   */
>  
> +/*
> + * The "get_*restore_pointer" functions are used to provide a
> + * physical restore address where the ROM code jumps while waking
> + * up from MPU OFF/OSWR state.
> + * The restore pointer is stored into the scratchpad.
> + */
> +
we need to cleanup comments such as those used below:

>  	.text
>  /* Function call to get the restore pointer for resume from OFF */
^^^^
may be make it explicit what the difference for get_restore_pointer is etc..

>  ENTRY(get_restore_pointer)
> @@ -102,7 +109,7 @@ ENTRY(get_es3_restore_pointer_sz)
>  /*
>   * L2 cache needs to be toggled for stable OFF mode functionality on 3630.
>   * This function sets up a flag that will allow for this toggling to take
> - * place on 3630. Hopefully some version in the future maynot need this
> + * place on 3630. Hopefully some version in the future may not need this.
I think we should split the patch up for the comment cleanup -> it is a 
little nuisance trying to review the actual functional change mixed with 
comment cleanups together..

>   */
>  ENTRY(enable_omap3630_toggle_l2_on_restore)
>          stmfd   sp!, {lr}     @ save registers on stack
> @@ -144,34 +151,158 @@ ENTRY(save_secure_ram_context_sz)
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
> + * omap34xx_suspend() - This bit of code saves the CPU context if needed
> + * and executes the WFI instruction
since we are cleaning up, I might as well suggest - what condition do we 
save the CPU context might be worth mentioning. is this called during 
RET transition or OFF transition is not clear..
>   *
> - * Note: This code get's copied to internal SRAM at boot. When the OMAP
> - *	 wakes up it continues execution at the point it went to sleep.
> + * Notes:
> + * - this code gets copied to internal SRAM at boot.
> + * - when the OMAP wakes up it continues at different execution points
> + *   depending on the low power mode (non-OFF vs OFF modes),
> + *   cf. 'Resume path for xxx mode' comments.
Further, might as well help people and say that this is the call 
_omap_sram_idle actually takes ;)

Also might be a little indepth pseudo code overview of this complex code 
flow might help for code maintainers later on..

omap34xx_cpu_suspend
    |- if Context save not required -> omap3_do_wfi -> wfi
    \- if context save required: -> save_context_wfi
                                       |
				cache maintenance:
cache maintenance:
	- what happens when l1 is lost, what happens when l2 is lost..

>   */
>  ENTRY(omap34xx_cpu_suspend)
>  	stmfd	sp!, {r0-r12, lr}		@ save registers on stack
>  
> -	/* r0 contains restore pointer in sdram */
> -	/* r1 contains information about saving context */
> -	ldr     r4, sdrc_power          @ read the SDRC_POWER register
> -	ldr     r5, [r4]                @ read the contents of SDRC_POWER
> -	orr     r5, r5, #0x40           @ enable self refresh on idle req
> -	str     r5, [r4]                @ write back to SDRC_POWER register
> +	/*
> +	 * r0 contains restore pointer in sdram
> +	 * r1 contains information about saving context:
> +	 *   0 - No context lost
> +	 *   1 - Only L1 and logic lost
> +	 *   2 - Only L2 lost
> +	 *   3 - Both L1 and L2 lost
Since we are cleaning up, one generic Suggestion:
since these 0 1 2 3 are used by pm34xx.c and this code alone, we might 
as well define it in a common header and save ourselves the pain of 
defining this in 2 places and some one screwing things up later on..

looking at pm34xx.c, I dont see 2 being defined at all :( unless I 
missed something, pm34xx.c:
  switch (mpu_next_state) {
  case PWRDM_POWER_ON:
  case PWRDM_POWER_RET:
          /* No need to save context */
Which is kind of funny for me. since we use this parameter to determine 
to clean cache or not :D - another misinterpretation of using values 
instead of readable macros ;)
          save_state = 0;
          break;
  case PWRDM_POWER_OFF:
          save_state = 3;
          break;

> +	 */
>  
> +	/* Save context only if required */
>  	cmp	r1, #0x0
> -	/* If context save is required, do that and execute wfi */
> -	bne	save_context_wfi
> +	beq	omap3_do_wfi
> +
Add comment to fall through here.

> +save_context_wfi:
> +	mov	r8, r0			@ Store SDRAM address in r8
> +	mrc	p15, 0, r5, c1, c0, 1	@ Read Auxiliary Control Register
> +	mov	r4, #0x1		@ Number of parameters for restore call
> +	stmia	r8!, {r4-r5}		@ Push parameters for restore call
> +	mrc	p15, 1, r5, c9, c0, 2	@ Read L2 AUX ctrl register
> +	stmia	r8!, {r4-r5}		@ Push parameters for restore call
> +
> +        /* Check what that target sleep state is from r1 */
> +	cmp	r1, #0x2		@ Only L2 lost, no need to save context
> +	beq	clean_caches

one suggestion here:
how about:
	and rn, r1, #L2_LOGIC_LOST
	cmp rn, #L2_LOGIC_LOST
	bleq l2_cleanup
	and rn, r1, #L1_LOGIC_LOST
	cmp rn, #L1_LOGIC_LOST
	bleq l1_cleanup
	move the omap3_do_wfi code here

l1_cleanup:
	...
	save_context
	...
	return back

l2_cleanup:
	...
	...
	return back

or am I simplifying things too much here?

> +
> +l1_logic_lost:
> +	/* Store sp and spsr to SDRAM */
> +	mov	r4, sp
> +	mrs	r5, spsr
> +	mov	r6, lr
> +	stmia	r8!, {r4-r6}
> +	/* Save all ARM registers */
> +	/* Coprocessor access control register */
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
> +	 * data fault address register and instruction fault address register
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
> +	/* Secure or non secure vector base address, FCSE PID, Context PID*/
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
> +	/*
> +	 * Clean Data or unified cache to POU
> +	 * How to invalidate only L1 cache???? - #FIX_ME#
> +	 * mcr	p15, 0, r11, c7, c11, 1
> +	 */
> +	cmp	r1, #0x1 		@ Check whether L2 inval is required
> +	beq	omap3_do_wfi
> +
> +clean_l2:
> +	/*
> +	 * jump out to kernel flush routine
> +	 *  - reuse that code is better
> +	 *  - it executes in a cached space so is faster than refetch per-block
> +	 *  - should be faster and will change with kernel
> +	 *  - 'might' have to copy address, load and jump to it
> +	 */
> +	ldr r1, kernel_flush
> +	mov lr, pc
> +	bx  r1
> +
> +omap3_do_wfi:
recommend changing the name -> basically the flow is split into two:
wfi with save of context: save_context_wfi
wfi without save of context: omap3_do_wfi (I suppose the naming is 
because it is being used in multiple paths)



> +	ldr	r4, sdrc_power		@ read the SDRC_POWER register
> +	ldr	r5, [r4]		@ read the contents of SDRC_POWER
> +	orr	r5, r5, #0x40		@ enable self refresh on idle req
> +	str	r5, [r4]		@ write back to SDRC_POWER register
> +
we just changed the functional sequence of when we enable self refresh 
on idle req (previously - this was the first step on entry, now, we do 
this after context save) -> this should be a separate patch of it's own 
for tracking any issues that may be detected by this change i suppose.

>  	/* Data memory barrier and Data sync barrier */
>  	mov	r1, #0
>  	mcr	p15, 0, r1, c7, c10, 4
>  	mcr	p15, 0, r1, c7, c10, 5
>  
> +/*
> + * ===================================
> + * == WFI instruction => Enter idle ==
idle is a bit confusing -> cpu idle can hit both RET and OFF..

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
> @@ -184,7 +315,29 @@ ENTRY(omap34xx_cpu_suspend)
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
cosmetic changes like this belong it's own patch to help the reviewer.

> +
> +
additional EOL?
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
> @@ -214,12 +367,17 @@ restore_3630:
>  	ldr	r1, control_mem_rta
>  	mov	r2, #OMAP36XX_RTA_DISABLE
>  	str	r2, [r1]
> -	/* Fall thru for the remaining logic */
> +
> +	/* Fall thru to common code for the remaining logic */
might as well replace thru with through ;)

> +
>  restore:
> -        /* Check what was the reason for mpu reset and store the reason in r9*/
> -        /* 1 - Only L1 and logic lost */
> -        /* 2 - Only L2 lost - In this case, we wont be here */
> -        /* 3 - Both L1 and L2 lost */
> +        /*
> +	 * Check what was the reason for mpu reset and store the reason in r9:
> +	 *  0 - No context lost
> +         *  1 - Only L1 and logic lost
> +         *  2 - Only L2 lost - In this case, we wont be here
> +         *  3 - Both L1 and L2 lost
> +	 */
again something we can skip if we were to use #defines.

>  	ldr     r1, pm_pwstctrl_mpu
>  	ldr	r2, [r1]
>  	and     r2, r2, #0x3
> @@ -422,118 +580,12 @@ usettbr0:
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
> -	mov	r4, #0x1		@ Number of parameters for restore call
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
> -	datat fault address register and instruction fault address register*/
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
> -	/* Secure or non secure vector base address, FCSE PID, Context PID*/
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
> -	 *  - it executes in a cached space so is faster than refetch per-block
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
> @@ -683,5 +735,6 @@ kick_counter:
>  	.word	0
>  wait_dll_lock_counter:
>  	.word	0
> +
spurious change.

>  ENTRY(omap34xx_cpu_suspend_sz)
>  	.word	. - omap34xx_cpu_suspend

as such, this patch:

Tested-by: Nishanth Menon <nm@ti.com>
Tested on:
SDP3630
SDP3430
Test script:
http://pastebin.mozilla.org/889933


-- 
Regards,
Nishanth Menon
