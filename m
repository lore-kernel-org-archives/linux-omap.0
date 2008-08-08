From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] ARM MMU: add strongly-ordered memory type
Date: Fri, 08 Aug 2008 12:44:49 +0100
Message-ID: <1218195889.12256.31.camel@pc1117.cambridge.arm.com>
References: <alpine.DEB.1.00.0808041738400.18201@utopia.booyaka.com>
	 <1218016428.25235.11.camel@pc1117.cambridge.arm.com>
	 <13B9B4C6EF24D648824FF11BE89671620361F4E504@dlee02.ent.ti.com>
	 <20080807073035.GA10255@flint.arm.linux.org.uk>
	 <13B9B4C6EF24D648824FF11BE89671620361FBB4FB@dlee02.ent.ti.com>
	 <20080807192531.GF5737@flint.arm.linux.org.uk>
	 <13B9B4C6EF24D648824FF11BE89671620361FBB662@dlee02.ent.ti.com>
	 <20080807212033.GH5737@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:59521 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753606AbYHHLpQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Aug 2008 07:45:16 -0400
In-Reply-To: <20080807212033.GH5737@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Woodruff, Richard" <r-woodruff2@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>

On Thu, 2008-08-07 at 22:20 +0100, Russell King - ARM Linux wrote:
> On Thu, Aug 07, 2008 at 03:38:55PM -0500, Woodruff, Richard wrote:
> > 
> > > From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> > > > Is DEVICE really safe for things other than FIFOs with out the use of
> > > > barriers?
> > >
> > > As far as I'm aware, yes - and that comment is based solely upon the
> > > fact that no one has reported any problems with the kernel which have
> > > been tracked down to using the device memory type on ARMv6 and above...
> > >
> > > > We do in some drivers today get spurious interrupts when DEVICE is
> > > > used but don't see them when using SO.
> > >
> > > ... until now, or even that very sentence.
> > 
> > That is our fault then I suppose for not discussing this on arm-linux.
> > In OMAP2 and OMAP3 this has been observed.  In vendor kernels where
> > time stands still and lots of validation has happened we did stick
> > with SO for OMAP2.  On some internal kernels already we have gone to
> > SO for OMAP3 as customers ramp and need the errors gone.  The faster
> > the system clocks the more it seems to show.
> 
> To do that, and then ask about when Linux is going to start exploiting
> the weak memory types is a little unfair don't you think?

There are already CPUs with weaker memory ordering model than ARM (e.g.
Alpha) and they are supported by Linux. Of course, there may be problems
with drivers since most of them are developed in x86.

On the strongly-ordered instead of normal uncached memory, the unaligned
accesses to SO memory which are not faulted have unpredictable behaviour
(according to the ARM ARM, though some v7 implementations may not be
bothered). If you use such memory for skbuff for example, is there any
risk of unaligned accesses when the network packets are processed? Is
there any other example that would make this fail?

> > The thing with these effects, especially spurious IRQs is there usually
> > are several reasons they show up and several ways to make them go away.
> > In the beginning there have been lots then they drop off as the system
> > software matures.  Then if the program survives long enough to be
> > optimized they start to show up again but in lesser numbers.  This has
> > been the OMAP2/3 experience so far.  Going SO to control regions has
> > stamped them out at this point.
> 
> What you're therefore asking for is a weak memory ordering model which
> doesn't require any effort on the software programmers part - that's
> a CPU architecture thing which you'll need to talk to ARM about.
> 
> x86 can do this for the most part because x86's development has been
> such that the hardware has had to work around the software to make
> improvements.  On ARM, normally when there's updates, software has
> to work around the hardware.

For ARM CPU (RISC architecture) to get faster while keeping the power
consumption low, it must become weakly ordered (maybe CISC architectures
can cope with this). Anyway, it seems that ia64 requires some barriers
as well. That's more like evolution in the CPU field and while the
software becomes more complex, the overall performance is better.

> > > That's not unexpected if you don't have the right barriers in place
> > > at the end of things such as IRQ controllers ack/mask functions.
> > 
> > Yes. I've submitted patches (to linux-omap) and Catalin did submit
> > patches (to arm-linux) for PIC barriers.  In the past they have been
> > rejected by Tony or you for different reasons.  Tony last rejected
> > it because he thought it should be generic at the ARM level.  I
> > don't recall what your last stance was.
> 
> Looking back, I never commented on that patch.  I did on the previous
> patch which was adding DSBs in a way which would break stuff.  The
> patch to add them to the interrupt controllers has never been reposted.
> 
> However, adding barriers may not be the correct answer for this.
> See Documentation/io_ordering.txt - reading back from a safe register
> on the target device ensures that the previous writes should hit the
> device before the read completes, without the overhead of a full
> barrier.
> 
> This point is even more important if you have some form of write
> posting between the CPU and the device (eg, a PCI bus) - a DSB
> won't reach down to the target PCI device which may be behind some
> write-posting bridges.
> 
> So, in the case of arch/arm/common/gic.c, we should be reading one of
> the gic control registers after the writes.  In the case of
> arch/arm/mach-omap2/irq.c, reading the INTC_REVISION reg after masking
> should be a sufficient solution.

I need to check in ARM when people come from holidays but a simple LDR
might not be enough to guarantee that a CPSIE etc. happens after it. You
may need to add either an LDR + CMP (or some other usage of the loaded
register) or LDR + DSB. I agree that DSB alone is not enough.

> > Use a dual mapping to manage a device (2 ioremaps).  You use a SO mapping
> > to write to registers of that device.  Then when you go to write to its
> > FIFO use a DEVICE mapping.
> 
> I believe ARMv7 has some restrictions on dual mapping of the same
> space with different types, so don't expect this technique to always
> work.

This setup may lead to unpredictable behaviour if not used properly. I
think it is allowed as long as accesses to these mappings are separated
by a DSB or return from / entering an exception.

-- 
Catalin

