From: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v2 1/3] ARM: omap: Enable low-level omap3 PM code to work
	withCONFIG_THUMB2_KERNEL
Date: Tue, 7 Dec 2010 12:01:58 +0530
Message-ID: <8ff74b57e40b64459978eefba8f4c9ca@mail.gmail.com>
References: <1291656937-24992-1-git-send-email-dave.martin@linaro.org>
	<1291656937-24992-2-git-send-email-dave.martin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1291656937-24992-2-git-send-email-dave.martin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Dave Martin <dave.martin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Dave,
> -----Original Message-----
> From: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org [mailto:linaro-dev-
> bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org] On Behalf Of Dave Martin
> Sent: Monday, December 06, 2010 11:06 PM
> To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> Cc: Tony Lindgren; Dave Martin; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linaro-
> dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
> Subject: [PATCH v2 1/3] ARM: omap: Enable low-level omap3 PM code to
work
> withCONFIG_THUMB2_KERNEL
>
> sleep34xx.S, sram34xx.S:
>
>   * Added ENDPROC() directives for all exported function symbols.
>     Without these, exported function symbols are not correctly
>     identified as Thumb by the linker, causing incorrect linkage.
>     This is needed to avoid some calls to the functions ending up
>     with the CPU in the wrong instruction set.
>
>   * Added .align directives where needed to ensure that .word won't
>     be misaligned.  (Note that ENTRY() implies .align; no extra
>     .align has been added for these cases.)
>
>   * Exported new "base address" symbols for functions which get
>     copied to sram by code outside sleep34xx.S (applies to
>     save_secure_ram_context and omap32xx_cpu_suspend), and fix up
>     the relevant address arithmetic so that these will be copied
>     and called correctly by the Thumb code in the rest of the
>     kernel.
>
>   * Explicitly build a few parts of sleep34xx.S as ARM.
>
>       * lock_scratchpad_sem is kept as ARM because of the need to
>         synchronise with hardware (?) using the SWP instruction.
>
>       * save_secure_ram_context and omap34xx_cpu_suspend are built
>         as ARM in case the Secure World firmware expects to decode
>         the comment field from the SMC (aka smi) instructions.
>
>         This can be undone later if the firmware is confirmed as
>         able to decode the Thumb SMC encoding (or ignores the
>         comment field).
>
>       * es3_sdrc_fix should presumably only be called from the
>         low-level wakeup code.  To minimise the diff, switched this
>         to ARM and demoted it to be a local symbol, since I believe
>         it shouldn't be called from outside anyway.
>
>      To prevent future maintainence problems, it would probably be
>      a good idea to demote _all_ functions which aren't called
>      externally to local.  (i.e., everything except for
>      get_es3_restore_pointer, get_restore_pointer,
>      omap34xx_cpu_suspend and save_secure_ram_context).
>
>      For now, I've left these as-is to minimise disruption.
>
>    * Use a separate base register instead of PC-relative stores in
>      sram34xx.S.  This isn't permitted in Thumb-2, but at least
>      some versions of gas will silently output non-working code,
>      leading to unpredictable run-time behaviour.
>
> pm34xx.c, pm.h, sram.c, sram.h:
>
>   * Resolve some memory addressing issues where a function symbol's
>     value is assumed to be equal to the start address of the
>     function body for the purpose of copying some low-level code
>     from sleep34xx.S to SRAM.
>
>     This assumption breaks for Thumb, since Thumb functions symbols
>     have bit 0 set to indicate the Thumb-ness.  This would result
>     in a non-working, off-by-one copy of the function body.
>
> Tested on Beagle xM A2:
>   * CONFIG_THUMB2_KERNEL && !CONFIG_SMP_ON_UP
>   * CONFIG_THUMB2_KERNEL && CONFIG_SMP_ON_UP
>   * !CONFIG_THUMB2_KERNEL && !CONFIG_SMP_ON_UP
>   * !CONFIG_THUMB2_KERNEL && CONFIG_SMP_ON_UP
>
> Signed-off-by: Dave Martin <dave.martin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
> KernelVersion: 2.6.37-rc4

No need to mention but this patch changes lot of things around
power management code. You said " Tested on: omap3 (Beagle xM A2)"

What did you test ? Is it just boot test ? For sure just boot
test is not enough for this patch and needs to test the PM.

>
>  arch/arm/mach-omap2/pm.h               |    2 +
>  arch/arm/mach-omap2/pm34xx.c           |   13 ++++++++--
>  arch/arm/mach-omap2/sleep34xx.S        |   37
> +++++++++++++++++++++++++++++--
>  arch/arm/mach-omap2/sram34xx.S         |   34
+++++++++++++++++++++------
> -
>  arch/arm/plat-omap/include/plat/sram.h |    1 +
>  arch/arm/plat-omap/sram.c              |   10 +++++++-
>  6 files changed, 80 insertions(+), 17 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index 0d75bfd..c333bfd 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -80,7 +80,9 @@ extern void save_secure_ram_context(u32 *addr);
>  extern void omap3_save_scratchpad_contents(void);
>
>  extern unsigned int omap24xx_idle_loop_suspend_sz;
> +extern char *const omap34xx_cpu_suspend_base;
>  extern unsigned int omap34xx_suspend_sz;
> +extern char *const save_secure_ram_context_base;
>  extern unsigned int save_secure_ram_context_sz;
>  extern unsigned int omap24xx_cpu_suspend_sz;
>  extern unsigned int omap34xx_cpu_suspend_sz;
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 0ec8a04..93f0ee8 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -982,11 +982,18 @@ static int __init clkdms_setup(struct clockdomain
> *clkdm, void *unused)
>
>  void omap_push_sram_idle(void)
>  {
> -	_omap_sram_idle = omap_sram_push(omap34xx_cpu_suspend,
> +	_omap_sram_idle = omap_sram_push(omap34xx_cpu_suspend_base,
>  					omap34xx_cpu_suspend_sz);
> -	if (omap_type() != OMAP2_DEVICE_TYPE_GP)
> -		_omap_save_secure_sram =
> omap_sram_push(save_secure_ram_context,
> +	_omap_sram_idle += (char *)omap34xx_cpu_suspend -
> +		omap34xx_cpu_suspend_base;
> +
> +	if (omap_type() != OMAP2_DEVICE_TYPE_GP) {
> +		_omap_save_secure_sram = omap_sram_push(
> +				save_secure_ram_context_base,
>  				save_secure_ram_context_sz);
> +		_omap_save_secure_sram += (char *)save_secure_ram_context
-
> +			save_secure_ram_context_base;
> +	}
>  }
>
>  static int __init omap3_pm_init(void)
> diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-
> omap2/sleep34xx.S
> index 2fb205a..06ae955 100644
> --- a/arch/arm/mach-omap2/sleep34xx.S
> +++ b/arch/arm/mach-omap2/sleep34xx.S
> @@ -61,6 +61,7 @@
>
>          .text
>  /* Function to acquire the semaphore in scratchpad */
> +	.arm			@ Do this in ARM for now, due to use of
SWP.
>  ENTRY(lock_scratchpad_sem)
>  	stmfd	sp!, {lr}	@ save registers on stack
>  wait_sem:
> @@ -74,6 +75,9 @@ wait_loop:
>  	cmp	r2, r0		@ did we succeed ?
>  	beq	wait_sem	@ no - try again
>  	ldmfd	sp!, {pc}	@ restore regs and return
> +ENDPROC(lock_scratchpad_sem)
> + THUMB(	.thumb		)
> +	.align
>  sdrc_scratchpad_sem:
>          .word SDRC_SCRATCHPAD_SEM_V
>  ENTRY(lock_scratchpad_sem_sz)
> @@ -87,6 +91,7 @@ ENTRY(unlock_scratchpad_sem)
>  	mov	r2,#0
>  	str	r2,[r3]
>  	ldmfd	sp!, {pc}	@ restore regs and return
> +ENDPROC(unlock_scratchpad_sem)
>  ENTRY(unlock_scratchpad_sem_sz)
>          .word   . - unlock_scratchpad_sem
>
> @@ -96,6 +101,7 @@ ENTRY(get_restore_pointer)
>          stmfd   sp!, {lr}     @ save registers on stack
>  	adr	r0, restore
>          ldmfd   sp!, {pc}     @ restore regs and return
> +ENDPROC(get_restore_pointer)
>  ENTRY(get_restore_pointer_sz)
>          .word   . - get_restore_pointer
>
> @@ -105,10 +111,16 @@ ENTRY(get_es3_restore_pointer)
>  	stmfd	sp!, {lr}	@ save registers on stack
>  	adr	r0, restore_es3
>  	ldmfd	sp!, {pc}	@ restore regs and return
> +ENDPROC(get_es3_restore_pointer)
>  ENTRY(get_es3_restore_pointer_sz)
>  	.word	. - get_es3_restore_pointer
>
> -ENTRY(es3_sdrc_fix)
> +@ For simplicity, make this ARM so it gets called OK from es3_restore.
> +@ Demote to a local symbol, since this gives this function an ARM ABI
> interface
> +@ which won't be callable directly from a Thumb-2 kernel.  This code
> +@ shouldn't be called from outside anyway...
> +	.arm
> +es3_sdrc_fix:
>  	ldr	r4, sdrc_syscfg		@ get config addr
>  	ldr	r5, [r4]		@ get value
>  	tst	r5, #0x100		@ is part access blocked
> @@ -134,6 +146,9 @@ ENTRY(es3_sdrc_fix)
>  	mov	r5, #0x2		@ autorefresh command
>  	str	r5, [r4]		@ kick off refreshes
>  	bx	lr
> +ENDPROC(es3_sdrc_fix)
> + THUMB(	.thumb		)
> +	.align
>  sdrc_syscfg:
>  	.word	SDRC_SYSCONFIG_P
>  sdrc_mr_0:
> @@ -150,8 +165,12 @@ sdrc_manual_1:
>  	.word	SDRC_MANUAL_1_P
>  ENTRY(es3_sdrc_fix_sz)
>  	.word	. - es3_sdrc_fix
> + THUMB(	.thumb		)
>
>  /* Function to call rom code to save secure ram context */
> +	.arm			@ Do this in ARM for now, due to use of
SMC,
> +				@ in case the Secure World firmware may
depends
> +				@ on decoding the SMC instruction.
>  ENTRY(save_secure_ram_context)
>  	stmfd	sp!, {r1-r12, lr}	@ save registers on stack
>  save_secure_ram_debug:
> @@ -175,6 +194,9 @@ save_secure_ram_debug:
>  	nop
>  	nop
>  	ldmfd	sp!, {r1-r12, pc}
> +ENDPROC(save_secure_ram_context)
> + THUMB(	.thumb		)
> +	.align
>  sram_phy_addr_mask:
>  	.word	SRAM_BASE_P
>  high_mask:
> @@ -183,6 +205,8 @@ api_params:
>  	.word	0x4, 0x0, 0x0, 0x1, 0x1
>  ENTRY(save_secure_ram_context_sz)
>  	.word	. - save_secure_ram_context
> +ENTRY(save_secure_ram_context_base)
> +	.word	save_secure_ram_context_base
>
>  /*
>   * Forces OMAP into idle state
> @@ -193,6 +217,7 @@ ENTRY(save_secure_ram_context_sz)
>   * Note: This code get's copied to internal SRAM at boot. When the OMAP
>   *	 wakes up it continues execution at the point it went to sleep.
>   */
> +	.arm			@ Do this in ARM for now, due to use of
SMC.
>  ENTRY(omap34xx_cpu_suspend)
>  	stmfd	sp!, {r0-r12, lr}		@ save registers on stack
>  loop:
> @@ -563,10 +588,12 @@ loop2:
>  	mov     r9, r4
>  	/* create working copy of max way size*/
>  loop3:
> +	mov     r1, r9, lsl r5
> +	mov     r2, r7, lsl r2
>  	/* factor way and cache number into r11 */
> -	orr     r11, r10, r9, lsl r5
> +	orr     r11, r10, r1
>  	/* factor index number into r11 */
> -	orr     r11, r11, r7, lsl r2
> +	orr     r11, r11, r2
>  	/*clean & invalidate by set/way */
>  	mcr     p15, 0, r11, c7, c10, 2
>  	/* decrement the way*/
> @@ -631,7 +658,9 @@ wait_dll_lock:
>          cmp     r5, #0x4
>          bne     wait_dll_lock
>          bx      lr
> +ENDPROC(omap34xx_cpu_suspend)
>
> +	.align
>  cm_idlest1_core:
>  	.word	CM_IDLEST1_CORE_V
>  sdrc_dlla_status:
> @@ -670,3 +699,5 @@ control_stat:
>  	.word	CONTROL_STAT
>  ENTRY(omap34xx_cpu_suspend_sz)
>  	.word	. - omap34xx_cpu_suspend
> +ENTRY(omap34xx_cpu_suspend_base)
> +	.word	omap34xx_cpu_suspend
> diff --git a/arch/arm/mach-omap2/sram34xx.S b/arch/arm/mach-
> omap2/sram34xx.S
> index 3637274..65fd54f 100644
> --- a/arch/arm/mach-omap2/sram34xx.S
> +++ b/arch/arm/mach-omap2/sram34xx.S
> @@ -105,29 +105,42 @@
>   * can satisfy the above requirement can enable the
> CONFIG_OMAP3_SDRC_AC_TIMING
>   * option.
>   */
> +__omap3_sram_configure_core_dpll_base:	@ Separate local symbol
with the
> Thumb
> +					@ bit _not_ set (for base address
when
> +					@ copying to sram).
>  ENTRY(omap3_sram_configure_core_dpll)
>  	stmfd	sp!, {r1-r12, lr}	@ store regs to stack
>
>  					@ pull the extra args off the
stack
>  					@  and store them in SRAM
> +
> +@ PC-relative stores lead to undefined behaviour in Thumb-2: use a r7
as
> a
> +@ base instead.
> +@ Be careful not to clobber r7 when maintaing this file.
> + THUMB(	adr	r7, omap3_sram_configure_core_dpll
)
> +	.macro strtext Rt:req, label:req
> + ARM(	str	\Rt, \label
)
> + THUMB(	str	\Rt, [r7, \label - omap3_sram_configure_core_dpll]
)
> +	.endm
> +
>  	ldr	r4, [sp, #52]
> -	str     r4, omap_sdrc_rfr_ctrl_0_val
> +	strtext	r4, omap_sdrc_rfr_ctrl_0_val
>  	ldr	r4, [sp, #56]
> -	str     r4, omap_sdrc_actim_ctrl_a_0_val
> +	strtext	r4, omap_sdrc_actim_ctrl_a_0_val
>  	ldr	r4, [sp, #60]
> -	str     r4, omap_sdrc_actim_ctrl_b_0_val
> +	strtext	r4, omap_sdrc_actim_ctrl_b_0_val
>  	ldr	r4, [sp, #64]
> -	str     r4, omap_sdrc_mr_0_val
> +	strtext	r4, omap_sdrc_mr_0_val
>  	ldr	r4, [sp, #68]
> -	str     r4, omap_sdrc_rfr_ctrl_1_val
> +	strtext	r4, omap_sdrc_rfr_ctrl_1_val
>  	cmp	r4, #0			@ if SDRC_RFR_CTRL_1 is 0,
>  	beq	skip_cs1_params		@  do not use cs1 params
>  	ldr	r4, [sp, #72]
> -	str     r4, omap_sdrc_actim_ctrl_a_1_val
> +	strtext	r4, omap_sdrc_actim_ctrl_a_1_val
>  	ldr	r4, [sp, #76]
> -	str     r4, omap_sdrc_actim_ctrl_b_1_val
> +	strtext	r4, omap_sdrc_actim_ctrl_b_1_val
>  	ldr	r4, [sp, #80]
> -	str     r4, omap_sdrc_mr_1_val
> +	strtext	r4, omap_sdrc_mr_1_val
>  skip_cs1_params:
>  	mrc	p15, 0, r8, c1, c0, 0	@ read ctrl register
>  	bic	r10, r8, #0x800		@ clear Z-bit, disable branch
> prediction
> @@ -264,7 +277,9 @@ configure_sdrc:
>  skip_cs1_prog:
>  	ldr	r12, [r11]		@ posted-write barrier for SDRC
>  	bx	lr
> +ENDPROC(omap3_sram_configure_core_dpll)
>
> +	.align
>  omap3_sdrc_power:
>  	.word OMAP34XX_SDRC_REGADDR(SDRC_POWER)
>  omap3_cm_clksel1_pll:
> @@ -316,4 +331,5 @@ core_m2_mask_val:
>
>  ENTRY(omap3_sram_configure_core_dpll_sz)
>  	.word	. - omap3_sram_configure_core_dpll
> -
> +ENTRY(omap3_sram_configure_core_dpll_base)
> +	.word	__omap3_sram_configure_core_dpll_base
> diff --git a/arch/arm/plat-omap/include/plat/sram.h b/arch/arm/plat-
> omap/include/plat/sram.h
> index 5905100..2f27167 100644
> --- a/arch/arm/plat-omap/include/plat/sram.h
> +++ b/arch/arm/plat-omap/include/plat/sram.h
> @@ -67,6 +67,7 @@ extern u32 omap3_sram_configure_core_dpll(
>  			u32 sdrc_rfr_ctrl_1, u32 sdrc_actim_ctrl_a_1,
>  			u32 sdrc_actim_ctrl_b_1, u32 sdrc_mr_1);
>  extern unsigned long omap3_sram_configure_core_dpll_sz;
> +extern char *omap3_sram_configure_core_dpll_base;
>
>  #ifdef CONFIG_PM
>  extern void omap_push_sram_idle(void);
> diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
> index e2c8eeb..61282f4 100644
> --- a/arch/arm/plat-omap/sram.c
> +++ b/arch/arm/plat-omap/sram.c
> @@ -386,8 +386,11 @@ void omap3_sram_restore_context(void)
>  	omap_sram_ceil = omap_sram_base + omap_sram_size;
>
>  	_omap3_sram_configure_core_dpll =
> -		omap_sram_push(omap3_sram_configure_core_dpll,
> +		omap_sram_push(omap3_sram_configure_core_dpll_base,
>  			       omap3_sram_configure_core_dpll_sz);
> +	_omap3_sram_configure_core_dpll +=
> +		(char *)omap3_sram_configure_core_dpll -
> +		omap3_sram_configure_core_dpll_base;
>  	omap_push_sram_idle();
>  }
>  #endif /* CONFIG_PM */
> @@ -395,8 +398,11 @@ void omap3_sram_restore_context(void)
>  static int __init omap34xx_sram_init(void)
>  {
>  	_omap3_sram_configure_core_dpll =
> -		omap_sram_push(omap3_sram_configure_core_dpll,
> +		omap_sram_push(omap3_sram_configure_core_dpll_base,
>  			       omap3_sram_configure_core_dpll_sz);
> +	_omap3_sram_configure_core_dpll +=
> +		(char *)omap3_sram_configure_core_dpll -
> +		omap3_sram_configure_core_dpll_base;
>  	omap_push_sram_idle();
>  	return 0;
>  }
> --
> 1.7.1
>
>
> _______________________________________________
> linaro-dev mailing list
> linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
> http://lists.linaro.org/mailman/listinfo/linaro-dev
