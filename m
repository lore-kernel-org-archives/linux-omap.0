From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] Documentation: dt-bindings: Add binding documentation
 for TI clkctrl clocks
Date: Mon, 16 Jan 2017 09:07:47 -0800
Message-ID: <20170116170746.GA7403@atomide.com>
References: <20170109234226.9449-1-tony@atomide.com>
 <7acb6824-0e64-960b-1490-9b7a8b867b3b@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7acb6824-0e64-960b-1490-9b7a8b867b3b@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Rob Herring <robh@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [170116 07:20]:
> On 10/01/17 01:42, Tony Lindgren wrote:
> > +Example: Clock controller node:
> > +
> > +&cm_l4per {
> > +	cm_l4per_clkctrl: clk@20 {
> > +		compatible = "ti,clkctrl";
> > +		reg = <0x20 0x1b0>;
> > +		#clock-cells = 1;
> > +		ti,modulemode-auto = <OMAP4_GPIO2_CLKCTRL>;
> > +	};
> > +};
> 
> So, in this example, what would cm_l4per be? Is it a clockdomain? Or is it
> just an arbitrary interconnect instance, and the clockdomain would also be a
> separate node under cm_l4per?

Good question. It's not a clockdomain, those are the CLKSTCTRL registers.
And for example "3.11.33.1 CORE_CM2 Register Summary" for core_cm2 has
multiple clockdomains under it.

Looking at the interconnect target module for cm2, it's range is from
0x4a008000 - 0x4a009fff as listed in "Table 2-3. L4_CFG Memory Space
Mapping". So that's the cm2 parent module, and whatever we can clearly
set up as separate devices under that will make things easier to
understand.

The various device instances under cm2 can be seen in "3.11.29 CM2
Instance Summary".

So how about the following would describe that hardware using the
#clock-cells = <3> as discussed:

&cm2 {	/* 0x4a008000 */
	compatible = "ti,interconnect-socket-cm", "simple-pm-bus";
	reg = <0 0x2000>;
	ranges;
	...

	ckgen_cm2: cm@100 {
		reg = <0x100 0x100>;
		compatible = <"ti,clockmanager", "simple-pm-bus">;
		ranges;
		...
	};

	always_on_cm2: cm@600 {
		reg = <0x100 0x100>;
		compatible = <"ti,clockmanager", "simple-pm-bus">;
		ranges;
		...
	};

	...

	l4per: cm@1400 {
		reg = <0x1400 0x200>;
		compatible = <"ti,clockmanager", "simple-pm-bus">;
		ranges;
		...

		/* drivers/soc/ti/clockdomain.c */
		cm_l4per@0 {
			compatible = "ti,clockdomain";
			reg = <0 0x200>;
			ranges;
			...

			/* drivers/clk/ti/clkctrl.c */
			cm_l4per_clkctrl: clk@20 {
				compatible = "ti,clkctrl";
				reg = <0x20 0x1b0>;
				#clock-cells = <3>;
			};

			...

		}

		...
	};

	...
};

Then on am335x we need to set the ranges at the "ti,clockmanager" level
as the registers are partially sorted and most of the CLKSTCTRL registers
are at the beginning for all the clockdomains. With the ranges we can
have each clkctrl instance be a child of the related clockdomain.

> Shall we add power-domains = <&cm_l4per_clkdm>; entry under the
> cm_l4per_clkctrl in this example? (My thinking is that we will represent
> both OMAP clock and power domains as generic power domains within kernel /
> DT.)

Yeah it seems we can represent both the clock and power domains with just
a single "power-domains" property.

To me it seems the "power-domains" property would then belong to the
"ti,clockdomain" node above. As the clkctrl clock instances are children
of each clockdomain then "simple-pm-bus" should automatically manage
PM runtime usecount for each clockdomain.

Regards,

Tony
