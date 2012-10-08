From: Dave Martin <dave.martin@linaro.org>
Subject: Re: [PATCH v2 2/7] ARM: virt: allow the kernel to be entered in HYP
 mode
Date: Mon, 8 Oct 2012 12:33:32 +0100
Message-ID: <20121008113332.GF2302@linaro.org>
References: <1347036934-8519-1-git-send-email-marc.zyngier@arm.com>
 <1347036934-8519-3-git-send-email-marc.zyngier@arm.com>
 <20121005200822.GQ3874@atomide.com>
 <6d3553bfe8a2d1ac88cab852100616a7@localhost>
 <20121006160031.GC3874@atomide.com>
 <20121008110109.GE2302@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:60755 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324Ab2JHLdh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Oct 2012 07:33:37 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1970745bkc.19
        for <linux-omap@vger.kernel.org>; Mon, 08 Oct 2012 04:33:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20121008110109.GE2302@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>

On Mon, Oct 08, 2012 at 12:01:09PM +0100, Dave Martin wrote:
> On Sat, Oct 06, 2012 at 09:00:32AM -0700, Tony Lindgren wrote:
> > * Marc Zyngier <marc.zyngier@arm.com> [121006 03:19]:
> > > 
> > > If so, that indicates some side effect of the safe_svcmode_maskall macro,
> > > and I suspect the "movs pc, lr" bit.
> > > 
> > > Can you try the attached patch? It basically falls back to the previous
> > > behaviour if not entered in HYP mode.
> > ...
> > 
> > > diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
> > > index 658a15d..b21b97f 100644
> > > --- a/arch/arm/include/asm/assembler.h
> > > +++ b/arch/arm/include/asm/assembler.h
> > > @@ -254,16 +254,17 @@
> > >  	mov	lr , \reg
> > >  	and	lr , lr , #MODE_MASK
> > >  	cmp	lr , #HYP_MODE
> > > -	orr	\reg , \reg , #PSR_A_BIT | PSR_I_BIT | PSR_F_BIT
> > > +	orr	\reg , \reg , #PSR_I_BIT | PSR_F_BIT
> > >  	bic	\reg , \reg , #MODE_MASK
> > >  	orr	\reg , \reg , #SVC_MODE
> > >  THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
> > > -	msr	spsr_cxsf, \reg
> > > -	adr	lr, BSYM(2f)
> > >  	bne	1f
> > > +	orr	\reg, \reg, #PSR_A_BIT
> > > +	adr	lr, BSYM(2f)
> > > +	msr	spsr_cxsf, \reg
> > >  	__MSR_ELR_HYP(14)
> > >  	__ERET
> > > -1:	movs	pc, lr
> > > +1:	msr	cpsr_c, \reg
> > >  2:
> > >  .endm
> > >  
> > 
> > The minimal version of this that still boots on my n800 is just
> > the last change of the above patch:
> > 
> > --- a/arch/arm/include/asm/assembler.h
> > +++ b/arch/arm/include/asm/assembler.h
> > @@ -263,7 +263,7 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
> >  	bne	1f
> >  	__MSR_ELR_HYP(14)
> >  	__ERET
> > -1:	movs	pc, lr
> > +1:	msr	cpsr_c, \reg
> >  2:
> >  .endm
> >  
> 
> In an attempt to narrow this down...
> 
> Can you follow this (i.e., _after_ a known successful switch to SVC mode)
> 
> (a)
> 	mrs	\reg, cpsr
> 	msr	spsr_cxsf, \reg
> 	adr	\reg, 3f
> 	movs	pc, lr
> 3:
> 
> and (b)
> 
> 	mrs	\reg, cpsr
> 	orr	\reg, \reg, #CPSR_A_BIT
> 	msr	cpsr_cxsf, \reg
> 
> and (c)
> 
> 	mrs	\reg, cpsr
> 	orr	\reg, \reg, #CPSR_A_BIT
> 	msr	spsr_cxsf, \reg
> 	adr	\reg, 3f
> 	movs	pc, lr
> 3:
> 
> 
> 
> 
> If only (a) works, this would suggest that the attempt to set the A bit
> is causing the problem.
> 
> If only (b) works, this suggests that the A bit is OK but that some
> invalid hardware state, or something else we don't understand, is causing
> exception returns to fail in general.
> 
> If (a) and (b) work but (c) fails, this suggests that specifically
> trying to set the A bit via an exception return is problematic.
> 
> If all of them work then this suggests some invalid hardware state or
> something else we don't understand, but which is cleared by the initial
> msr cpsr_c which clobbers the processor mode.


Marc Z also just pointed out to me that there is one architecturally
valid explanation for why the movs route could fail: if the kernel is
entered in System mode for some reason -- this causes msr spsr and movs
pc to become UNPREDICTABLE.  If this is the explanation, then
(a), (b) and (c) should all work, provided the CPU has already been forced
out of System mode.

Of course, we're not supposed to be entered in System mode ... but since
the whole purpose of this code is to force us into a sane state, we should
work around it anyway.  I think Marc is busy rolling a patch for that.

Cheers
---Dave
