From: Paul Walmsley <paul@pwsan.com>
Subject: RE: Open issues after 2.6.38 merge window
Date: Mon, 17 Jan 2011 13:31:47 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101171319590.13225@utopia.booyaka.com>
References: <20110114194758.GM4957@atomide.com> <alpine.DEB.1.10.1101171328440.8142@esdhcp041196.research.nokia.com> <701a8169276ef3a1eccbac0d31117a6b@mail.gmail.com> <alpine.DEB.1.10.1101171410290.8142@esdhcp041196.research.nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:54303 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753069Ab1AQUbs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 15:31:48 -0500
In-Reply-To: <alpine.DEB.1.10.1101171410290.8142@esdhcp041196.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Tony Lindgren <tony@atomide.com>, rmk+kernel@arm.linux.org.uk, linux-omap@vger.kernel.org

On Mon, 17 Jan 2011, Aaro Koskinen wrote:

> On Mon, 17 Jan 2011, Santosh Shilimkar wrote:
> > > Amstrad E3 fails during the boot. Bisection points to:
> > > 
> > >  	commit 211baa7016894c02fc18693e21ca479cd08ac0c0
> > >  	Author: Russell King <rmk+kernel@arm.linux.org.uk>
> > >  	Date:   Tue Jan 11 16:23:04 2011 +0000
> > > 
> > >  	    ARM: sched_clock: allow init_sched_clock() to be called
> > > early
> > > 
> > > The board does not have sched_clock(), although HAVE_SCHED_CLOCK is
> > > defined for all OMAP.
> > > 
> > I guess above is sorted out by the attached patch from Paul.
> 
> I don't see how it could help? Amstrad E3 is OMAP 15xx.

OMAP15xx uses the MPU timer for its clocksource, since OMAP15xx doesn't 
have GPTIMERs or the 32k sync timer, and the MPU timer code in 
mach-omap1/time.c wasn't updated for sched_clock() support.

Adding an init_fixed_sched_clock() into omap_init_clocksource() should 
fix the boot on OMAP15xx/7xx.


- Paul
