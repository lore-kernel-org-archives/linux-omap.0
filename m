From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 2/7] ARM: virt: allow the kernel to be entered in
 HYP mode
Date: Fri, 5 Oct 2012 16:23:25 -0700
Message-ID: <20121005232325.GV3874@atomide.com>
References: <1347036934-8519-1-git-send-email-marc.zyngier@arm.com>
 <1347036934-8519-3-git-send-email-marc.zyngier@arm.com>
 <20121005200822.GQ3874@atomide.com>
 <20121005230908.GC15246@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:36335 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754221Ab2JEXXe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Oct 2012 19:23:34 -0400
Content-Disposition: inline
In-Reply-To: <20121005230908.GC15246@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Dave Martin <dave.martin@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [121005 16:10]:
> On Fri, Oct 05, 2012 at 01:08:22PM -0700, Tony Lindgren wrote:
> > Just bisected this down in linux-next for breaking booting of
> > my omap2420 ARMv6 based n8x0..
> > 
> > > --- a/arch/arm/kernel/head.S
> > > +++ b/arch/arm/kernel/head.S
> > > @@ -83,8 +83,12 @@ ENTRY(stext)
> > >   THUMB(	.thumb			)	@ switch to Thumb now.
> > >   THUMB(1:			)
> > >  
> > > -	setmode	PSR_F_BIT | PSR_I_BIT | SVC_MODE, r9 @ ensure svc mode
> > > -						@ and irqs disabled
> > > +#ifdef CONFIG_ARM_VIRT_EXT
> > > +	bl	__hyp_stub_install
> > > +#endif
> > > +	@ ensure svc mode and all interrupts masked
> > > +	safe_svcmode_maskall r9
> > > +
> > >  	mrc	p15, 0, r9, c0, c0		@ get processor id
> > >  	bl	__lookup_processor_type		@ r5=procinfo r9=cpuid
> > >  	movs	r10, r5				@ invalid processor (r5=0)?
> > 
> > ..and looks like undoing this part fixes it. Any ideas?
> > 
> > I quickly tried disabling ARCH_OMAP3 and ARCH_OMAP4 so it's
> > ARMv6 but that does not help.
> 
> You really should Cc me when you hit something like this.  I was
> thinking about sending my tree (which contains these changes) this
> evening but if they're breaking stuff, I'd prefer to delay that
> stuff at least for a while.

Sorry was planning to cc you for sure but forgot. Got any ideas
what to try to fix this?

Tony
