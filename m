From: Simon Horman <horms@verge.net.au>
Subject: Re: Regression with legacy IRQ numbers caused by 9a1091ef0017
Date: Sat, 17 Jan 2015 09:48:04 +0900
Message-ID: <20150117004804.GA27616@verge.net.au>
References: <20150114221407.GS2419@atomide.com>
 <87wq4ogl48.fsf@approximate.cambridge.arm.com>
 <20150115153746.GC18552@atomide.com>
 <3822486.YZLIqXdAgt@wuerfel>
 <54B948F9.2060100@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:42465 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466AbbAQAsS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2015 19:48:18 -0500
Content-Disposition: inline
In-Reply-To: <54B948F9.2060100@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, Felipe Balbi <balbi@ti.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>, Thomas Gleixner <tglx@linutronix.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "magnus.damm@gmail.com" <magnus.damm@gmail.com>

On Fri, Jan 16, 2015 at 05:23:05PM +0000, Marc Zyngier wrote:
> On 16/01/15 16:56, Arnd Bergmann wrote:
> > On Thursday 15 January 2015 07:37:48 Tony Lindgren wrote:
> >> * Marc Zyngier <marc.zyngier@arm.com> [150115 06:46]:
> >>> On Thu, Jan 15 2015 at  2:27:56 pm GMT, Arnd Bergmann <arnd@arndb.de> wrote:
> >>>> On Thursday 15 January 2015 13:42:57 Marc Zyngier wrote:
> >>> Probably there is a workable strategy, but my knowledge about OMAP is
> >>> close to *nothing*...
> >>
> >> I have a feeling this might bite other platforms too and we just have
> >> not noticed it yet..
> > 
> > I'm looking through the entire tree now, scanning for machines that have
> > GIC and use IORESOURCE_IRQ or DEFINE_RES_IRQ in their platform code.
> > Most platforms using GIC are completely converted to DT and have no
> > hardcoded legacy IRQs.
> > 
> > I have checked that cns3xxx and realview are both fine by inspection.
> > 
> > The only one I'm not sure about is shmobile, which looks like it might
> > suffer from the same problem. Simon/Magnus, could you verify this
> > with a multiplatform kernel on any SoC that has GIC and uses devices
> > that have interrupts defined in setup-*.c or board-*.c?
> 
> There are 3 patches floating around for shmobile, converting their
> non-DT support to directly initializing the GIC instead of relying on
> irqchip_init().

There is also a fourth patch pending to fix one last SoC, the r8a73a4.
My understanding is that should be the end of the problems that
we have been seeing in this area.

> That's assuming their DT implementation doesn't use any
> of these device declarations.

I believe that assumption is correct. shmobile does not use any
devices that have interrupts defined in setup-*.c or board-*.c when
booting using multiplatform.

> If they do, we could use a hack similar to the one I implemented for
> OMAP, populating the virtual IRQ in the resource at boot time, just
> after the irqchip initialization.
> 
> Thanks,
> 
> 	M.
> -- 
> Jazz is not dead. It just smells funny...
> 
