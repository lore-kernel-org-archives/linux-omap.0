From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Open issues after 2.6.38 merge window
Date: Mon, 17 Jan 2011 15:49:02 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101171427330.13225@utopia.booyaka.com>
References: <20110114194758.GM4957@atomide.com> <alpine.DEB.1.10.1101171328440.8142@esdhcp041196.research.nokia.com> <701a8169276ef3a1eccbac0d31117a6b@mail.gmail.com> <alpine.DEB.1.10.1101171410290.8142@esdhcp041196.research.nokia.com>
 <alpine.DEB.2.00.1101171319590.13225@utopia.booyaka.com> <20110117203902.GC4042@flint.arm.linux.org.uk> <alpine.DEB.2.00.1101171341591.13225@utopia.booyaka.com> <20110117211956.GD4042@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43402 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753082Ab1AQWtD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 17:49:03 -0500
In-Reply-To: <20110117211956.GD4042@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Mon, 17 Jan 2011, Russell King wrote:

> On Mon, Jan 17, 2011 at 02:00:17PM -0700, Paul Walmsley wrote:
> > On Mon, 17 Jan 2011, Russell King wrote:
> > > On Mon, Jan 17, 2011 at 01:31:47PM -0700, Paul Walmsley wrote:
> > > > 
> > > > OMAP15xx uses the MPU timer for its clocksource, since OMAP15xx doesn't 
> > > > have GPTIMERs or the 32k sync timer, and the MPU timer code in 
> > > > mach-omap1/time.c wasn't updated for sched_clock() support.
> > > > 
> > > > Adding an init_fixed_sched_clock() into omap_init_clocksource() should 
> > > > fix the boot on OMAP15xx/7xx.
> > > 
> > > No, it needs fixing properly.  There's no reason the gpt clocksource
> > > can't be used for sched_clock.
> > 
> > There's a very good reason why it can't on OMAP15xx/7xx.  GPTIMER/DMTIMER 
> > IP blocks are only present on OMAP1610 and later[1].  Nor is a 
> > SYNCTIMER_32K IP block present on OMAP15xx/7xx[2].
> 
> Yes I realise that.  That doesn't negate what I said though.  Let me
> show you how to do it:

...

> Both a GPT _and_ 32K sched_clock implementation together, selectable
> at runtime or build time depending on what is selected.  I'll give you
> that it isn't nice code, but it does what's required.

Right.  I agree that it is possible to support both GPTIMER and 32KiHz 
clocksources at runtime.  But there should be a third case in that code 
also, a case for the OMAP1 MPU Timer IP blocks.  

Of course, it would be technically possible to define "GPT"/"GPTIMER" to 
mean "MPU Timer" on OMAP15xx/OMAP7xx.  However, later OMAP1 chips contain 
all three of the above-mentioned timer IP blocks: GPTIMERs[1], a 
SYNCTIMER_32K[2], and the MPU Timers[3].  Each of these timers also has 
distinct power, interconnect, and register access properties.  So it seems 
less confusing to keep the MPU Timer case distinct from the GPTIMER/GPT 
case.


- Paul


1. OMAP1611/12 Multimedia Processor Technical Reference Manual [SWPU066B],
   section 13.5, "Dual-Mode Timer"

2. OMAP1611/12 Multimedia Processor Technical Reference Manual [SWPU066B],
   section 13.6, "32-kHz Synchronized Timer"

3. OMAP1611/12 Multimedia Processor Technical Reference Manual [SWPU066B],
   section 13.4, "OMAP3.2 Operating System Timer"
