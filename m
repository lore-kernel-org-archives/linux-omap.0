From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] save and restore etm state across core OFF modes
Date: Tue, 12 Jan 2010 14:02:29 -0800
Message-ID: <87ockz56dm.fsf@deeprootsystems.com>
References: <1263315891-4440-1-git-send-email-virtuoso@slind.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.216.174]:44747 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752921Ab0ALWCb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Jan 2010 17:02:31 -0500
Received: by pxi4 with SMTP id 4so4958674pxi.33
        for <linux-omap@vger.kernel.org>; Tue, 12 Jan 2010 14:02:31 -0800 (PST)
In-Reply-To: <1263315891-4440-1-git-send-email-virtuoso@slind.org> (Alexander Shishkin's message of "Tue\, 12 Jan 2010 19\:04\:51 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alexander Shishkin <virtuoso@slind.org>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Richard Woodruff <r-woodruff2@ti.com>

Alexander Shishkin <virtuoso@slind.org> writes:

> This prevents ETM stalls whenever core enters OFF mode. Original patch
> author is Richard Woodruff <r-woodruff2@ti.com>.
>
> This patch applies on top of pm branch.

There doesn't seem to be any dependencies on PM branch here.

Applying to l-o master has a minor conflict with the adding of the
base addresses that could be easily fixed.

Please rebase onto l-o master.

Thanks,

Kevin

> Signed-off-by: Alexander Shishkin <virtuoso@slind.org>
> CC: Richard Woodruff <r-woodruff2@ti.com>
> ---
>  arch/arm/mach-omap2/Kconfig               |    9 ++
>  arch/arm/mach-omap2/control.c             |    2 +-
>  arch/arm/mach-omap2/sleep34xx.S           |  133 +++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/control.h |    2 +-
>  4 files changed, 144 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 606bf04..02ea136 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -153,6 +153,15 @@ config MACH_OMAP_4430SDP
>  	bool "OMAP 4430 SDP board"
>  	depends on ARCH_OMAP4
>  
> +config ENABLE_OFF_MODE_JTAG_ETM_DEBUG
> +	bool "Enable hardware emulation context save and restore"
> +	depends on ARCH_OMAP3
> +	default y
> +	help
> +	  This option enables JTAG & ETM debugging across power states.
> +	  With out this option emulation features are reset across OFF
> +	  mode state changes.
> +
>  config OMAP3_EMU
>  	bool "OMAP3 debugging peripherals"
>  	depends on ARCH_OMAP3
> diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
> index cdd1f35..78f4634 100644
> --- a/arch/arm/mach-omap2/control.c
> +++ b/arch/arm/mach-omap2/control.c
> @@ -93,7 +93,7 @@ void *omap3_secure_ram_storage;
>   * The address is stored in scratchpad, so that it can be used
>   * during the restore path.
>   */
> -u32 omap3_arm_context[128];
> +u32 omap3_arm_context[256];
>  
>  struct omap3_control_regs {
>  	u32 sysconfig;
> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
> index 69521be..0a5ec86 100644
> --- a/arch/arm/mach-omap2/sleep34xx.S
> +++ b/arch/arm/mach-omap2/sleep34xx.S
> @@ -59,6 +59,13 @@
>  #define SDRC_DLLA_STATUS_V	OMAP34XX_SDRC_REGADDR(SDRC_DLLA_STATUS)
>  #define SDRC_DLLA_CTRL_V	OMAP34XX_SDRC_REGADDR(SDRC_DLLA_CTRL)
>  
> +#define CORTEX_CORSIGHT_OFF     (0x00011000)
> +#define CORTEX_EMU_DEBUG_V      (L4_EMU_34XX_VIRT + CORTEX_CORSIGHT_OFF)
> +#define CORTEX_EMU_DEBUG_P      (L4_EMU_34XX_PHYS + CORTEX_CORSIGHT_OFF)
> +#define ETM_CORSIGHT_OFF        (0x00010000)
> +#define CORTEX_EMU_ETM_V        (L4_EMU_34XX_VIRT + ETM_CORSIGHT_OFF)
> +#define CORTEX_EMU_ETM_P        (L4_EMU_34XX_PHYS + ETM_CORSIGHT_OFF)
> +
>          .text
>  /* Function to aquire the semaphore in scratchpad */
>  ENTRY(lock_scratchpad_sem)
> @@ -226,6 +233,18 @@ loop:
>  	nop
>  	bl wait_sdrc_ok
>  
> +#ifdef CONFIG_ENABLE_OFF_MODE_JTAG_ETM_DEBUG
> +	/*
> +	 * Restore Coresight debug registers
> +	 */
> +	ldr     r6, debug_vbase      /* base Vaddr of CortexA8-Debug */
> +	ldr     r4, debug_xlar_key   /* get lock key for OSLAR */
> +	bl      unlock_debug         /* remove global lock if set */
> +	ldr     r6, etm_vbase        /* base Vaddr of ETM */
> +	bl      unlock_debug         /* remove global lock if set */
> +	str     r6, [r6, #0x300]     /* clear OSLAR lock using non-key */
> +#endif
> +
>  	ldmfd	sp!, {r0-r12, pc}		@ restore regs and return
>  restore_es3:
>  	/*b restore_es3*/		@ Enable to debug restore code
> @@ -385,6 +404,50 @@ logic_l1_restore:
>  	/*normal memory remap register */
>  	MCR p15, 0, r5, c10, c2, 1
>  
> +#ifdef CONFIG_ENABLE_OFF_MODE_JTAG_ETM_DEBUG
> +	/*
> +	 * Restore Coresight debug registers
> +	 */
> +	ldr     r6, debug_pbase      /* base paddr of CortexA8-Debug */
> +	ldr     r4, debug_xlar_key   /* get lock key for OSLAR */
> +	bl      unlock_debug         /* remove global lock if set */
> +	str     r4, [r6, #0x300]     /* reset-pointer (already locked) */
> +	ldr     r4, [r6, #0x308]     /* dummy read */
> +	ldr     r4, [r3], #4         /* load save size */
> +	cmp     r4, #0               /* check for zero */
> +debug_restore:
> +	ittt    ne                   /* t2/compat if-then block */
> +	ldrne   r5, [r3], #4         /* get save value */
> +	strne   r5, [r6,#0x308]      /* restore cp14 value */
> +	subnes  r4, r4, #1           /* decrement loop */
> +	bne     debug_restore        /* loop till done */
> +	str     r5, [r6, #0x300]     /* clear lock */
> +	/*
> +	 * Restore CoreSight ETM registers
> +	 */
> +	ldr     r6, etm_pbase        /* base paddr of ETM */
> +	ldr     r4, debug_xlar_key   /* get lock key for OSLAR */
> +	bl      unlock_debug         /* remove global lock if set */
> +	ldr     r4, [r3], #4         /* load save size */
> +	cmp     r4, #0               /* check for zero */
> +	beq     etm_skip
> +	sub     r4, #1
> +	ldr     r7, [r3], #4         /* get/store first value to r7 */
> +	mov     r5, #0x3             /* enable programming in ETMCR*/
> +	lsl     r5, r5, #10
> +	orr     r5, r7
> +	str     r5,[r6], #4
> +	cmp     r4, #0               /* check for zero */
> +etm_restore:
> +	ldrne   r5, [r3], #4         /* get save value */
> +	strne   r5, [r6], #4         /* restore cp14 value */
> +	subnes  r4, r4, #1           /* decrement loop */
> +	bne     etm_restore          /* loop till done */
> +	ldr     r6, etm_pbase        /* base paddr of ETM */
> +	str     r7,[r6]              /* dis-able programming in ETMCR */
> +etm_skip:
> +#endif
> +
>  	/* Restore cpsr */
>  	ldmia	r3!,{r4}	/*load CPSR from SDRAM*/
>  	msr	cpsr, r4	/*store cpsr */
> @@ -506,6 +569,39 @@ l1_logic_lost:
>  	mrc	p15, 0, r5, c10, c2, 1
>  	stmia	r8!,{r4-r5}
>  
> +#ifdef CONFIG_ENABLE_OFF_MODE_JTAG_ETM_DEBUG
> +	/*
> +	 * Save Coresight debug registers
> +	 */
> +	ldr     r6, debug_vbase      /* base vaddr of CortexA8-Debug */
> +	ldr     r4, debug_xlar_key   /* get lock key for OSLAR */
> +	bl      unlock_debug         /* force global unlock */
> +	str     r4, [r6, #0x300]     /* lock debug access */
> +	ldr     r4, [r6, #0x308]     /* OSSRR returns size on first read */
> +	str     r4, [r8], #4         /* push item to save area */
> +	cmp     r4, #0               /* zero check */
> +debug_save:
> +	ittt    ne                   /* thumb 2 compat if-then block */
> +	ldrne   r5, [r6, #0x308]     /* get reg value */
> +	strne   r5, [r8], #4         /* push item to save area */
> +	subnes  r4, r4, #1           /* decrement size */
> +	bne     debug_save           /* loop till done */
> +	/*
> +	 * Save etm registers
> +	 */
> +	ldr     r6, etm_vbase        /* base vaddr of CortexA8-Debug */
> +	ldr     r4, debug_xlar_key   /* get lock key for OSLAR */
> +	bl      unlock_debug         /* force global unlock */
> +	mov     r4, #128             /* OSSRR returns size on first read */
> +	str     r4, [r8], #4         /* push item to save area */
> +	cmp     r4, #0               /* zero check */
> +etm_save:
> +	ldrne   r5, [r6], #4         /* get reg value */
> +	strne   r5, [r8], #4         /* push item to save area */
> +	subnes  r4, r4, #1           /* decrement size */
> +	bne     etm_save             /* loop till done */
> +#endif
> +
>  	/* Store current cpsr*/
>  	mrs	r2, cpsr
>  	stmia	r8!, {r2}
> @@ -520,6 +616,7 @@ clean_caches:
>  	cmp	r9, #1 /* Check whether L2 inval is required or not*/
>  	bne	skip_l2_inval
>  clean_l2:
> +#if 0
>  	/* read clidr */
>  	mrc     p15, 1, r0, c0, c0, 1
>  	/* extract loc from clidr */
> @@ -586,6 +683,12 @@ finished:
>  	/* select current cache level in cssr */
>  	mcr     p15, 2, r10, c0, c0, 0
>  	isb
> +#else
> +	ldr r1, kernel_flush     /* get 32 bit addr of flush */
> +	mov lr, pc               /* prepare for return */
> +	bx  r1                   /* do it */
> +#endif
> +
>  skip_l2_inval:
>  	/* Data memory barrier and Data sync barrier */
>  	mov     r1, #0
> @@ -632,6 +735,36 @@ wait_dll_lock:
>          bne     wait_dll_lock
>          bx      lr
>  
> +#ifdef CONFIG_ENABLE_OFF_MODE_JTAG_ETM_DEBUG
> +	/*
> +	 * unlock debug:
> +	 *  Input:
> +	 *      r6 has base address of emulation
> +	 *      r4 has unlock key
> +	 *  Output
> +	 *      r5 has PDS value (1=accessable)
> +	 */
> +unlock_debug:
> +	ldr     r5, [r6, #0xfb4]     /* get LSR */
> +	cmp     r5, #0x3             /* need unlocking? */
> +	streq   r4, [r6, #0xfb0]     /* unlock if so */
> +	ldr     r5, [r6, #0x314]     /* clear power status */
> +	bx      lr                   /* back to caller */
> +
> +debug_vbase:
> +	.word CORTEX_EMU_DEBUG_V
> +debug_pbase:
> +	.word CORTEX_EMU_DEBUG_P
> +etm_vbase:
> +	.word CORTEX_EMU_ETM_V
> +etm_pbase:
> +	.word CORTEX_EMU_ETM_P
> +debug_xlar_key:
> +	.word 0xC5ACCE55
> +#endif
> +
> +kernel_flush:
> +	.word v7_flush_dcache_all
>  cm_idlest1_core:
>  	.word	CM_IDLEST1_CORE_V
>  sdrc_dlla_status:
> diff --git a/arch/arm/plat-omap/include/plat/control.h b/arch/arm/plat-omap/include/plat/control.h
> index 69428ff..22c492c 100644
> --- a/arch/arm/plat-omap/include/plat/control.h
> +++ b/arch/arm/plat-omap/include/plat/control.h
> @@ -324,7 +324,7 @@ extern void omap3_save_scratchpad_contents(void);
>  extern void omap3_clear_scratchpad_contents(void);
>  extern u32 *get_restore_pointer(void);
>  extern u32 *get_es3_restore_pointer(void);
> -extern u32 omap3_arm_context[128];
> +extern u32 omap3_arm_context[256];
>  extern void omap3_control_save_context(void);
>  extern void omap3_control_restore_context(void);
>  
> -- 
> 1.6.3.3
