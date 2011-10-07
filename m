From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: ARM SoC tree: OMAP PM dependency on tip irq/core
Date: Fri, 7 Oct 2011 20:59:11 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1110072056050.3240@ionos>
References: <87aa9mm8ts.fsf@ti.com> <201110071804.11494.arnd@arndb.de> <87d3e8lmhp.fsf@ti.com> <201110072053.41594.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:43920 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753416Ab1JGS7P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Oct 2011 14:59:15 -0400
In-Reply-To: <201110072053.41594.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robherring2@gmail.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Fri, 7 Oct 2011, Arnd Bergmann wrote:

> On Friday 07 October 2011, Kevin Hilman wrote:
> > > I've pulled in rmk/devel-stable as a dependency now, thanks for
> > > reminding me of that.
> > >
> > > Thomas, where should I get the irq-core branch (or whichever
> > > I should wait for) to pull in as another dependency. Is that
> > > branch one that never gets rebased? 
> > 
> > git://tesla.tglx.de/git/linux-2.6-tip irq/core
> > 
> > I asked Thomas about this earlier when I was going to build up the
> > dependencies myself, and he said it won't be rebased.
> 
> Ok, thanks for the info.
> 
> I think I've now also come up with a workflow for tracking the dependencies:
> I have a depends/xxx branch for each other branch that I need to wait for
> getting merged first. When I want to send a pull request, I first check
> all the depends/* branches using 'git branch --merged next/xxx |
> grep depends' to see what the dependencies are, and 'git branch --merged
> torvalds/master | grep depends' to see if they are already merged upstream.
> When a dependency is already merged, I can remove its tracking branch
> from the arm-soc tree.

For your internal dependecies, yes. But for irq/core you don't have to
wait. You just need to tell Linus in the pull request that you pulled
my branch with my ack as it contains modifications which are
prerequisite for arm/whatever.

When I send my pull request later, then this wont do any damage as
Linus has the commits already. Same the other way round. We do that
all the time, otherwise pull dependencies would be a nightmare.

Thanks,

	tglx
