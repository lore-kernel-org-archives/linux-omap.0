From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 3/6] ARM: Fix v7wbi_tlb_flags for SMP on UP
Date: Mon, 06 Sep 2010 18:11:00 +0100
Message-ID: <1283793060.12076.192.camel@e102109-lin.cambridge.arm.com>
References: <20100902161659.GJ11597@atomide.com>
	 <20100902162039.GM11597@atomide.com>
	 <20100902162537.GU26319@n2100.arm.linux.org.uk>
	 <20100902163453.GR11597@atomide.com> <20100902234746.GF11597@atomide.com>
	 <20100903090734.GJ26319@n2100.arm.linux.org.uk>
	 <20100903091029.GK26319@n2100.arm.linux.org.uk>
	 <1283773594.11660.10.camel@e102109-lin.cambridge.arm.com>
	 <20100906153440.GA27858@n2100.arm.linux.org.uk>
	 <1283788427.12076.125.camel@e102109-lin.cambridge.arm.com>
	 <20100906163645.GB27858@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:39416 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753754Ab0IFRLN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Sep 2010 13:11:13 -0400
In-Reply-To: <20100906163645.GB27858@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, Bryan Wu <bryan.wu@canonical.com>

On Mon, 2010-09-06 at 17:36 +0100, Russell King - ARM Linux wrote:
> On Mon, Sep 06, 2010 at 04:53:47PM +0100, Catalin Marinas wrote:
> > On Mon, 2010-09-06 at 16:34 +0100, Russell King - ARM Linux wrote:
> > > On Mon, Sep 06, 2010 at 12:46:34PM +0100, Catalin Marinas wrote:
> > > > Would this work with Thumb-2 kernel builds? Maybe you can add a W(instr)
> > > > in the SMP/UP macros to make sure that the instruction is always 32-bit
> > > > wide.
> > >
> > > Probably not, and it's not obvious how to make it work for T2 kernel
> > > builds.  For the time being, I'm going to make this available only for
> > > native ARM builds.  We can think about how to make this work for T2
> > > sometime later.
> > [...]
> > > Indeed, that's only half of the problem.  On T2, some of these may be
> > > 16-bit values, others may be 32-bit values, and this mechanism has no
> > > way to know the size of the areas.
> >
> > We can add the W() macro and they are guaranteed to be 32-bit wide or
> > get a compilation error. Something like using "UP(W(nop))", though it's
> > doesn't look as nice.
> >
> > The usr_ret macro is always compiled to ARM mode anyway.
> 
> That's not the only place - here's another:
> 
> +       ALT_SMP(test_for_ipi r0, r6, r5, lr)
> +       ALT_UP_B(9997f)
> 
> test_for_ipi may be thumb code, which could be 16-bit aligned.

The branch can be 16-bit aligned as well but we would have to change the
fixup loop for Thumb-2 to load/store 2 half-words and avoid an alignment
fault.

Anyway, I agree that for now we should get the ARM builds working and we
can change the Thumb-2 afterwards, as time allows. It doesn't look like
something fundamental would prevent this.

-- 
Catalin

