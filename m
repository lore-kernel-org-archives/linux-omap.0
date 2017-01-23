From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv2] Documentation: dt-bindings: Add binding documentation
 for TI clkctrl clocks
Date: Mon, 23 Jan 2017 10:38:51 -0800
Message-ID: <20170123183851.GT7403@atomide.com>
References: <20170117225302.10844-1-tony@atomide.com>
 <40b1f6a8-fc5c-b619-9570-bc2f9731af89@ti.com>
 <20170123162828.GR7403@atomide.com>
 <f3c4154d-09d0-3930-4452-1f7d61622f3d@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <f3c4154d-09d0-3930-4452-1f7d61622f3d-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Cc: Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org> [170123 10:30]:
> On 23/01/17 18:28, Tony Lindgren wrote:
> > * Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org> [170123 06:45]:
> > > On 18/01/17 00:53, Tony Lindgren wrote:
> > > > Texas Instruments omap variant SoCs starting with omap4 have a clkctrl
> > > > clock controller instance for each interconnect target module. The clkctrl
> > > > controls functional and interface clocks for the module.
> > > > 
> > > > The clkctrl clocks are currently handled by arch/arm/mach-omap2 hwmod code.
> > > > With this binding and a related clock device driver we can start moving the
> > > > clkctrl clock handling to live in drivers/clk/ti.
> > > > 
> > > > Note that this binding allows keeping the clockdomain related parts out of
> > > > drivers/clock. The CLKCTCTRL and DYNAMICDEP registers can be handled by
> > > > a separate driver in drivers/soc/ti and genpd. If the clockdomain driver
> > > > needs to know it's clocks, we can just set the the clkctrl device
> > > > instances to be children of the related clockdomain device.
> > > > 
> > > > Each clkctrl clock can have multiple optional gate clocks, and multiple
> > > > optional mux clocks. To represent this in device tree, it seems that
> > > > it is best done using four clock cells #clock-cells = <4> property.
> > > > 
> > > > The reasons for using #clock-cells = <4> are:
> > > > 
> > > > 1. We need to specify the clkctrl offset from the instance base. Otherwise
> > > >    we end up with a large number of device tree nodes that need to be
> > > >    patched when new clocks are discovered in a clkctrl clock with minor
> > > >    hardware revision changes for example
> > > > 
> > > > 2. On omap5 CM_L3INIT_USB_HOST_HS_CLKCTRL has ten OPTFCLKEN bits. So we
> > > >    need to use a separate cell for optional gate clocks to avoid address
> > > >    space conflicts
> > > > 
> > > > 3. Some clkctrl instances can also also optional mux clocks. To address
> > > >    them properly we need also a separate cell for the optional mux
> > > >    clock index
> > > > 
> > > > 4. The modulemode clock needs a flag passed to it for hardware or
> > > >    software controlled mode
> > > 
> > > Hi Tony,
> > > 
> > > I think #clock-cells = <4> is too much. I believe we only need 2:
> > > 
> > > - one entry for clkctrl offset
> > > - one entry for clock offset within the clkctrl entry (0 = module clock, 8+
> > > = opt-clocks / mux clocks / dividers)
> > 
> > OK the less #clock-cells the better as long as it's enough :)
> > 
> > > Fields 2 / 3 in your proposal are mutually exclusive, if either field is
> > > non-zero, the other one must be zero. And, the opt clocks / mux / divs
> > > always have different values for these.
> > 
> > OK. Just to confirm the assumptions then:
> > 
> > 1. The optional mux clock the consumer needs to select the right
> >    source clock with with clk_set_parent()
> 
> Yes. And for this you need to fetch a clock handle via some mechanism
> (of_clk_get, clk_get...) Clock consumers can't directly use parent IDs.
> 
> > 
> > 2. The optional divider clock rate must be set by the consumer
> >    using clk_set_rate()
> 
> Yes again.
> 
> > 
> > And in that case we again don't need to define any artificial
> > clock indexes, which is good if new clocks are discovered between
> > various SoC revisions.
> > 
> > > Field 4 is kind of redundant also, as the module clock must be registered at
> > > the clkctrl probe time, it is too late for the clock consumer to provide the
> > > proper setting for the clock during its own probe. It seems I need to add
> > > static data to driver which basically has this information in place already.
> > 
> > OK yeah good point, the "clocks" is a consumer property.
> > 
> > So in that case we must also assume that if any clock consumer needs
> > to change between HWSUP or SWSUP, it needs to be done with some yet
> > to be determined API. We have not needed that so far AFAIK though.
> > 
> > If there are no issues with the above, I'm naturally fine using the
> > #clock-cells = <2> :)
> 
> Yeah, clock-cells = <2>; seems to work just fine in the WIP codebase I have.

OK thanks for confirming, will post v3 of the binding.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
