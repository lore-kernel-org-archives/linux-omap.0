From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv4 11/15] clk: ti: clockdomain: add clock provider support
 to clockdomains
Date: Fri, 9 Dec 2016 13:58:55 -0800
Message-ID: <20161209215854.GM4920@atomide.com>
References: <20161028235448.57squdf6cu2wxxvm@atomide.com>
 <148071802182.32158.11479184984645880313@resonance>
 <20161202231240.GH4705@atomide.com>
 <148072274164.32158.6012452044533845688@resonance>
 <20161203001852.GI4705@atomide.com>
 <ed253013-1f12-9fd8-d007-400a6c6fd427@ti.com>
 <20161205152534.GJ4705@atomide.com>
 <148131376868.16621.16082839810419290638@resonance>
 <20161209204015.GL4920@atomide.com>
 <148131892585.16621.5033331614135070003@resonance>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <148131892585.16621.5033331614135070003@resonance>
Sender: linux-clk-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: Tero Kristo <t-kristo@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Michael Turquette <mturquette@baylibre.com> [161209 13:28]:
> Quoting Tony Lindgren (2016-12-09 12:40:16)
> > Yeah that's what we already have with hwmod and PM runtime for the
> > clockctrl register. But hwmod currently directly manages the clkctrl
> > register, we just want to move that part to be a clock driver.
> > 
> > The children of the interconnect target modules just need to use
> > PM runtime, but the interconnect target module driver needs to know
> > it's clkctrl clock.
> 
> OK, that sounds good to me but I'm not quite sure about the difference
> between "children of interconnect target modules" versus just the
> "interconnect target module".

The interconnect target module specific registers are "sysc", "syss"
and "revision". Those are usually stuffed to random addresses, and
currently managed by hwmod. Each interconnect target module has a
module gate clock "clkctrl" in some clockdomain. Each clockdomain
has multiple similar "clckctrl" clocks.

> Can you give an example on each? I just want to understand for my own
> curiosity.

For example, musb on am335x has these as children of a single
interconnect target module:

- Two instances of musb wrapper IP
- Two instances of musb IP
- One instance of CPP41 DMA

The on omap4, the whole system control module is just a single
interconnect target module with tens of devices in it like padconf,
clocks, pbias regulator and whatever random devices.

> > I don't think the clockdomain should be a genpd provider because
> > that creates a genpd network of dependencies instead of a tree
> > structure. If we end up setting the clockdomains with genpd, then
> > only the other clockdomains should use them, but I don't know how
> > we ever keep drivers from directly tinkering with them..
> 
> Genpd is set up as an arbitrary graph, not strictly a tree, so these
> types of dependencies should be OK.

Well maybe that works then, worth checking for sure.

Regards,

Tony
