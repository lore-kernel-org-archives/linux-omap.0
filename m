From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 2/7] ARM: virt: allow the kernel to be entered in
 HYP mode
Date: Sat, 6 Oct 2012 07:42:52 -0700
Message-ID: <20121006144252.GY3874@atomide.com>
References: <1347036934-8519-1-git-send-email-marc.zyngier@arm.com>
 <1347036934-8519-3-git-send-email-marc.zyngier@arm.com>
 <20121005200822.GQ3874@atomide.com>
 <6d3553bfe8a2d1ac88cab852100616a7@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:43905 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751485Ab2JFOm4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Oct 2012 10:42:56 -0400
Content-Disposition: inline
In-Reply-To: <6d3553bfe8a2d1ac88cab852100616a7@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Dave Martin <dave.martin@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>

Hi,

* Marc Zyngier <marc.zyngier@arm.com> [121006 03:19]:
> 
> If you compiled for v6 only, we can safely exclude __hyp_stub_install, and
> I assume that you get past the decompressor.

Yes, by default it's v6 + v7, but making it v6 only did not help.
 
> If so, that indicates some side effect of the safe_svcmode_maskall macro,
> and I suspect the "movs pc, lr" bit.
> 
> Can you try the attached patch? It basically falls back to the previous
> behaviour if not entered in HYP mode.

Yes, with this it boots OK.

Regards,

Tony

> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
> index 658a15d..b21b97f 100644
> --- a/arch/arm/include/asm/assembler.h
> +++ b/arch/arm/include/asm/assembler.h
> @@ -254,16 +254,17 @@
>  	mov	lr , \reg
>  	and	lr , lr , #MODE_MASK
>  	cmp	lr , #HYP_MODE
> -	orr	\reg , \reg , #PSR_A_BIT | PSR_I_BIT | PSR_F_BIT
> +	orr	\reg , \reg , #PSR_I_BIT | PSR_F_BIT
>  	bic	\reg , \reg , #MODE_MASK
>  	orr	\reg , \reg , #SVC_MODE
>  THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
> -	msr	spsr_cxsf, \reg
> -	adr	lr, BSYM(2f)
>  	bne	1f
> +	orr	\reg, \reg, #PSR_A_BIT
> +	adr	lr, BSYM(2f)
> +	msr	spsr_cxsf, \reg
>  	__MSR_ELR_HYP(14)
>  	__ERET
> -1:	movs	pc, lr
> +1:	msr	cpsr_c, \reg
>  2:
>  .endm
>  

