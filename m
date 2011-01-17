From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Open issues after 2.6.38 merge window
Date: Mon, 17 Jan 2011 12:50:15 +0000
Message-ID: <20110117125015.GC18600@flint.arm.linux.org.uk>
References: <20110114194758.GM4957@atomide.com> <alpine.DEB.1.10.1101171328440.8142@esdhcp041196.research.nokia.com> <701a8169276ef3a1eccbac0d31117a6b@mail.gmail.com> <alpine.DEB.1.10.1101171410290.8142@esdhcp041196.research.nokia.com> <78caabae29d28f26d5d003eeb7e75526@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33007 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131Ab1AQMuf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 07:50:35 -0500
Content-Disposition: inline
In-Reply-To: <78caabae29d28f26d5d003eeb7e75526@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Mon, Jan 17, 2011 at 06:05:36PM +0530, Santosh Shilimkar wrote:
> > -----Original Message-----
> > From: Aaro Koskinen [mailto:aaro.koskinen@nokia.com]
> > Sent: Monday, January 17, 2011 5:52 PM
> > To: Santosh Shilimkar
> > Cc: Aaro Koskinen; Tony Lindgren; rmk+kernel@arm.linux.org.uk;
> > linux-omap@vger.kernel.org
> > Subject: RE: Open issues after 2.6.38 merge window
> >
> > Hi,
> >
> > On Mon, 17 Jan 2011, Santosh Shilimkar wrote:
> > >> Amstrad E3 fails during the boot. Bisection points to:
> > >>
> > >>  	commit 211baa7016894c02fc18693e21ca479cd08ac0c0
> > >>  	Author: Russell King <rmk+kernel@arm.linux.org.uk>
> > >>  	Date:   Tue Jan 11 16:23:04 2011 +0000
> > >>
> > >>  	    ARM: sched_clock: allow init_sched_clock() to be called
> > >> early
> > >>
> > >> The board does not have sched_clock(), although HAVE_SCHED_CLOCK
> > is
> > >> defined for all OMAP.
> > >>
> > > I guess above is sorted out by the attached patch from Paul.
> >
> > I don't see how it could help? Amstrad E3 is OMAP 15xx.
> >
> I read patch again and omap15xx is skipped. Not sure
> why 15xx is skipped.

EWW.  This is horrible - and too far complicated.

So if we build a kernel with OMAP730 or OMAP15xx support, the 32k
counter support is disabled for every platform, which also removes
sched_clock() support (as this uses the 32k timer).

If CONFIG_OMAP_32K_TIMER is also true (eg, because you enabled
OMAP16xx) then we won't have the GP clocksource code.  So a kernel
which is configured for OMAP15xx + OMAP16xx won't have any clocksource
code at all.

In effect, all this being done by _negative_ dependencies.  As has
been seen with deselecting the V6K configuration symbol, negative
dependencies are Bad News(tm).

This code needs to be restructured for positive dependencies and
proper selection of the appopriate clock sources - which then
needs to be coupled into sched_clock() properly so OMAP15xx can also
benefit from sched_clock() support.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
