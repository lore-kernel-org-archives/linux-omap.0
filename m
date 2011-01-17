From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Open issues after 2.6.38 merge window
Date: Mon, 17 Jan 2011 20:39:02 +0000
Message-ID: <20110117203902.GC4042@flint.arm.linux.org.uk>
References: <20110114194758.GM4957@atomide.com> <alpine.DEB.1.10.1101171328440.8142@esdhcp041196.research.nokia.com> <701a8169276ef3a1eccbac0d31117a6b@mail.gmail.com> <alpine.DEB.1.10.1101171410290.8142@esdhcp041196.research.nokia.com> <alpine.DEB.2.00.1101171319590.13225@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45377 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497Ab1AQUjy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 15:39:54 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1101171319590.13225@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Mon, Jan 17, 2011 at 01:31:47PM -0700, Paul Walmsley wrote:
> On Mon, 17 Jan 2011, Aaro Koskinen wrote:
> 
> > On Mon, 17 Jan 2011, Santosh Shilimkar wrote:
> > > > Amstrad E3 fails during the boot. Bisection points to:
> > > > 
> > > >  	commit 211baa7016894c02fc18693e21ca479cd08ac0c0
> > > >  	Author: Russell King <rmk+kernel@arm.linux.org.uk>
> > > >  	Date:   Tue Jan 11 16:23:04 2011 +0000
> > > > 
> > > >  	    ARM: sched_clock: allow init_sched_clock() to be called
> > > > early
> > > > 
> > > > The board does not have sched_clock(), although HAVE_SCHED_CLOCK is
> > > > defined for all OMAP.
> > > > 
> > > I guess above is sorted out by the attached patch from Paul.
> > 
> > I don't see how it could help? Amstrad E3 is OMAP 15xx.
> 
> OMAP15xx uses the MPU timer for its clocksource, since OMAP15xx doesn't 
> have GPTIMERs or the 32k sync timer, and the MPU timer code in 
> mach-omap1/time.c wasn't updated for sched_clock() support.
> 
> Adding an init_fixed_sched_clock() into omap_init_clocksource() should 
> fix the boot on OMAP15xx/7xx.

No, it needs fixing properly.  There's no reason the gpt clocksource
can't be used for sched_clock.  We just need to switch to the variable
rate implementation rather than the fixed rate if we include OMAP15xx/7xx
support.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
