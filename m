From: David Brownell <david-b@pacbell.net>
Subject: Re: Overo broken after recent mainline merge
Date: Sat, 14 Mar 2009 14:14:05 -0700
Message-ID: <200903141414.06045.david-b@pacbell.net>
References: <5e088bd90903140624u5b5098f4vd9b1afa937325779@mail.gmail.com> <200903141208.30413.david-b@pacbell.net> <20090314202250.GA17554@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:28449 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751198AbZCNVOJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 14 Mar 2009 17:14:09 -0400
In-Reply-To: <20090314202250.GA17554@sirena.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Steve Sakoman <sakoman@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

On Saturday 14 March 2009, Mark Brown wrote:
> On Sat, Mar 14, 2009 at 12:08:30PM -0700, David Brownell wrote:
> 
> > The basic problem is that still-unfixed goofage in the regulator
> > framework:  it seriously mis-handles regulators that bootloaders
> > leave enabled.  This can be teased apart into at least two bugs,
> > possibly as many as four.  The fix for one of them is queued in
> > the regulator-next tree.
> 
> For clarity, what David is referring to here is that it's not currently
> possible for the machine constraints to turn off a regulator that has
> been left enabled when the kernel starts.

Not quite -- that would be one solution, for the first
several cases I had to deal with.

But thinking about how to handle the video support makes
it clear that's not always the best solution.  One needs
bootloaders to be able to throw a splash screen which
stays active until the window system kicks in ... but
turning off video regulators would clearly blacken the
screen, which is the wrong model.  (And marking them as
"always on" or "boot_on" is wrong for other reasons.)

The way clocks handle that is with a late disable,
so drivers have a chance to start up.  You rejected
the REGULATOR_DISABLE_UNUSED patch I sent, applying
that model ... and that's why I started to think about
other approaches, as in the "early disable" patch I
sent earlier in this thread.

A third approach (after applying that one patch that's
in the regulator-next tree) would be

	if (rdev->is_enabled() > 0)
		rdev->use_count = 1;

when initializing regulators.  I updated the TWL4030
code so is_enabled() checks only the Linux enables,
while get_status() reports the true state, so maybe
that would be a solution you'd accept.

Of course that makes use_count be even more of a
misnomer, but that's a separate issue ... refcounts
should be handled by the driver model.

- Dave


