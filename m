From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/3] ARM: OMAP2+: Add support to parse optional clk
 info from DT
Date: Wed, 14 Aug 2013 15:08:07 +0100
Message-ID: <20130814140807.GE13141@e106331-lin.cambridge.arm.com>
References: <1374560679-14666-1-git-send-email-rnayak@ti.com>
 <1374560679-14666-3-git-send-email-rnayak@ti.com>
 <CAGo_u6rfXpU1Wzn+oXqpAezNNtFb9pk=9RZxodGtBbZXVy+yJA@mail.gmail.com>
 <520B8409.5000708@ti.com>
 <520B88A0.6080806@ti.com>
 <20130814134904.GC13141@e106331-lin.cambridge.arm.com>
 <520B8D01.1040205@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:64329 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759792Ab3HNOIK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Aug 2013 10:08:10 -0400
Content-Disposition: inline
In-Reply-To: <520B8D01.1040205@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <benoit.cousson@gmail.com>, Tero Kristo <t-kristo@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Pawel Moll <Pawel.Moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "tomasz.figa@gmail.com" <tomasz.figa@gmail.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "galak@codeaurora.org" <galak@codeaurora.org>, "mturquette@linaro.org" <mturquette@linaro.org>

On Wed, Aug 14, 2013 at 02:58:25PM +0100, Nishanth Menon wrote:
> On 08/14/2013 08:49 AM, Mark Rutland wrote:
> > [Adding Mike Turquette and dt maintainers]
> >
> > On Wed, Aug 14, 2013 at 02:39:44PM +0100, Nishanth Menon wrote:
> >> On 08/14/2013 08:20 AM, Rajendra Nayak wrote:
> >>> On Wednesday 14 August 2013 06:18 PM, Nishanth Menon wrote:
> >>>> Hi Rajendra,
> >>>>
> >>>> On Tue, Jul 23, 2013 at 1:24 AM, Rajendra Nayak <rnayak@ti.com> wrote:
> >>>> [..]
> >>>>> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> >>>>> index 12fa589..e5c804b 100644
> >>>>> --- a/arch/arm/mach-omap2/omap_hwmod.c
> >>>>> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> >>>>> @@ -805,6 +805,65 @@ static int _init_interface_clks(struct omap_hwmod *oh)
> >>>>>           return ret;
> >>>>>    }
> >>>>>
> >>>>> +static const char **_parse_opt_clks_dt(struct omap_hwmod *oh,
> >>>>> +                                      struct device_node *np,
> >>>>> +                                      int *opt_clks_cnt)
> >>>>> +{
> >>>>> +       int i, clks_cnt;
> >>>>> +       const char *clk_name;
> >>>>> +       const char **opt_clk_names;
> >>>>> +
> >>>>> +       clks_cnt = of_property_count_strings(np, "clock-names");
> >>>>> +       if (!clks_cnt)
> >>>>> +               return NULL;
> >>>>> +
> >>>>> +       opt_clk_names = kzalloc(sizeof(char *)*clks_cnt, GFP_KERNEL);
> >>>>> +       if (!opt_clk_names)
> >>>>> +               return NULL;
> >>>>> +
> >>>>> +       for (i = 0; i < clks_cnt; i++) {
> >>>>> +               of_property_read_string_index(np, "clock-names", i, &clk_name);
> >>>>> +               if (!strcmp(clk_name, "fck"))
> >>>>
> >>>> Could we instead parse for names that are "optional,role_name" instead
> >>>> of assuming anything other than fck is optional clocks?
> >>>
> >>> you mean look for anything with optional,*? because the role names would change.
> >>>
> >>
> >> yes. the idea being, we now have a meaning to the clock name - there are
> >> two types of clocks here.. functional and optional, we *might* have
> >> facility to add interface clock(we dont know interface clock handling
> >> yet, but something in the future).. we might increase the support for
> >> number of functional clocks.. it might help to keep the format such that
> >> it is a "bit extendable".
> >
> > I completely disagree. The only things that should appear in clock-names
> > are the names of the clock inputs that appear in the manual for the
> > device. The driver should know which ones are optional, as that's a
> > fixed property of the IP and the way the driver uses it.
> >
> > You should not be embedding additional semantics in name properties.
> 
> we use an level of abstraction called omap_device and hwmod to allow 
> devices to use a generic pm_runtime. drivers for specific blocks dont 
> normally need to know about the clocks to deal with. This allows maximum 
> reuse consider concept is generic enough.
> 
> The traditional way of dealing with this has been to encode the *names* 
> *inside* hwmod!!! which is obviously the wrong way to deal with with 
> clock nodes in dts.
> 
> This series moves away from that approach - which is good. Now, the 
> question is:
> 
> clocks-names = "....."  is not sufficient to indicate a list of clocks 
> of different functions
> 
> 3 types of clocks may exist for OMAP h/w blocks:
> a) functional clock (1 usually, but we are starting to see multiple 
> fclks). this drives the actual functionality
> b) optional clocks - additional clocks such as debounce clock etc. - 
> there can be n such clocks
> c) interface clocks - this drives the register interface on the bus.  - 
> there can be n such clocks and additional headaches for interface - 
> currently embedded inside hwmod.

I don't see why these can't all be supported without embedding
additional details in the clock-names property. When you say "there can
be n such clocks", do you mean that different devices may have different
numbers of clocks, or that a given device could have an arbitrary set?
Surely the design of the IP imposes a maximum limit on the number of
clocks a device may have?

> 
> you could do:
> A) embedd in the sematics of the name
> clock-names="fck", "optional,role1",  "optional,role2";
> clocks= <&clk_a>, <&clk_x>, <&clk_y>;
> OR:

Does the name of the clock itself not encode this?

Surely "fclk" would be your functional clock, "dbncclk" or similar would
be an (optional) debounce clock, "apbclk" would be an interface clock?
Surely you must know their type by which input they are and how they are
to be used?

>From the sounds of your other reply, the issue is that you're poking
clocks for arbitrary devices, without knowing the semantics of those
clocks, because you're doing it form outside the driver. I don't have a
good solution to this, but your proposed solution is not one I'm happy
with.

> B) embedd in the property name
> optional-clock-names="optional,role1",  "optional,role2";
> optional-clocks=<&clk_x>, <&clk_y>;
> functional-clock-names="fck";
> functional-clocks=<&clk_a>;
> 
> are you suggesting (b) here?

I'm suggesting neither.

Thanks,
Mark.
