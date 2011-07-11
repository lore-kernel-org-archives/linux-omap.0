From: Tony Lindgren <tony@atomide.com>
Subject: Re: [linux-pm] Runtime PM discussion notes
Date: Mon, 11 Jul 2011 04:14:24 -0700
Message-ID: <20110711111424.GV5783@atomide.com>
References: <Pine.LNX.4.44L0.1106231113170.2033-100000@iolanthe.rowland.org>
 <201106232234.21930.rjw@sisk.pl>
 <alpine.DEB.2.00.1106241239340.25533@utopia.booyaka.com>
 <BANLkTinaa2W0mTUGCzfLAgBsgC5nP57x9ZXC0PfOvqa7x16kvw@mail.gmail.com>
 <alpine.DEB.2.00.1106281346160.2874@utopia.booyaka.com>
 <20110709040622.GH26900@sirena.org.uk>
 <20110711095812.GT5783@atomide.com>
 <20110711110435.GF5092@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:41291 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752531Ab1GKLOr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jul 2011 07:14:47 -0400
Content-Disposition: inline
In-Reply-To: <20110711110435.GF5092@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Paul Walmsley <paul@pwsan.com>, Arve Hj?nnev?g <arve@android.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Kevin Hilman <khilman@ti.com>

* Mark Brown <broonie@opensource.wolfsonmicro.com> [110711 03:59]:
> On Mon, Jul 11, 2011 at 02:58:12AM -0700, Tony Lindgren wrote:
> > * Mark Brown <broonie@opensource.wolfsonmicro.com> [110708 21:01]:
> 
> > > At least the Nexus S doesn't implmeent any of the deep idle
> > > infrastructure.  However, I'd expect that you can achieve some power
> > > saving from entering system suspend as if *everything* is off then the
> > > PMIC can be suspended which can enable additional power savings.  Unless
> > > I'm missing something that'd be hard to hit with cpuidle only stuff.
> 
> > You should be able to hit the same states from idle no problem. At that
> > point the only things on are memory in retention and some wake-up timer.
> > Even the timer could be off if you have hardware wake-up events, but then
> > system timer won't work the noral way naturally.
> 
> Right, but it can be interesting to tell the PMIC that we went into this
> mode.  Possibly cpuidle will end up doing this as a result of signals
> generated as the CPU core goes down, but at that point it's just s2ram
> by another name.

All PMIC devices should be shut down when not in use, so I don't know
what else you would configure in the PMIC. Maybe you have something else
there to configure? Just curious what kind of mess you have to deal with
compared to the mess I need to deal with :)

Also, hitting deeper sleep states from idle is not same as suspend to ram.
With suspend to ram the system timer is killed while timers behave in a
normal way when hitting deeper sleep states from idle.
 
> > The only way power down everything in suspend to disk :) Most PMICs have
> > some functionality always on so they can charge the battery when it's
> > empty.
> 
> With some PMICs the truly always on functionality is *very* minimal and
> doesn't include chargers, it can be pretty much limited to wake sources
> (including power status changes which might start charging if power
> appears).

Sure.

Tony
