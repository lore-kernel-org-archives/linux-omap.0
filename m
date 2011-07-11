From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [linux-pm] Runtime PM discussion notes
Date: Mon, 11 Jul 2011 20:26:22 +0900
Message-ID: <20110711112619.GH5092@opensource.wolfsonmicro.com>
References: <Pine.LNX.4.44L0.1106231113170.2033-100000@iolanthe.rowland.org>
 <201106232234.21930.rjw@sisk.pl>
 <alpine.DEB.2.00.1106241239340.25533@utopia.booyaka.com>
 <BANLkTinaa2W0mTUGCzfLAgBsgC5nP57x9ZXC0PfOvqa7x16kvw@mail.gmail.com>
 <alpine.DEB.2.00.1106281346160.2874@utopia.booyaka.com>
 <20110709040622.GH26900@sirena.org.uk>
 <20110711095812.GT5783@atomide.com>
 <20110711110435.GF5092@opensource.wolfsonmicro.com>
 <20110711111424.GV5783@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:59590 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754477Ab1GKL0e (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Jul 2011 07:26:34 -0400
Content-Disposition: inline
In-Reply-To: <20110711111424.GV5783@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Arve Hj?nnev?g <arve@android.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Kevin Hilman <khilman@ti.com>

On Mon, Jul 11, 2011 at 04:14:24AM -0700, Tony Lindgren wrote:
> * Mark Brown <broonie@opensource.wolfsonmicro.com> [110711 03:59]:

> > Right, but it can be interesting to tell the PMIC that we went into this
> > mode.  Possibly cpuidle will end up doing this as a result of signals
> > generated as the CPU core goes down, but at that point it's just s2ram
> > by another name.

> All PMIC devices should be shut down when not in use, so I don't know
> what else you would configure in the PMIC. Maybe you have something else
> there to configure? Just curious what kind of mess you have to deal with
> compared to the mess I need to deal with :)

The interesting bits are things like being able to kill lots of the SoC
core supplies when the RAM is in retention mode - the CPU needs to go
through its shutdown procedures.

> Also, hitting deeper sleep states from idle is not same as suspend to ram.
> With suspend to ram the system timer is killed while timers behave in a
> normal way when hitting deeper sleep states from idle.

Actually, it just occurred to me that if we're waiting for a system
timer and can hand that off to a suitable timer in the PMIC then we can
do a suspend to RAM for the deep idle state from the hardware point of
view.
