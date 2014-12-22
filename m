From: Tony Lindgren <tony@atomide.com>
Subject: Re: regression: OMAP4 (next-20141204) (bisect to: ARM: 8208/1: l2c:
 Refactor the driver to use commit-like)
Date: Mon, 22 Dec 2014 09:08:49 -0800
Message-ID: <20141222170849.GK23854@atomide.com>
References: <5481D913.9040109@ti.com>
 <5481D9BF.2090007@ti.com>
 <20141209165746.GA29935@kahuna>
 <54881589.20105@samsung.com>
 <20141211092945.GE11502@n2100.arm.linux.org.uk>
 <54897528.4030804@samsung.com>
 <20141222170411.GL11502@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:22012 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754481AbaLVRLg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 22 Dec 2014 12:11:36 -0500
Content-Disposition: inline
In-Reply-To: <20141222170411.GL11502@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-next <linux-next@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [141222 09:06]:
> On Thu, Dec 11, 2014 at 11:42:48AM +0100, Marek Szyprowski wrote:
> > On 2014-12-11 10:29, Russell King - ARM Linux wrote:
> > >On Wed, Dec 10, 2014 at 10:42:33AM +0100, Marek Szyprowski wrote:
> > >>I assume that now it won't be possible to get l2c patches back to -next,
> > >>so I will resend them (again...) with the omap related fix.
> > >What, you mean you don't know the fundamental rules of kernel development?
> > >
> > >No one should ever dump any new code into linux-next during a merge
> > >window which is not a fix for a regression or a bug fix, period.
> > >
> > >Linus has in the past taken a snapshot of linux-next at the beginning
> > >of a merge window, and then threatened to refuse to merge anything that
> > >wasn't in his local snapshot, or which doesn't qualify as the above.
> > >
> > >So no, it won't be possible, because I play by the community rules when
> > >it comes to what gets merged and at what time in the cycle.
> > 
> > I know the rules. It was just my whining, that it is yet another release
> > cycle
> > that got missed. It is really disappointing, that those patches have been
> > floating for months and noone found issues related to different order of
> > initialization. It took way to long to get them scheduled for testing in
> > -next.
> 
> Right, so - we're now at -rc1, and we should see about queuing this up
> sooner rather than later - in its fixed form.  From what I can see,
> there's been little progress on the OMAP problem.
> 
> Nishanth - can we push OMAP over to using the generic DT L2C
> initialisation (the one from init_IRQ in arch/arm/kernel/irq.c) and
> kill the SoC specific stuff in arch/arm/mach-omap2/omap4-common.c ?
> 
> From what I can see, in the DT case, the only thing which is used
> there is the ioremap() to provide omap4_get_l2cache_base() with
> something to return.  Everything else - the initialisation of the
> l2c_write_sec pointer, and the aux mask and values - can be specified
> via the machine_desc struct.
> 
> That only leaves the non-DT stuff to worry about this, and from what I
> understand, that's going to be removed soon.  If we're going to keep
> the non-DT stuff, we should implement a new machine_desc hook for it
> instead of hijacking one of the existing callbacks.

For omap4 and later we've been DT only for about 1.5 years now so
that should not be an issue here.

Regards,

Tony
