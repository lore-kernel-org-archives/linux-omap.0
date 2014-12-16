From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: regression: Clock changes in next-20141205 break at least omap4
Date: Tue, 16 Dec 2014 20:57:54 +0000
Message-ID: <20141216205754.GG11502@n2100.arm.linux.org.uk>
References: <20141212194238.20398.33333@quantum>
 <alpine.DEB.2.02.1412122310570.29716@utopia.booyaka.com>
 <20141215220224.20398.98259@quantum>
 <548F7B02.1090009@nvidia.com>
 <20141216003834.GC23854@atomide.com>
 <548F8B70.2060803@nvidia.com>
 <5490816E.7060706@codeaurora.org>
 <54908F8D.2020202@nvidia.com>
 <20141216202301.GF11502@n2100.arm.linux.org.uk>
 <alpine.DEB.2.02.1412162034420.3102@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gw-1.arm.linux.org.uk ([78.32.30.217]:34470 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750910AbaLPU6J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Dec 2014 15:58:09 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1412162034420.3102@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <pwalmsley@nvidia.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Tony Lindgren <tony@atomide.com>, t-kristo@ti.com, Nishanth Menon <nm@ti.com>, khilman@linaro.org, Mike Turquette <mturquette@linaro.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Dec 16, 2014 at 08:45:25PM +0000, Paul Walmsley wrote:
> On Tue, 16 Dec 2014, Russell King - ARM Linux wrote:
> 
> > On Tue, Dec 16, 2014 at 01:01:17PM -0700, Paul Walmsley wrote:
> > > So the reference clock and functional clock are (usually) required by the
> > > PLL to operate, and should therefore be required by the PLL clock driver
> > > code in the kernel; but one could claim that they aren't technically parent
> > > clocks of the PLL in a clock tree sense, since the downstream output clock
> > > isn't directly derived from either of those clocks.
> > 
> > The reference clock is the parent clock for a PLL, and the output clock 
> > is a derivative of the reference clock. The PLL maths show that very 
> > clearly.
> 
> The PLL's internal oscillator is the electrical source of the PLL's output 
> clock.  The reference clock is just used to discipline that internal 
> oscillator.  Even that's not necessary - the reference clock can be 
> optional on some clock source implementations, which can run the internal 
> oscillator in open-loop mode.

I would argue that running a PLL in open-loop mode is an exceptional
circumstance: in such scenarios, many PLLs will head towards a certain
frequency (depending on their design) and some may be rather unstable
in open loop mode.  Only those which have been explicitly designed to
be stable in open loop mode should be run that way.

And arguably, a PLL without a reference clock is not a phase *locked*
loop at all - the clue is in the name.  A PLL without a reference clock
is merely an oscillator.  There is no "phase lock" what so ever.

> The question of what the appropriate "parent" clock(s) should be is really 
> a question of how the software chooses to model it, and has more to do 
> with use-counts, constraints, etc.  I don't believe we have documented a 
> precise definition for what a "parent clock" is, in the Linux clock 
> framework context.

If a PLL is designed to be operated in open loop mode, then the parent
clock should be optional, otherwise the parent clock is rather fundamental
to the PLLs operation, in the same way that the parent clock is
fundamental to a divider's operation.

You can argue that taking away the "reference" clock to a divider gives
a known output (which happens to be 0Hz) but a steady state can still be
a perfectly valid clock signal too if it changes state at some point. :)

In much the same way, some PLLs are designed to disable their output
when they are not in lock.  Much like that divider above with no
reference input.

This really is a question about how you view a PLL, and it's one which
can be debated for a very long time, and everyone will have perfectly
valid but conflicting ideas on it.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
