From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM MMU: add strongly-ordered memory type
Date: Thu, 7 Aug 2008 22:20:33 +0100
Message-ID: <20080807212033.GH5737@flint.arm.linux.org.uk>
References: <alpine.DEB.1.00.0808041738400.18201@utopia.booyaka.com> <1218016428.25235.11.camel@pc1117.cambridge.arm.com> <13B9B4C6EF24D648824FF11BE89671620361F4E504@dlee02.ent.ti.com> <20080807073035.GA10255@flint.arm.linux.org.uk> <13B9B4C6EF24D648824FF11BE89671620361FBB4FB@dlee02.ent.ti.com> <20080807192531.GF5737@flint.arm.linux.org.uk> <13B9B4C6EF24D648824FF11BE89671620361FBB662@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:46817 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753894AbYHGVVP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Aug 2008 17:21:15 -0400
Content-Disposition: inline
In-Reply-To: <13B9B4C6EF24D648824FF11BE89671620361FBB662@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>

On Thu, Aug 07, 2008 at 03:38:55PM -0500, Woodruff, Richard wrote:
> 
> > From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> > > Is DEVICE really safe for things other than FIFOs with out the use of
> > > barriers?
> >
> > As far as I'm aware, yes - and that comment is based solely upon the
> > fact that no one has reported any problems with the kernel which have
> > been tracked down to using the device memory type on ARMv6 and above...
> >
> > > We do in some drivers today get spurious interrupts when DEVICE is
> > > used but don't see them when using SO.
> >
> > ... until now, or even that very sentence.
> 
> That is our fault then I suppose for not discussing this on arm-linux.
> In OMAP2 and OMAP3 this has been observed.  In vendor kernels where
> time stands still and lots of validation has happened we did stick
> with SO for OMAP2.  On some internal kernels already we have gone to
> SO for OMAP3 as customers ramp and need the errors gone.  The faster
> the system clocks the more it seems to show.

To do that, and then ask about when Linux is going to start exploiting
the weak memory types is a little unfair don't you think?

> The thing with these effects, especially spurious IRQs is there usually
> are several reasons they show up and several ways to make them go away.
> In the beginning there have been lots then they drop off as the system
> software matures.  Then if the program survives long enough to be
> optimized they start to show up again but in lesser numbers.  This has
> been the OMAP2/3 experience so far.  Going SO to control regions has
> stamped them out at this point.

What you're therefore asking for is a weak memory ordering model which
doesn't require any effort on the software programmers part - that's
a CPU architecture thing which you'll need to talk to ARM about.

x86 can do this for the most part because x86's development has been
such that the hardware has had to work around the software to make
improvements.  On ARM, normally when there's updates, software has
to work around the hardware.

> > That's not unexpected if you don't have the right barriers in place
> > at the end of things such as IRQ controllers ack/mask functions.
> 
> Yes. I've submitted patches (to linux-omap) and Catalin did submit
> patches (to arm-linux) for PIC barriers.  In the past they have been
> rejected by Tony or you for different reasons.  Tony last rejected
> it because he thought it should be generic at the ARM level.  I
> don't recall what your last stance was.

Looking back, I never commented on that patch.  I did on the previous
patch which was adding DSBs in a way which would break stuff.  The
patch to add them to the interrupt controllers has never been reposted.

However, adding barriers may not be the correct answer for this.
See Documentation/io_ordering.txt - reading back from a safe register
on the target device ensures that the previous writes should hit the
device before the read completes, without the overhead of a full
barrier.

This point is even more important if you have some form of write
posting between the CPU and the device (eg, a PCI bus) - a DSB
won't reach down to the target PCI device which may be behind some
write-posting bridges.

So, in the case of arch/arm/common/gic.c, we should be reading one of
the gic control registers after the writes.  In the case of
arch/arm/mach-omap2/irq.c, reading the INTC_REVISION reg after masking
should be a sufficient solution.

But, not a barrier.

> However, if you use the irq-controller barriers they tend to go away.

Great, so solving that should prevent them.

> > > Originally the IC-Architect wanted two memory windows per device, one
> > > SO for register control and one DEVICE for FIFO access.  Given that we
> > > do DMA (which doesn't care about how ARM sees the world) on the
> > > performance hungry devices not doing this was ok.
> >
> > I'm not sure what point you're making there.
> 
> Use a dual mapping to manage a device (2 ioremaps).  You use a SO mapping
> to write to registers of that device.  Then when you go to write to its
> FIFO use a DEVICE mapping.

I believe ARMv7 has some restrictions on dual mapping of the same
space with different types, so don't expect this technique to always
work.

> Say TX IRQ happens at UART, I might check status bits through a SO mapping,
> but when it comes time to fill the FIFO I write to the DEVICE mapping.

Why?  Firstly, the read _has_ to complete before the program can
continue.  (If it hasn't completed, you don't have the data to decide
what to do next.)  Secondly, any previous device writes will have to
complete before the read completes.

So what does reading the status bits through a SO mapping gain you?
The answer is, all other reads and writes previously issued by the
program completing.  Does that affect the status that the UART is
giving you?

> > > For an experiment a couple years back we did convert the dma alloc
> > > pool addresses as NC.  All worked -except- for OHCI-USB which started
> > > failing some tests.
> >
> > If we go down the route of marking DMA as 'normal memory non-cacheable'
> > we're going to have a never ending stream of drivers which don't work
> > correctly.  We're forever going to be bug hunting drivers, having to
> > add barriers as required.  Arguably those barriers should be there
> > already, but if drivers are developed on platforms without weak ordering,
> > authors just don't think about it, and _certainly_ can't test them.
> 
> Is this just the case for an attribute to be made available from an
> API change/addition to allow a driver to make use of it?  The default
> can always be conservative.
> 
> The trend is ARMs are depending more on pipeline and prefetch tricks
> to perform. For these tricks to work weak memory features need to be
> used at times.

My preference at the moment is "we'll see, lets sort out the problems
we know about first".
