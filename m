From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/3] clk: ti: add 'ti,round-rate' flag
Date: Tue, 1 Jul 2014 23:34:18 +0100
Message-ID: <20140701223418.GQ3705@n2100.arm.linux.org.uk>
References: <1399540009-6953-1-git-send-email-tomi.valkeinen@ti.com> <5370B839.3050108@ti.com> <5370BAFF.9070501@ti.com> <20140515060834.3084.5199@quantum> <5374B241.9010201@ti.com> <20140531000207.10062.55946@quantum> <alpine.DEB.2.02.1406031907210.14238@utopia.booyaka.com> <538EBBF1.7040804@ti.com> <alpine.DEB.2.02.1406131924571.340@utopia.booyaka.com> <20140701214017.32686.37324@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:50508 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S964946AbaGAWe1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Jul 2014 18:34:27 -0400
Content-Disposition: inline
In-Reply-To: <20140701214017.32686.37324@quantum>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Paul Walmsley <paul@pwsan.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Jul 01, 2014 at 02:40:17PM -0700, Mike Turquette wrote:
> Let's get consensus on my above question before we solidify the API.
> It's worth noting that the current behavior of rounding the rate within
> clk_set_rate is actually what Russell had in mind back in 2010. See this
> thread[1] for details.

Yes, because the problem is that doing anything else is racy.

Consider the sequence (which some folk who don't understand this point
have coded all over the place):

	rate = clk_round_rate(clk, my_rate);

	clk_set_rate(clk, rate);

The problem here is that between the two calls, it is possible that (as
you say) the parent clocks could be reconfigured - there are no locks
held at any point to protect against that happening.

So, what the above sequence means is that:

	rate = clk_round_rate(clk, my_rate);

would return the rounded rate that the clock could provide for my_rate.
Then the clk's parent changes.

We now do the clk_set_rate().  This re-rounds the rate, and we get a
different rate to the one which was passed.  This could well be end
result from the rate you would get if you simply did:

	clk_set_rate(clk, my_rate);

Let's say that we did augment the interface with a load of clk_round_xxx()
method functions, and made clk_set_rate() error out of the passed rate
is not possible.  On the face of it, this looks like a sensible way
forward - but wait!  What if we re-read the above with these new
conditions and that race occurs:

	rate = clk_round_nearest(clk, my_rate);
	/* clk is reparented */
	err = clk_set_rate(clk, rate);

Now, err indicates an error.  So now we need to audit every driver using
this that they do something like this:

	for (try = 0; try < 10; try++) {
		rate = clk_round_nearest(clk, my_rate);

		err = clk_set_rate(clk, rate);
		if (!err)
			continue;
	}

	if (err)
		dev_err(dev, "failed to set clock rate to %lu: %d\n",
			my_rate, err);

and this is still racy and unreliable (who says ten loops is enough?)

You could introduce a per-clock lock around this, but that also gets
messy, and makes the API harder to use (and more error-prone for the
driver author to use.)

What /may/ be a better idea is to pass a function pointer to a new
clk_round_rate() or clk_set_rate() pair of functions - both accept
the same function pointer.  This function pointer points at the
rounding method that is desired, which would be called by the
underlying implementation with the appropriate locks.

Yes, it still doesn't guarantee that this sequence:

	rate = clk_round_new_rate(clk, my_rate, clk_round_nearest);

	clk_set_new_rate(clk, my_rate, clk_round_nearest);

will end up with the same clock, but it will help ensure that there
is a consistent manner in which both of these functions operate, and
that there won't be any doubling up of rounding errors caused by
serially calling clk_round_rate followed by clk_set_rate.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
