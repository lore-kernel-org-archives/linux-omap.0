From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH 5/6] ARM: pm: convert samsung platforms to generic
 suspend/resume support
Date: Thu, 17 Feb 2011 21:09:02 +0900
Message-ID: <017901cbce9b$7b405ee0$71c11ca0$%kim@samsung.com>
References: <20110211161626.GA31356@n2100.arm.linux.org.uk>
 <E1Pnvhv-0002yp-A0@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:18039 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753532Ab1BQMJM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Feb 2011 07:09:12 -0500
Received: from epmmp2 (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LGR000MYGF95YE0@mailout3.samsung.com> for
 linux-omap@vger.kernel.org; Thu, 17 Feb 2011 21:09:09 +0900 (KST)
Received: from DOKGENEKIM02 ([12.23.103.104])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LGR00JCFGF9XH@mmp2.samsung.com> for
 linux-omap@vger.kernel.org; Thu, 17 Feb 2011 21:09:09 +0900 (KST)
In-reply-to: <E1Pnvhv-0002yp-A0@rmk-PC.arm.linux.org.uk>
Content-language: ko
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Russell King - ARM Linux' <linux@arm.linux.org.uk>, 'Eric Miao' <eric.y.miao@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Russell King - ARM Linux wrote:
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/mach-s3c64xx/sleep.S           |   63 +-----------------
>  arch/arm/mach-s5pv210/sleep.S           |  104
+----------------------------
> --
>  arch/arm/plat-s3c24xx/sleep.S           |   57 +----------------
>  arch/arm/plat-samsung/include/plat/pm.h |   12 +---
>  arch/arm/plat-samsung/pm.c              |   16 +-----
>  5 files changed, 13 insertions(+), 239 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c64xx/sleep.S b/arch/arm/mach-s3c64xx/sleep.S
> index b2ef443..afe5a76 100644
> --- a/arch/arm/mach-s3c64xx/sleep.S
> +++ b/arch/arm/mach-s3c64xx/sleep.S
> @@ -32,25 +32,13 @@
>  	 * code after resume.
>  	 *
>  	 * entry:
> -	 *	r0 = pointer to the save block
> +	 *	r1 = v:p offset
>  	*/
> 
>  ENTRY(s3c_cpu_save)
>  	stmfd	sp!, { r4 - r12, lr }
> -
> -	mrc	p15, 0, r4, c13, c0, 0	@ FCSE/PID
> -	mrc	p15, 0, r5, c3, c0, 0	@ Domain ID
> -	mrc	p15, 0, r6, c2, c0, 0	@ Translation Table BASE0
> -	mrc	p15, 0, r7, c2, c0, 1	@ Translation Table BASE1
> -	mrc	p15, 0, r8, c2, c0, 2	@ Translation Table Control
> -	mrc	p15, 0, r9, c1, c0, 0	@ Control register
> -	mrc	p15, 0, r10, c1, c0, 1	@ Auxiliary control register
> -	mrc	p15, 0, r11, c1, c0, 2	@ Co-processor access controls
> -
> -	stmia	r0, { r4 - r13 }	@ Save CP registers and SP
> -
> -	@@ save our state to ram
> -	bl	s3c_pm_cb_flushcache
> +	ldr	r3, =resume_with_mmu
> +	bl	cpu_suspend
> 
>  	@@ call final suspend code
>  	ldr	r0, =pm_cpu_sleep
> @@ -61,18 +49,6 @@ ENTRY(s3c_cpu_save)
>  resume_with_mmu:
>  	ldmfd	sp!, { r4 - r12, pc }	@ return, from sp from s3c_cpu_save
> 
> -	.data
> -
> -	/* the next bit is code, but it requires easy access to the
> -	 * s3c_sleep_save_phys data before the MMU is switched on, so
> -	 * we store the code that needs this variable in the .data where
> -	 * the value can be written to (the .text segment is RO).
> -	*/
> -
> -	.global	s3c_sleep_save_phys
> -s3c_sleep_save_phys:
> -	.word	0
> -
>  	/* Sleep magic, the word before the resume entry point so that the
>  	 * bootloader can check for a resumeable image. */
> 
> @@ -110,35 +86,4 @@ ENTRY(s3c_cpu_resume)
>  	orr	r0, r0, #1 << 15			@ GPN15
>  	str	r0, [ r3, #S3C64XX_GPNDAT ]
>  #endif
> -
> -	/* __v6_setup from arch/arm/mm/proc-v6.S, ensure that the caches
> -	 * are thoroughly cleaned just in case the bootloader didn't do it
> -	 * for us. */
> -	mov	r0, #0
> -	mcr	p15, 0, r0, c7, c14, 0		@ clean+invalidate D cache
> -	mcr	p15, 0, r0, c7, c5, 0		@ invalidate I cache
> -	mcr	p15, 0, r0, c7, c15, 0		@ clean+invalidate cache
> -	mcr	p15, 0, r0, c7, c10, 4		@ drain write buffer
> -	@@mcr	p15, 0, r0, c8, c7, 0		@ invalidate I + D TLBs
> -	@@mcr	p15, 0, r0, c7, c7, 0		@ Invalidate I + D caches
> -
> -	ldr	r0, s3c_sleep_save_phys
> -	ldmia	r0, { r4 - r13 }
> -
> -	mcr	p15, 0, r4, c13, c0, 0	@ FCSE/PID
> -	mcr	p15, 0, r5, c3, c0, 0	@ Domain ID
> -	mcr	p15, 0, r6, c2, c0, 0	@ Translation Table BASE0
> -	mcr	p15, 0, r7, c2, c0, 1	@ Translation Table BASE1
> -	mcr	p15, 0, r8, c2, c0, 2	@ Translation Table Control
> -	mcr	p15, 0, r10, c1, c0, 1	@ Auxiliary control register
> -
> -	mov	r0, #0			@ restore copro access controls
> -	mcr	p15, 0, r11, c1, c0, 2	@ Co-processor access controls
> -	mcr 	p15, 0, r0, c7, c5, 4
> -
> -	ldr	r2, =resume_with_mmu
> -	mcr	p15, 0, r9, c1, c0, 0		/* turn mmu back on */
> -	nop
> -	mov	pc, r2				/* jump back */
> -
> -	.end
> +	b	cpu_resume
> diff --git a/arch/arm/mach-s5pv210/sleep.S b/arch/arm/mach-s5pv210/sleep.S
> index d4d222b..ef4bd2a 100644
> --- a/arch/arm/mach-s5pv210/sleep.S
> +++ b/arch/arm/mach-s5pv210/sleep.S
> @@ -35,50 +35,23 @@
>  	/* s3c_cpu_save
>  	 *
>  	 * entry:
> -	 *	r0 = save address (virtual addr of s3c_sleep_save_phys)
> +	 *	r1 = v:p offset
>  	*/
> 
>  ENTRY(s3c_cpu_save)
> 
>  	stmfd	sp!, { r3 - r12, lr }
> -
> -	mrc	p15, 0, r4, c13, c0, 0	@ FCSE/PID
> -	mrc	p15, 0, r5, c3, c0, 0	@ Domain ID
> -	mrc	p15, 0, r6, c2, c0, 0	@ Translation Table BASE0
> -	mrc	p15, 0, r7, c2, c0, 1	@ Translation Table BASE1
> -	mrc	p15, 0, r8, c2, c0, 2	@ Translation Table Control
> -	mrc	p15, 0, r9, c1, c0, 0	@ Control register
> -	mrc	p15, 0, r10, c1, c0, 1	@ Auxiliary control register
> -	mrc	p15, 0, r11, c1, c0, 2	@ Co-processor access controls
> -	mrc	p15, 0, r12, c10, c2, 0	@ Read PRRR
> -	mrc	p15, 0, r3, c10, c2, 1	@ READ NMRR
> -
> -	stmia	r0, { r3 - r13 }
> -
> -	bl	s3c_pm_cb_flushcache
> +	bl	cpu_suspend
> 
>  	ldr	r0, =pm_cpu_sleep
>  	ldr	r0, [ r0 ]
>  	mov	pc, r0
> 
>  resume_with_mmu:
> -	/*
> -	 * After MMU is turned on, restore the previous MMU table.
> -	 */
> -	ldr	r9 , =(PAGE_OFFSET - PHYS_OFFSET)
> -	add	r4, r4, r9
> -	str	r12, [r4]
> -
>  	ldmfd	sp!, { r3 - r12, pc }
> 
>  	.ltorg
> 
> -	.data
> -
> -	.global	s3c_sleep_save_phys
> -s3c_sleep_save_phys:
> -	.word	0
> -
>  	/* sleep magic, to allow the bootloader to check for an valid
>  	 * image to resume to. Must be the first word before the
>  	 * s3c_cpu_resume entry.
> @@ -96,75 +69,4 @@ s3c_sleep_save_phys:
>  	*/
> 
>  ENTRY(s3c_cpu_resume)
> -	mov	r0, #PSR_I_BIT | PSR_F_BIT | SVC_MODE
> -	msr	cpsr_c, r0
> -
> -	mov	r1, #0
> -	mcr	p15, 0, r1, c8, c7, 0		@ invalidate TLBs
> -	mcr	p15, 0, r1, c7, c5, 0		@ invalidate I Cache
> -
> -	ldr	r0, s3c_sleep_save_phys		@ address of restore
> block
> -	ldmia	r0, { r3 - r13 }
> -
> -	mcr	p15, 0, r4, c13, c0, 0		@ FCSE/PID
> -	mcr	p15, 0, r5, c3, c0, 0		@ Domain ID
> -
> -	mcr	p15, 0, r8, c2, c0, 2		@ Translation Table Control
> -	mcr	p15, 0, r7, c2, c0, 1		@ Translation Table BASE1
> -	mcr	p15, 0, r6, c2, c0, 0		@ Translation Table BASE0
> -
> -	mcr	p15, 0, r10, c1, c0, 1		@ Auxiliary control register
> -
> -	mov	r0, #0
> -	mcr	p15, 0, r0, c8, c7, 0		@ Invalidate I & D TLB
> -
> -	mov	r0, #0				@ restore copro access
> -	mcr	p15, 0, r11, c1, c0, 2		@ Co-processor access
> -	mcr 	p15, 0, r0, c7, c5, 4
> -
> -	mcr	p15, 0, r12, c10, c2, 0		@ write PRRR
> -	mcr	p15, 0, r3, c10, c2, 1		@ write NMRR
> -
> -	/*
> -	 * In Cortex-A8, when MMU is turned on, the pipeline is flushed.
> -	 * And there are no valid entries in the MMU table at this point.
> -	 * So before turning on the MMU, the MMU entry for the DRAM address
> -	 * range is added. After the MMU is turned on, the other entries
> -	 * in the MMU table will be restored.
> -	*/
> -
> -	/* r6 = Translation Table BASE0 */
> -	mov	r4, r6
> -	mov	r4, r4, LSR #14
> -	mov	r4, r4, LSL #14
> -
> -	/* Load address for adding to MMU table list */
> -	ldr	r11, =0xE010F000		@ INFORM0 reg.
> -	ldr	r10, [r11, #0]
> -	mov	r10, r10, LSR #18
> -	bic	r10, r10, #0x3
> -	orr	r4, r4, r10
> -
> -	/* Calculate MMU table entry */
> -	mov 	r10, r10, LSL #18
> -	ldr	r5, =0x40E
> -	orr	r10, r10, r5
> -
> -	/* Back up originally data */
> -	ldr	r12, [r4]
> -
> -	/* Add calculated MMU table entry into MMU table list */
> -	str	r10, [r4]
> -
> -	ldr	r2, =resume_with_mmu
> -	mcr	p15, 0, r9, c1, c0, 0		@ turn on MMU, etc
> -
> -	nop
> -	nop
> -	nop
> -	nop
> -	nop					@ second-to-last before mmu
> -
> -	mov	pc, r2				@ go back to virtual address
> -
> -	.ltorg
> +	b	cpu_resume
> diff --git a/arch/arm/plat-s3c24xx/sleep.S b/arch/arm/plat-s3c24xx/sleep.S
> index e73e3b6..fd7032f 100644
> --- a/arch/arm/plat-s3c24xx/sleep.S
> +++ b/arch/arm/plat-s3c24xx/sleep.S
> @@ -44,23 +44,13 @@
>  	/* s3c_cpu_save
>  	 *
>  	 * entry:
> -	 *	r0 = save address (virtual addr of s3c_sleep_save_phys)
> +	 *	r1 = v:p offset
>  	*/
> 
>  ENTRY(s3c_cpu_save)
>  	stmfd	sp!, { r4 - r12, lr }
> -
> -	@@ store co-processor registers
> -
> -	mrc	p15, 0, r4, c13, c0, 0	@ PID
> -	mrc	p15, 0, r5, c3, c0, 0	@ Domain ID
> -	mrc	p15, 0, r6, c2, c0, 0	@ translation table base address
> -	mrc	p15, 0, r7, c1, c0, 0	@ control register
> -
> -	stmia	r0, { r4 - r13 }
> -
> -	@@ write our state back to RAM
> -	bl	s3c_pm_cb_flushcache
> +	ldr	r3, =resume_with_mmu
> +	bl	cpu_suspend
> 
>  	@@ jump to final code to send system to sleep
>  	ldr	r0, =pm_cpu_sleep
> @@ -76,20 +66,6 @@ resume_with_mmu:
> 
>  	.ltorg
> 
> -	@@ the next bits sit in the .data segment, even though they
> -	@@ happen to be code... the s3c_sleep_save_phys needs to be
> -	@@ accessed by the resume code before it can restore the MMU.
> -	@@ This means that the variable has to be close enough for the
> -	@@ code to read it... since the .text segment needs to be RO,
> -	@@ the data segment can be the only place to put this code.
> -
> -	.data
> -
> -	.global	s3c_sleep_save_phys
> -s3c_sleep_save_phys:
> -	.word	0
> -
> -
>  	/* sleep magic, to allow the bootloader to check for an valid
>  	 * image to resume to. Must be the first word before the
>  	 * s3c_cpu_resume entry.
> @@ -100,10 +76,6 @@ s3c_sleep_save_phys:
>  	/* s3c_cpu_resume
>  	 *
>  	 * resume code entry for bootloader to call
> -	 *
> -	 * we must put this code here in the data segment as we have no
> -	 * other way of restoring the stack pointer after sleep, and we
> -	 * must not write to the code segment (code is read-only)
>  	*/
> 
>  ENTRY(s3c_cpu_resume)
> @@ -134,25 +106,4 @@ ENTRY(s3c_cpu_resume)
>  	beq	1001b
>  #endif /* CONFIG_DEBUG_RESUME */
> 
> -	mov	r1, #0
> -	mcr	p15, 0, r1, c8, c7, 0		@@ invalidate I & D TLBs
> -	mcr	p15, 0, r1, c7, c7, 0		@@ invalidate I & D caches
> -
> -	ldr	r0, s3c_sleep_save_phys		@ address of restore
> block
> -	ldmia	r0, { r4 - r13 }
> -
> -	mcr	p15, 0, r4, c13, c0, 0		@ PID
> -	mcr	p15, 0, r5, c3, c0, 0		@ Domain ID
> -	mcr	p15, 0, r6, c2, c0, 0		@ translation table base
> -
> -#ifdef CONFIG_DEBUG_RESUME
> -	mov	r3, #'R'
> -	strb	r3, [ r2, #S3C2410_UTXH ]
> -#endif
> -
> -	ldr	r2, =resume_with_mmu
> -	mcr	p15, 0, r7, c1, c0, 0		@ turn on MMU, etc
> -	nop					@ second-to-last before mmu
> -	mov	pc, r2				@ go back to virtual address
> -
> -	.ltorg
> +	b	cpu_resume
> diff --git a/arch/arm/plat-samsung/include/plat/pm.h b/arch/arm/plat-
> samsung/include/plat/pm.h
> index d9025e3..4aa697d 100644
> --- a/arch/arm/plat-samsung/include/plat/pm.h
> +++ b/arch/arm/plat-samsung/include/plat/pm.h
> @@ -50,13 +50,11 @@ extern unsigned char pm_uart_udivslot;  /* true to
save
> UART UDIVSLOT */
> 
>  /* from sleep.S */
> 
> -extern int  s3c_cpu_save(unsigned long *saveblk);
> +extern int  s3c_cpu_save(unsigned long *saveblk, long);
>  extern void s3c_cpu_resume(void);
> 
>  extern void s3c2410_cpu_suspend(void);
> 
> -extern unsigned long s3c_sleep_save_phys;
> -
>  /* sleep save info */
> 
>  /**
> @@ -179,13 +177,5 @@ extern void s3c_pm_restore_gpios(void);
>   */
>  extern void s3c_pm_save_gpios(void);
> 
> -/**
> - * s3c_pm_cb_flushcache - callback for assembly code
> - *
> - * Callback to issue flush_cache_all() as this call is
> - * not a directly callable object.
> - */
> -extern void s3c_pm_cb_flushcache(void);
> -
>  extern void s3c_pm_save_core(void);
>  extern void s3c_pm_restore_core(void);
> diff --git a/arch/arm/plat-samsung/pm.c b/arch/arm/plat-samsung/pm.c
> index 02d531f..d5b58d3 100644
> --- a/arch/arm/plat-samsung/pm.c
> +++ b/arch/arm/plat-samsung/pm.c
> @@ -241,8 +241,6 @@ void (*pm_cpu_sleep)(void);
> 
>  static int s3c_pm_enter(suspend_state_t state)
>  {
> -	static unsigned long regs_save[16];
> -
>  	/* ensure the debug is initialised (if enabled) */
> 
>  	s3c_pm_debug_init();
> @@ -266,12 +264,6 @@ static int s3c_pm_enter(suspend_state_t state)
>  		return -EINVAL;
>  	}
> 
> -	/* store the physical address of the register recovery block */
> -
> -	s3c_sleep_save_phys = virt_to_phys(regs_save);
> -
> -	S3C_PMDBG("s3c_sleep_save_phys=0x%08lx\n", s3c_sleep_save_phys);
> -
>  	/* save all necessary core registers not covered by the drivers */
> 
>  	s3c_pm_save_gpios();
> @@ -305,7 +297,7 @@ static int s3c_pm_enter(suspend_state_t state)
>  	 * we resume as it saves its own register state and restores it
>  	 * during the resume.  */
> 
> -	s3c_cpu_save(regs_save);
> +	s3c_cpu_save(0, PLAT_PHYS_OFFSET - PAGE_OFFSET);
> 
>  	/* restore the cpu state using the kernel's cpu init code. */
> 
> @@ -336,12 +328,6 @@ static int s3c_pm_enter(suspend_state_t state)
>  	return 0;
>  }
> 
> -/* callback from assembly code */
> -void s3c_pm_cb_flushcache(void)
> -{
> -	flush_cache_all();
> -}
> -
>  static int s3c_pm_prepare(void)
>  {
>  	/* prepare check area if configured */
> --
> 1.6.2.5

Hi Russell,

I tested on SMDKV210(S5PV210) and SMDKC110(S5PC110).

Firstly, looks like suspend working is fine.
But had some problem during resume :( unfortunately, didn't find fundamental
reason of it.

Shortly, the problem is that r14 has always unexpected value, 0x4 on #113
line, "cpy pc, r14" of v7_flush_cache_all.
So happened abort. I will debugging tomorrow then let you know.

As a note, I tested it based on your devel-stable branch.
If missed some stuff, please let me know :)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

