From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 2/7] ARM: virt: allow the kernel to be entered in
 HYP mode
Date: Sat, 6 Oct 2012 07:44:36 -0700
Message-ID: <20121006144435.GZ3874@atomide.com>
References: <1347036934-8519-1-git-send-email-marc.zyngier@arm.com>
 <1347036934-8519-3-git-send-email-marc.zyngier@arm.com>
 <20121005200822.GQ3874@atomide.com>
 <6d3553bfe8a2d1ac88cab852100616a7@localhost>
 <alpine.LFD.2.02.1210060955230.16518@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:44373 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751117Ab2JFOoi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Oct 2012 10:44:38 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1210060955230.16518@xanadu.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Dave Martin <dave.martin@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King - ARM Linux <linux@arm.linux.org.uk>

* Nicolas Pitre <nicolas.pitre@linaro.org> [121006 07:07]:
> On Sat, 6 Oct 2012, Marc Zyngier wrote:
> > 
> > If so, that indicates some side effect of the safe_svcmode_maskall macro,
> > and I suspect the "movs pc, lr" bit.
> 
> That would be surprizing if the "movs pc, lr" was to blame.  This should 
> work on all architectures.
> 
> However the A bit might be to blame.
> 
> > Can you try the attached patch? It basically falls back to the previous
> > behaviour if not entered in HYP mode.
> 
> This is likely to work of course.  However I think we should try to 
> pinpoint the exact problem i.e. whether it is the A bit or the "movs pc, 
> lr" which makes a difference (it is unlikely to be both).
> 
> So I was about to suggest to test this patch as well:

No luck with this patch alone.

Regards,

Tony
 
> diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
> index 683a1e6b60..118e22ee46 100644
> --- a/arch/arm/include/asm/assembler.h
> +++ b/arch/arm/include/asm/assembler.h
> @@ -254,8 +254,7 @@
>  	mov	lr , \reg
>  	and	lr , lr , #MODE_MASK
>  	cmp	lr , #HYP_MODE
> -	orr	\reg , \reg , #PSR_A_BIT | PSR_I_BIT | PSR_F_BIT
> -	bic	\reg , \reg , #MODE_MASK
> +	mov	\reg , #PSR_I_BIT | PSR_F_BIT
>  	orr	\reg , \reg , #SVC_MODE
>  THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
>  	msr	spsr_cxsf, \reg
> 
> 
> Nicolas
