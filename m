From: Tony Lindgren <tony@atomide.com>
Subject: Re: [linux-pm] Runtime PM discussion notes
Date: Mon, 11 Jul 2011 02:58:12 -0700
Message-ID: <20110711095812.GT5783@atomide.com>
References: <Pine.LNX.4.44L0.1106231113170.2033-100000@iolanthe.rowland.org>
 <201106232234.21930.rjw@sisk.pl>
 <alpine.DEB.2.00.1106241239340.25533@utopia.booyaka.com>
 <BANLkTinaa2W0mTUGCzfLAgBsgC5nP57x9ZXC0PfOvqa7x16kvw@mail.gmail.com>
 <alpine.DEB.2.00.1106281346160.2874@utopia.booyaka.com>
 <20110709040622.GH26900@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:41119 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752361Ab1GKJ62 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Jul 2011 05:58:28 -0400
Content-Disposition: inline
In-Reply-To: <20110709040622.GH26900@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Paul Walmsley <paul@pwsan.com>, Arve Hj?nnev?g <arve@android.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Kevin Hilman <khilman@ti.com>

* Mark Brown <broonie@opensource.wolfsonmicro.com> [110708 21:01]:
> On Tue, Jun 28, 2011 at 01:47:47PM -0600, Paul Walmsley wrote:
> > On Fri, 24 Jun 2011, Arve Hj?nnev?g wrote:
> > > On Fri, Jun 24, 2011 at 12:53 PM, Paul Walmsley <paul@pwsan.com> wrote:
> 
> > > > "On the hardware that shipped we enter the same power state from idle
> > > > and suspend, so the only power savings we get from suspend that we
> > > > don't get in idle is from not respecting the scheduler and timers."
> 
> > > This is no longer the case. Both the Nexus-S and Xoom enter lower
> > > power states from suspend than idle.
> 
> > Just out of curiosity, is that due to some kind of hardware limitation on 
> > those platforms, or is it because the software infrastructure for dynamic 
> > deep idle hasn't been fully implemented in that subarchitecture code?
> 
> At least the Nexus S doesn't implmeent any of the deep idle
> infrastructure.  However, I'd expect that you can achieve some power
> saving from entering system suspend as if *everything* is off then the
> PMIC can be suspended which can enable additional power savings.  Unless
> I'm missing something that'd be hard to hit with cpuidle only stuff.

You should be able to hit the same states from idle no problem. At that
point the only things on are memory in retention and some wake-up timer.
Even the timer could be off if you have hardware wake-up events, but then
system timer won't work the noral way naturally.

The only way power down everything in suspend to disk :) Most PMICs have
some functionality always on so they can charge the battery when it's
empty.

Regards,

Tony
