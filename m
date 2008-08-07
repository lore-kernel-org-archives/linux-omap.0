From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM MMU: add strongly-ordered memory type
Date: Thu, 7 Aug 2008 20:25:31 +0100
Message-ID: <20080807192531.GF5737@flint.arm.linux.org.uk>
References: <alpine.DEB.1.00.0808041738400.18201@utopia.booyaka.com> <1218016428.25235.11.camel@pc1117.cambridge.arm.com> <13B9B4C6EF24D648824FF11BE89671620361F4E504@dlee02.ent.ti.com> <20080807073035.GA10255@flint.arm.linux.org.uk> <13B9B4C6EF24D648824FF11BE89671620361FBB4FB@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54468 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbYHGT0R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Aug 2008 15:26:17 -0400
Content-Disposition: inline
In-Reply-To: <13B9B4C6EF24D648824FF11BE89671620361FBB4FB@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>

On Thu, Aug 07, 2008 at 01:56:40PM -0500, Woodruff, Richard wrote:
> > From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> > > Most of the weak memory attributes in newer ARMs are not exploited
> > > today in tree.  I'll guess this was more a correctness and capability
> > > judgment from Russell.
> >
> > Not entirely true.  We do as much as is safe to do - which is
> > basically
> > using 'device' mappings for devices and ioremap, and 'memory' mappings
> > for the main memory, module and vmalloc mappings.
> 
> Is DEVICE really safe for things other than FIFOs with out the use of
> barriers?

As far as I'm aware, yes - and that comment is based solely upon the
fact that no one has reported any problems with the kernel which have
been tracked down to using the device memory type on ARMv6 and above...

> We do in some drivers today get spurious interrupts when DEVICE is
> used but don't see them when using SO.

... until now, or even that very sentence.

That's not unexpected if you don't have the right barriers in place
at the end of things such as IRQ controllers ack/mask functions.

Can you give me more information - which OMAP platform, which IRQ
controller, which device is easiest to provoke this behaviour, and
I'll look at it.

> Originally the IC-Architect wanted two memory windows per device, one
> SO for register control and one DEVICE for FIFO access.  Given that we
> do DMA (which doesn't care about how ARM sees the world) on the
> performance hungry devices not doing this was ok.

I'm not sure what point you're making there.

> For an experiment a couple years back we did convert the dma alloc
> pool addresses as NC.  All worked -except- for OHCI-USB which started
> failing some tests.

If we go down the route of marking DMA as 'normal memory non-cacheable'
we're going to have a never ending stream of drivers which don't work
correctly.  We're forever going to be bug hunting drivers, having to
add barriers as required.  Arguably those barriers should be there
already, but if drivers are developed on platforms without weak ordering,
authors just don't think about it, and _certainly_ can't test them.
