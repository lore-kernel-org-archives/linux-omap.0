From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: [PATCH] ARM MMU: add strongly-ordered memory type
Date: Thu, 7 Aug 2008 15:38:55 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE89671620361FBB662@dlee02.ent.ti.com>
References: <alpine.DEB.1.00.0808041738400.18201@utopia.booyaka.com>
 <1218016428.25235.11.camel@pc1117.cambridge.arm.com>
 <13B9B4C6EF24D648824FF11BE89671620361F4E504@dlee02.ent.ti.com>
 <20080807073035.GA10255@flint.arm.linux.org.uk>
 <13B9B4C6EF24D648824FF11BE89671620361FBB4FB@dlee02.ent.ti.com>
 <20080807192531.GF5737@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59723 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753267AbYHGUjX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Aug 2008 16:39:23 -0400
In-Reply-To: <20080807192531.GF5737@flint.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>


> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> > Is DEVICE really safe for things other than FIFOs with out the use of
> > barriers?
>
> As far as I'm aware, yes - and that comment is based solely upon the
> fact that no one has reported any problems with the kernel which have
> been tracked down to using the device memory type on ARMv6 and above...
>
> > We do in some drivers today get spurious interrupts when DEVICE is
> > used but don't see them when using SO.
>
> ... until now, or even that very sentence.

That is our fault then I suppose for not discussing this on arm-linux. In OMAP2 and OMAP3 this has been observed.  In vendor kernels where time stands still and lots of validation has happened we did stick with SO for OMAP2.  On some internal kernels already we have gone to SO for OMAP3 as customers ramp and need the errors gone.  The faster the system clocks the more it seems to show.

The thing with these effects, especially spurious IRQs is there usually are several reasons they show up and several ways to make them go away.  In the beginning there have been lots then they drop off as the system software matures.  Then if the program survives long enough to be optimized they start to show up again but in lesser numbers.  This has been the OMAP2/3 experience so far.  Going SO to control regions has stamped them out at this point.

> That's not unexpected if you don't have the right barriers in place
> at the end of things such as IRQ controllers ack/mask functions.

Yes. I've submitted patches (to linux-omap) and Catalin did submit patches (to arm-linux) for PIC barriers.  In the past they have been rejected by Tony or you for different reasons.  Tony last rejected it because he thought it should be generic at the ARM level.  I don't recall what your last stance was.

It is consistently observed, that with these irq-controller barriers in place, spurious irqs go down (but not necessarily away).

Our internal kernels still have this in them for OMAP2 and OMAP3.

> Can you give me more information - which OMAP platform, which IRQ
> controller, which device is easiest to provoke this behaviour, and
> I'll look at it.

Lately, a full OMAP3 system running with the 3d-GFX driver is causing these. Camera driver operation has been one which raised them on and off.  If it persists exporting an environment to you should be possible.  I expect it will take time and coordination to do this.

The pure linux-omap kernel has periodically seen spurious irqs with UART.  However, if you use the irq-controller barriers they tend to go away.

> > Originally the IC-Architect wanted two memory windows per device, one
> > SO for register control and one DEVICE for FIFO access.  Given that we
> > do DMA (which doesn't care about how ARM sees the world) on the
> > performance hungry devices not doing this was ok.
>
> I'm not sure what point you're making there.

Use a dual mapping to manage a device (2 ioremaps).  You use a SO mapping to write to registers of that device.  Then when you go to write to its FIFO use a DEVICE mapping.

Say TX IRQ happens at UART, I might check status bits through a SO mapping, but when it comes time to fill the FIFO I write to the DEVICE mapping.  Maybe I can even arrange it such that I burst in order using the natural FIFO width.  Even if you don't burst you can take advantage of the bus posting effects.  Fill the FIFO and get out of there with out a big stall time.

Like I said previously, a system likely will use DMA to the FIFO if performance matters, so not optimizing here has been the choice.

> > For an experiment a couple years back we did convert the dma alloc
> > pool addresses as NC.  All worked -except- for OHCI-USB which started
> > failing some tests.
>
> If we go down the route of marking DMA as 'normal memory non-cacheable'
> we're going to have a never ending stream of drivers which don't work
> correctly.  We're forever going to be bug hunting drivers, having to
> add barriers as required.  Arguably those barriers should be there
> already, but if drivers are developed on platforms without weak ordering,
> authors just don't think about it, and _certainly_ can't test them.

Is this just the case for an attribute to be made available from an API change/addition to allow a driver to make use of it?  The default can always be conservative.

The trend is ARMs are depending more on pipeline and prefetch tricks to perform. For these tricks to work weak memory features need to be used at times.

Regards,
Richard W.

