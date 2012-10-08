From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 2/7] ARM: virt: allow the kernel to be entered in
 HYP mode
Date: Mon, 8 Oct 2012 13:36:56 -0700
Message-ID: <20121008203655.GA13011@atomide.com>
References: <1347036934-8519-1-git-send-email-marc.zyngier@arm.com>
 <1347036934-8519-3-git-send-email-marc.zyngier@arm.com>
 <20121005200822.GQ3874@atomide.com>
 <6d3553bfe8a2d1ac88cab852100616a7@localhost>
 <20121006160031.GC3874@atomide.com>
 <20121008110109.GE2302@linaro.org>
 <5072B9EF.1020005@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:24768 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752144Ab2JHUhA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Oct 2012 16:37:00 -0400
Content-Disposition: inline
In-Reply-To: <5072B9EF.1020005@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Dave Martin <dave.martin@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Nicolas Pitre <nico@fluxnic.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>

* Marc Zyngier <marc.zyngier@arm.com> [121008 04:34]:
> On 08/10/12 12:01, Dave Martin wrote:
> > 
> > In an attempt to narrow this down...
> > 
> > Can you follow this (i.e., _after_ a known successful switch to SVC mode)
> > 
> > (a)
> > 	mrs	\reg, cpsr
> > 	msr	spsr_cxsf, \reg
> > 	adr	\reg, 3f
> > 	movs	pc, lr
> > 3:
> > 
> > and (b)
> > 
> > 	mrs	\reg, cpsr
> > 	orr	\reg, \reg, #CPSR_A_BIT
> > 	msr	cpsr_cxsf, \reg
> > 
> > and (c)
> > 
> > 	mrs	\reg, cpsr
> > 	orr	\reg, \reg, #CPSR_A_BIT
> > 	msr	spsr_cxsf, \reg
> > 	adr	\reg, 3f
> > 	movs	pc, lr
> > 3:
> > 
> > 
> > 
> > 
> > If only (a) works, this would suggest that the attempt to set the A bit
> > is causing the problem.
> > 
> > If only (b) works, this suggests that the A bit is OK but that some
> > invalid hardware state, or something else we don't understand, is causing
> > exception returns to fail in general.
> > 
> > If (a) and (b) work but (c) fails, this suggests that specifically
> > trying to set the A bit via an exception return is problematic.
> > 
> > If all of them work then this suggests some invalid hardware state or
> > something else we don't understand, but which is cleared by the initial
> > msr cpsr_c which clobbers the processor mode.

Thanks it does not seem to be the A bit..
 
> Playing with an Integrator-CP with a 1136 tile, the only way I could
> cause the thing to fail was to boot the thing in SYSTEM mode.
> 
> Tony, can you possibly also try the attached patch?

Yup you figured it out n800 is in system mode while 2430sdp is not..
I verified it with printhex2.

Your patch fails to compile with:

arch/arm/kernel/head.S: Assembler messages:
arch/arm/kernel/head.S:336: Error: symbol `omgsys' is already defined

Probably because it's included twice. Also, shouldn't it
be bne omgsys instead of beq?

Regards,

Tony

> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
> index 683a1e6..7714ec7 100644
> --- a/arch/arm/include/asm/assembler.h
> +++ b/arch/arm/include/asm/assembler.h
> @@ -253,6 +253,8 @@
>  	mrs	\reg , cpsr
>  	mov	lr , \reg
>  	and	lr , lr , #MODE_MASK
> +	cmp	lr , #SYSTEM_MODE	/* Yet another braindead platform? */
> +	beq	omgsys
>  	cmp	lr , #HYP_MODE
>  	orr	\reg , \reg , #PSR_A_BIT | PSR_I_BIT | PSR_F_BIT
>  	bic	\reg , \reg , #MODE_MASK
> @@ -264,6 +266,7 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
>  	__MSR_ELR_HYP(14)
>  	__ERET
>  1:	movs	pc, lr
> +omgsys: msr	cpsr_c, \reg
>  2:
>  .endm
>  
