From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCHv5 05/31] CLK: TI: add support for OMAP gate clock
Date: Mon, 19 Aug 2013 15:29:59 +0100
Message-ID: <20130819142959.GP3719@e106331-lin.cambridge.arm.com>
References: <1375460751-23676-1-git-send-email-t-kristo@ti.com>
 <1375460751-23676-6-git-send-email-t-kristo@ti.com>
 <20130813110437.GK27165@e106331-lin.cambridge.arm.com>
 <521220AD.4070308@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:43240 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751136Ab3HSOac (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 Aug 2013 10:30:32 -0400
Content-Disposition: inline
In-Reply-To: <521220AD.4070308@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>, "nm@ti.com" <nm@ti.com>, "rnayak@ti.com" <rnayak@ti.com>, "mturquette@linaro.org" <mturquette@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Aug 19, 2013 at 02:42:05PM +0100, Tero Kristo wrote:
> On 08/13/2013 02:04 PM, Mark Rutland wrote:
> > On Fri, Aug 02, 2013 at 05:25:24PM +0100, Tero Kristo wrote:
> >> This node adds support for a clock node which allows control to the
> >> clockdomain enable / disable.
> >>
> >> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> >> ---
> >>   .../devicetree/bindings/clock/ti/gate.txt          |   41 ++++++++
> >>   arch/arm/mach-omap2/clock.h                        |    9 --
> >>   drivers/clk/ti/Makefile                            |    2 +-
> >>   drivers/clk/ti/gate.c                              |  106 ++++++++++++++++++++
> >>   include/linux/clk/ti.h                             |    8 ++
> >>   5 files changed, 156 insertions(+), 10 deletions(-)
> >>   create mode 100644 Documentation/devicetree/bindings/clock/ti/gate.txt
> >>   create mode 100644 drivers/clk/ti/gate.c
> >>
> >> diff --git a/Documentation/devicetree/bindings/clock/ti/gate.txt b/Documentation/devicetree/bindings/clock/ti/gate.txt
> >> new file mode 100644
> >> index 0000000..620a73d
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/clock/ti/gate.txt
> >> @@ -0,0 +1,41 @@
> >> +Binding for Texas Instruments gate clock.
> >> +
> >> +This binding uses the common clock binding[1]. This clock is
> >> +quite much similar to the basic gate-clock [2], however,
> >> +it supports a number of additional features. If no register
> >> +is provided for this clock, the code assumes that a clockdomain
> >> +will be controlled instead and the corresponding hw-ops for
> >> +that is used.
> >> +
> >> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> >> +[2] Documentation/devicetree/bindings/clock/gate-clock.txt
> >> +
> >> +Required properties:
> >> +- compatible : shall be "ti,gate-clock"
> >> +- #clock-cells : from common clock binding; shall be set to 0
> >> +- clocks : link to phandle of parent clock
> >> +
> >> +Optional properties:
> >> +- reg : base address for register controlling adjustable gate
> >
> > Optional? That's odd. If I have a clock with registers, but don't
> > specify the register, will it still work? i.e. are registerless clocks
> > really compatible with clocks with registers?.
> 
> I think I implemented this in somewhat confusing manner. This could be 
> split to:
> 
> ti,gate-clock:
>    requires reg and ti,enable-bit info
> ti,clkdm-clock:
>    requires ti,clkdm-name
> 
> clkdm clock is kind of a master clock for clockdomain, the clock is 
> provided always if the clockdomain is active.

Ok.

> 
> >
> >> +- ti,enable-bit : bit shift for programming the clock gate
> >
> > Why is this needed? Does the hardware vary wildly, or are several clocks
> > sharing the same register(s)?
> 
> Yea, same register is shared.

Ok. Are those gate clocks are part of a larger "gate clocks" block, with
the register that controls them? or are they really independent? Does
the register control other items too?

If they were part of some bigger unit, it might be possible to have a
binding like the following (though maybe not):

gate_clks: gate_clks {
	compatible = "ti,gate-clocks-block";
	reg = <0x4003a000 0x1000>;

	#clock-cells = <1>;
	/*
	 * has 4 gate clocks at bit shifts 0,1,2,3,
	 * corresponding to input clocks 0,1,2,3
	 */
	clocks = <&clk1 0 23>,
		 <&clk1 0 4>,
		 <&clk3 2>,
		 <&clk3 5>;
};

device {
	compatible = "vendor,some-device";
	clocks = <&gate_clks 1>; /* gate clock with bitshift 1*/
};

> 
> >
> >> +- ti,dss-clk : use DSS hardware OPS for the clock
> >> +- ti,am35xx-clk : use AM35xx hardware OPS for the clock
> >
> > Those last two sounds like the kind of thing that should be derived from
> > the compatible string (e.g. ti,am35xx-gate-clock).
> 
> Hmm yea, I think I can change this and add some sub-types.
> 
> >
> >> +- ti,clkdm-name : clockdomain to control this gate
> >
> > As previously mentioned, I'm not a fan of this property. It would make
> > more sense to describe the domain and have an explicit link to it
> > (either nodes being children of the domain or having a phandle).
> 
> Same comments as with patch #2.

Same reply as to patch #2 :)

> 
> >
> > [...]
> >
> >> +void __init of_omap_gate_clk_setup(struct device_node *node)
> >> +{
> >> +       struct clk *clk;
> >> +       struct clk_init_data init = { 0 };
> >> +       struct clk_hw_omap *clk_hw;
> >> +       const char *clk_name = node->name;
> >> +       int num_parents;
> >> +       const char **parent_names = NULL;
> >> +       int i;
> >> +       u32 val;
> >> +
> >> +       clk_hw = kzalloc(sizeof(*clk_hw), GFP_KERNEL);
> >> +       if (!clk_hw) {
> >> +               pr_err("%s: could not allocate clk_hw_omap\n", __func__);
> >> +               return;
> >> +       }
> >> +
> >> +       clk_hw->hw.init = &init;
> >> +
> >> +       of_property_read_string(node, "clock-output-names", &clk_name);
> >> +       of_property_read_string(node, "ti,clkdm-name", &clk_hw->clkdm_name);
> >> +
> >> +       init.name = clk_name;
> >> +       init.flags = 0;
> >> +
> >> +       if (of_property_read_u32_index(node, "reg", 0, &val)) {
> >> +               /* No register, clkdm control only */
> >> +               init.ops = &omap_gate_clkdm_clk_ops;
> >
> > If they're truly compatible, you can just see if you can of_iomap, and
> > if not, continue. Your reg values might be wider than 32 bits, and usig
> > of_property_read_u32 to read this feels wrong.
> 
> I'll split this to two separate supported types.
> 
> >
> >> +       } else {
> >> +               init.ops = &omap_gate_clk_ops;
> >> +               clk_hw->enable_reg = of_iomap(node, 0);
> >> +               of_property_read_u32(node, "ti,enable-bit", &val);
> >> +               clk_hw->enable_bit = val;
> >
> > What if of_property_read_u32 failed to read the "ti,enable-bit"
> > property? One might not be present, it's marked as optional in the
> > binding description.
> 
> I'll make sure this is present in case it is needed.
> 
> >
> >> +
> >> +               clk_hw->ops = &clkhwops_wait;
> >> +
> >> +               if (of_property_read_bool(node, "ti,dss-clk"))
> >> +                       clk_hw->ops = &clkhwops_omap3430es2_dss_usbhost_wait;
> >> +
> >> +               if (of_property_read_bool(node, "ti,am35xx-clk"))
> >> +                       clk_hw->ops = &clkhwops_am35xx_ipss_module_wait;
> >
> > I really don't like this. I think this should be done based on the
> > compatible string.
> 
> Yea, will change.

Cheers!

Mark.
