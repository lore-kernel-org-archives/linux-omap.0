From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCHv4 11/15] clk: ti: clockdomain: add clock provider support
 to clockdomains
Date: Fri, 09 Dec 2016 13:28:45 -0800
Message-ID: <148131892585.16621.5033331614135070003@resonance>
References: <20161028125112.xfyrx7l7m64z6cu6@atomide.com>
 <20161028235448.57squdf6cu2wxxvm@atomide.com>
 <148071802182.32158.11479184984645880313@resonance>
 <20161202231240.GH4705@atomide.com>
 <148072274164.32158.6012452044533845688@resonance>
 <20161203001852.GI4705@atomide.com>
 <ed253013-1f12-9fd8-d007-400a6c6fd427@ti.com>
 <20161205152534.GJ4705@atomide.com>
 <148131376868.16621.16082839810419290638@resonance>
 <20161209204015.GL4920@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161209204015.GL4920@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Quoting Tony Lindgren (2016-12-09 12:40:16)
> * Michael Turquette <mturquette@baylibre.com> [161209 12:02]:
> > Quoting Tony Lindgren (2016-12-05 07:25:34)
> > > * Tero Kristo <t-kristo@ti.com> [161205 02:09]:
> ...
> <snip>
> 
> > I had a recent conversation with Kevin Hilman about a related issue
> > (we were not discussing this thread or this series) and we both agreed
> > that most drivers don't even need to managed their clocks directly, so
> > much as they need to manage their on/off resources. Clocks are just one
> > part of that, and if we can hide that stuff inside of an attached genpd
> > then it would be better than having the driver manage clocks explicitly.
> > 
> > Obviously some devices such as audio codec or uart will need to manage
> > clocks directly, but this is mostly the exception, not the rule.
> 
> Yes. And we do that already for clkctrl clocks via PM runtime where
> hwmod manages them. Tero's series still has hwmod manage the clocks,
> but the clock register handling is moved to live under drivers/clock.
> 
> > > > > > There is certainly no API for that in the clock framework, but for genpd
> > > > > > your runtime_pm_get() callback for clkdm_A could call runtime_pm_get
> > > > > > against clkdm_B, which would satisfy the requirement. See section
> > > > > > 3.1.1.1.7 Clock Domain Dependency in the OMAP4 TRM, version AB.
> > > > 
> > > > For static dependencies the apis genpd_add/remove_subdomain could probably
> > > > be used.
> > > > 
> > > > > To me it seems the API is just clk_get() :) Do you have some
> > > > > specific example we can use to check? My guess is that the
> > > > > TRM "Clock Domain Dependency" is just the usual parent child
> > > > > relationship between clocks that are the clockdomains..
> > 
> > clk_get() only fetches a pointer to the clk. I guess you mean
> > clk_prepare_enable() to actually increment the use count?
> 
> Right, with clocks that's all we should need to do :)
> 
> > If we used the clk framework here is that it would look something like
> > this:
> > 
> > clk_enable(clk_a)
> > -> .enable(clk_a_hw)
> >    -> clk_enable(clk_b)
> > 
> > However, clk_a and clk_b do not have a parent-child relationship in the
> > clock tree. This is purely a functional relationship between IP blocks.
> > Modeling this sort of thing in the clk framework would be wrong, and
> > genpd is a much better place to establish these arbitrary relationships.
> 
> Hmm yes, and I don't mean the clock framework should do anything more
> complex beyond what it already does.
> 
> We just want to represent the clocks as clocks, then have the
> interconnect code manage those clocks. That's currently hwmod, eventually
> it will be genpd.
> 
> > > > > If there is something more magical there certainly that should
> > > > > be considered though.
> > > > 
> > > > The hwmods could be transformed to individual genpds also I guess. On DT
> > > > level though, we would still need a clock pointer to the main clock and a
> > > > genpd pointer in addition to that.
> > > 
> > > Hmm a genpd pointer to where exactly? AFAIK each interconnect
> > > instance should be a genpd provider, and the individual interconnect
> > > target modules should be consumers for that genpd.
> > 
> > I was thinking that the clock domains would be modeled as genpd objects
> > with the interconnect target modules attached as struct devices.
> 
> I think clock domains should be just clocks, then we let the interconnect
> code and eventually genpd manage them.
> 
> > > > Tony, any thoughts on that? Would this break up the plans for the
> > > > interconnect completely?
> > > 
> > > Does using genpd for clockdomains cause issues for using genpd for
> > > interconnect instances and the target modules?
> > 
> > Can they be the same object in Linux? If there is a one-to-one mapping
> > between clock domains and the interconnect port then maybe you can just
> > model them together.
> 
> I'm thinking that it should be the interconnect code implementing
> genpd, and use clk_request_enable().
> 
> > > The thing I'd be worried about there is that the clockdomains and
> > > their child clocks are just devices sitting on the interconnect,
> > > so we could easily end up with genpd modeling something that does
> > > not represent the hardware.
> > > 
> > > For example, on 4430 we have:
> > > 
> > > l4_cfg interconnect
> > >        ...
> > >        segment@0
> > >                 ...
> > >                 target_module@4000
> > >                         cm1: cm1@0
> > 
> > How about:
> > 
> > l4_cfg interconnect
> >        ...
> >        segment@0
> >                 ...
> >                 cm1@4000
> >                       module: foo_module@0
> 
> That's the wrong way around from hardware point of view. There's
> a generic interconnect wrapper module with it's own registers,
> then cm1 (and possibly other devices) are children of that target
> module.
> 
> > I don't know much about the segments. Do they map one-to-one with the
> > clock domains?
> 
> I need to check, it's been a while, but I recall some interconnects
> are partioned to segments based on voltages or clocks.
> 
> > If my quick-and-dirty DT above makes sense, then the target modules
> > (e.g. io controller) would not get clocks anymore, but just
> > pm_runtime_get(). The genpd backing object would call clk_enable/disable
> > as needed.
> 
> Yeah that's what we already have with hwmod and PM runtime for the
> clockctrl register. But hwmod currently directly manages the clkctrl
> register, we just want to move that part to be a clock driver.
> 
> The children of the interconnect target modules just need to use
> PM runtime, but the interconnect target module driver needs to know
> it's clkctrl clock.

OK, that sounds good to me but I'm not quite sure about the difference
between "children of interconnect target modules" versus just the
"interconnect target module".

Can you give an example on each? I just want to understand for my own
curiosity.

> 
> > If fine grained control of a clock is needed (e.g. for clk_set_rate)
> > then the driver can still clk_get it. Whether or not the clockdomain
> > provides that clock or if it comes from the clock generator (e.g. cm1,
> > cm2, prm, etc) isn't as important to me, but I prefer for the
> > clockdomain to not be a clock provider if possible.
> 
> Yeah I totally agree with that, and that's already what we mostly
> have.
> 
> > > I don't at least yet
> > > follow what we need to do with the clockdomains with genpd :)
> > 
> > Use the clockdomain genpd to call clk_enable/disable under the hood.
> > Don't use them as clock providers to the target modules. Clockdomain
> > genpds would be the clock consumers.
> 
> I don't think the clockdomain should be a genpd provider because
> that creates a genpd network of dependencies instead of a tree
> structure. If we end up setting the clockdomains with genpd, then
> only the other clockdomains should use them, but I don't know how
> we ever keep drivers from directly tinkering with them..

Genpd is set up as an arbitrary graph, not strictly a tree, so these
types of dependencies should be OK.

> 
> IMO, the clockdomain clock driver should just provides clocks, then
> we can have the interconnect target module driver deal with the
> clockdomain dependencies.
> 
> > > Wouldn't just doing clk_get() from one clockdomain clock to
> > > another clockdomain clock (or it's output) be enough to
> > > represent the clockdomain dependencies?
> > 
> > s/clk_get/clk_prepare_enable/
> > 
> > Yes, but you're stuffing functional dependencies into the clock tree,
> > which sucks. genpd was created to model these arbitrary dependencies.
> 
> Well let's not stuff anything beyond clock framework to the
> clockdomain clock drivers. We already have the clockdomain
> dependencies handled by the interconnect code (hwmod), and there
> should be no problem moving those to be handled by genpd and the
> interconnect target driver instances.
> 
> Care to take another look at Tero's patches with the assumption
> that the clockdomain clocks stay just as a clocks?

Sure.

Regards,
Mike

> 
> Regards,
> 
> Tony
