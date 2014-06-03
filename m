From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/3] clk: ti: add 'ti,round-rate' flag
Date: Tue, 3 Jun 2014 19:35:38 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1406031907210.14238@utopia.booyaka.com>
References: <1399540009-6953-1-git-send-email-tomi.valkeinen@ti.com> <5370B839.3050108@ti.com> <5370BAFF.9070501@ti.com> <20140515060834.3084.5199@quantum> <5374B241.9010201@ti.com> <20140531000207.10062.55946@quantum>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:43373 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541AbaFCTfj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Jun 2014 15:35:39 -0400
In-Reply-To: <20140531000207.10062.55946@quantum>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, linux-arm-kernel@lists.infradead.org

On Fri, 30 May 2014, Mike Turquette wrote:

> Quoting Tomi Valkeinen (2014-05-15 05:25:37)
> > On 15/05/14 09:08, Mike Turquette wrote:
> > > Quoting Tomi Valkeinen (2014-05-12 05:13:51)
> > >> On 12/05/14 15:02, Tero Kristo wrote:
> > >>> On 05/08/2014 12:06 PM, Tomi Valkeinen wrote:
> > >>>> The current DPLL code does not try to round the clock rate, and instead
> > >>>> returns an error if the requested clock rate cannot be produced exactly
> > >>>> by the DPLL.
> > >>>>
> > >>>> It could be argued that this is a bug, but as the current drivers may
> > >>>> depend on that behavior, a new flag 'ti,round-rate' is added which
> > >>>> enables clock rate rounding.
> > >>>
> > >>> Someone could probably argue that this flag is not a hardware feature,
> > >>
> > >> I fully agree.
> > >>
> > >>> but instead is used to describe linux-kernel behavior, and would
> > >>> probably be frowned upon by the DT enthusiasts. Othen than that, I like
> > >>> this approach better than a global setting, but would like second
> > >>> opinions here.
> > >>
> > >> I think the dpll code should always do rounding. That's what
> > >> round_rate() is supposed to do, afaik. The current behavior of not
> > >> rounding and returning an error is a bug in my opinion.
> > > 
> > > From include/linux/clk.h:
> > > 
> > > /**
> > >  * clk_round_rate - adjust a rate to the exact rate a clock can provide
> > >  * @clk: clock source
> > >  * @rate: desired clock rate in Hz
> > >  *
> > >  * Returns rounded clock rate in Hz, or negative errno.
> > >  */
> > > long clk_round_rate(struct clk *clk, unsigned long rate);
> > > 
> > > Definitely not rounding the rate is a bug, with respect to the API
> > > definition. Has anyone tried making the new flag as the default behavior
> > > and seeing if anything breaks?
> > 
> > The v1 of the patch fixed the rounding unconditionally:
> > 
> > http://article.gmane.org/gmane.linux.ports.arm.kernel/295077
> > 
> > Paul wanted it optional so that existing drivers would not break. No one
> > knows if there is such a driver, or what would the driver's code look
> > like that would cause an issue.
> > 
> > And, as I've pointed out in the above thread, as clk-divider driver
> > doesn't an error code from the dpll driver, my opinion is that such
> > drivers would not work even now.
> > 
> > I like v1 more.
> > 
> > In any case, I hope we'd get something merged ASAP so that we fix the
> > display AM3xxx boards and we'd still have time to possibly find out if
> > some other driver breaks.
> 
> Resurrecting this thread. Can we reach a consensus? I prefer V1 as well
> for the reasons stated above, and also since ti,round-rate isn't really
> describing the hardware at all in DT.

What's really needed is better control over rounding in the clock code.  
Both the driver API should be improved; and, to the extent that clock 
sources share the same underlying code implementation, probably some clock 
source configuration data enhancement is needed (DT or whatever).

Furthermore, clk_set_rate() should never silently round a requested rate - 
it should just return an error if it can't satisfy the requested rate 
precisely.  Silently rounding a rate is racy, and, if we care about 
drivers behaving consistently across different integration environments, 
prone to behavior that the driver may not expect.

Frankly, a DT "ti,round-rate" property is risible.  I certainly understand 
why you don't like it and I don't know why that specific property was 
proposed.  The issue has never been whether clk_round_rate() should round 
rates.  Of course it should.  The more pertinent question is, *how* should 
it round the rate?  A more reasonable DT property approach would be to 
specify how the clock's rate should be rounded: to the closest rate, to 
the closest rate equal to or less than the desired rate, to the closest 
rate greater than or equal to the desired rate; what the tolerance of the 
"closest rate" should be, etc.  But drivers, e.g. many drivers that 
control external I/O, should always be able to state that they want an 
exact rate.

...

In terms of the short-term thing to do, I'm currently thinking that the 
thing to do is to modify the PLL set_rate() code in mach-omap2/ to not 
round the rate at all, and then switch the PLL rate rounding code to 
equal-or-closest-lesser-rate, with something like the oldhardcoded rate 
tolerances.  That should push the responsibility out to the drivers to 
control how they want the rounding to happen.  Then the drivers should be 
able to probe available rates with repeated calls to clk_round_rate() if 
they want, and if people get unhappy with that, then it might drive 
rounding improvements in the clock API.

But all this won't happen in -rc8; this is 3.16 material..


> We can always see how it goes and fix it up afterwards when everything 
> explodes.

No thanks... that's what leads to these kinds of messes :-( 


- Paul
