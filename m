From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 20/25] OMAP4: PM: Add L2X0 cache lowpower support
Date: Mon, 5 Sep 2011 15:01:26 +0100
Message-ID: <20110905140126.GA30520@e102568-lin.cambridge.arm.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
 <1315144466-9395-21-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:63555 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751371Ab1IEOBv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Sep 2011 10:01:51 -0400
Content-Disposition: inline
In-Reply-To: <1315144466-9395-21-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@ti.com" <khilman@ti.com>, "rnayak@ti.com" <rnayak@ti.com>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Santosh,

just a question below.

On Sun, Sep 04, 2011 at 02:54:21PM +0100, Santosh Shilimkar wrote:
> When MPUSS hits off-mode e, L2 cache is lost. This patch adds L2X0
> necessary maintenance operations and context restoration in the
> low power code.
> 
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> ---
>  arch/arm/mach-omap2/include/mach/omap-secure.h |    5 +
>  arch/arm/mach-omap2/omap-mpuss-lowpower.c      |   38 +++++++++-
>  arch/arm/mach-omap2/omap4-sar-layout.h         |    4 +
>  arch/arm/mach-omap2/sleep44xx.S                |   96 ++++++++++++++++++++++++
>  4 files changed, 142 insertions(+), 1 deletions(-)
> 

[...]

> diff --git a/arch/arm/mach-omap2/sleep44xx.S b/arch/arm/mach-omap2/sleep44xx.S
> index 230ab8c..a7cce0b 100644
> --- a/arch/arm/mach-omap2/sleep44xx.S
> +++ b/arch/arm/mach-omap2/sleep44xx.S
> @@ -32,6 +32,9 @@
>  ppa_zero_params:
>  	.word		0x0
>  
> +ppa_por_params:
> +	.word		1, 0
> +
>  /*
>   * =============================
>   * == CPU suspend finisher ==
> @@ -130,6 +133,55 @@ skip_scu_gp_set:
>  	mcrne	p15, 0, r0, c1, c0, 1
>  	isb
>  	dsb
> +#ifdef CONFIG_CACHE_L2X0
> +	/*
> +	 * Clean and invalidate the L2 cache.
> +	 * Common cache-l2x0.c functions can't be used here since it
> +	 * uses spinlocks. We are out of coherency here with data cache
> +	 * disabled. The spinlock implementation uses exclusive load/store
> +	 * instruction which can fail without data cache being enabled.
> +	 * OMAP4 hardware doesn't support exclusive monitor which can
> +	 * overcome exclusive access issue. Because of this, CPU can
> +	 * lead to deadlock.
> +	 */
> +l2x_clean_inv:
> +	bl	omap4_get_sar_ram_base
> +	mov	r8, r0
> +	mrc	p15, 0, r5, c0, c0, 5		@ Read MPIDR
> +	ands	r5, r5, #0x0f
> +	ldreq	r0, [r8, #L2X0_SAVE_OFFSET0]
> +	ldrne	r0, [r8, #L2X0_SAVE_OFFSET1]
> +	cmp	r0, #3
> +	bne	do_WFI
> +#ifdef CONFIG_PL310_ERRATA_727915
> +	mov	r0, #0x03
> +	mov	r12, #OMAP4_MON_L2X0_DBG_CTRL_INDEX
> +	DO_SMC
> +#endif
> +	bl	omap4_get_l2cache_base
> +	mov	r2, r0
> +	ldr	r0, =0xffff
> +	str	r0, [r2, #L2X0_CLEAN_INV_WAY]
> +wait:
> +	ldr	r0, [r2, #L2X0_CLEAN_INV_WAY]
> +	ldr	r1, =0xffff
> +	ands	r0, r0, r1
> +	bne	wait
> +#ifdef CONFIG_PL310_ERRATA_727915
> +	mov	r0, #0x00
> +	mov	r12, #OMAP4_MON_L2X0_DBG_CTRL_INDEX
> +	DO_SMC
> +#endif
> +l2x_sync:
> +	bl	omap4_get_l2cache_base
> +	mov	r2, r0
> +	mov	r0, #0x0
> +	str	r0, [r2, #L2X0_CACHE_SYNC]
> +sync:
> +	ldr	r0, [r2, #L2X0_CACHE_SYNC]
> +	ands	r0, r0, #0x1
> +	bne	sync
> +#endif
>

If I am not mistaken, here the PL310 is still on. Is it
safe to go to wfi (PL310 logic state is lost then ?) with the controller
enabled ? You still use the stack and I think prefetch is enabled,
do not know if you can end up having AXI bus transactions ongoing
whilst HW yanks the power. To disable it I think you need a secure call,
again it is just a question for my information.

Thanks,
Lorenzo

>  do_WFI:
>  	bl	omap_do_wfi
> @@ -222,6 +274,50 @@ enable_smp_bit:
>  	mcreq	p15, 0, r0, c1, c0, 1
>  	isb
>  skip_ns_smp_enable:
> +#ifdef CONFIG_CACHE_L2X0
> +	/*
> +	 * Restore the L2 AUXCTRL and enable the L2 cache.
> +	 * OMAP4_MON_L2X0_AUXCTRL_INDEX =  Program the L2X0 AUXCTRL
> +	 * OMAP4_MON_L2X0_CTRL_INDEX =  Enable the L2 using L2X0 CTRL
> +	 * register r0 contains value to be programmed.
> +	 * L2 cache is already invalidate by ROM code as part
> +	 * of MPUSS OFF wakeup path.
> +	 */
> +	ldr	r2, =OMAP44XX_L2CACHE_BASE
> +	ldr	r0, [r2, #L2X0_CTRL]
> +	and	r0, #0x0f
> +	cmp	r0, #1
> +	beq	skip_l2en			@ Skip if already enabled
> +	ldr	r3, =OMAP44XX_SAR_RAM_BASE
> +	ldr	r1, [r3, #OMAP_TYPE_OFFSET]
> +	cmp	r1, #0x1			@ Check for HS device
> +	bne     set_gp_por
> +	ldr     r0, =OMAP4_PPA_L2_POR_INDEX
> +	ldr     r1, =OMAP44XX_SAR_RAM_BASE
> +	ldr     r4, [r1, #L2X0_PREFETCH_CTRL_OFFSET]
> +	adr     r3, ppa_por_params
> +	str     r4, [r3, #0x04]
> +	mov	r1, #0x0			@ Process ID
> +	mov	r2, #0x4			@ Flag
> +	mov	r6, #0xff
> +	mov	r12, #0x00			@ Secure Service ID
> +	DO_SMC
> +	b	set_aux_ctrl
> +set_gp_por:
> +	ldr     r1, =OMAP44XX_SAR_RAM_BASE
> +	ldr     r0, [r1, #L2X0_PREFETCH_CTRL_OFFSET]
> +	ldr	r12, =OMAP4_MON_L2X0_PREFETCH_INDEX	@ Setup L2 PREFETCH
> +	DO_SMC
> +set_aux_ctrl:
> +	ldr     r1, =OMAP44XX_SAR_RAM_BASE
> +	ldr	r0, [r1, #L2X0_AUXCTRL_OFFSET]
> +	ldr	r12, =OMAP4_MON_L2X0_AUXCTRL_INDEX	@ Setup L2 AUXCTRL
> +	DO_SMC
> +	mov	r0, #0x1
> +	ldr	r12, =OMAP4_MON_L2X0_CTRL_INDEX		@ Enable L2 cache
> +	DO_SMC
> +skip_l2en:
> +#endif
>  
>  	b	cpu_resume			@ Jump to generic resume
>  ENDPROC(omap4_cpu_resume)
> -- 
> 1.7.4.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
