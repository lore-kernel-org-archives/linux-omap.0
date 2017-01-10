From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] Documentation: dt-bindings: Add binding documentation
 for TI clkctrl clocks
Date: Tue, 10 Jan 2017 07:44:01 -0800
Message-ID: <20170110154400.GT2630@atomide.com>
References: <20170109234226.9449-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170109234226.9449-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [170109 15:43]:
> Texas Instruments omap variant SoCs starting with omap4 have a clkctrl
> clock controller instance for each interconnect target module. The clkctrl
> controls functional and interface clocks for the module.
> 
> The clkctrl clocks are currently handled by arch/arm/mach-omap2 hwmod code.
> With this binding and a related clock device driver we can start moving the
> clkctrl clock handling to live in drivers/clk/ti.
> 
> For hardware reference, see omap4430 TRM "Table 3-1312. L4PER_CM2 Registers
> Mapping Summary" for example. It show one instance of a clkctrl clock
> controller with multiple clkctrl registers.
> 
> Note that this binding allows keeping the clockdomain related parts out of
> drivers/clock. The CLKCTCTRL and DYNAMICDEP registers can be handled by
> using a separate driver in drivers/soc/ti and genpd. If the clockdomain
> driver needs to know it's clocks, we can just set the the clkctrl device
> instances to be children of the related clockdomain device.
> 
> On omap4 CM_L3INIT_USB_HOST_HS_CLKCTRL on omap5 has eight OPTFCLKEN bits.
> So we need to shift the clock index to avoid index conflict for the clock
> consumer binding with the next clkctrl offset on omap4.
> 
> Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
> Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
> 
> So here's what I was able to come up for the clkctr binding based on
> all we've discussed so far. Can you guys please take a look and see
> if it looks OK to you before we do the device driver?
> 
> Also, does anybody have better suggestions for addressing the optional
> clocks in each clkctrl register?

The other option that might be worth considering is to make use of the
#clock-cells property. Then the index of any optional clock could be passed
in the second cell.

The third cell could be used to set the modulemode for the clock (software
controlled or hardware controlled) instead of using a custom property
at the clock controllel level.

In that case clock consume usage would look like the following using
#clock-cells = <3>:

#define OMAP4_CLKCTRL_OFFSET		0x20
#define MODULEMODE_HWCTRL		1
#define MODULEMODE_SWCTRL		2

#define OMAP_CLKCTRL_INDEX(offset)	((offset) - OMAP4_CLKCTRL_OFFSET)

#define OMAP4_GPTIMER10_CLKTRL		OMAP_CLKCTRL_INDEX(0x28)
#define OMAP4_GPTIMER11_CLKTRL		OMAP_CLKCTRL_INDEX(0x30)
#define OMAP4_GPTIMER2_CLKTRL		OMAP_CLKCTRL_INDEX(0x38)
...
#define OMAP4_GPIO2_CLKCTRL		OMAP_CLKCTRL_INDEX(0x60)
...

&gpio2 {
	clocks = <&cm_l4per_clkctrl OMAP4_GPIO2_CLKCTRL 0 MODULEMODE_HWCTRL
		  &cm_l4per_clkctrl OMAP4_GPIO2_CLKCTRL_DBCLK 1 0>;
};

Regards,

Tony


>  .../devicetree/bindings/clock/ti-clkctrl.txt       | 56 ++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/ti-clkctrl.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/ti-clkctrl.txt b/Documentation/devicetree/bindings/clock/ti-clkctrl.txt
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/ti-clkctrl.txt
> @@ -0,0 +1,56 @@
> +Texas Instruments clkctrl clock binding
> +
> +Texas Instruments SoCs can have a clkctrl clock controller for each
> +interconnect target module. The clkctrl clock controller manages functional
> +and interface clocks for each module. Each clkctrl controller can also
> +gate one or more optional functional clocks for a module. The clkctrl
> +clock controller is typical for omap3 and later variants.
> +
> +The clock consumers can specify the index of the clkctrl clock using
> +the hardware offset from the clkctrl instance register space. The optional
> +functional clocks can be specified by clkctrl hardware offset plus the
> +index of the optional clock. Please see the Linux clock framework binding
> +at Documentation/devicetree/bindings/clock/clock-bindings.txt.
> +
> +Required properties :
> +- compatible : shall be "ti,clkctrl"
> +- #clock-cells : shall contain 1
> +
> +Optional properties :
> +- "ti,modulemode-auto" : list of clkctrl offsets using automatic gating
> +
> +Example: Clock controller node:
> +
> +&cm_l4per {
> +	cm_l4per_clkctrl: clk@20 {
> +		compatible = "ti,clkctrl";
> +		reg = <0x20 0x1b0>;
> +		#clock-cells = 1;
> +		ti,modulemode-auto = <OMAP4_GPIO2_CLKCTRL>;
> +	};
> +};
> +
> +Example: Preprocessor helper macros in dt-bindings/ti-clkctrl.h
> +
> +#define OMAP4_CLKCTRL_OFFSET		0x20
> +
> +#define OMAP_CLKCTRL_INDEX(offset)		\
> +	(((offset) - OMAP4_CLKCTRL_OFFSET) << 8)
> +
> +#define OMAP_CLKCTRL_OPT_INDEX(offset, optclk)	\
> +	(OMAP_CLKCTRL_INDEX(offset) + (optclk))
> +
> +#define OMAP4_GPTIMER10_CLKTRL		OMAP_CLKCTRL_INDEX(0x28)
> +#define OMAP4_GPTIMER11_CLKTRL		OMAP_CLKCTRL_INDEX(0x30)
> +#define OMAP4_GPTIMER2_CLKTRL		OMAP_CLKCTRL_INDEX(0x38)
> +...
> +#define OMAP4_GPIO2_CLKCTRL		OMAP_CLKCTRL_INDEX(0x60)
> +#define OMAP4_GPIO2_CLKCTRL_DBCLK	OMAP_CLKCTRL_OPT_INDEX(0x60, 1)
> +...
> +
> +Example: Clock consumer node for GPIO2:
> +
> +&gpio2 {
> +       clocks = <&cm_l4per_clkctrl OMAP4_GPIO2_CLKCTRL
> +		 &cm_l4per_clkctrl OMAP4_GPIO2_CLKCTRL_DBCLK>;
> +};
> -- 
> 2.11.0
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
