From: Paul Walmsley <paul@pwsan.com>
Subject: Re: regression: Clock changes in next-20141205 break at least
 omap4
Date: Thu, 18 Dec 2014 19:23:07 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1412181717450.3102@utopia.booyaka.com>
References: <20141212194238.20398.33333@quantum>  <alpine.DEB.2.02.1412122310570.29716@utopia.booyaka.com>  <20141215220224.20398.98259@quantum> <548F7B02.1090009@nvidia.com>  <20141216003834.GC23854@atomide.com> <548F8B70.2060803@nvidia.com>
 <5490816E.7060706@codeaurora.org> <54908F8D.2020202@nvidia.com>  <20141216202301.GF11502@n2100.arm.linux.org.uk>  <alpine.DEB.2.02.1412162034420.3102@utopia.booyaka.com>  <20141216205754.GG11502@n2100.arm.linux.org.uk>  <alpine.DEB.2.02.1412162159270.3102@utopia.booyaka.com>
 <1418809957.3347.1.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:54758 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbaLRTXI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Dec 2014 14:23:08 -0500
In-Reply-To: <1418809957.3347.1.camel@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Paul Walmsley <pwalmsley@nvidia.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Nishanth Menon <nm@ti.com>, khilman@linaro.org, Mike Turquette <mturquette@linaro.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tony Lindgren <tony@atomide.com>, Stephen Boyd <sboyd@codeaurora.org>, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, 17 Dec 2014, Lucas Stach wrote:

> Maybe I'm thinking about this too lightly, but I think we already have
> the right abstractions in place.
> 
> The clock tree in Linux is always modeled along the flow of reference
> clocks. So typically the root of the tree is something like an
> oscillator and everything spreads out from this in a parent/child
> relation. So clearly the reference clock of a PLL is the PLLs parent. If
> the PLL is running in open-loop mode (isn't this rather direct frequency
> synthesis?) is has no parent and is the root of a tree itself.
> 
> If a PLL needs a functional clock to drive some internal logic, that
> doesn't directly influence the clock synthesis from reference to
> resulting clock, that clock would be no parent to the PLL. The PLL is
> merely a consumer of this clock just like every other device in the
> system.

I suspect we're using different terminology.

>From my point of view, a reference clock is an input clock signal that is 
used by another clock generator IP block or clock measurement IP block.  
The use is to measure and (optionally) discipline another oscillator.  
Thus the clock generator/measurement IP block generally does not 
electrically propagate the reference clock outside of the block.  
(Although some of the reference clock's characteristics, like phase noise 
or frequency stability, may be propagated indirectly.)  Only a small 
number of clock tree entities makes use of reference clocks.  

By contrast, we could use the term "source clock" in the SoC context to 
mean a clock signal that directly drives a downstream IP block, in an 
electrical sense.  These clocks are directly propagated through dividers 
and muxes.

If you're willing to play along with this terminology, then a PLL's 
"source clock" would be its internal VCO/DCO, which thus would be the root 
clock of the PLL.

Flipping over from hardware to software, in the Linux clock tree, there's 
usually not much point to modeling the VCO/DCO directly because it tends 
not to be under the direct control of the OS, and it is usually tightly 
integrated into the PLLs from a hardware point of view.  But unlike most 
of the Linux clock tree nodes that are downstream from clock sources, 
which use clocks that are electrically driven by the clock source, the 
clock signal that PLLs and PLL-like clocks generate is not directly driven 
by the reference clock.

So why is a reference clock listed as a Linux parent clock of an OMAP PLL?  
At least for OMAP, it was sort of shoehorned in to represent a gating 
dependency.  It was a way of stating that the reference clock had to be 
enabled for the PLL to generate an output clock.  (The off-chip crystal 
oscillator that drives most of the PLL reference clocks could be disabled 
when all of its users were idle, to save energy.)  But this type of gating 
dependency is equally true for, say, a separate functional clock that the 
clock source requires in order to operate.  (OMAP PLLs didn't have a 
separate functional clock, at least not that I was aware of; but that's 
not true for some similar clock sources used in other SoCs.)

The clock framework wasn't re-entrant back then, and we wanted to avoid 
implementing re-entrancy because we were worried that it could turn into a 
mess.  So we just wound up listing the reference clock as the PLL's Linux 
parent clock.

My original comment was just intended to be a reflection on what it means 
to be a "parent clock" in the Linux clock tree sense.  If it's intended to 
represent "source clocks" as they are defined above, then PLLs and 
PLL-like clocks should be root nodes, except for the few cases where it's 
useful to add a node for the underlying source oscillator directly (for 
example, if open-loop mode is supported).

This might be the right way forward for the time being, and I like the 
idea of stating that Linux parent clocks should represent electrical 
"source clock" relationships.  

That raises the question of what to do about the additional gating 
relationships.  At the moment, the clock type code needs to be responsible 
for calling clk_enable() etc. on all of the reference and functional 
clocks that need to be ungated for the clock source to work.  But it has 
always seemed preferable to me to represent fundamental hardware 
structural constraints in data.  If the data structures are well-defined, 
then the data should be relatively easy to analyze, reason about, 
generate, validate, share across platforms, and operate upon iteratively; 
unlike custom per-clocktype code, which often isn't.


- Paul
