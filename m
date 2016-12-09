From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv4 11/15] clk: ti: clockdomain: add clock provider support
 to clockdomains
Date: Fri, 9 Dec 2016 12:40:16 -0800
Message-ID: <20161209204015.GL4920@atomide.com>
References: <20161028125112.xfyrx7l7m64z6cu6@atomide.com>
 <20161028233617.GP16026@codeaurora.org>
 <20161028235448.57squdf6cu2wxxvm@atomide.com>
 <148071802182.32158.11479184984645880313@resonance>
 <20161202231240.GH4705@atomide.com>
 <148072274164.32158.6012452044533845688@resonance>
 <20161203001852.GI4705@atomide.com>
 <ed253013-1f12-9fd8-d007-400a6c6fd427@ti.com>
 <20161205152534.GJ4705@atomide.com>
 <148131376868.16621.16082839810419290638@resonance>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <148131376868.16621.16082839810419290638@resonance>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org> [161209 12:02]:
> Quoting Tony Lindgren (2016-12-05 07:25:34)
> > * Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org> [161205 02:09]:
...
<snip>

> I had a recent conversation with Kevin Hilman about a related issue
> (we were not discussing this thread or this series) and we both agreed
> that most drivers don't even need to managed their clocks directly, so
> much as they need to manage their on/off resources. Clocks are just one
> part of that, and if we can hide that stuff inside of an attached genpd
> then it would be better than having the driver manage clocks explicitly.
> 
> Obviously some devices such as audio codec or uart will need to manage
> clocks directly, but this is mostly the exception, not the rule.

Yes. And we do that already for clkctrl clocks via PM runtime where
hwmod manages them. Tero's series still has hwmod manage the clocks,
but the clock register handling is moved to live under drivers/clock.

> > > > > There is certainly no API for that in the clock framework, but for genpd
> > > > > your runtime_pm_get() callback for clkdm_A could call runtime_pm_get
> > > > > against clkdm_B, which would satisfy the requirement. See section
> > > > > 3.1.1.1.7 Clock Domain Dependency in the OMAP4 TRM, version AB.
> > > 
> > > For static dependencies the apis genpd_add/remove_subdomain could probably
> > > be used.
> > > 
> > > > To me it seems the API is just clk_get() :) Do you have some
> > > > specific example we can use to check? My guess is that the
> > > > TRM "Clock Domain Dependency" is just the usual parent child
> > > > relationship between clocks that are the clockdomains..
> 
> clk_get() only fetches a pointer to the clk. I guess you mean
> clk_prepare_enable() to actually increment the use count?

Right, with clocks that's all we should need to do :)

> If we used the clk framework here is that it would look something like
> this:
> 
> clk_enable(clk_a)
> -> .enable(clk_a_hw)
>    -> clk_enable(clk_b)
> 
> However, clk_a and clk_b do not have a parent-child relationship in the
> clock tree. This is purely a functional relationship between IP blocks.
> Modeling this sort of thing in the clk framework would be wrong, and
> genpd is a much better place to establish these arbitrary relationships.

Hmm yes, and I don't mean the clock framework should do anything more
complex beyond what it already does.

We just want to represent the clocks as clocks, then have the
interconnect code manage those clocks. That's currently hwmod, eventually
it will be genpd.

> > > > If there is something more magical there certainly that should
> > > > be considered though.
> > > 
> > > The hwmods could be transformed to individual genpds also I guess. On DT
> > > level though, we would still need a clock pointer to the main clock and a
> > > genpd pointer in addition to that.
> > 
> > Hmm a genpd pointer to where exactly? AFAIK each interconnect
> > instance should be a genpd provider, and the individual interconnect
> > target modules should be consumers for that genpd.
> 
> I was thinking that the clock domains would be modeled as genpd objects
> with the interconnect target modules attached as struct devices.

I think clock domains should be just clocks, then we let the interconnect
code and eventually genpd manage them.

> > > Tony, any thoughts on that? Would this break up the plans for the
> > > interconnect completely?
> > 
> > Does using genpd for clockdomains cause issues for using genpd for
> > interconnect instances and the target modules?
> 
> Can they be the same object in Linux? If there is a one-to-one mapping
> between clock domains and the interconnect port then maybe you can just
> model them together.

I'm thinking that it should be the interconnect code implementing
genpd, and use clk_request_enable().

> > The thing I'd be worried about there is that the clockdomains and
> > their child clocks are just devices sitting on the interconnect,
> > so we could easily end up with genpd modeling something that does
> > not represent the hardware.
> > 
> > For example, on 4430 we have:
> > 
> > l4_cfg interconnect
> >        ...
> >        segment@0
> >                 ...
> >                 target_module@4000
> >                         cm1: cm1@0
> 
> How about:
> 
> l4_cfg interconnect
>        ...
>        segment@0
>                 ...
>                 cm1@4000
>                 	module: foo_module@0

That's the wrong way around from hardware point of view. There's
a generic interconnect wrapper module with it's own registers,
then cm1 (and possibly other devices) are children of that target
module.

> I don't know much about the segments. Do they map one-to-one with the
> clock domains?

I need to check, it's been a while, but I recall some interconnects
are partioned to segments based on voltages or clocks.

> If my quick-and-dirty DT above makes sense, then the target modules
> (e.g. io controller) would not get clocks anymore, but just
> pm_runtime_get(). The genpd backing object would call clk_enable/disable
> as needed.

Yeah that's what we already have with hwmod and PM runtime for the
clockctrl register. But hwmod currently directly manages the clkctrl
register, we just want to move that part to be a clock driver.

The children of the interconnect target modules just need to use
PM runtime, but the interconnect target module driver needs to know
it's clkctrl clock.

> If fine grained control of a clock is needed (e.g. for clk_set_rate)
> then the driver can still clk_get it. Whether or not the clockdomain
> provides that clock or if it comes from the clock generator (e.g. cm1,
> cm2, prm, etc) isn't as important to me, but I prefer for the
> clockdomain to not be a clock provider if possible.

Yeah I totally agree with that, and that's already what we mostly
have.

> > I don't at least yet
> > follow what we need to do with the clockdomains with genpd :)
> 
> Use the clockdomain genpd to call clk_enable/disable under the hood.
> Don't use them as clock providers to the target modules. Clockdomain
> genpds would be the clock consumers.

I don't think the clockdomain should be a genpd provider because
that creates a genpd network of dependencies instead of a tree
structure. If we end up setting the clockdomains with genpd, then
only the other clockdomains should use them, but I don't know how
we ever keep drivers from directly tinkering with them..

IMO, the clockdomain clock driver should just provides clocks, then
we can have the interconnect target module driver deal with the
clockdomain dependencies.

> > Wouldn't just doing clk_get() from one clockdomain clock to
> > another clockdomain clock (or it's output) be enough to
> > represent the clockdomain dependencies?
> 
> s/clk_get/clk_prepare_enable/
> 
> Yes, but you're stuffing functional dependencies into the clock tree,
> which sucks. genpd was created to model these arbitrary dependencies.

Well let's not stuff anything beyond clock framework to the
clockdomain clock drivers. We already have the clockdomain
dependencies handled by the interconnect code (hwmod), and there
should be no problem moving those to be handled by genpd and the
interconnect target driver instances.

Care to take another look at Tero's patches with the assumption
that the clockdomain clocks stay just as a clocks?

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
