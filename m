From: Lucas Stach <l.stach@pengutronix.de>
Subject: Re: regression: Clock changes in next-20141205 break at least omap4
Date: Wed, 17 Dec 2014 10:52:37 +0100
Message-ID: <1418809957.3347.1.camel@pengutronix.de>
References: <20141212194238.20398.33333@quantum>
	 <alpine.DEB.2.02.1412122310570.29716@utopia.booyaka.com>
	 <20141215220224.20398.98259@quantum> <548F7B02.1090009@nvidia.com>
	 <20141216003834.GC23854@atomide.com> <548F8B70.2060803@nvidia.com>
	 <5490816E.7060706@codeaurora.org> <54908F8D.2020202@nvidia.com>
	 <20141216202301.GF11502@n2100.arm.linux.org.uk>
	 <alpine.DEB.2.02.1412162034420.3102@utopia.booyaka.com>
	 <20141216205754.GG11502@n2100.arm.linux.org.uk>
	 <alpine.DEB.2.02.1412162159270.3102@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52851 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274AbaLQJxD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Dec 2014 04:53:03 -0500
In-Reply-To: <alpine.DEB.2.02.1412162159270.3102@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <pwalmsley@nvidia.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Nishanth Menon <nm@ti.com>, paul@pwsan.com, khilman@linaro.org, Mike Turquette <mturquette@linaro.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tony Lindgren <tony@atomide.com>, Stephen Boyd <sboyd@codeaurora.org>, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Am Dienstag, den 16.12.2014, 22:25 +0000 schrieb Paul Walmsley:
> + paul@pwsan.com (I prefer not having to deal with MS Exchange when 
> possible :-) )
> 
> On Tue, 16 Dec 2014, Russell King - ARM Linux wrote:
> 
> > On Tue, Dec 16, 2014 at 08:45:25PM +0000, Paul Walmsley wrote:
> > > On Tue, 16 Dec 2014, Russell King - ARM Linux wrote:
> > > 
> > > > On Tue, Dec 16, 2014 at 01:01:17PM -0700, Paul Walmsley wrote:
> > > > > So the reference clock and functional clock are (usually) required by the
> > > > > PLL to operate, and should therefore be required by the PLL clock driver
> > > > > code in the kernel; but one could claim that they aren't technically parent
> > > > > clocks of the PLL in a clock tree sense, since the downstream output clock
> > > > > isn't directly derived from either of those clocks.
> > > > 
> > > > The reference clock is the parent clock for a PLL, and the output clock 
> > > > is a derivative of the reference clock. The PLL maths show that very 
> > > > clearly.
> > > 
> > > The PLL's internal oscillator is the electrical source of the PLL's output 
> > > clock.  The reference clock is just used to discipline that internal 
> > > oscillator.  Even that's not necessary - the reference clock can be 
> > > optional on some clock source implementations, which can run the internal 
> > > oscillator in open-loop mode.
> > 
> > I would argue that running a PLL in open-loop mode is an exceptional
> > circumstance: in such scenarios, many PLLs will head towards a certain
> > frequency (depending on their design) and some may be rather unstable
> > in open loop mode.  Only those which have been explicitly designed to
> > be stable in open loop mode should be run that way.
> > 
> > And arguably, a PLL without a reference clock is not a phase *locked*
> > loop at all - the clue is in the name.  A PLL without a reference clock
> > is merely an oscillator.  There is no "phase lock" what so ever.
> 
> ...
> 
> > This really is a question about how you view a PLL, and it's one which
> > can be debated for a very long time, and everyone will have perfectly
> > valid but conflicting ideas on it.
> 
> Yep, I agree with most of what you wrote.  I was mostly thinking about our 
> Linux data structures and software abstraction for clocks that have 
> multiple input clocks that all need to be simultaneously active for the IP 
> block to work.  PLLs and PLL-like clock sources which take multiple input 
> clocks just happened to be the examples of this phenomenon that came to 
> mind.
> 
> Those multiple input clocks could all be considered "parents" from a 
> use-counting point of view, and we could expect the core clock code to 
> deal with them.  Or one could take the electrical point of view and 
> consider only one of the input clocks to be the "parent" -- whatever's 
> directly driving the output clock -- and fix up the gating and constraint 
> details in the driver code for that clock source.
> 
> I don't think this pot is boiling over at the moment; but, just something 
> for us to reflect on.
> 
Maybe I'm thinking about this too lightly, but I think we already have
the right abstractions in place.

The clock tree in Linux is always modeled along the flow of reference
clocks. So typically the root of the tree is something like an
oscillator and everything spreads out from this in a parent/child
relation. So clearly the reference clock of a PLL is the PLLs parent. If
the PLL is running in open-loop mode (isn't this rather direct frequency
synthesis?) is has no parent and is the root of a tree itself.

If a PLL needs a functional clock to drive some internal logic, that
doesn't directly influence the clock synthesis from reference to
resulting clock, that clock would be no parent to the PLL. The PLL is
merely a consumer of this clock just like every other device in the
system.

Regards,
Lucas
-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

