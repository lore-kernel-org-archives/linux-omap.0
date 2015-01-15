From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Regression with legacy IRQ numbers caused by 9a1091ef0017
Date: Thu, 15 Jan 2015 17:37:50 +0100
Message-ID: <20923934.GLG5LeSnXd@wuerfel>
References: <20150114221407.GS2419@atomide.com> <2776397.iNGHcrIBZz@wuerfel> <87wq4ogl48.fsf@approximate.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:59917 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929AbbAOQi5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Jan 2015 11:38:57 -0500
In-Reply-To: <87wq4ogl48.fsf@approximate.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, Felipe Balbi <balbi@ti.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>, Thomas Gleixner <tglx@linutronix.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Thursday 15 January 2015 14:43:35 Marc Zyngier wrote:
> On Thu, Jan 15 2015 at  2:27:56 pm GMT, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thursday 15 January 2015 13:42:57 Marc Zyngier wrote:
> >> Of course, this is in no way a proper fix, but I suppose the OMAP DT is
> >> still missing a few bits...
> >
> > I must be missing something here, but all the interrupts are listed
> > correctly in the DT, so what is the omap_hwmod_irq_info actually
> > achieving on omap4 and omap5?
> >
> > Would it work if we just remove the incorrect copy of the resource
> > and use the one that comes from DT?
> 
> By the look of it, omap_hwmod_irq_info serves multiple purposes:
> - low level configuration (pads, probably more stuff)
> - interrupt description for some drivers, using resources.
> 
> It should be fairly easy to do the latter, but the former looks more
> tricky (it would push the pad configuration down to the drivers, which
> is avoided at the moment).
> 
> Probably there is a workable strategy, but my knowledge about OMAP is
> close to *nothing*...

I don't know much about OMAP either so maybe it's better to let someone
comment who understands this better. ;-)

A number of commits have in the past removed omap_hwmod_irq_info entries
here, the last one was  09182ab11b49 ("ARM: OMAP4: hwmod data: Remove
irq entries from mcspi, mmc hwmods").

>From what I can tell, we could drop the omap44xx_dss_dispc_irqs,
omap44xx_dss_dsi1_irqs, omap44xx_dss_dsi2_irqs, and omap44xx_dss_hdmi_irqs
in the samem way, after this data got added to DT as part of
cfe86fcf2d0079f03 ("ARM: omap4.dtsi: add omapdss information").

Unfortunately, the omap-dma driver once again gets in the way, since
there are still users of this that are not converted to use dmaengine,
and unlike the proper driver (drivers/dma/omap-dma.c), the legacy
driver (arch/arm/mach-omap2/dma.c) does not get probed from DT and
instead gets the wrong irq numbers from hwmod now.

	Arnd
