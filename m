From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC/PATCH 1/5] usb: otg: add notifier support
Date: Tue, 26 Jan 2010 05:35:21 -0800
Message-ID: <201001260535.21689.david-b@pacbell.net>
References: <6ed0b2680912101251jeec28e6i216dfc51caab13aa@mail.gmail.com> <201001260316.20529.david-b@pacbell.net> <20100126131146.GC32291@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp127.sbc.mail.sp1.yahoo.com ([69.147.65.186]:32365 "HELO
	smtp127.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752946Ab0AZNfX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Jan 2010 08:35:23 -0500
In-Reply-To: <20100126131146.GC32291@sirena.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Anton Vorontsov <avorontsov@ru.mvista.com>, Grazvydas Ignotas <notasas@gmail.com>, Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>

On Tuesday 26 January 2010, Mark Brown wrote:
> On Tue, Jan 26, 2010 at 03:16:20AM -0800, David Brownell wrote:
> 
> > I'd vote to convert all the USB-to-charger interfaces so
> > they use notifiers.  After fixing the events ... see
> > comments below.  :)
> 
> Yes please - it's not just chargers either, this can also be used by
> PMICs which do power path management that includes USB.

Color me confused ... what do you mean by "power path"?

Do you mean something like "the board as a whole can take N mA of
current from USB", rather than specifically addressing a charger?

It's not uncommon to do things like use VBUS current to power the
USB circuitry, too.  That can leave less for other purposes.  All
of that being rather board-specific.


> > Those seem like the wrong events.  The right events for a charger
> > would be more along the lines of:
> 
> >  - For peripheral:  "you may use N milliAmperes now".
> >  - General:  "Don't Charge" (a.k.a. "use 0 mA").
> 
> > I don't see how "N" would be passed with those events ...
> 
> These are good for the peripheral side.  You do get to pass a void *
> along with the notifier value, that could be used to pass data like the
> current limit.

I don't think I saw that being done ... either in code, comments,
or documentation.  Passing N is fundamental.


> > A host *might* want to be able to say things like "supply
> > up to N milliAmperes now", e.g. to let a regulator choose
> > the most efficient mode.
> 
> Yes, they definitely want this - not just for efficiency but also to
> allow current limiting to protect the system from excessive current
> drain.

There are load bursting issues too.  All part of the USB spec;
a load that's OK for 1 millisecond might not be OK for 1 second.
ISTR the "supply N mA" refers to an average.  And there are some
limits to the capacitance that can practically be stuck on VBUS
output lines (which includes the cable).  Solvable problems, but
not always pretty if software has to think it through.

Thing is, supplying current is a bit more involved.  If the
board can't supply 300 mA, the USB configuration selection
mechanism has to know that, so it never selects peripheral
configurations which require that much current.

Or maybe these two ports can serve 500 mA, but not those two;
or their total can't exceed N (function of componentry and power
budgeting).

Ergo my desire to start with a straightforward problem whose
solution has real value (how much VBUS current may be consumed?),
and leave some of those other messes for later!

- Dave

