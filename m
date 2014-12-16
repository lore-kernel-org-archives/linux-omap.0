From: Paul Walmsley <pwalmsley@nvidia.com>
Subject: Re: regression: Clock changes in next-20141205 break at least
 omap4
Date: Tue, 16 Dec 2014 22:25:18 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1412162159270.3102@utopia.booyaka.com>
References: <20141212194238.20398.33333@quantum> <alpine.DEB.2.02.1412122310570.29716@utopia.booyaka.com> <20141215220224.20398.98259@quantum> <548F7B02.1090009@nvidia.com> <20141216003834.GC23854@atomide.com> <548F8B70.2060803@nvidia.com>
 <5490816E.7060706@codeaurora.org> <54908F8D.2020202@nvidia.com> <20141216202301.GF11502@n2100.arm.linux.org.uk> <alpine.DEB.2.02.1412162034420.3102@utopia.booyaka.com> <20141216205754.GG11502@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:34804 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbaLPWZU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Dec 2014 17:25:20 -0500
In-Reply-To: <20141216205754.GG11502@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: paul@pwsan.com, Stephen Boyd <sboyd@codeaurora.org>, Tony Lindgren <tony@atomide.com>, t-kristo@ti.com, Nishanth Menon <nm@ti.com>, khilman@linaro.org, Mike Turquette <mturquette@linaro.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

+ paul@pwsan.com (I prefer not having to deal with MS Exchange when 
possible :-) )

On Tue, 16 Dec 2014, Russell King - ARM Linux wrote:

> On Tue, Dec 16, 2014 at 08:45:25PM +0000, Paul Walmsley wrote:
> > On Tue, 16 Dec 2014, Russell King - ARM Linux wrote:
> > 
> > > On Tue, Dec 16, 2014 at 01:01:17PM -0700, Paul Walmsley wrote:
> > > > So the reference clock and functional clock are (usually) required by the
> > > > PLL to operate, and should therefore be required by the PLL clock driver
> > > > code in the kernel; but one could claim that they aren't technically parent
> > > > clocks of the PLL in a clock tree sense, since the downstream output clock
> > > > isn't directly derived from either of those clocks.
> > > 
> > > The reference clock is the parent clock for a PLL, and the output clock 
> > > is a derivative of the reference clock. The PLL maths show that very 
> > > clearly.
> > 
> > The PLL's internal oscillator is the electrical source of the PLL's output 
> > clock.  The reference clock is just used to discipline that internal 
> > oscillator.  Even that's not necessary - the reference clock can be 
> > optional on some clock source implementations, which can run the internal 
> > oscillator in open-loop mode.
> 
> I would argue that running a PLL in open-loop mode is an exceptional
> circumstance: in such scenarios, many PLLs will head towards a certain
> frequency (depending on their design) and some may be rather unstable
> in open loop mode.  Only those which have been explicitly designed to
> be stable in open loop mode should be run that way.
> 
> And arguably, a PLL without a reference clock is not a phase *locked*
> loop at all - the clue is in the name.  A PLL without a reference clock
> is merely an oscillator.  There is no "phase lock" what so ever.

...

> This really is a question about how you view a PLL, and it's one which
> can be debated for a very long time, and everyone will have perfectly
> valid but conflicting ideas on it.

Yep, I agree with most of what you wrote.  I was mostly thinking about our 
Linux data structures and software abstraction for clocks that have 
multiple input clocks that all need to be simultaneously active for the IP 
block to work.  PLLs and PLL-like clock sources which take multiple input 
clocks just happened to be the examples of this phenomenon that came to 
mind.

Those multiple input clocks could all be considered "parents" from a 
use-counting point of view, and we could expect the core clock code to 
deal with them.  Or one could take the electrical point of view and 
consider only one of the input clocks to be the "parent" -- whatever's 
directly driving the output clock -- and fix up the gating and constraint 
details in the driver code for that clock source.

I don't think this pot is boiling over at the moment; but, just something 
for us to reflect on.


- Paul
