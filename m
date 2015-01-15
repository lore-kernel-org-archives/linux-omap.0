From: Tony Lindgren <tony@atomide.com>
Subject: Re: Regression with legacy IRQ numbers caused by 9a1091ef0017
Date: Thu, 15 Jan 2015 07:37:48 -0800
Message-ID: <20150115153746.GC18552@atomide.com>
References: <20150114221407.GS2419@atomide.com>
 <8761c8i2hq.fsf@approximate.cambridge.arm.com>
 <2776397.iNGHcrIBZz@wuerfel>
 <87wq4ogl48.fsf@approximate.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:45692 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752275AbbAOPlq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Jan 2015 10:41:46 -0500
Content-Disposition: inline
In-Reply-To: <87wq4ogl48.fsf@approximate.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, Felipe Balbi <balbi@ti.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>, Thomas Gleixner <tglx@linutronix.de>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Marc Zyngier <marc.zyngier@arm.com> [150115 06:46]:
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

The muxing is only done for omap3 in legacy booting mode.

> - interrupt description for some drivers, using resources.

That's still used to create legacy platform_device entries on omap4
for legacy DMA, DSS, PRM. The twl6040 entries are already unused
and I have a patch queued to remove them.
 
> It should be fairly easy to do the latter, but the former looks more
> tricky (it would push the pad configuration down to the drivers, which
> is avoided at the moment).

The pad configuration is already done with pinctrl-single.
 
> Probably there is a workable strategy, but my knowledge about OMAP is
> close to *nothing*...

I have a feeling this might bite other platforms too and we just have
not noticed it yet..

Regards,

Tony
