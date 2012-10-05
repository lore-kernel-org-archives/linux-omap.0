From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 2/7] ARM: virt: allow the kernel to be entered in
 HYP mode
Date: Fri, 5 Oct 2012 16:50:46 -0700
Message-ID: <20121005235046.GW3874@atomide.com>
References: <1347036934-8519-1-git-send-email-marc.zyngier@arm.com>
 <1347036934-8519-3-git-send-email-marc.zyngier@arm.com>
 <20121005200822.GQ3874@atomide.com>
 <20121005230908.GC15246@n2100.arm.linux.org.uk>
 <20121005232325.GV3874@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:16595 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752254Ab2JEXuy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Oct 2012 19:50:54 -0400
Content-Disposition: inline
In-Reply-To: <20121005232325.GV3874@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Dave Martin <dave.martin@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>

* Tony Lindgren <tony@atomide.com> [121005 16:27]:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [121005 16:10]:
> > On Fri, Oct 05, 2012 at 01:08:22PM -0700, Tony Lindgren wrote:
> > > Just bisected this down in linux-next for breaking booting of
> > > my omap2420 ARMv6 based n8x0..
> > > 
> > > > --- a/arch/arm/kernel/head.S
> > > > +++ b/arch/arm/kernel/head.S
> > > > @@ -83,8 +83,12 @@ ENTRY(stext)
> > > >   THUMB(	.thumb			)	@ switch to Thumb now.
> > > >   THUMB(1:			)
> > > >  
> > > > -	setmode	PSR_F_BIT | PSR_I_BIT | SVC_MODE, r9 @ ensure svc mode
> > > > -						@ and irqs disabled
> > > > +#ifdef CONFIG_ARM_VIRT_EXT
> > > > +	bl	__hyp_stub_install
> > > > +#endif
> > > > +	@ ensure svc mode and all interrupts masked
> > > > +	safe_svcmode_maskall r9
> > > > +
> > > >  	mrc	p15, 0, r9, c0, c0		@ get processor id
> > > >  	bl	__lookup_processor_type		@ r5=procinfo r9=cpuid
> > > >  	movs	r10, r5				@ invalid processor (r5=0)?
> > > 
> > > ..and looks like undoing this part fixes it. Any ideas?
> > > 
> > > I quickly tried disabling ARCH_OMAP3 and ARCH_OMAP4 so it's
> > > ARMv6 but that does not help.

The same kernel boots on 2430sdp, which is the same ARMv6 core
as 2430 if I remember correctly. So this hints that it has something
to do with the bits set differently by the bootloader?

Regards,

Tony
