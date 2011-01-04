From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 1/3] ARM: add CPPI 4.1 DMA support
Date: Tue, 4 Jan 2011 11:12:36 -0800
Message-ID: <20110104191236.GG7771@atomide.com>
References: <201005152214.53993.sshtylyov@ru.mvista.com>
 <4D21F3F2.6090302@mvista.com>
 <20110103163447.GB2911@n2100.arm.linux.org.uk>
 <19F8576C6E063C45BE387C64729E739404BD3F2C4D@dbde02.ent.ti.com>
 <4D220246.5020303@mvista.com>
 <20110103171945.GA3839@n2100.arm.linux.org.uk>
 <20110103204952.GB2240@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:42912 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513Ab1ADTMw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 14:12:52 -0500
Content-Disposition: inline
In-Reply-To: <20110103204952.GB2240@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Sergei Shtylyov <sshtylyov@mvista.com>, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Felipe Balbi <balbi@ti.com> [110103 12:49]:
> Hi,
> 
> On Mon, Jan 03, 2011 at 05:19:45PM +0000, Russell King - ARM Linux wrote:
> >>   Frankly speaking, I doubt that drivers/dma/ will have place for the
> >>purely MUSB specific DMA engines such as the named ones (there's no TUSB
> >>DMA BTW -- it uses OMAP DMA).
> >
> >Long term, we need to kill off all these platform private DMA interfaces.
> >There's a growing amount of IP that's being shared not only between ARM
> >silicon vendors, but also across architectures, and having to re-implement
> >drivers because the underlying DMA engine is different is not feasible.
> >
> >For example, we're seeing ARMs primecells being used with various
> >different DMA controllers in various different ARM SoCs.  I've heard
> >rumours of them appearing in MIPS or PPC stuff as well.  We're seeing
> >PXA peripheral IP appearing in x86 stuff too.
> >
> >We can't have drivers tied to their SoC DMA engines, and we can't continue
> >having SoC DMA engines implementing their own unique APIs.  We do need to
> >get on top of this before it becomes a major problem (if it hasn't
> >already).
> >
> >The DMA engine API is still evolving, and should not be taken as concrete
> >- I've recently been bringing up a number of points with Dan on various
> >aspects of the API, some of which ultimately will lead to changes to the
> >async-tx API, and others which hopefully will mean that the DMA slave
> >API is better documented.
> 
> I couldn't agree more with you Russell. If the API isn't enough
> currently, we can always propose an extension.
> 
> Having all sorts of SoC-specific "APIs" has already caused enough
> problems and it still does (non-generic IRQ handling on
> twl?030, menelaus, cbus - which isn't in mainline yet -, etc,
> non-generic McBSP usage, non-generic GPMC usage, etc etc). So, if we can
> plan for making use of generic APIs, let's do so.

Yes I too agree with this. We just need to do whatever it takes to
make the DMA engine suitable for all drivers.

Regards,

Tony
