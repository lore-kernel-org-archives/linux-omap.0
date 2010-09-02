From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 5/6] ARM: Don't set TLB ops broadcasting on UP ARMv7
Date: Thu, 2 Sep 2010 19:18:37 +0100
Message-ID: <20100902181837.GZ26319@n2100.arm.linux.org.uk>
References: <20100819102025.GA32151@n2100.arm.linux.org.uk> <20100820120622.GL25742@atomide.com> <20100830225527.GC11597@atomide.com> <20100902133637.GJ26319@n2100.arm.linux.org.uk> <20100902161659.GJ11597@atomide.com> <20100902162220.GO11597@atomide.com> <20100902165756.GV26319@n2100.arm.linux.org.uk> <20100902172133.GT11597@atomide.com> <20100902180153.GY26319@n2100.arm.linux.org.uk> <20100902181317.GV11597@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59309 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753152Ab0IBSSp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Sep 2010 14:18:45 -0400
Content-Disposition: inline
In-Reply-To: <20100902181317.GV11597@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bryan Wu <bryan.wu@canonical.com>, Will Deacon <will.deacon@arm.com>

On Thu, Sep 02, 2010 at 11:13:17AM -0700, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [100902 10:54]:
> > On Thu, Sep 02, 2010 at 10:21:33AM -0700, Tony Lindgren wrote:
> > > * Russell King - ARM Linux <linux@arm.linux.org.uk> [100902 09:50]:
> > > > On Thu, Sep 02, 2010 at 09:22:20AM -0700, Tony Lindgren wrote:
> > > > > diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> > > > > index 07fc660..51a063d 100644
> > > > > --- a/arch/arm/mm/proc-v7.S
> > > > > +++ b/arch/arm/mm/proc-v7.S
> > > > > @@ -191,7 +191,8 @@ __v7_setup:
> > > > >  	UP(mov	r0, #(1 << 6))			@ fake it for UP
> > > > 
> > > > If it's UP, we set r0 to 1 << 6, which...
> > > > 
> > > > >  	tst	r0, #(1 << 6)			@ SMP/nAMP mode enabled?
> > > > 
> > > > means this test produces a non-zero result.
> > > > 
> > > > >  	orreq	r0, r0, #(1 << 6) | (1 << 0)	@ Enable SMP/nAMP mode and
> > > > > -	mcreq	p15, 0, r0, c1, c0, 1		@ TLB ops broadcasting
> > > > 
> > > > And therefore these instructions will not be executed.
> > > 
> > > AFAIK these bits are different for Cortex-A8 and A9, bit 6 is IBE on A8.
> > 
> > So what?
> 
> Ah right, sorry I should have looked more carefully. You're right, this patch
> is no longer needed either.

Thanks - I was wondering whether I was missing something.
