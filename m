From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] Documentation: dt-bindings: Add binding documentation
 for TI clkctrl clocks
Date: Fri, 13 Jan 2017 09:13:40 -0800
Message-ID: <20170113171340.GY2630@atomide.com>
References: <20170109234226.9449-1-tony@atomide.com>
 <20170110154400.GT2630@atomide.com>
 <20170113163647.6xbhoafb5xddtvnz@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170113163647.6xbhoafb5xddtvnz@rob-hp-laptop>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [170113 08:37]:
> On Tue, Jan 10, 2017 at 07:44:01AM -0800, Tony Lindgren wrote:
> > * Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [170109 15:43]:
> > > Texas Instruments omap variant SoCs starting with omap4 have a clkctrl
> > > clock controller instance for each interconnect target module. The clkctrl
> > > controls functional and interface clocks for the module.
> > > 
> > > The clkctrl clocks are currently handled by arch/arm/mach-omap2 hwmod code.
> > > With this binding and a related clock device driver we can start moving the
> > > clkctrl clock handling to live in drivers/clk/ti.
> > > 
> > > For hardware reference, see omap4430 TRM "Table 3-1312. L4PER_CM2 Registers
> > > Mapping Summary" for example. It show one instance of a clkctrl clock
> > > controller with multiple clkctrl registers.
> > > 
> > > Note that this binding allows keeping the clockdomain related parts out of
> > > drivers/clock. The CLKCTCTRL and DYNAMICDEP registers can be handled by
> > > using a separate driver in drivers/soc/ti and genpd. If the clockdomain
> > > driver needs to know it's clocks, we can just set the the clkctrl device
> > > instances to be children of the related clockdomain device.
> > > 
> > > On omap4 CM_L3INIT_USB_HOST_HS_CLKCTRL on omap5 has eight OPTFCLKEN bits.
> > > So we need to shift the clock index to avoid index conflict for the clock
> > > consumer binding with the next clkctrl offset on omap4.
> > > 
> > > Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
> > > Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > > Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> > > ---
> > > 
> > > So here's what I was able to come up for the clkctr binding based on
> > > all we've discussed so far. Can you guys please take a look and see
> > > if it looks OK to you before we do the device driver?
> > > 
> > > Also, does anybody have better suggestions for addressing the optional
> > > clocks in each clkctrl register?
> > 
> > The other option that might be worth considering is to make use of the
> > #clock-cells property. Then the index of any optional clock could be passed
> > in the second cell.
> > 
> > The third cell could be used to set the modulemode for the clock (software
> > controlled or hardware controlled) instead of using a custom property
> > at the clock controllel level.
> 
> I guess I prefer this way. Or you could do a mixture of both proposals 
> with 2 cells. The first being the clock id and the 2nd flags. 

OK. I don't think we can do it with two cells with using real hardware
offsets for the clocks though. So in that case I'd prefer the three
cell binding as below.

> What's the max optional clocks in theory? B picked from the current 
> worst case seems a bit worrying. Why not 16? Upper half is offset, lower 
> half is index. 

It seems the max is "stuff it into whatever bits are available" in the
register :)  And I just noticed omap5 CM_L3INIT_USB_HOST_HS_CLKCTRL has 10
optional clocks, not 8. So yeah let's assume it could be even more.

> > In that case clock consume usage would look like the following using
> > #clock-cells = <3>:
> > 
> > #define OMAP4_CLKCTRL_OFFSET		0x20
> > #define MODULEMODE_HWCTRL		1
> > #define MODULEMODE_SWCTRL		2
> 
> Can you make one of these 0 instead or is both being set valid?

For MODULEMODE clock 0 means disabed. HWCTRL and SWCTRL are flags for
enabled mode.

So clock index 0 would be the MODULEMODE clock, index 1 first optional clock
and so on. The index could be also be the offset in the actual register
if you prefer that.

> > #define OMAP_CLKCTRL_INDEX(offset)	((offset) - OMAP4_CLKCTRL_OFFSET)
> > 
> > #define OMAP4_GPTIMER10_CLKTRL		OMAP_CLKCTRL_INDEX(0x28)
> > #define OMAP4_GPTIMER11_CLKTRL		OMAP_CLKCTRL_INDEX(0x30)
> > #define OMAP4_GPTIMER2_CLKTRL		OMAP_CLKCTRL_INDEX(0x38)
> > ...
> > #define OMAP4_GPIO2_CLKCTRL		OMAP_CLKCTRL_INDEX(0x60)
> > ...
> > 
> > &gpio2 {
> > 	clocks = <&cm_l4per_clkctrl OMAP4_GPIO2_CLKCTRL 0 MODULEMODE_HWCTRL
> > 		  &cm_l4per_clkctrl OMAP4_GPIO2_CLKCTRL_DBCLK 1 0>;
> 
> Drop the _DBCLK here, right?

Ah sorry yeah this should be:

&gpio2 {
	clocks = <&cm_l4per_clkctrl OMAP4_GPIO2_CLKCTRL 0 MODULEMODE_HWCTRL
		  &cm_l4per_clkctrl OMAP4_GPIO2_CLKCTRL 1 0>;
};

or if using actual bit offsets within the register instead of optional
clock instance count:

&gpio2 {
	clocks = <&cm_l4per_clkctrl OMAP4_GPIO2_CLKCTRL 0 MODULEMODE_HWCTRL
		  &cm_l4per_clkctrl OMAP4_GPIO2_CLKCTRL 8 0>;
};

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
