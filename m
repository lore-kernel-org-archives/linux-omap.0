From: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv2] Documentation: dt-bindings: Add binding documentation
 for TI clkctrl clocks
Date: Mon, 23 Jan 2017 16:43:55 +0200
Message-ID: <40b1f6a8-fc5c-b619-9570-bc2f9731af89@ti.com>
References: <20170117225302.10844-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170117225302.10844-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On 18/01/17 00:53, Tony Lindgren wrote:
> Texas Instruments omap variant SoCs starting with omap4 have a clkctrl
> clock controller instance for each interconnect target module. The clkctrl
> controls functional and interface clocks for the module.
>
> The clkctrl clocks are currently handled by arch/arm/mach-omap2 hwmod code.
> With this binding and a related clock device driver we can start moving the
> clkctrl clock handling to live in drivers/clk/ti.
>
> Note that this binding allows keeping the clockdomain related parts out of
> drivers/clock. The CLKCTCTRL and DYNAMICDEP registers can be handled by
> a separate driver in drivers/soc/ti and genpd. If the clockdomain driver
> needs to know it's clocks, we can just set the the clkctrl device
> instances to be children of the related clockdomain device.
>
> Each clkctrl clock can have multiple optional gate clocks, and multiple
> optional mux clocks. To represent this in device tree, it seems that
> it is best done using four clock cells #clock-cells = <4> property.
>
> The reasons for using #clock-cells = <4> are:
>
> 1. We need to specify the clkctrl offset from the instance base. Otherwise
>    we end up with a large number of device tree nodes that need to be
>    patched when new clocks are discovered in a clkctrl clock with minor
>    hardware revision changes for example
>
> 2. On omap5 CM_L3INIT_USB_HOST_HS_CLKCTRL has ten OPTFCLKEN bits. So we
>    need to use a separate cell for optional gate clocks to avoid address
>    space conflicts
>
> 3. Some clkctrl instances can also also optional mux clocks. To address
>    them properly we need also a separate cell for the optional mux
>    clock index
>
> 4. The modulemode clock needs a flag passed to it for hardware or
>    software controlled mode

Hi Tony,

I think #clock-cells = <4> is too much. I believe we only need 2:

- one entry for clkctrl offset
- one entry for clock offset within the clkctrl entry (0 = module clock, 
8+ = opt-clocks / mux clocks / dividers)

Fields 2 / 3 in your proposal are mutually exclusive, if either field is 
non-zero, the other one must be zero. And, the opt clocks / mux / divs 
always have different values for these.

Field 4 is kind of redundant also, as the module clock must be 
registered at the clkctrl probe time, it is too late for the clock 
consumer to provide the proper setting for the clock during its own 
probe. It seems I need to add static data to driver which basically has 
this information in place already.

-Tero

>
> There is probably no need to list input clocks for each clkctrl clock
> instance in the binding. If we want to add them, the standard clocks
> binding can be used for that.
>
> For hardware reference, see omap4430 TRM "Table 3-1312. L4PER_CM2 Registers
> Mapping Summary" for example. It shows one instance of a clkctrl clock
> controller with multiple clkctrl registers.
>
> Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
> Cc: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> ---
>
> Changes from v1:
>
> - Use #clock-cells to avoid address space conflicts
>
> - Consider also optional mux clocks as pointed out by Tero
>
> ---
>  .../devicetree/bindings/clock/ti-clkctrl.txt       | 57 ++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/ti-clkctrl.txt
>
> diff --git a/Documentation/devicetree/bindings/clock/ti-clkctrl.txt b/Documentation/devicetree/bindings/clock/ti-clkctrl.txt
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/ti-clkctrl.txt
> @@ -0,0 +1,57 @@
> +Texas Instruments clkctrl clock binding
> +
> +Texas Instruments SoCs can have a clkctrl clock controller for each
> +interconnect target module. The clkctrl clock controller manages functional
> +and interface clocks for each module. Each clkctrl controller can also
> +gate one or more optional functional clocks for a module, and can have one
> +or more clock muxes. There is a clkctrl clock controller typically for each
> +interconnect target module on omap4 and later variants.
> +
> +The clock consumers can specify the index of the clkctrl clock using
> +the hardware offset from the clkctrl instance register space. The optional
> +clocks can be specified by clkctrl hardware offset and the index of the
> +optional clock.
> +
> +For more information, please see the Linux clock framework binding at
> +Documentation/devicetree/bindings/clock/clock-bindings.txt.
> +
> +Required properties :
> +- compatible : shall be "ti,clkctrl"
> +- #clock-cells : shall contain 4 with the first entry being the instance
> +		 offset from the clock domain base, the second being the
> +		 clock index, the third being the optional clock mux index,
> +		 and fourth being the clock flags
> +
> +Example: Clock controller node on omap 4430:
> +
> +&cm2 {
> +	l4per: cm@1400 {
> +		cm_l4per@0 {
> +			cm_l4per_clkctrl: clk@20 {
> +				compatible = "ti,clkctrl";
> +				reg = <0x20 0x1b0>;
> +				#clock-cells = <4>;
> +			};
> +		};
> +	};
> +};
> +
> +Example: Preprocessor helper macros in dt-bindings/clock/ti-clkctrl.h
> +
> +#define OMAP4_CLKCTRL_OFFSET		0x20
> +#define OMAP4_CLKCTRL_INDEX(offset)	((offset) - OMAP4_CLKCTRL_OFFSET)
> +#define MODULEMODE_HWCTRL		1
> +#define MODULEMODE_SWCTRL		2
> +
> +#define OMAP4_GPTIMER10_CLKTRL		OMAP4_CLKCTRL_INDEX(0x28)
> +#define OMAP4_GPTIMER11_CLKTRL		OMAP4_CLKCTRL_INDEX(0x30)
> +#define OMAP4_GPTIMER2_CLKTRL		OMAP4_CLKCTRL_INDEX(0x38)
> +...
> +#define OMAP4_GPIO2_CLKCTRL		OMAP_CLKCTRL_INDEX(0x60)
> +
> +Example: Clock consumer node for GPIO2:
> +
> +&gpio2 {
> +       clocks = <&cm_l4per_clkctrl OMAP4_GPIO2_CLKCTRL 0 0 MODULEMODE_HWCTRL
> +		 &cm_l4per_clkctrl OMAP4_GPIO2_CLKCTRL 8 0 0>;
> +};
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
