From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCHv4 00/15] clk: ti: add support for hwmod clocks
Date: Mon, 12 Dec 2016 20:40:25 -0800
Message-ID: <148160402543.37646.6019420188689675769@resonance>
References: <1476805568-19264-1-git-send-email-t-kristo@ti.com>
 <20161028005341.GR26139@codeaurora.org>
 <2cfa10a9-9ea0-23e4-30de-9aece13e47e3@ti.com>
 <20161028233750.GQ16026@codeaurora.org>
 <7371ef35-5d95-bf78-4c97-c61091a1fa4b@ti.com>
 <148156710975.37646.2957511113527634913@resonance>
 <20161213004914.GM5423@codeaurora.org> <20161213013133.GR4920@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20161213013133.GR4920@atomide.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Quoting Tony Lindgren (2016-12-12 17:31:34)
> * Stephen Boyd <sboyd@codeaurora.org> [161212 16:49]:
> > On 12/12, Michael Turquette wrote:
> > > Quoting Tero Kristo (2016-12-02 00:15:53)
> > > > On 29/10/16 02:37, Stephen Boyd wrote:
> > > > > On 10/28, Tero Kristo wrote:
> > > > >> Eventually that should happen. However, we have plenty of legacy
> > > > >> code still in place which depend on clk_get functionality within
> > > > >> kernel. The major contributing factor is the hwmod codebase, for
> > > > >> which we have plans to:
> > > > >>
> > > > >> - get this clock driver merged
> > > > >> - implement a new interconnect driver for OMAP family SoCs
> > > > >> - interconnect driver will use DT handles for fetching clocks,
> > > > >> rather than clock aliases
> > > > >> - reset handling will be implemented as part of the interconnect
> > > > >> driver somehow (no prototype / clear plans for that as of yet)
> > > > >> - all the hwmod stuff can be dropped
> > > > >>
> > > > >> The clock alias handling is still needed as a transition phase u=
ntil
> > > > >> all the above is done, then we can start dropping them. Basically
> > > > >> anything that is using omap_hwmod depends on the clock aliases r=
ight
> > > > >> now.
> > > > >
> > > > > Ok, sounds good. Thanks.
> > > > =

> > > > Stephen, any final comments on this series? I guess its too late to=
 push =

> > > > for 4.10, but I would like to get this merged early for 4.11 window.
> > > =

> > > Hi Tero,
> > > =

> > > No final comments from me. I needed to go back and forth with Tony ab=
out
> > > the clockdomain modeling, but it seems sensible to create clock
> > > providers from the clock domains if you want to pass those struct clk
> > > objects down to the drivers.
> > > =

> > > One thing I wasn't able to follow exactly in the code is how the
> > > clockdomains are linking parent clocks from cm1, cm2, etc to the clock
> > > domains. Are the clockdomain providers calling clk_get() on the clocks
> > > that it *consumes*, or are the clockdomain providers never calling
> > > clk_get() on those clocks and just establishing the tree hierarchy at
> > > clk_register() time?
> > > =

> > > Unless Stephen has any more review comments we can merge this into a
> > > clk-next based on v4.10-rc1 when that drops.
> > > =

> > =

> > I spent a bunch of time looking at this again today. From a DT
> > perspective we don't want to have clocks or clockdomains nodes
> > below the cm1/cm2/prm dt nodes. That's getting to the point of
> > describing individual elements of a device that should be
> > described in the driver instead of DT.
> =

> I agree we don't need separate clocks and clockdomain nodes.. But
> I think you're missing something here though. The clockdomains in
> this case are separate devices on the interconnect, not individual
> elements within a device. The outputs of a clockdomain are individual
> elements of a clockdomain and can be just described as indexed
> outputs of the clockdomain.

Is the goal to describe this hardware topology in DT? Is that right
thing to do? I think it's cool to have this modeled *somehow* in Linux,
but I'm not sure DT is the right place to model the interconnect and
every device hanging off of it.

I don't want to put words in Stephen's mouth, but I think the issue over
whether clockdomains are CCF clock providers or some genpd thing is
probably less important to him than the fact that the DT bindings are
super detailed to inner workings of the SoC.

Regards,
Mike

> =

> So we just need the clockdomain clock nodes, then each clock output is
> just offset from that clockdomain. And we can have readable defines
> for the offsets. That's all there should be to it.
> =

> > I'd also prefer we didn't have cm1/cm2/prm nodes and just had one
> > prcm node as the clock provider (#clock-cells) because that's the
> > aligned register address space that's visible on the bus.  From
> > my perspective cm1/cm2/prm look like macros that are put inside
> > the prcm container and they're at least aligned on some register
> > address boundary so I'm not too worried if we keep describing
> > down to the level of these modules in DT. Anything beyond that is
> > not good though.
> =

> Having just one prcm node instead of cm1, cm2 and prm is wrong from
> hardware point of view. These are on separate interconnect instances.
> Ideally the clockdomain clock driver works for all these though, just
> separate instances of the same driver.
> =

> > Finally we come to using clock providers or genpds for the clock
> > domains. If we don't put clockdomains into DT (because I don't
> > want clockdomain nodes) then this problem almost goes away. At
> > least, I don't really care what happens here because it will be
> > an internal TI prcm driver question of implementation. A clk
> > consumer will just see a provider that outputs some sort of clk.
> > If that happens to go through a clockdomain and we need to toggle
> > some bits inside the domain registers to make the clk actually
> > output a signal, that's fine. The prcm driver can take care of it
> > behind the scenes. Or at a later date we can model the domain as
> > a genpd and have the framework turn on/off genpds attached to
> > certain clocks. There's a lot of freedom here as long as we don't
> > put things in DT.
> =

> Yeah totally agree. And this problem also goes away when we just
> assume a clockdomain is just a clock device with multiple outputs.
> Any magic that needs to happen beyond that can be dealt with at
> the interconnect level.
> =

> Regards,
> =

> Tony
