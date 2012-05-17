From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCHv2 17/19] ARM: OMAP4: put cpu1 back to sleep if no wake request
Date: Wed, 16 May 2012 17:31:24 -0700
Message-ID: <87396z3axv.fsf@ti.com>
References: <1336990730-26892-1-git-send-email-t-kristo@ti.com>
	<1336990730-26892-18-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:59382 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751638Ab2EQAb2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 May 2012 20:31:28 -0400
Received: by dadm1 with SMTP id m1so1916137dad.36
        for <linux-omap@vger.kernel.org>; Wed, 16 May 2012 17:31:27 -0700 (PDT)
In-Reply-To: <1336990730-26892-18-git-send-email-t-kristo@ti.com> (Tero
	Kristo's message of "Mon, 14 May 2012 13:18:48 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

Tero Kristo <t-kristo@ti.com> writes:

> If AUX_CORE_BOOT0 does not indicate wakeup request for cpu1, put it back
> to off. 

Why is it waking up then?  (I know the answer, but will forget.  The
changelog serves as my long-term memory.)

> This is needed during wakeup from device off to prevent cpu1
> from being stuck indefinitely in the wakeup loop 

Why does it get stuck?

> and also to prevent wakeup problem on GP chips with device off mode.

What wakeup problem?

> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Assembly code should have some comments to aid comprehension.


> ---
>  arch/arm/mach-omap2/omap-headsmp.S |   45 ++++++++++++++++++++++++++++++++---
>  1 files changed, 41 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap-headsmp.S b/arch/arm/mach-omap2/omap-headsmp.S
> index d602555..59c6578 100644
> --- a/arch/arm/mach-omap2/omap-headsmp.S
> +++ b/arch/arm/mach-omap2/omap-headsmp.S
> @@ -17,8 +17,37 @@
>  
>  #include <linux/linkage.h>
>  #include <linux/init.h>
> +#include <mach/omap-secure.h>
> +#include "prcm_mpu44xx.h"
> +
> +#define CPU1_PWRSTCTRL (OMAP4430_PRCM_MPU_BASE + OMAP4430_PRCM_MPU_CPU1_INST + \
> +			OMAP4_PM_CPU1_PWRSTCTRL_OFFSET)
>  
>  	__CPUINIT
> +
> +ENTRY(omap_cpu1_off)
> +	ldr	r12, =CPU1_PWRSTCTRL
> +	ldr	r0, [r12]
> +	and	r0, #3
> +	cmp	r0, #2
> +	beq	exit_cpu1_off
> +
> +	mov	r0, #0x3
> +	mov	r1, #0x0
> +	ldr	r12, =OMAP4_MON_SCU_PWR_INDEX

Help!  no comments.

> +	dsb
> +	smc     #0

The DO_SMC in sleep44xx.S suggests there should be another dsb here.

> +	isb
> +	dsb
> +	dmb
> +	wfi
> +	nop
> +	nop

Shoudln't this use omap_do_wfi?

Kevin

> +exit_cpu1_off:
> +	mov	pc, lr
> +ENDPROC(omap_cpu1_off)
> +
>  /*
>   * OMAP4 specific entry point for secondary CPU to jump from ROM
>   * code.  This routine also provides a holding flag into which
> @@ -27,32 +56,40 @@
>   * register AuxCoreBoot0.
>   */
>  ENTRY(omap_secondary_startup)
> -hold:	ldr	r12,=0x103
> +	ldr	r12,=0x103
>  	dsb
>  	smc	#0			@ read from AuxCoreBoot0
>  	mov	r0, r0, lsr #9
>  	mrc	p15, 0, r4, c0, c0, 5
>  	and	r4, r4, #0x0f
>  	cmp	r0, r4
> -	bne	hold
> +	beq	omap_cont_boot
> +
> +	bl	omap_cpu1_off
> +	b	omap_secondary_startup
>  
>  	/*
>  	 * we've been released from the wait loop,secondary_stack
>  	 * should now contain the SVC stack for this core
>  	 */
> +omap_cont_boot:
>  	b	secondary_startup
>  ENDPROC(omap_secondary_startup)
>  
>  ENTRY(omap_secondary_startup_4460)
> -hold_2:	ldr	r12,=0x103
> +	ldr	r12,=0x103
>  	dsb
>  	smc	#0			@ read from AuxCoreBoot0
>  	mov	r0, r0, lsr #9
>  	mrc	p15, 0, r4, c0, c0, 5
>  	and	r4, r4, #0x0f
>  	cmp	r0, r4
> -	bne	hold_2
> +	beq	omap4460_cont_boot
> +
> +	bl	omap_cpu1_off
> +	b	omap_secondary_startup_4460
>  
> +omap4460_cont_boot:
>  	/*
>  	 * GIC distributor control register has changed between
>  	 * CortexA9 r1pX and r2pX. The Control Register secure
