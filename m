From: Paul Walmsley <paul@pwsan.com>
Subject: Re: Open issues after 2.6.38 merge window
Date: Mon, 17 Jan 2011 14:00:17 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1101171341591.13225@utopia.booyaka.com>
References: <20110114194758.GM4957@atomide.com> <alpine.DEB.1.10.1101171328440.8142@esdhcp041196.research.nokia.com> <701a8169276ef3a1eccbac0d31117a6b@mail.gmail.com> <alpine.DEB.1.10.1101171410290.8142@esdhcp041196.research.nokia.com>
 <alpine.DEB.2.00.1101171319590.13225@utopia.booyaka.com> <20110117203902.GC4042@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45990 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913Ab1AQVAS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Jan 2011 16:00:18 -0500
In-Reply-To: <20110117203902.GC4042@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

On Mon, 17 Jan 2011, Russell King wrote:

> On Mon, Jan 17, 2011 at 01:31:47PM -0700, Paul Walmsley wrote:
> > 
> > OMAP15xx uses the MPU timer for its clocksource, since OMAP15xx doesn't 
> > have GPTIMERs or the 32k sync timer, and the MPU timer code in 
> > mach-omap1/time.c wasn't updated for sched_clock() support.
> > 
> > Adding an init_fixed_sched_clock() into omap_init_clocksource() should 
> > fix the boot on OMAP15xx/7xx.
> 
> No, it needs fixing properly.  There's no reason the gpt clocksource
> can't be used for sched_clock.

There's a very good reason why it can't on OMAP15xx/7xx.  GPTIMER/DMTIMER 
IP blocks are only present on OMAP1610 and later[1].  Nor is a 
SYNCTIMER_32K IP block present on OMAP15xx/7xx[2].

That said, the clocksource code in the OMAP tree could definitely use some 
cleanup.  The SYNCTIMER_32K/counter_32k clocksource should be registered 
from the plat-omap/counter_32k.c.  And your point about the compile-time 
negative dependencies is also a good one, now that omap1_defconfig exists.


- Paul

1. Current mainline source code for arch/arm/plat-omap/dmtimer.c, line 
   168:
   http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/arm/plat-omap/dmtimer.c;h=1d706cf63ca0e697521d38ab814d9889a1b70435;hb=refs/heads/master#l168

2. Current mainline source code for arch/arm/plat-omap/counter_32k.c, line 
   39:
   http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/arm/plat-omap/counter_32k.c;h=ea4644021fb9c0867c2e4ca4bd4bcb118e863f80;hb=refs/heads/master#l39

3. ibid.

